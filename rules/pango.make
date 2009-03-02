# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2006 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
#                         Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PANGO) += pango

#
# Paths and names
#
PANGO_VERSION	:= 1.22.4
PANGO		:= pango-$(PANGO_VERSION)
PANGO_SUFFIX	:= tar.bz2
PANGO_URL	:= http://ftp.gnome.org/pub/GNOME/sources/pango/1.22/$(PANGO).$(PANGO_SUFFIX)
PANGO_SOURCE	:= $(SRCDIR)/$(PANGO).$(PANGO_SUFFIX)
PANGO_DIR	:= $(BUILDDIR)/$(PANGO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pango_get: $(STATEDIR)/pango.get

$(STATEDIR)/pango.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PANGO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PANGO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pango_extract: $(STATEDIR)/pango.extract

$(STATEDIR)/pango.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(PANGO_DIR))
	@$(call extract, PANGO)
	@$(call patchin, PANGO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pango_prepare: $(STATEDIR)/pango.prepare

PANGO_PATH	:= PATH=$(CROSS_PATH)
PANGO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
ifdef PTXCONF_PANGO_BASIC
PANGO_MODULES += basic-fc,basic-win32,basic-x,basic-atsui
endif

ifdef PTXCONF_PANGO_ARABIC
PANGO_MODULES += arabic-fc
endif

ifdef PTXCONF_PANGO_HANGUL
PANGO_MODULES += hangul-fc
endif

ifdef PTXCONF_PANGO_HEBREW
PANGO_MODULES += hebrew-fc
endif

ifdef PTXCONF_PANGO_INDIC
PANGO_MODULES += indic-fc,indic-lang
endif

ifdef PTXCONF_PANGO_KHMER
PANGO_MODULES += khmer-fc
endif

ifdef PTXCONF_PANGO_SYRIAC
PANGO_MODULES += syriac-fc
endif

ifdef PTXCONF_PANGO_THAI
PANGO_MODULES += thai-fc
endif

ifdef PTXCONF_PANGO_TIBETAN
PANGO_MODULES += tibetan-fc
endif

PANGO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static \
	--enable-explicit-deps=yes \
	--without-dynamic-modules \
	--with-included-modules=$(subst $(space),$(comma),$(PANGO_MODULES))

ifdef PTXCONF_PANGO_TARGET_X11
PANGO_AUTOCONF += --with-x=$(SYSROOT)/usr
else
PANGO_AUTOCONF += --without-x
endif

$(STATEDIR)/pango.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(PANGO_DIR)/config.cache)
	cd $(PANGO_DIR) && \
		$(PANGO_PATH) $(PANGO_ENV) \
		./configure $(PANGO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pango_compile: $(STATEDIR)/pango.compile

$(STATEDIR)/pango.compile:
	@$(call targetinfo, $@)
	cd $(PANGO_DIR) && $(PANGO_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pango_install: $(STATEDIR)/pango.install

$(STATEDIR)/pango.install:
	@$(call targetinfo, $@)
	@$(call install, PANGO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pango_targetinstall: $(STATEDIR)/pango.targetinstall

$(STATEDIR)/pango.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, pango)
	@$(call install_fixup,pango,PACKAGE,pango)
	@$(call install_fixup,pango,PRIORITY,optional)
	@$(call install_fixup,pango,VERSION,$(PANGO_VERSION))
	@$(call install_fixup,pango,SECTION,base)
	@$(call install_fixup,pango,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,pango,DEPENDS,)
	@$(call install_fixup,pango,DESCRIPTION,missing)

	@$(call install_copy, pango, 0, 0, 0644, \
		$(PANGO_DIR)/pango/.libs/libpango-1.0.so.0.2203.1, \
		/usr/lib/libpango-1.0.so.0.2203.1)
	@$(call install_link, pango, libpango-1.0.so.0.2203.1, /usr/lib/libpango-1.0.so.0)
	@$(call install_link, pango, libpango-1.0.so.0.2203.1, /usr/lib/libpango-1.0.so)

	@$(call install_copy, pango, 0, 0, 0644, \
		$(PANGO_DIR)/pango/.libs/libpangoft2-1.0.so.0.2203.1, \
		/usr/lib/libpangoft2-1.0.so.0.2203.1)
	@$(call install_link, pango, libpangoft2-1.0.so.0.2203.1, /usr/lib/libpangoft2-1.0.so.0)
	@$(call install_link, pango, libpangoft2-1.0.so.0.2203.1, /usr/lib/libpangoft2-1.0.so)

	@$(call install_copy, pango, 0, 0, 0644, \
		$(PANGO_DIR)/pango/.libs/libpangocairo-1.0.so.0.2203.1, \
		/usr/lib/libpangocairo-1.0.so.0.2203.1)
	@$(call install_link, pango, libpangocairo-1.0.so.0.2203.1, /usr/lib/libpangocairo-1.0.so.0)
	@$(call install_link, pango, libpangocairo-1.0.so.0.2203.1, /usr/lib/libpangocairo-1.0.so)

	@$(call install_finish,pango)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pango_clean:
	rm -rf $(STATEDIR)/pango.*
	rm -rf $(PKGDIR)/pango_*
	rm -rf $(PANGO_DIR)

# vim: syntax=make
