# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBQXT) += libqxt

#
# Paths and names
#
LIBQXT_VERSION	:= 0.6.1
LIBQXT_MD5	:= b83cb8c105366c4cf9d9282211d5db31
LIBQXT		:= libqxt-$(LIBQXT_VERSION)
LIBQXT_SUFFIX	:= tar.bz2
LIBQXT_URL	:= http://dev.libqxt.org/libqxt/get/v$(LIBQXT_VERSION).$(LIBQXT_SUFFIX)
LIBQXT_SOURCE	:= $(SRCDIR)/$(LIBQXT).$(LIBQXT_SUFFIX)
LIBQXT_DIR	:= $(BUILDDIR)/$(LIBQXT)
LIBQXT_LICENSE	:= LGPLv2.1,CPLv1.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBQXT_MODULES- := docs designer

LIBQXT_MODULES-$(PTXCONF_LIBQXT_CORE)		+= Core
LIBQXT_MODULES-$(PTXCONF_LIBQXT_GUI)		+= Gui
LIBQXT_MODULES-$(PTXCONF_LIBQXT_NETWORK)	+= Network
LIBQXT_MODULES-$(PTXCONF_LIBQXT_SQL)		+= Sql
LIBQXT_MODULES-$(PTXCONF_LIBQXT_BERKELEY)	+= Berkeley
LIBQXT_MODULES-$(PTXCONF_LIBQXT_ZEROCONF)	+= Zeroconf
LIBQXT_MODULES-$(PTXCONF_LIBQXT_WEB)		+= Web

LIBQXT_CONF_TOOL	:= autoconf
LIBQXT_CONF_OPT	:= \
	-verbose \
	-prefix /usr \
	-featuredir /usr/mkspecs/features \
	-release \
	-nomake "$(shell echo $(LIBQXT_MODULES-) | tr "a-z-" "A-Z_")"

ifdef PTXCONF_QT4_PLATFORM_EMBEDDED
LIBQXT_CONF_OPT += -qws
endif
ifndef PTXCONF_QT4_X11_XRANDR
LIBQXT_CONF_OPT += -no-xrandr
endif
ifdef PTXCONF_LIBQXT_ZEROCONF
LIBQXT_CONF_OPT += -I "$(SYSROOT)/usr/include/avahi-compat-libdns_sd"
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libqxt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libqxt)
	@$(call install_fixup, libqxt,PRIORITY,optional)
	@$(call install_fixup, libqxt,SECTION,base)
	@$(call install_fixup, libqxt,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libqxt,DESCRIPTION,missing)

	@$(foreach lib, $(LIBQXT_MODULES-y), \
		$(call install_lib, libqxt, 0, 0, 0644, libQxt$(lib));)

	@$(call install_finish, libqxt)

	@$(call touch)

# vim: syntax=make
