# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
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
LIBXCB_VERSION		:= 1.1
LIBXCB			:= libxcb-$(LIBXCB_VERSION)
LIBXCB_SUFFIX		:= tar.bz2
LIBXCB_URL		:= http://xcb.freedesktop.org/dist/$(LIBXCB).$(LIBXCB_SUFFIX)
LIBXCB_SOURCE		:= $(SRCDIR)/$(LIBXCB).$(LIBXCB_SUFFIX)
LIBXCB_DIR		:= $(BUILDDIR)/$(LIBXCB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libxcb_get: $(STATEDIR)/libxcb.get

$(STATEDIR)/libxcb.get: $(libxcb_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBXCB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBXCB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libxcb_extract: $(STATEDIR)/libxcb.extract

$(STATEDIR)/libxcb.extract: $(libxcb_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBXCB_DIR))
	@$(call extract, LIBXCB)
	@$(call patchin, LIBXCB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libxcb_prepare: $(STATEDIR)/libxcb.prepare

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

$(STATEDIR)/libxcb.prepare: $(libxcb_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBXCB_DIR)/config.cache)
	cd $(LIBXCB_DIR) && \
		$(LIBXCB_PATH) $(LIBXCB_ENV) \
		./configure $(LIBXCB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libxcb_compile: $(STATEDIR)/libxcb.compile

$(STATEDIR)/libxcb.compile: $(libxcb_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBXCB_DIR) && $(LIBXCB_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libxcb_install: $(STATEDIR)/libxcb.install

$(STATEDIR)/libxcb.install: $(libxcb_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBXCB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libxcb_targetinstall: $(STATEDIR)/libxcb.targetinstall

$(STATEDIR)/libxcb.targetinstall: $(libxcb_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libxcb)
	@$(call install_fixup, libxcb,PACKAGE,libxcb)
	@$(call install_fixup, libxcb,PRIORITY,optional)
	@$(call install_fixup, libxcb,VERSION,$(LIBXCB_VERSION))
	@$(call install_fixup, libxcb,SECTION,base)
	@$(call install_fixup, libxcb,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libxcb,DEPENDS,)
	@$(call install_fixup, libxcb,DESCRIPTION,missing)

	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-composite.so.0.0.0, \
		/usr/lib/libxcb-composite.so.0.0.0)
	@$(call install_link, libxcb, libxcb-composite.so.0.0.0, /usr/lib/libxcb-composite.so.0)
	@$(call install_link, libxcb, libxcb-composite.so.0.0.0, /usr/lib/libxcb-composite.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-damage.so.0.0.0, \
		/usr/lib/libxcb-damage.so.0.0.0)
	@$(call install_link, libxcb, libxcb-damage.so.0.0.0, /usr/lib/libxcb-damage.so.0)
	@$(call install_link, libxcb, libxcb-damage.so.0.0.0, /usr/lib/libxcb-damage.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-dpms.so.0.0.0, \
		/usr/lib/libxcb-dpms.so.0.0.0)
	@$(call install_link, libxcb, libxcb-dpms.so.0.0.0, /usr/lib/libxcb-dpms.so.0)
	@$(call install_link, libxcb, libxcb-dpms.so.0.0.0, /usr/lib/libxcb-dpms.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-glx.so.0.0.0, \
		/usr/lib/libxcb-glx.so.0.0.0)
	@$(call install_link, libxcb, libxcb-glx.so.0.0.0, /usr/lib/libxcb-glx.so.0)
	@$(call install_link, libxcb, libxcb-glx.so.0.0.0, /usr/lib/libxcb-glx.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-randr.so.0.0.0, \
		/usr/lib/libxcb-randr.so.0.0.0)
	@$(call install_link, libxcb, libxcb-randr.so.0.0.0, /usr/lib/libxcb-randr.so.0)
	@$(call install_link, libxcb, libxcb-randr.so.0.0.0, /usr/lib/libxcb-randr.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-record.so.0.0.0, \
		/usr/lib/libxcb-record.so.0.0.0)
	@$(call install_link, libxcb, libxcb-record.so.0.0.0, /usr/lib/libxcb-record.so.0)
	@$(call install_link, libxcb, libxcb-record.so.0.0.0, /usr/lib/libxcb-record.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-render.so.0.0.0, \
		/usr/lib/libxcb-render.so.0.0.0)
	@$(call install_link, libxcb, libxcb-render.so.0.0.0, /usr/lib/libxcb-render.so.0)
	@$(call install_link, libxcb, libxcb-render.so.0.0.0, /usr/lib/libxcb-render.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-res.so.0.0.0, \
		/usr/lib/libxcb-res.so.0.0.0)
	@$(call install_link, libxcb, libxcb-res.so.0.0.0, /usr/lib/libxcb-res.so.0)
	@$(call install_link, libxcb, libxcb-res.so.0.0.0, /usr/lib/libxcb-res.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-screensaver.so.0.0.0, \
		/usr/lib/libxcb-screensaver.so.0.0.0)
	@$(call install_link, libxcb, libxcb-screensaver.so.0.0.0, /usr/lib/libxcb-screensaver.so.0)
	@$(call install_link, libxcb, libxcb-screensaver.so.0.0.0, /usr/lib/libxcb-screensaver.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-shape.so.0.0.0, \
		/usr/lib/libxcb-shape.so.0.0.0)
	@$(call install_link, libxcb, libxcb-shape.so.0.0.0, /usr/lib/libxcb-shape.so.0)
	@$(call install_link, libxcb, libxcb-shape.so.0.0.0, /usr/lib/libxcb-shape.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-shm.so.0.0.0, \
		/usr/lib/libxcb-shm.so.0.0.0)
	@$(call install_link, libxcb, libxcb-shm.so.0.0.0, /usr/lib/libxcb-shm.so.0)
	@$(call install_link, libxcb, libxcb-shm.so.0.0.0, /usr/lib/libxcb-shm.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-sync.so.0.0.0, \
		/usr/lib/libxcb-sync.so.0.0.0)
	@$(call install_link, libxcb, libxcb-sync.so.0.0.0, /usr/lib/libxcb-sync.so.0)
	@$(call install_link, libxcb, libxcb-sync.so.0.0.0, /usr/lib/libxcb-sync.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-xevie.so.0.0.0, \
		/usr/lib/libxcb-xevie.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xevie.so.0.0.0, /usr/lib/libxcb-xevie.so.0)
	@$(call install_link, libxcb, libxcb-xevie.so.0.0.0, /usr/lib/libxcb-xevie.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-xf86dri.so.0.0.0, \
		/usr/lib/libxcb-xf86dri.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xf86dri.so.0.0.0, /usr/lib/libxcb-xf86dri.so.0)
	@$(call install_link, libxcb, libxcb-xf86dri.so.0.0.0, /usr/lib/libxcb-xf86dri.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-xfixes.so.0.0.0, \
		/usr/lib/libxcb-xfixes.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xfixes.so.0.0.0, /usr/lib/libxcb-xfixes.so.0)
	@$(call install_link, libxcb, libxcb-xfixes.so.0.0.0, /usr/lib/libxcb-xfixes.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-xinerama.so.0.0.0, \
		/usr/lib/libxcb-xinerama.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xinerama.so.0.0.0, /usr/lib/libxcb-xinerama.so.0)
	@$(call install_link, libxcb, libxcb-xinerama.so.0.0.0, /usr/lib/libxcb-xinerama.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-xlib.so.0.0.0, \
		/usr/lib/libxcb-xlib.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xlib.so.0.0.0, /usr/lib/libxcb-xlib.so.0)
	@$(call install_link, libxcb, libxcb-xlib.so.0.0.0, /usr/lib/libxcb-xlib.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-xprint.so.0.0.0, \
		/usr/lib/libxcb-xprint.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xprint.so.0.0.0, /usr/lib/libxcb-xprint.so.0)
	@$(call install_link, libxcb, libxcb-xprint.so.0.0.0, /usr/lib/libxcb-xprint.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-xtest.so.0.0.0, \
		/usr/lib/libxcb-xtest.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xtest.so.0.0.0, /usr/lib/libxcb-xtest.so.0)
	@$(call install_link, libxcb, libxcb-xtest.so.0.0.0, /usr/lib/libxcb-xtest.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-xv.so.0.0.0, \
		/usr/lib/libxcb-xv.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xv.so.0.0.0, /usr/lib/libxcb-xv.so.0)
	@$(call install_link, libxcb, libxcb-xv.so.0.0.0, /usr/lib/libxcb-xv.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb-xvmc.so.0.0.0, \
		/usr/lib/libxcb-xvmc.so.0.0.0)
	@$(call install_link, libxcb, libxcb-xvmc.so.0.0.0, /usr/lib/libxcb-xvmc.so.0)
	@$(call install_link, libxcb, libxcb-xvmc.so.0.0.0, /usr/lib/libxcb-xvmc.so)
	@$(call install_copy, libxcb, 0, 0, 0644, \
		$(LIBXCB_DIR)/src/.libs/libxcb.so.1.0.0, \
		/usr/lib/libxcb.so.1.0.0)
	@$(call install_link, libxcb, libxcb.so.1.0.0, /usr/lib/libxcb.so.1)
	@$(call install_link, libxcb, libxcb.so.1.0.0, /usr/lib/libxcb.so)

	@$(call install_finish, libxcb)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libxcb_clean:
	rm -rf $(STATEDIR)/libxcb.*
	rm -rf $(IMAGEDIR)/libxcb_*
	rm -rf $(LIBXCB_DIR)

# vim: syntax=make
