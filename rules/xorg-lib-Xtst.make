# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XTST) += xorg-lib-xtst

#
# Paths and names
#
XORG_LIB_XTST_VERSION	:= 1.2.1
XORG_LIB_XTST_MD5	:= e8abc5c00c666f551cf26aa53819d592
XORG_LIB_XTST		:= libXtst-$(XORG_LIB_XTST_VERSION)
XORG_LIB_XTST_SUFFIX	:= tar.bz2
XORG_LIB_XTST_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XTST).$(XORG_LIB_XTST_SUFFIX))
XORG_LIB_XTST_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XTST).$(XORG_LIB_XTST_SUFFIX)
XORG_LIB_XTST_DIR	:= $(BUILDDIR)/$(XORG_LIB_XTST)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XTST_CONF_TOOL := autoconf
XORG_LIB_XTST_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-specs \
	$(XORG_OPTIONS_DOCS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xtst.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xtst)
	@$(call install_fixup, xorg-lib-xtst,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xtst,SECTION,base)
	@$(call install_fixup, xorg-lib-xtst,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xtst,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xtst, 0, 0, 0644, libXtst)

	@$(call install_finish, xorg-lib-xtst)

	@$(call touch)

# vim: syntax=make
