# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CAIRO) += host-cairo

#
# Paths and names
#
HOST_CAIRO_DIR	= $(HOST_BUILDDIR)/$(CAIRO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-cairo_get: $(STATEDIR)/host-cairo.get

$(STATEDIR)/host-cairo.get: $(STATEDIR)/cairo.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-cairo_extract: $(STATEDIR)/host-cairo.extract

$(STATEDIR)/host-cairo.extract: $(host-cairo_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_CAIRO_DIR))
	@$(call extract, CAIRO, $(HOST_BUILDDIR))
	@$(call patchin, CAIRO, $(HOST_CAIRO_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-cairo_prepare: $(STATEDIR)/host-cairo.prepare

HOST_CAIRO_PATH	:= PATH=$(HOST_PATH)
HOST_CAIRO_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_CAIRO_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-quartz \
	--disable-xcb \
	--disable-beos \
	--disable-glitz \
	--enable-svg \
	--disable-atsui \
	--enable-xlib \
	--disable-directfb \
	--disable-win32 \
	--disable-win32-font \
	--enable-freetype

ifdef PTXCONF_HOST_CAIRO_PS
HOST_CAIRO_AUTOCONF += --enable-ps
else
HOST_CAIRO_AUTOCONF +=--disable-ps
endif

ifdef PTXCONF_HOST_CAIRO_PDF
HOST_CAIRO_AUTOCONF += --enable-pdf
else
HOST_CAIRO_AUTOCONF +=--disable-pdf
endif

ifdef PTXCONF_HOST_CAIRO_PNG
HOST_CAIRO_AUTOCONF += --enable-png
else
HOST_CAIRO_AUTOCONF += --disable-png
endif

$(STATEDIR)/host-cairo.prepare: $(host-cairo_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_CAIRO_DIR)/config.cache)
	cd $(HOST_CAIRO_DIR) && \
		$(HOST_CAIRO_PATH) $(HOST_CAIRO_ENV) \
		./configure $(HOST_CAIRO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-cairo_compile: $(STATEDIR)/host-cairo.compile

$(STATEDIR)/host-cairo.compile: $(host-cairo_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_CAIRO_DIR) && $(HOST_CAIRO_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-cairo_install: $(STATEDIR)/host-cairo.install

$(STATEDIR)/host-cairo.install: $(host-cairo_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_CAIRO,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-cairo_clean:
	rm -rf $(STATEDIR)/host-cairo.*
	rm -rf $(HOST_CAIRO_DIR)

# vim: syntax=make
