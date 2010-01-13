# -*-makefile-*-
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBXCB) += libxcb

#
# Paths and names
#
LIBXCB_VERSION		:= 1.4
LIBXCB			:= libxcb-$(LIBXCB_VERSION)
LIBXCB_SUFFIX		:= tar.bz2
LIBXCB_URL		:= http://xcb.freedesktop.org/dist/$(LIBXCB).$(LIBXCB_SUFFIX)
LIBXCB_SOURCE		:= $(SRCDIR)/$(LIBXCB).$(LIBXCB_SUFFIX)
LIBXCB_DIR		:= $(BUILDDIR)/$(LIBXCB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBXCB_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBXCB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBXCB_PATH	:= PATH=$(CROSS_PATH)
LIBXCB_ENV 	:= $(CROSS_ENV) ac_cv_prog_BUILD_DOCS=no

#
# autoconf
#
LIBXCB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-build-docs
#
# configure outputs: checking for XDMCP... no
# How to control this in a reliable way?
# What's here detected depends on the build order!
#

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libxcb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libxcb)
	@$(call install_fixup, libxcb,PACKAGE,libxcb)
	@$(call install_fixup, libxcb,PRIORITY,optional)
	@$(call install_fixup, libxcb,VERSION,$(LIBXCB_VERSION))
	@$(call install_fixup, libxcb,SECTION,base)
	@$(call install_fixup, libxcb,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libxcb,DEPENDS,)
	@$(call install_fixup, libxcb,DESCRIPTION,missing)

	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-composite.so.0.0.0)
	@$(call install_link, libxcb, libxcb-composite.so.0.0.0, /usr/lib/libxcb-composite.so.0)
	@$(call install_link, libxcb, libxcb-composite.so.0.0.0, /usr/lib/libxcb-composite.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-damage.so.0.0.0)
	@$(call install_link, libxcb, libxcb-damage.so.0.0.0, /usr/lib/libxcb-damage.so.0)
	@$(call install_link, libxcb, libxcb-damage.so.0.0.0, /usr/lib/libxcb-damage.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-dpms.so.0.0.0)
	@$(call install_link, libxcb, libxcb-dpms.so.0.0.0, /usr/lib/libxcb-dpms.so.0)
	@$(call install_link, libxcb, libxcb-dpms.so.0.0.0, /usr/lib/libxcb-dpms.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-glx.so.0.0.0)
	@$(call install_link, libxcb, libxcb-glx.so.0.0.0, /usr/lib/libxcb-glx.so.0)
	@$(call install_link, libxcb, libxcb-glx.so.0.0.0, /usr/lib/libxcb-glx.so)

	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-randr.so.0.1.0)
	@$(call install_link, libxcb, libxcb-randr.so.0.1.0, /usr/lib/libxcb-randr.so.0)
	@$(call install_link, libxcb, libxcb-randr.so.0.1.0, /usr/lib/libxcb-randr.so)

	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-record.so.0.0.0)
	@$(call install_link, libxcb, libxcb-record.so.0.0.0, /usr/lib/libxcb-record.so.0)
	@$(call install_link, libxcb, libxcb-record.so.0.0.0, /usr/lib/libxcb-record.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-render.so.0.0.0)
	@$(call install_link, libxcb, libxcb-render.so.0.0.0, /usr/lib/libxcb-render.so.0)
	@$(call install_link, libxcb, libxcb-render.so.0.0.0, /usr/lib/libxcb-render.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-res.so.0.0.0)
	@$(call install_link, libxcb, libxcb-res.so.0.0.0, /usr/lib/libxcb-res.so.0)
	@$(call install_link, libxcb, libxcb-res.so.0.0.0, /usr/lib/libxcb-res.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-screensaver.so.0.0.0)
	@$(call install_link, libxcb, libxcb-screensaver.so.0.0.0, /usr/lib/libxcb-screensaver.so.0)
	@$(call install_link, libxcb, libxcb-screensaver.so.0.0.0, /usr/lib/libxcb-screensaver.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-shape.so.0.0.0)
	@$(call install_link, libxcb, libxcb-shape.so.0.0.0, /usr/lib/libxcb-shape.so.0)
	@$(call install_link, libxcb, libxcb-shape.so.0.0.0, /usr/lib/libxcb-shape.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-shm.so.0.0.0)
	@$(call install_link, libxcb, libxcb-shm.so.0.0.0, /usr/lib/libxcb-shm.so.0)
	@$(call install_link, libxcb, libxcb-shm.so.0.0.0, /usr/lib/libxcb-shm.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-sync.so.0.0.0)
	@$(call install_link, libxcb, libxcb-sync.so.0.0.0, /usr/lib/libxcb-sync.so.0)
	@$(call install_link, libxcb, libxcb-sync.so.0.0.0, /usr/lib/libxcb-sync.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-xevie.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xevie.so.0.0.0, /usr/lib/libxcb-xevie.so.0)
	@$(call install_link, libxcb, libxcb-xevie.so.0.0.0, /usr/lib/libxcb-xevie.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-xf86dri.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xf86dri.so.0.0.0, /usr/lib/libxcb-xf86dri.so.0)
	@$(call install_link, libxcb, libxcb-xf86dri.so.0.0.0, /usr/lib/libxcb-xf86dri.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-xfixes.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xfixes.so.0.0.0, /usr/lib/libxcb-xfixes.so.0)
	@$(call install_link, libxcb, libxcb-xfixes.so.0.0.0, /usr/lib/libxcb-xfixes.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-xinerama.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xinerama.so.0.0.0, /usr/lib/libxcb-xinerama.so.0)
	@$(call install_link, libxcb, libxcb-xinerama.so.0.0.0, /usr/lib/libxcb-xinerama.so)
#	@$(call install_copy, libxcb, 0, 0, 0644, -, \
#		/usr/lib/libxcb-xlib.so.0.0.0)
#	@$(call install_link, libxcb, libxcb-xlib.so.0.0.0, /usr/lib/libxcb-xlib.so.0)
#	@$(call install_link, libxcb, libxcb-xlib.so.0.0.0, /usr/lib/libxcb-xlib.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-xprint.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xprint.so.0.0.0, /usr/lib/libxcb-xprint.so.0)
	@$(call install_link, libxcb, libxcb-xprint.so.0.0.0, /usr/lib/libxcb-xprint.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-xtest.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xtest.so.0.0.0, /usr/lib/libxcb-xtest.so.0)
	@$(call install_link, libxcb, libxcb-xtest.so.0.0.0, /usr/lib/libxcb-xtest.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-xv.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xv.so.0.0.0, /usr/lib/libxcb-xv.so.0)
	@$(call install_link, libxcb, libxcb-xv.so.0.0.0, /usr/lib/libxcb-xv.so)
	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb-xvmc.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xvmc.so.0.0.0, /usr/lib/libxcb-xvmc.so.0)
	@$(call install_link, libxcb, libxcb-xvmc.so.0.0.0, /usr/lib/libxcb-xvmc.so)

	@$(call install_copy, libxcb, 0, 0, 0644, -, \
		/usr/lib/libxcb.so.1.1.0)
	@$(call install_link, libxcb, libxcb.so.1.1.0, /usr/lib/libxcb.so.1)
	@$(call install_link, libxcb, libxcb.so.1.1.0, /usr/lib/libxcb.so)

	@$(call install_finish, libxcb)

	@$(call touch)

# vim: syntax=make
