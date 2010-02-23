# -*-makefile-*-
#
# Copyright (C) 2005, 2006, 2007 Robert Schwebel <r.schwebel@pengutronix.de>
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# install_copy
#
# Installs a file with user/group ownership and permissions via
# fakeroot.
#
# $1: packet label
# $2: UID
# $3: GID
# $4: permissions (octal)
#
# a) install src->dst:
#     $5: source (for files); directory (for directories)
#     $6: destination (for files); empty (for directories). Prefixed with
#         $(ROOTDIR), so it needs to have a leading /
#
# b) install from PKG_PKGDIR (result of 'make install'):
#
#     $5: "-": source is taken from $(PKG_PKGDIR)/$destination
#     $6: destination
#
# binaries are stripped automatically
#
install_copy = 											\
	PACKET="$(strip $(1))";									\
	OWN="$(strip $(2))";									\
	GRP="$(strip $(3))";									\
	PER="$(strip $(4))";									\
	SRC="$(strip $(5))";									\
	DST="$(strip $(6))";									\
	STRIP="$(strip $(7))";									\
	PKG_PKGDIR="$(PKGDIR)/$($(PTX_MAP_TO_PACKAGE_$(notdir $(basename $(basename $@)))))";	\
												\
	if [ "$$SRC" = "-" ]; then								\
		SRC=$${PKG_PKGDIR}/$$DST;							\
	fi; 											\
												\
	PER_NFS=$$(printf "0%o" $$(( 0$${PER} & ~06000 )) );					\
	PER_NFS_WRITABLE=$$(printf "0%o" $$(( 0$${PER} & ~06000 | 00200 )) );			\
												\
	if [ -z "$(6)" ]; then									\
		echo "install_copy:";								\
		echo "  dir=$$SRC";								\
		echo "  owner=$$OWN";								\
		echo "  group=$$GRP";								\
		echo "  permissions=$$PER";							\
		$(INSTALL) -d "$(PKGDIR)/$$PACKET.tmp/ipkg/$$SRC";				\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit 1;									\
		fi;										\
		$(INSTALL) -m $$PER_NFS -d "$(ROOTDIR)/$$SRC";					\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit 1;									\
		fi;										\
		$(INSTALL) -m $$PER_NFS -d "$(ROOTDIR_DEBUG)/$$SRC";				\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit 1;									\
		fi;										\
		mkdir -p "$(PKGDIR)/$$PACKET.tmp";						\
		echo "f:$$SRC:$$OWN:$$GRP:$$PER" >> "$(STATEDIR)/$$PACKET.perms";		\
	else											\
		if [ -e "$${SRC}$(PTXDIST_PLATFORMSUFFIX)" ]; then				\
			SRC="$${SRC}$(PTXDIST_PLATFORMSUFFIX)";					\
		fi;										\
		echo "install_copy:";								\
		echo "  src=$$SRC";								\
		echo "  dst=$$DST";								\
		echo "  owner=$$OWN";								\
		echo "  group=$$GRP";								\
		echo "  permissions=$$PER"; 							\
		rm -fr "$(PKGDIR)/$$PACKET.tmp/ipkg/$$DST"; 					\
		$(INSTALL) -D "$$SRC" "$(PKGDIR)/$$PACKET.tmp/ipkg/$$DST";			\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit 1;									\
		fi;										\
		$(INSTALL) -m $$PER_NFS_WRITABLE -D "$$SRC" "$(ROOTDIR)$$DST";			\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit 1;									\
		fi;										\
		$(INSTALL) -m $$PER_NFS_WRITABLE -D "$$SRC" "$(ROOTDIR_DEBUG)$$DST";		\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit 1;									\
		fi;										\
		case "$$STRIP" in								\
		(0 | n | no)									\
			;;									\
		(*)											\
			file "$(PKGDIR)/$$PACKET.tmp/ipkg/$$DST" | egrep -q ":.*(executable|shared object).*stripped";	\
				case "$$?" in								\
				(0)									\
				$(CROSS_STRIP) -R .note -R .comment "$(PKGDIR)/$$PACKET.tmp/ipkg/$$DST";\
				if [ $$? -ne 0 ]; then							\
					echo "Error: install_copy failed!";				\
					exit 1;								\
				fi;									\
				$(CROSS_STRIP) -R .note -R .comment "$(ROOTDIR)$$DST";			\
				if [ $$? -ne 0 ]; then							\
					echo "Error: install_copy failed!";				\
					exit 1;								\
				fi;									\
				;;									\
				(1)									\
				;;									\
				esac;									\
			;;										\
		esac;											\
		chmod $$PER_NFS "$(ROOTDIR)$$DST";							\
		chmod $$PER_NFS "$(ROOTDIR_DEBUG)$$DST";						\
		mkdir -p "$(PKGDIR)/$$PACKET.tmp";							\
		echo "f:$$DST:$$OWN:$$GRP:$$PER" >> "$(STATEDIR)/$$PACKET.perms";			\
	fi

