# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBDRM) += libdrm

#
# Paths and names
#
LIBDRM_VERSION	:= 2.4.12
LIBDRM		:= libdrm-$(LIBDRM_VERSION)
LIBDRM_SUFFIX	:= tar.gz
LIBDRM_URL	:= http://dri.freedesktop.org/libdrm/$(LIBDRM).$(LIBDRM_SUFFIX)
LIBDRM_SOURCE	:= $(SRCDIR)/$(LIBDRM).$(LIBDRM_SUFFIX)
LIBDRM_DIR	:= $(BUILDDIR)/$(LIBDRM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBDRM_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBDRM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBDRM_PATH	:=  PATH=$(CROSS_PATH)
LIBDRM_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
LIBDRM_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libdrm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libdrm)
	@$(call install_fixup, libdrm,PACKAGE,libdrm)
	@$(call install_fixup, libdrm,PRIORITY,optional)
	@$(call install_fixup, libdrm,VERSION,$(LIBDRM_VERSION))
	@$(call install_fixup, libdrm,SECTION,base)
	@$(call install_fixup, libdrm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libdrm,DEPENDS,)
	@$(call install_fixup, libdrm,DESCRIPTION,missing)

	@$(call install_copy, libdrm, 0, 0, 0755, -, \
		/usr/lib/libdrm.so.2.4.0)

	@$(call install_link, libdrm, libdrm.so.2.4.0, /usr/lib/libdrm.so.2)
	@$(call install_link, libdrm, libdrm.so.2.4.0, /usr/lib/libdrm.so)

ifdef PTXCONF_XORG_DRIVER_VIDEO_INTEL_DRI
	@$(call install_copy, libdrm, 0, 0, 0755, -, \
		/usr/lib/libdrm_intel.so.1.0.0)

	@$(call install_link, libdrm, libdrm_intel.so.1.0.0, /usr/lib/libdrm_intel.so.1)
	@$(call install_link, libdrm, libdrm_intel.so.1.0.0, /usr/lib/libdrm_intel.so)
endif

	@$(call install_finish, libdrm)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libdrm_clean:
	rm -rf $(STATEDIR)/libdrm.*
	rm -rf $(PKGDIR)/libdrm_*
	rm -rf $(LIBDRM_DIR)

# vim: syntax=make
