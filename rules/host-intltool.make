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

ifdef PTXCONF_HOST_INTLTOOL
ifeq ($(shell perl -e "require XML::Parser" 2>/dev/null || echo no),no)
    $(warning *** XML::Parser perl module is required for host-intltool)
    $(warning *** please install libxml-parser-perl (debian))
    $(error )
endif
endif

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

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_INTLTOOL_CONF_TOOL	:= autoconf

# vim: syntax=make
