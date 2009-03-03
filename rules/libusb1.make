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
PACKAGES-$(PTXCONF_LIBUSB1) += libusb1

#
# Paths and names
#
LIBUSB1_VERSION	:= 1.0.0
LIBUSB1		:= libusb-$(LIBUSB1_VERSION)
LIBUSB1_SUFFIX	:= tar.bz2
LIBUSB1_URL	:= $(PTXCONF_SETUP_SFMIRROR)/libusb/$(LIBUSB1).$(LIBUSB1_SUFFIX)
LIBUSB1_SOURCE	:= $(SRCDIR)/$(LIBUSB1).$(LIBUSB1_SUFFIX)
LIBUSB1_DIR	:= $(BUILDDIR)/$(LIBUSB1)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBUSB1_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBUSB1)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBUSB1_PATH	:= PATH=$(CROSS_PATH)
LIBUSB1_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBUSB1_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBUSB1_DEBUG_LOG
LIBUSB1_AUTOCONF += --enable-debug-log
endif

ifdef PTXCONF_LIBUSB1_DISABLE_LOG
LIBUSB1_AUTOCONF += --disable-log
endif

ifdef PTXCONF_LIBUSB1_BUILD_STATIC
LIBUSB1_AUTOCONF += --enable-shared=no
else
LIBUSB1_AUTOCONF += --enable-static=no
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libusb1.targetinstall:
	@$(call targetinfo)

ifndef PTXCONF_LIBUSB1_BUILD_STATIC
	@$(call install_init, libusb1)
	@$(call install_fixup, libusb1,PACKAGE,libusb1)
	@$(call install_fixup, libusb1,PRIORITY,optional)
	@$(call install_fixup, libusb1,VERSION,$(LIBUSB1_VERSION))
	@$(call install_fixup, libusb1,SECTION,base)
	@$(call install_fixup, libusb1,AUTHOR,"Juergen Beisert <juergen\@kreuzholzen.de>")
	@$(call install_fixup, libusb1,DEPENDS,)
	@$(call install_fixup, libusb1,DESCRIPTION,missing)

	@$(call install_copy, libusb1, 0, 0, 0644, $(LIBUSB1_DIR)/libusb/.libs/libusb-1.0.so.0.0.0, /usr/lib/libusb-1.0.so.0.0.0 )
	@$(call install_link, libusb1, libusb-1.0.so.0.0.0, /usr/lib/libusb-1.0.so.0)
	@$(call install_link, libusb1, libusb-1.0.so.0.0.0, /usr/lib/libusb-1.0.so)

	@$(call install_finish, libusb1)
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libusb1_clean:
	rm -rf $(STATEDIR)/libusb1.*
	rm -rf $(PKGDIR)/libusb1_*
	rm -rf $(LIBUSB1_DIR)

# vim: syntax=make
