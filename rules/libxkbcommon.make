# -*-makefile-*-
#
# Copyright (C) 2013 by Philipp Zabel <p.zabel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBXKBCOMMON) += libxkbcommon

#
# Paths and names
#
LIBXKBCOMMON_VERSION	:= 0.7.1
LIBXKBCOMMON_MD5	:= 947ba609cb0239b9462127d5cf8908ee
LIBXKBCOMMON		:= libxkbcommon-$(LIBXKBCOMMON_VERSION)
LIBXKBCOMMON_SUFFIX	:= tar.xz
LIBXKBCOMMON_URL	:= http://xkbcommon.org/download/$(LIBXKBCOMMON).$(LIBXKBCOMMON_SUFFIX)
LIBXKBCOMMON_SOURCE	:= $(SRCDIR)/$(LIBXKBCOMMON).$(LIBXKBCOMMON_SUFFIX)
LIBXKBCOMMON_DIR	:= $(BUILDDIR)/$(LIBXKBCOMMON)
LIBXKBCOMMON_LICENSE	:= MIT AND X11 AND HPND

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBXKBCOMMON_CONF_TOOL	:= autoconf
LIBXKBCOMMON_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
        $(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--disable-selective-werror \
	--disable-strict-compilation \
	--disable-docs \
	--$(call ptx/endis, PTXCONF_LIBXKBCOMMON_X11)-x11 \
	--disable-wayland \
	--with-xkb-config-root=$(XORG_DATADIR)/X11/xkb

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libxkbcommon.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libxkbcommon)
	@$(call install_fixup, libxkbcommon,PRIORITY,optional)
	@$(call install_fixup, libxkbcommon,SECTION,base)
	@$(call install_fixup, libxkbcommon,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, libxkbcommon,DESCRIPTION,missing)

	@$(call install_lib, libxkbcommon, 0, 0, 0644, libxkbcommon)
ifdef PTXCONF_LIBXKBCOMMON_X11
	@$(call install_lib, libxkbcommon, 0, 0, 0644, libxkbcommon-x11)
endif

	@$(call install_finish, libxkbcommon)

	@$(call touch)

# vim: syntax=make
