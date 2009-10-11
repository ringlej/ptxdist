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
PACKAGES-$(PTXCONF_XORG_FONT_BH_LUCIDATYPEWRITER_75DPI) += xorg-font-bh-lucidatypewriter-75dpi

#
# Paths and names
#
XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_VERSION	:= 1.0.1
XORG_FONT_BH_LUCIDATYPEWRITER_75DPI		:= font-bh-lucidatypewriter-75dpi-$(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_VERSION)
XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_SUFFIX	:= tar.bz2
XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI).$(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_SUFFIX)
XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI).$(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_SUFFIX)
XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_DIR		:= $(BUILDDIR)/$(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI)

ifdef PTXCONF_XORG_FONT_BH_LUCIDATYPEWRITER_75DPI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-bh-lucidatypewriter-75dpi_get: $(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.get

$(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.get: $(xorg-font-bh-lucidatypewriter-75dpi_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_BH_LUCIDATYPEWRITER_75DPI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-bh-lucidatypewriter-75dpi_extract: $(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.extract

$(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.extract: $(xorg-font-bh-lucidatypewriter-75dpi_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_DIR))
	@$(call extract, XORG_FONT_BH_LUCIDATYPEWRITER_75DPI)
	@$(call patchin, XORG_FONT_BH_LUCIDATYPEWRITER_75DPI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-bh-lucidatypewriter-75dpi_prepare: $(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.prepare

XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/100dpi

$(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.prepare: $(xorg-font-bh-lucidatypewriter-75dpi_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_DIR)/config.cache)
	cd $(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_DIR) && \
		$(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_PATH) $(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_ENV) \
		./configure $(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-bh-lucidatypewriter-75dpi_compile: $(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.compile

$(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.compile: $(xorg-font-bh-lucidatypewriter-75dpi_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_DIR) && $(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_PATH) make UTIL_DIR=$(SYSROOT)/usr/lib/X11/fonts/util/
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-bh-lucidatypewriter-75dpi_install: $(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.install

$(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.install: $(xorg-font-bh-lucidatypewriter-75dpi_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-bh-lucidatypewriter-75dpi_targetinstall: $(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.targetinstall

$(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.targetinstall: $(xorg-font-bh-lucidatypewriter-75dpi_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/75dpi

	@find $(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_DIR) \
		-name "*.pcf.gz" -a \! -name "*ISO8859*" \
		-o -name "*ISO8859-1.pcf.gz" \
		-o -name "*ISO8859-15.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/75dpi; \
	done

ifdef PTXCONF_XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_TRANS
	@find $(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_DIR) \
		-name "*ISO8859-2.pcf.gz" \
		-o -name "*ISO8859-3.pcf.gz" \
		-o -name "*ISO8859-4.pcf.gz" \
		-o -name "*ISO8859-9.pcf.gz" \
		-o -name "*ISO8859-10.pcf.gz" \
		-o -name "*ISO8859-13.pcf.gz" \
		-o -name "*ISO8859-14.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/75dpi; \
	done
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-bh-lucidatypewriter-75dpi_clean:
	rm -rf $(STATEDIR)/xorg-font-bh-lucidatypewriter-75dpi.*
	rm -rf $(PKGDIR)/xorg-font-bh-lucidatypewriter-75dpi_*
	rm -rf $(XORG_FONT_BH_LUCIDATYPEWRITER_75DPI_DIR)

# vim: syntax=make
