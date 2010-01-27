# -*-makefile-*-
#
# Copyright (C) 2005, 2006, 2007 Robert Schwebel <r.schwebel@pengutronix.de>
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2009 by Jon Ringle <jon@ringle.org>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# install_initramfs
#
# Installs a file with user/group ownership and permissions via
# initramfs.
#
# $1: packet label (not used)
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: source file
# $6: dest file
#
install_initramfs =										\
	PACKET=$(strip $(1));									\
	OWN=$(strip $(2));									\
	GRP=$(strip $(3));									\
	PER=$(strip $(4));									\
	SRC=$(strip $(5));									\
	DST=$(strip $(6));									\
	PKG_PKGDIR="$(PKGDIR)/$($(PTX_MAP_TO_PACKAGE_$(notdir $(basename $(basename $@)))))";	\
												\
	if [ "$$SRC" = "-" ]; then								\
		SRC=$${PKG_PKGDIR}/$$DST;							\
	fi; 											\
												\
	if [ -z "$(6)" ]; then									\
		echo "install_initramfs:";							\
		echo "  dir=$$SRC";								\
		echo "  owner=$$OWN";								\
		echo "  group=$$GRP";								\
		echo "  permissions=$$PER";							\
		echo "dir $$SRC $$PER $$OWN $$GRP" >> $(INITRAMFS_CONTROL);				\
	else											\
		if [ \! -f "$${SRC}" ]; then							\
			ptxd_bailout "source '$${SRC}' does not exist!";			\
		fi;										\
		echo "install_initramfs:";							\
		echo "  installing $$DST from $$SRC";						\
		echo "  owner=$$OWN";								\
		echo "  group=$$GRP";								\
		echo "  permissions=$$PER"; 							\
		echo "file $$DST $$SRC $$PER $$OWN $$GRP" >> $(INITRAMFS_CONTROL);			\
	fi

#
# install_initramfs_alt
#
# Installs a file with user/group ownership and permissions via
# initramfs.
#
# This macro first looks in $(PTXDIST_WORKSPACE)/initramfs for the file to copy and then
# in $(PTXDIST_TOPDIR)/generic/initramfs and installs the file under $(ROOTDIR)
#
# $1: packet label (not used)
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: source file
#
install_initramfs_alt =										\
	PACKET=$(strip $(1));									\
	OWN=$(strip $(2));									\
	GRP=$(strip $(3));									\
	PER=$(strip $(4));									\
	FILE=$(strip $(5));									\
	PKG_PKGDIR="$(PKGDIR)/$($(PTX_MAP_TO_PACKAGE_$(notdir $(basename $(basename $@)))))";	\
	PKG_DIR="$($(PTX_MAP_TO_PACKAGE_$(notdir $(basename $(basename $@))))_DIR)";		\
												\
	if [ -f $(PTXDIST_WORKSPACE)/initramfs$$FILE$(PTXDIST_PLATFORMSUFFIX) ]; then		\
		SRC=$(PTXDIST_WORKSPACE)/initramfs$$FILE$(PTXDIST_PLATFORMSUFFIX);		\
	elif [ -f $(PTXDIST_WORKSPACE)/initramfs$$FILE ]; then					\
		SRC=$(PTXDIST_WORKSPACE)/initramfs$$FILE;					\
	elif [ -f $(PTXDIST_TOPDIR)/generic/initramfs$$FILE ]; then				\
		SRC=$(PTXDIST_TOPDIR)/generic/initramfs$$FILE;					\
	elif [ -f $${PKG_PKGDIR}$$FILE ]; then							\
		SRC=$${PKG_PKGDIR}$$FILE;							\
	elif [ -f $${PKG_DIR}$$FILE ]; then							\
		SRC=$${PKG_DIR}$$FILE;								\
	else											\
		echo "initramfs_alt: Search for $$FILE in:";					\
		echo "$(PTXDIST_WORKSPACE)/initramfs$$FILE$(PTXDIST_PLATFORMSUFFIX)";		\
		echo "$(PTXDIST_WORKSPACE)/initramfs$$FILE";					\
		echo "$(PTXDIST_TOPDIR)/generic/initramfs$$FILE";				\
		echo "$${PKG_PKGDIR}$$FILE";							\
		echo "$${PKG_DIR}$$FILE";							\
		ptxd_bailout "No suitable file $$FILE found to install";			\
	fi;											\
	echo "install_initramfs_alt:";								\
	echo "  installing $$FILE from $$SRC";							\
	echo "  owner=$$OWN";									\
	echo "  group=$$GRP";									\
	echo "  permissions=$$PER"; 								\
	echo "file $$FILE $$SRC $$PER $$OWN $$GRP" >> $(INITRAMFS_CONTROL)

#
# install_initramfs_link
#
# Installs a soft link in initramfs
#
# $1: packet label (not used)
# $2: source
# $3: destination
# slink <name> <target> <mode> <uid> <gid>
#
install_initramfs_link =							\
	PACKET=$(strip $(1));							\
	SRC=$(strip $(2));							\
	DST=$(strip $(3));							\
	echo "install_initramfs_link: src=$$SRC dst=$$DST "; 			\
	echo "slink $$DST $$SRC 0755 0 0" >> $(INITRAMFS_CONTROL)

#
# install_initramfs_node
#
# Installs a device node via initramfs
#
# $1: packet label (not used)
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: type
# $6: major
# $7: minor
# $8: device node name
#
install_initramfs_node =		\
	PACKET=$(strip $(1));		\
	OWN=$(strip $(2));		\
	GRP=$(strip $(3));		\
	PER=$(strip $(4));		\
	TYP=$(strip $(5));		\
	MAJ=$(strip $(6));		\
	MIN=$(strip $(7));		\
	DEV=$(strip $(8));		\
	echo "install_initramfs_node:";	\
	echo "  owner=$$OWN";		\
	echo "  group=$$GRP";		\
	echo "  permissions=$$PER";	\
	echo "  type=$$TYP";		\
	echo "  major=$$MAJ";		\
	echo "  minor=$$MIN";		\
	echo "  name=$$DEV";		\
	echo "nod $$DEV $$PER $$OWN $$GRP $$TYP $$MAJ $$MIN" >> $(INITRAMFS_CONTROL)

# vim: syntax=make
