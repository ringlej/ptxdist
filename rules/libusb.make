# -*-makefile-*-
#
# Copyright (C) 2009 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUSB) += libusb

#
# Paths and names
#
LIBUSB_VERSION	:= 1.0.6
LIBUSB		:= libusb-$(LIBUSB_VERSION)
LIBUSB_SUFFIX	:= tar.bz2
LIBUSB_URL	:= $(PTXCONF_SETUP_SFMIRROR)/libusb/$(LIBUSB).$(LIBUSB_SUFFIX)
LIBUSB_SOURCE	:= $(SRCDIR)/$(LIBUSB).$(LIBUSB_SUFFIX)
LIBUSB_DIR	:= $(BUILDDIR)/$(LIBUSB)
LIBUSB_LICENSE	:= LGPLv2.1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBUSB_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBUSB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBUSB_PATH	:= PATH=$(CROSS_PATH)
LIBUSB_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBUSB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-log \
	--disable-debug-log \
	--disable-examples-build \
	--enable-static \
	--enable-shared

ifdef PTXCONF_LIBUSB_DEBUG_LOG
LIBUSB_AUTOCONF += --enable-debug-log
endif

ifdef PTXCONF_LIBUSB_DISABLE_LOG
LIBUSB_AUTOCONF += --disable-log
else
LIBUSB_AUTOCONF += --enable-log
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libusb.targetinstall:
	@$(call targetinfo)

ifndef PTXCONF_LIBUSB_BUILD_STATIC
	@$(call install_init,  libusb)
	@$(call install_fixup, libusb,PACKAGE,libusb)
	@$(call install_fixup, libusb,PRIORITY,optional)
	@$(call install_fixup, libusb,VERSION,$(LIBUSB_VERSION))
	@$(call install_fixup, libusb,SECTION,base)
	@$(call install_fixup, libusb,AUTHOR,"Juergen Beisert <juergen@kreuzholzen.de>")
	@$(call install_fixup, libusb,DEPENDS,)
	@$(call install_fixup, libusb,DESCRIPTION,missing)

	@$(call install_copy, libusb, 0, 0, 0644, -, /usr/lib/libusb-1.0.so.0.0.0 )
	@$(call install_link, libusb, libusb-1.0.so.0.0.0, /usr/lib/libusb-1.0.so.0)
	@$(call install_link, libusb, libusb-1.0.so.0.0.0, /usr/lib/libusb-1.0.so)

	@$(call install_finish, libusb)
endif
	@$(call touch)

# vim: syntax=make
