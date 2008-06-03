# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CAIRO) += cairo

#
# Paths and names
#
CAIRO_SUFFIX	:= tar.gz
CAIRO_VERSION	:= 1.4.10
CAIRO_URL	:= http://cairographics.org/releases/cairo-$(CAIRO_VERSION).$(CAIRO_SUFFIX)
CAIRO		:= cairo-$(CAIRO_VERSION)
CAIRO_SOURCE	:= $(SRCDIR)/$(CAIRO).$(CAIRO_SUFFIX)
CAIRO_DIR	:= $(BUILDDIR)/$(CAIRO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cairo_get: $(STATEDIR)/cairo.get

$(STATEDIR)/cairo.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CAIRO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CAIRO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cairo_extract: $(STATEDIR)/cairo.extract

$(STATEDIR)/cairo.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(CAIRO_DIR))
	@$(call extract, CAIRO)
	@$(call patchin, CAIRO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cairo_prepare: $(STATEDIR)/cairo.prepare

CAIRO_PATH	:= PATH=$(CROSS_PATH)
CAIRO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CAIRO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-quartz \
	--disable-xcb \
	--disable-beos \
	--disable-glitz \
	--disable-svg \
	--disable-atsui

ifdef PTXCONF_CAIRO_PS
CAIRO_AUTOCONF += --enable-ps
else
CAIRO_AUTOCONF +=--disable-ps
endif

ifdef PTXCONF_CAIRO_PDF
CAIRO_AUTOCONF += --enable-pdf
else
CAIRO_AUTOCONF +=--disable-pdf
endif

ifdef PTXCONF_CAIRO_XLIB
CAIRO_AUTOCONF += --enable-xlib
else
CAIRO_AUTOCONF += --disable-xlib
endif

ifdef PTXCONF_CAIRO_DIRECTFB
CAIRO_AUTOCONF += --enable-directfb
else
CAIRO_AUTOCONF += --disable-directfb
endif

ifdef PTXCONF_CAIRO_WIN32
CAIRO_AUTOCONF += \
	--enable-win32 \
	--enable-win32-font
else
CAIRO_AUTOCONF += \
	--disable-win32 \
	--disable-win32-font
endif

ifdef PTXCONF_CAIRO_FREETYPE
CAIRO_AUTOCONF += --enable-freetype
else
CAIRO_AUTOCONF += --disable-freetype
endif

ifdef PTXCONF_CAIRO_PNG
CAIRO_AUTOCONF += --enable-png
else
CAIRO_AUTOCONF += --disable-png
endif

$(STATEDIR)/cairo.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(CAIRO_DIR)/config.cache)
	cd $(CAIRO_DIR) && \
		$(CAIRO_PATH) $(CAIRO_ENV) \
		./configure $(CAIRO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cairo_compile: $(STATEDIR)/cairo.compile

$(STATEDIR)/cairo.compile:
	@$(call targetinfo, $@)
	cd $(CAIRO_DIR) && $(CAIRO_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cairo_install: $(STATEDIR)/cairo.install

$(STATEDIR)/cairo.install:
	@$(call targetinfo, $@)
	@$(call install, CAIRO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

cairo_targetinstall: $(STATEDIR)/cairo.targetinstall

$(STATEDIR)/cairo.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, cairo)
	@$(call install_fixup,cairo,PACKAGE,cairo)
	@$(call install_fixup,cairo,PRIORITY,optional)
	@$(call install_fixup,cairo,VERSION,$(CAIRO_VERSION))
	@$(call install_fixup,cairo,SECTION,base)
	@$(call install_fixup,cairo,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,cairo,DEPENDS,)
	@$(call install_fixup,cairo,DESCRIPTION,missing)

	@$(call install_copy, cairo, 0, 0, 0644, $(CAIRO_DIR)/src/.libs/libcairo.so.2.11.5, /usr/lib/libcairo.so.2.11.5)
	@$(call install_link, cairo, libcairo.so.2.11.5, /usr/lib/libcairo.so.2)
	@$(call install_link, cairo, libcairo.so.2.11.5, /usr/lib/libcairo.so)

	@$(call install_finish,cairo)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cairo_clean:
	rm -rf $(STATEDIR)/cairo.*
	rm -rf $(PKGDIR)/cairo_*
	rm -rf $(CAIRO_DIR)

# vim: syntax=make