#
# install_alternative
#
# Installs a file with user/group ownership and permissions via
# fakeroot.
#
# This macro first looks in $(PTXDIST_WORKSPACE)/projectroot for the file to copy and then
# in $(PTXDIST_TOPDIR)/generic and installs the file under $(ROOTDIR)
#
# $1: packet label
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: source file
#
install_alternative =									\
	PACKET=$(strip $(1));								\
	OWN=$(strip $(2));								\
	GRP=$(strip $(3));								\
	PER=$(strip $(4));								\
	FILE=$(strip $(5));								\
	if [ -f $(PTXDIST_WORKSPACE)/projectroot$$FILE$(PTXDIST_PLATFORMSUFFIX) ]; then	\
		SRC=$(PTXDIST_WORKSPACE)/projectroot$$FILE$(PTXDIST_PLATFORMSUFFIX);	\
	elif [ -f $(PTXDIST_WORKSPACE)/projectroot$$FILE ]; then			\
		SRC=$(PTXDIST_WORKSPACE)/projectroot$$FILE;				\
	else										\
		SRC=$(PTXDIST_TOPDIR)/generic$$FILE;					\
	fi;										\
	echo "install_alternative:";							\
	echo "  installing $$FILE from $$SRC";						\
	echo "  owner=$$OWN";								\
	echo "  group=$$GRP";								\
	echo "  permissions=$$PER"; 							\
	rm -fr $(PKGDIR)/$$PACKET.tmp/ipkg/$$FILE; 					\
	$(INSTALL) -D $$SRC $(PKGDIR)/$$PACKET.tmp/ipkg/$$FILE;				\
	if [ $$? -ne 0 ]; then								\
		echo "Error: install_alternative failed!";				\
		exit 1;									\
	fi;										\
	$(INSTALL) -m $$PER -D $$SRC $(ROOTDIR)$$FILE;					\
	if [ $$? -ne 0 ]; then								\
		echo "Error: install_alternative failed!";				\
		exit 1;									\
	fi;										\
	$(INSTALL) -m $$PER -D $$SRC $(ROOTDIR_DEBUG)$$FILE;				\
	if [ $$? -ne 0 ]; then								\
		echo "Error: install_alternative failed!";				\
		exit 1;									\
	fi;										\
	mkdir -p $(PKGDIR)/$$PACKET.tmp;						\
	echo "f:$$FILE:$$OWN:$$GRP:$$PER" >> $(STATEDIR)/$$PACKET.perms

#
# install_replace
#
# Replace placeholder with value in a previously
# installed file
#
# $1: label of the packet
# $2: filename
# $3: placeholder
# $4: value
#
install_replace = \
	PACKET=$(strip $(1));									\
	FILE=$(strip $(2));									\
	PLACEHOLDER=$(strip $(3));								\
	VALUE=$(strip $(4));									\
	if [ ! -f "$(PKGDIR)/$$PACKET.tmp/ipkg/$$FILE" ]; then 					\
		echo;										\
		echo "install_replace: error: file not found: $(PKGDIR)/$$PACKET.tmp/ipkg/$$FILE";\
		echo;										\
		exit 1;										\
	fi;											\
	if [ ! -f "$(ROOTDIR)/$$FILE" ]; then 							\
		echo										\
		echo "install_replace: error: file not found: $(ROOTDIR)/$$FILE";		\
		echo;										\
		exit 1;										\
	fi;											\
	if [ ! -f "$(ROOTDIR_DEBUG)/$$FILE" ]; then 						\
		echo										\
		echo "install_replace: error: file not found: $(ROOTDIR_DEBUG)/$$FILE";		\
		echo;										\
		exit 1;										\
	fi;											\
	sed -i -e "s,$$PLACEHOLDER,$$VALUE,g" $(PKGDIR)/$$PACKET.tmp/ipkg/$$FILE;		\
	sed -i -e "s,$$PLACEHOLDER,$$VALUE,g" $(ROOTDIR)/$$FILE;				\
	sed -i -e "s,$$PLACEHOLDER,$$VALUE,g" $(ROOTDIR_DEBUG)/$$FILE

#
# install_copy_toolchain_lib
#
# $1: packet label
# $2: source
# $3: destination
# $4: strip (y|n)	default is to strip
#
install_copy_toolchain_lib =									\
	PACKET=$(strip $(1));									\
	LIB="$(strip $2)";									\
	DST="$(strip $3)";									\
	STRIP="$(strip $4)";									\
	test "$${DST}" != "" && DST="-d $${DST}";						\
	${CROSS_ENV_CC} $(CROSS_ENV_STRIP) PKGDIR="$(PKGDIR)"					\
		$(SCRIPTSDIR)/install_copy_toolchain.sh -p "$${PACKET}" -l "$${LIB}" $${DST} -s "$${STRIP}"

