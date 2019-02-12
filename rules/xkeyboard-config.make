# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XKEYBOARD_CONFIG) += xkeyboard-config

#
# Paths and names
#
XKEYBOARD_CONFIG_VERSION	:= 2.25
XKEYBOARD_CONFIG_MD5		:= a0238f95118f39f5f685dd28fbd9d24f
XKEYBOARD_CONFIG		:= xkeyboard-config-$(XKEYBOARD_CONFIG_VERSION)
XKEYBOARD_CONFIG_SUFFIX		:= tar.bz2
XKEYBOARD_CONFIG_URL		:= $(call ptx/mirror, XORG, individual/data/xkeyboard-config/$(XKEYBOARD_CONFIG).$(XKEYBOARD_CONFIG_SUFFIX))
XKEYBOARD_CONFIG_SOURCE		:= $(SRCDIR)/$(XKEYBOARD_CONFIG).$(XKEYBOARD_CONFIG_SUFFIX)
XKEYBOARD_CONFIG_DIR		:= $(BUILDDIR)/$(XKEYBOARD_CONFIG)
XKEYBOARD_CONFIG_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XKEYBOARD_CONFIG_CONF_TOOL	:= autoconf
XKEYBOARD_CONFIG_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-compat-rules \
	--disable-runtime-deps \
	--disable-nls \
	--disable-rpath \
	--without-xsltproc \
	--with-xkb-base=$(XORG_DATADIR)/X11/xkb \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xkeyboard-config.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  xkeyboard-config)
	@$(call install_fixup, xkeyboard-config,PRIORITY,optional)
	@$(call install_fixup, xkeyboard-config,SECTION,base)
	@$(call install_fixup, xkeyboard-config,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xkeyboard-config,DESCRIPTION,missing)

	@$(call install_tree, xkeyboard-config, 0, 0, -, $(XORG_DATADIR)/X11/xkb)

	@$(call install_finish, xkeyboard-config)

	@$(call touch)

# vim: syntax=make
