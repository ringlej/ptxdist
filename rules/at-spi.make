# -*-makefile-*-
# $Id: at-spi.make,v 1.1 2004/02/25 06:20:08 bsp Exp $
#
# Copyright (C) 2003 by BSP
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_AT-SPI
PACKAGES += at-spi
endif

#
# Paths and names
#
AT-SPI_VERSION	= 1.3.13
AT-SPI		= at-spi-$(AT-SPI_VERSION)
AT-SPI_SUFFIX	= tar.bz2
AT-SPI_URL	= ftp://ftp.gnome.org/pub/GNOME/sources/at-spi/1.3/$(AT-SPI).$(AT-SPI_SUFFIX)
AT-SPI_SOURCE	= $(SRCDIR)/$(AT-SPI).$(AT-SPI_SUFFIX)
AT-SPI_DIR	= $(BUILDDIR)/$(AT-SPI)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

at-spi_get: $(STATEDIR)/at-spi.get

at-spi_get_deps = $(AT-SPI_SOURCE)

$(STATEDIR)/at-spi.get: $(at-spi_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(AT-SPI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(AT-SPI_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

at-spi_extract: $(STATEDIR)/at-spi.extract

at-spi_extract_deps = $(STATEDIR)/at-spi.get

$(STATEDIR)/at-spi.extract: $(at-spi_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(AT-SPI_DIR))
	@$(call extract, $(AT-SPI_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

at-spi_prepare: $(STATEDIR)/at-spi.prepare

#
# dependencies
#
at-spi_prepare_deps = \
	$(STATEDIR)/at-spi.extract \
	$(STATEDIR)/virtual-xchain.install

AT-SPI_PATH	=  PATH=$(CROSS_PATH)
AT-SPI_ENV 	=  $(CROSS_ENV)
#AT-SPI_ENV	+=

#
# autoconf
#
AT-SPI_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/at-spi.prepare: $(at-spi_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(AT-SPI_DIR)/config.cache)
	cd $(AT-SPI_DIR) && \
		$(AT-SPI_PATH) $(AT-SPI_ENV) \
		./configure $(AT-SPI_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

at-spi_compile: $(STATEDIR)/at-spi.compile

at-spi_compile_deps = $(STATEDIR)/at-spi.prepare

$(STATEDIR)/at-spi.compile: $(at-spi_compile_deps)
	@$(call targetinfo, $@)
	cd $(AT-SPI_DIR) && \
	   $(AT-SPI_PATH) make 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

at-spi_install: $(STATEDIR)/at-spi.install

$(STATEDIR)/at-spi.install: $(STATEDIR)/at-spi.compile
	@$(call targetinfo, $@)
	cd $(AT-SPI_DIR) && \       
	   $(AT-SPI_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

at-spi_targetinstall: $(STATEDIR)/at-spi.targetinstall

at-spi_targetinstall_deps = $(STATEDIR)/at-spi.compile

$(STATEDIR)/at-spi.targetinstall: $(at-spi_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

at-spi_clean:
	rm -rf $(STATEDIR)/at-spi.*
	rm -rf $(AT-SPI_DIR)

# vim: syntax=make
