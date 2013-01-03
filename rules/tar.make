# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TAR) += tar

#
# Paths and names
#
TAR_VERSION	:= 1.26
TAR_MD5		:= 0ced6f20b9fa1bea588005b5ad4b52c1
TAR		:= tar-$(TAR_VERSION)
TAR_SUFFIX	:= tar.xz
TAR_URL		:= $(call ptx/mirror, GNU, tar/$(TAR).$(TAR_SUFFIX))
TAR_SOURCE	:= $(SRCDIR)/$(TAR).$(TAR_SUFFIX)
TAR_DIR		:= $(BUILDDIR)/$(TAR)
TAR_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
TAR_CONF_TOOL	:= autoconf
TAR_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-rpath \
	--disable-nls

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tar.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tar)
	@$(call install_fixup, tar,PRIORITY,optional)
	@$(call install_fixup, tar,SECTION,base)
	@$(call install_fixup, tar,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, tar,DESCRIPTION,missing)

	@$(call install_copy, tar, 0, 0, 0755, -, /usr/bin/tar)

	@$(call install_finish, tar)

	@$(call touch)

# vim: syntax=make
