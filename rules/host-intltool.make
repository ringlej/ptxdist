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

ifdef PTXCONF_HOST_INTLTOOL
$(STATEDIR)/autogen-tools: $(STATEDIR)/host-intltool.install
endif

#
# Paths and names
#
HOST_INTLTOOL_VERSION	:= 0.40.5
HOST_INTLTOOL		:= intltool-$(HOST_INTLTOOL_VERSION)
HOST_INTLTOOL_SUFFIX	:= tar.bz2
HOST_INTLTOOL_URL	:= http://ftp.gnome.org/pub/gnome/sources/intltool/0.40/$(HOST_INTLTOOL).$(HOST_INTLTOOL_SUFFIX)
HOST_INTLTOOL_SOURCE	:= $(SRCDIR)/$(HOST_INTLTOOL).$(HOST_INTLTOOL_SUFFIX)
HOST_INTLTOOL_DIR	:= $(HOST_BUILDDIR)/$(HOST_INTLTOOL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_INTLTOOL_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_INTLTOOL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_INTLTOOL_PATH	:= PATH=$(HOST_PATH)
HOST_INTLTOOL_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_INTLTOOL_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make