#
# install_copy_toolchain_dl
#
# $1: packet label
# $2: destination
# $3: strip (y|n)	default is to strip
#
install_copy_toolchain_dl =									\
	PACKET=$(strip $(1));									\
	DST="$(strip $2)";									\
	STRIP="$(strip $3)";									\
	test "$${DST}" != "" && DST="-d $${DST}";						\
	${CROSS_ENV_CC} $(CROSS_ENV_STRIP) PKGDIR="$(PKGDIR)"					\
		$(SCRIPTSDIR)/install_copy_toolchain.sh -p "$${PACKET}" -l LINKER $${DST} -s "$${STRIP}"

#
# install_copy_toolchain_other
#
# $1: packet label
# $2: source
# $3: destination
# $4: strip (y|n)	default is to strip
#
install_copy_toolchain_usr =									\
	PACKET=$(strip $(1));									\
	LIB="$(strip $2)";									\
	DST="$(strip $3)";									\
	STRIP="$(strip $4)";									\
	test "$${DST}" != "" && DST="-d $${DST}";						\
	${CROSS_ENV_CC} $(CROSS_ENV_STRIP) PKGDIR="$(PKGDIR)"					\
		$(SCRIPTSDIR)/install_copy_toolchain.sh -p "$${PACKET}" -u "$${LIB}" $${DST} -s "$${STRIP}"

#
# install_link
#
# Installs a soft link in root directory in an ipkg packet.
#
# $1: packet label
# $2: source
# $3: destination
#
install_link =									\
	PACKET=$(strip $(1));							\
	SRC=$(strip $(2));							\
	DST=$(strip $(3));							\
	rm -fr $(ROOTDIR)$$DST;							\
	rm -fr $(ROOTDIR_DEBUG)$$DST;						\
	echo "install_link: src=$$SRC dst=$$DST "; 				\
	case "$${SRC}" in							\
	(/*)									\
		echo "Error: absolute link detected, please fix!";		\
		exit 1;								\
	(*)									\
		;;								\
	esac;									\
	install -d `dirname $(ROOTDIR)$$DST`;					\
	install -d `dirname $(ROOTDIR_DEBUG)$$DST`;				\
	ln -sf $$SRC $(ROOTDIR)$$DST; 						\
	ln -sf $$SRC $(ROOTDIR_DEBUG)$$DST; 					\
	install -d `dirname $(PKGDIR)/$$PACKET.tmp/ipkg$$DST`;			\
	ln -sf $$SRC $(PKGDIR)/$$PACKET.tmp/ipkg/$$DST

#
# install_node
#
# Installs a device node in root directory in an ipkg packet.
#
# $1: packet label
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: type
# $6: major
# $7: minor
# $8: device node name
#
install_node =				\
	PACKET=$(strip $(1));		\
	OWN=$(strip $(2));		\
	GRP=$(strip $(3));		\
	PER=$(strip $(4));		\
	TYP=$(strip $(5));		\
	MAJ=$(strip $(6));		\
	MIN=$(strip $(7));		\
	DEV=$(strip $(8));		\
	echo "install_node:";		\
	echo "  owner=$$OWN";		\
	echo "  group=$$GRP";		\
	echo "  permissions=$$PER";	\
	echo "  type=$$TYP";		\
	echo "  major=$$MAJ";		\
	echo "  minor=$$MIN";		\
	echo "  name=$$DEV";		\
	mkdir -p $(PKGDIR)/$$PACKET.tmp;\
	echo "n:$$DEV:$$OWN:$$GRP:$$PER:$$TYP:$$MAJ:$$MIN" >> $(STATEDIR)/$$PACKET.perms


#
# install_init
#
# Deletes $(PKGDIR)/$$PACKET.tmp/ipkg and prepares for new ipkg package creation
#
# $1: packet label
#
install_init =				\
	$(call xpkg/env, $(1))		\
	ptxd_make_install_init		\
		-p '$(strip $(1))'	\
		-t '$(@)'


#
# install_fixup
#
# Replaces @...@ sequences in rules/*.ipkg files
#
# $1: packet label
# $2: sequence to be replaced
# $3: replacement
#
install_fixup =							\
	$(call xpkg/env, $(1))					\
	PTXCONF_PROJECT_BUILD="$(PTXCONF_PROJECT_BUILD)"	\
	ptxd_make_install_fixup					\
		-p '$(strip $(1))'				\
		-f '$(strip $(2))'				\
		-t '$(strip $(3))'				\
		-s '$(@)'

#
# install_finish
#
# finishes packet creation
#
# $1: packet label
#
install_finish = \
	$(call xpkg/finish, $(1))

# vim: syntax=make
