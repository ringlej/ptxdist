# -*-makefile-*-
#
# Copyright (C) 2014 by Andreas Pretzsch <apr@cn-eng.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_ARCHIVEMOUNT) += archivemount

ARCHIVEMOUNT_VERSION	:= 0.8.3
ARCHIVEMOUNT_MD5	:= a8c890e3fc315b07c7e85ad73a4b4760
ARCHIVEMOUNT		:= archivemount-$(ARCHIVEMOUNT_VERSION)
ARCHIVEMOUNT_SUFFIX	:= tar.gz
ARCHIVEMOUNT_URL	:= http://www.cybernoia.de/software/archivemount/$(ARCHIVEMOUNT).$(ARCHIVEMOUNT_SUFFIX)
ARCHIVEMOUNT_SOURCE	:= $(SRCDIR)/$(ARCHIVEMOUNT).$(ARCHIVEMOUNT_SUFFIX)
ARCHIVEMOUNT_DIR	:= $(BUILDDIR)/$(ARCHIVEMOUNT)
ARCHIVEMOUNT_LICENSE	:= LGPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ARCHIVEMOUNT_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/archivemount.targetinstall:
	@$(call targetinfo)

	@$(call install_init, archivemount)
	@$(call install_fixup, archivemount,PRIORITY,optional)
	@$(call install_fixup, archivemount,SECTION,base)
	@$(call install_fixup, archivemount,AUTHOR,"Andreas Pretzsch <apr@cn-eng.de>")
	@$(call install_fixup, archivemount,DESCRIPTION,"Mount archives using FUSE and libarchive.")

	@$(call install_copy, archivemount, 0, 0, 0755, -, /usr/bin/archivemount)

	@$(call install_finish, archivemount)

	@$(call touch)

# vim: syntax=make
