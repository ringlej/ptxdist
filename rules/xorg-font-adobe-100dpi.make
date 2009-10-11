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
PACKAGES-$(PTXCONF_XORG_FONT_ADOBE_100DPI) += xorg-font-adobe-100dpi

#
# Paths and names
#
XORG_FONT_ADOBE_100DPI_VERSION	:= 1.0.1
XORG_FONT_ADOBE_100DPI		:= font-adobe-100dpi-$(XORG_FONT_ADOBE_100DPI_VERSION)
XORG_FONT_ADOBE_100DPI_SUFFIX	:= tar.bz2
XORG_FONT_ADOBE_100DPI_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_ADOBE_100DPI).$(XORG_FONT_ADOBE_100DPI_SUFFIX)
XORG_FONT_ADOBE_100DPI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ADOBE_100DPI).$(XORG_FONT_ADOBE_100DPI_SUFFIX)
XORG_FONT_ADOBE_100DPI_DIR	:= $(BUILDDIR)/$(XORG_FONT_ADOBE_100DPI)

ifdef PTXCONF_XORG_FONT_ADOBE_100DPI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-adobe-100dpi.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-adobe-100dpi_get: $(STATEDIR)/xorg-font-adobe-100dpi.get

$(STATEDIR)/xorg-font-adobe-100dpi.get: $(xorg-font-adobe-100dpi_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_ADOBE_100DPI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_ADOBE_100DPI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-adobe-100dpi_extract: $(STATEDIR)/xorg-font-adobe-100dpi.extract

$(STATEDIR)/xorg-font-adobe-100dpi.extract: $(xorg-font-adobe-100dpi_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_ADOBE_100DPI_DIR))
	@$(call extract, XORG_FONT_ADOBE_100DPI)
	@$(call patchin, XORG_FONT_ADOBE_100DPI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-adobe-100dpi_prepare: $(STATEDIR)/xorg-font-adobe-100dpi.prepare

XORG_FONT_ADOBE_100DPI_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_ADOBE_100DPI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_ADOBE_100DPI_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/100dpi

$(STATEDIR)/xorg-font-adobe-100dpi.prepare: $(xorg-font-adobe-100dpi_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_ADOBE_100DPI_DIR)/config.cache)
	cd $(XORG_FONT_ADOBE_100DPI_DIR) && \
		$(XORG_FONT_ADOBE_100DPI_PATH) $(XORG_FONT_ADOBE_100DPI_ENV) \
		./configure $(XORG_FONT_ADOBE_100DPI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-adobe-100dpi_compile: $(STATEDIR)/xorg-font-adobe-100dpi.compile

$(STATEDIR)/xorg-font-adobe-100dpi.compile: $(xorg-font-adobe-100dpi_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_ADOBE_100DPI_DIR) && $(XORG_FONT_ADOBE_100DPI_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-adobe-100dpi_install: $(STATEDIR)/xorg-font-adobe-100dpi.install

$(STATEDIR)/xorg-font-adobe-100dpi.install: $(xorg-font-adobe-100dpi_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-adobe-100dpi_targetinstall: $(STATEDIR)/xorg-font-adobe-100dpi.targetinstall

$(STATEDIR)/xorg-font-adobe-100dpi.targetinstall: $(xorg-font-adobe-100dpi_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/100dpi

	@find $(XORG_FONT_ADOBE_100DPI_DIR) \
		-name "*.pcf.gz" -a \! -name "*ISO8859*" \
		-o -name "*ISO8859-1.pcf.gz" \
		-o -name "*ISO8859-15.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/100dpi; \
	done

ifdef PTXCONF_XORG_FONT_ADOBE_100DPI_TRANS
	@find $(XORG_FONT_ADOBE_100DPI_DIR) \
		-name "*ISO8859-2.pcf.gz" \
		-o -name "*ISO8859-3.pcf.gz" \
		-o -name "*ISO8859-4.pcf.gz" \
		-o -name "*ISO8859-9.pcf.gz" \
		-o -name "*ISO8859-10.pcf.gz" \
		-o -name "*ISO8859-13.pcf.gz" \
		-o -name "*ISO8859-14.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/100dpi; \
	done
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-adobe-100dpi_clean:
	rm -rf $(STATEDIR)/xorg-font-adobe-100dpi.*
	rm -rf $(PKGDIR)/xorg-font-adobe-100dpi_*
	rm -rf $(XORG_FONT_ADOBE_100DPI_DIR)

# vim: syntax=make
