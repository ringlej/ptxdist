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
PACKAGES-$(PTXCONF_XORG_FONT_BITSTREAM_100DPI) += xorg-font-bitstream-100dpi

#
# Paths and names
#
XORG_FONT_BITSTREAM_100DPI_VERSION	:= 1.0.1
XORG_FONT_BITSTREAM_100DPI		:= font-bitstream-100dpi-$(XORG_FONT_BITSTREAM_100DPI_VERSION)
XORG_FONT_BITSTREAM_100DPI_SUFFIX	:= tar.bz2
XORG_FONT_BITSTREAM_100DPI_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_BITSTREAM_100DPI).$(XORG_FONT_BITSTREAM_100DPI_SUFFIX)
XORG_FONT_BITSTREAM_100DPI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_BITSTREAM_100DPI).$(XORG_FONT_BITSTREAM_100DPI_SUFFIX)
XORG_FONT_BITSTREAM_100DPI_DIR		:= $(BUILDDIR)/$(XORG_FONT_BITSTREAM_100DPI)

ifdef PTXCONF_XORG_FONT_BITSTREAM_100DPI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-bitstream-100dpi.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-bitstream-100dpi_get: $(STATEDIR)/xorg-font-bitstream-100dpi.get

$(STATEDIR)/xorg-font-bitstream-100dpi.get: $(xorg-font-bitstream-100dpi_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_BITSTREAM_100DPI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_BITSTREAM_100DPI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-bitstream-100dpi_extract: $(STATEDIR)/xorg-font-bitstream-100dpi.extract

$(STATEDIR)/xorg-font-bitstream-100dpi.extract: $(xorg-font-bitstream-100dpi_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_BITSTREAM_100DPI_DIR))
	@$(call extract, XORG_FONT_BITSTREAM_100DPI)
	@$(call patchin, XORG_FONT_BITSTREAM_100DPI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-bitstream-100dpi_prepare: $(STATEDIR)/xorg-font-bitstream-100dpi.prepare

XORG_FONT_BITSTREAM_100DPI_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_BITSTREAM_100DPI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_BITSTREAM_100DPI_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/100dpi

$(STATEDIR)/xorg-font-bitstream-100dpi.prepare: $(xorg-font-bitstream-100dpi_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_BITSTREAM_100DPI_DIR)/config.cache)
	cd $(XORG_FONT_BITSTREAM_100DPI_DIR) && \
		$(XORG_FONT_BITSTREAM_100DPI_PATH) $(XORG_FONT_BITSTREAM_100DPI_ENV) \
		./configure $(XORG_FONT_BITSTREAM_100DPI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-bitstream-100dpi_compile: $(STATEDIR)/xorg-font-bitstream-100dpi.compile

$(STATEDIR)/xorg-font-bitstream-100dpi.compile: $(xorg-font-bitstream-100dpi_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_BITSTREAM_100DPI_DIR) && $(XORG_FONT_BITSTREAM_100DPI_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-bitstream-100dpi_install: $(STATEDIR)/xorg-font-bitstream-100dpi.install

$(STATEDIR)/xorg-font-bitstream-100dpi.install: $(xorg-font-bitstream-100dpi_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-bitstream-100dpi_targetinstall: $(STATEDIR)/xorg-font-bitstream-100dpi.targetinstall

$(STATEDIR)/xorg-font-bitstream-100dpi.targetinstall: $(xorg-font-bitstream-100dpi_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/100dpi

	@find $(XORG_FONT_BITSTREAM_100DPI_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/100dpi; \
	done

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-bitstream-100dpi_clean:
	rm -rf $(STATEDIR)/xorg-font-bitstream-100dpi.*
	rm -rf $(PKGDIR)/xorg-font-bitstream-100dpi_*
	rm -rf $(XORG_FONT_BITSTREAM_100DPI_DIR)

# vim: syntax=make
