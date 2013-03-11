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
LIBXKBCOMMON_VERSION	:= 0.2.0
LIBXKBCOMMON_MD5	:= 2be3d4a255d02c7d46fc6a9486f21f6a
LIBXKBCOMMON		:= libxkbcommon-$(LIBXKBCOMMON_VERSION)
LIBXKBCOMMON_SUFFIX	:= tar.bz2
LIBXKBCOMMON_URL	:= http://xkbcommon.org/download/$(LIBXKBCOMMON).$(LIBXKBCOMMON_SUFFIX)
LIBXKBCOMMON_SOURCE	:= $(SRCDIR)/$(LIBXKBCOMMON).$(LIBXKBCOMMON_SUFFIX)
LIBXKBCOMMON_DIR	:= $(BUILDDIR)/$(LIBXKBCOMMON)
LIBXKBCOMMON_LICENSE	:= MIT/X11

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBXKBCOMMON_CONF_TOOL	:= autoconf
LIBXKBCOMMON_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--disable-selective-werror \
	--disable-strict-compilation \
	--disable-docs \
	--with-xkb-config-root=$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb

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

	@$(call install_finish, libxkbcommon)

	@$(call touch)

# vim: syntax=make
