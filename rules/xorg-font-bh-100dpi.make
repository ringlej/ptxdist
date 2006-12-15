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
PACKAGES-$(PTXCONF_XORG_FONT_BH_100DPI) += xorg-font-bh-100dpi

#
# Paths and names
#
XORG_FONT_BH_100DPI_VERSION	:= 1.0.0
XORG_FONT_BH_100DPI		:= font-bh-100dpi-X11R7.0-$(XORG_FONT_BH_100DPI_VERSION)
XORG_FONT_BH_100DPI_SUFFIX	:= tar.bz2
XORG_FONT_BH_100DPI_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.0/src/font//$(XORG_FONT_BH_100DPI).$(XORG_FONT_BH_100DPI_SUFFIX)
XORG_FONT_BH_100DPI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_BH_100DPI).$(XORG_FONT_BH_100DPI_SUFFIX)
XORG_FONT_BH_100DPI_DIR		:= $(BUILDDIR)/$(XORG_FONT_BH_100DPI)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-bh-100dpi_get: $(STATEDIR)/xorg-font-bh-100dpi.get

$(STATEDIR)/xorg-font-bh-100dpi.get: $(xorg-font-bh-100dpi_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_BH_100DPI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_BH_100DPI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-bh-100dpi_extract: $(STATEDIR)/xorg-font-bh-100dpi.extract

$(STATEDIR)/xorg-font-bh-100dpi.extract: $(xorg-font-bh-100dpi_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_BH_100DPI_DIR))
	@$(call extract, XORG_FONT_BH_100DPI)
	@$(call patchin, XORG_FONT_BH_100DPI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-bh-100dpi_prepare: $(STATEDIR)/xorg-font-bh-100dpi.prepare

XORG_FONT_BH_100DPI_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_BH_100DPI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_BH_100DPI_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-font-bh-100dpi.prepare: $(xorg-font-bh-100dpi_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_BH_100DPI_DIR)/config.cache)
	cd $(XORG_FONT_BH_100DPI_DIR) && \
		$(XORG_FONT_BH_100DPI_PATH) $(XORG_FONT_BH_100DPI_ENV) \
		./configure $(XORG_FONT_BH_100DPI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-bh-100dpi_compile: $(STATEDIR)/xorg-font-bh-100dpi.compile

$(STATEDIR)/xorg-font-bh-100dpi.compile: $(xorg-font-bh-100dpi_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_BH_100DPI_DIR) && $(XORG_FONT_BH_100DPI_PATH) make UTIL_DIR=$(SYSROOT)/usr/lib/X11/fonts/util/
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-bh-100dpi_install: $(STATEDIR)/xorg-font-bh-100dpi.install

$(STATEDIR)/xorg-font-bh-100dpi.install: $(xorg-font-bh-100dpi_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-bh-100dpi_targetinstall: $(STATEDIR)/xorg-font-bh-100dpi.targetinstall

$(STATEDIR)/xorg-font-bh-100dpi.targetinstall: $(xorg-font-bh-100dpi_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-font-bh-100dpi)
	@$(call install_fixup, xorg-font-bh-100dpi,PACKAGE,xorg-font-bh-100dpi)
	@$(call install_fixup, xorg-font-bh-100dpi,PRIORITY,optional)
	@$(call install_fixup, xorg-font-bh-100dpi,VERSION,$(XORG_FONT_BH_100DPI_VERSION))
	@$(call install_fixup, xorg-font-bh-100dpi,SECTION,base)
	@$(call install_fixup, xorg-font-bh-100dpi,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-font-bh-100dpi,DEPENDS,)
	@$(call install_fixup, xorg-font-bh-100dpi,DESCRIPTION,missing)

	@cd $(XORG_FONT_BH_100DPI_DIR); \
	for file in `find . -name "*.pcf.gz" -a \! -name "*ISO8859*"`; do	\
		if [ -e $$file ]; then \
			$(call install_copy, xorg-font-bh-100dpi, 0, 0, 0644, $$file, $(XORG_FONTDIR)/100dpi/$$file, n); \
		fi; \
	done;

	@cd $(XORG_FONT_BH_100DPI_DIR); \
	for file in *{ISO8859-15,ISO8859-1}.pcf.gz; do \
		if [ -e $$file ]; then \
			$(call install_copy, xorg-font-bh-100dpi, 0, 0, 0644, $$file, $(XORG_FONTDIR)/100dpi/$$file, n); \
		fi; \
	done;

ifdef PTXCONF_XORG_FONT_BH_100DPI_TRANS
	@cd $(XORG_FONT_BH_100DPI_DIR); \
	for file in *{ISO8859-2,ISO8859-3,ISO8859-4,ISO8859-9,ISO8859-10,ISO8859-13,ISO8859-14}.pcf.gz; do \
		if [ -e $$file ]; then \
			$(call install_copy, xorg-font-bh-100dpi, 0, 0, 0644, $$file, $(XORG_FONTDIR)/100dpi/$$file, n); \
		fi; \
	done;
endif

	@$(call install_finish, xorg-font-bh-100dpi)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-bh-100dpi_clean:
	rm -rf $(STATEDIR)/xorg-font-bh-100dpi.*
	rm -rf $(IMAGEDIR)/xorg-font-bh-100dpi_*
	rm -rf $(XORG_FONT_BH_100DPI_DIR)

# vim: syntax=make
