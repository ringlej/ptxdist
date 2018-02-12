# -*-makefile-*-
#
# Copyright (C) 2008 by mol@pengutronix.de
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_INTLTOOL) += host-intltool

#
# Paths and names
#
HOST_INTLTOOL_VERSION	:= 0.50.0
HOST_INTLTOOL_MD5	:= 0da9847a60391ca653df35123b1f7cc0
HOST_INTLTOOL		:= intltool-$(HOST_INTLTOOL_VERSION)
HOST_INTLTOOL_SUFFIX	:= tar.gz
HOST_INTLTOOL_URL	:= http://launchpad.net/intltool/trunk/0.50.0/+download/$(HOST_INTLTOOL).$(HOST_INTLTOOL_SUFFIX)
HOST_INTLTOOL_SOURCE	:= $(SRCDIR)/$(HOST_INTLTOOL).$(HOST_INTLTOOL_SUFFIX)
HOST_INTLTOOL_DIR	:= $(HOST_BUILDDIR)/$(HOST_INTLTOOL)
HOST_INTLTOOL_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_INTLTOOL_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-intltool.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_INTLTOOL)
	@sed -i "s;^prefix=$$;prefix=$(PTXCONF_SYSROOT_HOST);" $(PTXCONF_SYSROOT_HOST)/bin/intltoolize
	@$(call touch)

# vim: syntax=make
