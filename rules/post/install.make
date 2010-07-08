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

install_check =										\
	CMD="$(strip $(1))";								\
	if [ ! -f "$(STATEDIR)/$$PACKET.cmds" ]; then					\
		echo;									\
		echo "Error: install_init was not called for package '$$PACKET'!";	\
		echo "This is probably caused by a typo in the package name of:";	\
		echo "\$$(call $$CMD, $$PACKET, ...)";					\
		echo;									\
		exit 1;									\
	fi

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
	$(call install_check, install_copy);							\
	if [ -z "$(6)" ]; then									\
		echo "ptxd_install_dir '$$SRC' '$$OWN' '$$GRP' '$$PER'" >> "$(STATEDIR)/$$PACKET.cmds";\
	else											\
		echo "ptxd_install_file '$$SRC' '$$DST' '$$OWN' '$$GRP' '$$PER' '$$STRIP'" >> "$(STATEDIR)/$$PACKET.cmds";\
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
# $6: (strip, obsolete)
# $7: destination (optional)
#
install_alternative =									\
	PACKET=$(strip $(1));								\
	OWN=$(strip $(2));								\
	GRP=$(strip $(3));								\
	PER=$(strip $(4));								\
	FILE=$(strip $(5));								\
	STRIP=$(strip $(6));								\
	DST=$(strip $(7));								\
	$(call install_check, install_alternative);					\
	echo "ptxd_install_alternative '$$FILE' '$$DST' '$$OWN' '$$GRP' '$$PER' '$$STRIP'" >> "$(STATEDIR)/$$PACKET.cmds"

#
# install_tree
#
# Installs all files and subdirectories with user/group ownership and
# permissions via fakeroot.
#
#
# $1: packet label
# $2: OWN, use '-' to use the real UID of each file/directory
# $3: GID, use '-' to use the real GID of each file/directory
# $4: the toplevel directory.
# $5: the target directory.
#
install_tree =			\
	PACKET=$(strip $(1));	\
	OWN=$(strip $(2));	\
	GRP=$(strip $(3));	\
	DIR=$(strip $(4));	\
	DST=$(strip $(5));	\
	$(call install_check, install_tree);	\
	echo "ptxd_install_tree '$$DIR' '$$DST' '$$OWN' '$$GRP'" >> "$(STATEDIR)/$$PACKET.cmds"

#
# install_archive
#
# Installs all files and directories in an archive with user/group ownership and
# permissions via fakeroot.
#
#
# $1: packet label
# $2: OWN, use '-' to use the real UID of each file/directory
# $3: GID, use '-' to use the real GID of each file/directory
# $4: the toplevel directory
# $5: the target directory.
#
install_archive =		\
	PACKET=$(strip $(1));	\
	OWN=$(strip $(2));	\
	GRP=$(strip $(3));	\
	DIR=$(strip $(4));	\
	DST=$(strip $(5));	\
	$(call install_check, install_archive);	\
	echo "ptxd_install_archive '$$DIR' '$$DST' '$$OWN' '$$GRP'" >> "$(STATEDIR)/$$PACKET.cmds"

#
# install_spec
#
# Installs files specified by a spec file
# format as defined in linux/Documentation/filesystems/ramfs-rootfs-initramfs.txt
#	file  <name> <location> <mode> <uid> <gid>
#	dir   <name> <mode> <uid> <gid>
#	nod   <name> <mode> <uid> <gid> <dev_type> <maj> <min>
#	slink <name> <target> <mode> <uid> <gid>
#
# $1: packet label
# $2: spec file to parse
#
install_spec =			\
	PACKET=$(strip $(1));	\
	SPECFILE=$(strip $(2));	\
	$(call install_check, install_spec);	\
	echo "ptxd_install_spec '$$SPECFILE'" >> "$(STATEDIR)/$$PACKET.cmds"

#
# install_package
#
# Installs usefull files and directories in an archive with user/group ownership and
# permissions via fakeroot.
# Usefull means binaries, libs + links, etc.
#
#
# $1: packet label
# $2: the toplevel directory
#
install_package =		\
	PACKET=$(strip $(1));	\
	$(call install_check, install_package);	\
	echo "ptxd_install_package" >> "$(STATEDIR)/$$PACKET.cmds"

#
# install_lib
#
# Installs a library + links in an archive with root/root ownership and
# 0644 permissions via fakeroot.
#
#
# $1: packet label
# $2: library name without suffix.
#
install_lib =			\
	PACKET=$(strip $(1));	\
	OWN="$(strip $(2))";	\
	GRP="$(strip $(3))";	\
	PER="$(strip $(4))";	\
	LIB=$(strip $(5));	\
	$(call install_check, install_lib);	\
	echo "ptxd_install_lib '$$LIB' '$$OWN' '$$GRP' '$$PER'" >> "$(STATEDIR)/$$PACKET.cmds"

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
	$(call install_check, install_replace);							\
	echo "ptxd_install_replace '$$FILE' '$$PLACEHOLDER' '$$VALUE'" >> "$(STATEDIR)/$$PACKET.cmds"

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
	$(call install_check, install_copy_toolchain_lib);					\
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
	$(call install_check, install_copy_toolchain_dl);					\
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
	$(call install_check, install_copy_toolchain_other);					\
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
	$(call install_check, install_link);					\
	echo "ptxd_install_link '$$SRC' '$$DST'" >> "$(STATEDIR)/$$PACKET.cmds"

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
	$(call install_check, install_node);	\
	echo "ptxd_install_node '$$DEV' '$$OWN' '$$GRP' '$$PER' '$$TYP' '$$MAJ' '$$MIN'" >> "$(STATEDIR)/$$PACKET.cmds"


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

# vim: syntax=make
