# -*-makefile-*-
# $Id$
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
PACKAGES-$(PTXCONF_AT-SPI) += at-spi

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
	@$(call touch, $@)

$(AT-SPI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(AT-SPI_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

at-spi_extract: $(STATEDIR)/at-spi.extract

at-spi_extract_deps = $(call deps_extract, AT-SPI)

$(STATEDIR)/at-spi.extract: $(at-spi_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(AT-SPI_DIR))
	@$(call extract, $(AT-SPI_SOURCE))
	@$(call patchin, $(AT-SPI))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

at-spi_prepare: $(STATEDIR)/at-spi.prepare

#
# dependencies
#
at-spi_prepare_deps = $(call deps_prepare, AT-SPI)

AT-SPI_PATH	=  PATH=$(CROSS_PATH)
AT-SPI_ENV 	=  $(CROSS_ENV)
#AT-SPI_ENV	+=

#
# autoconf
#
AT-SPI_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/at-spi.prepare: $(at-spi_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(AT-SPI_DIR)/config.cache)
	cd $(AT-SPI_DIR) && \
		$(AT-SPI_PATH) $(AT-SPI_ENV) \
		./configure $(AT-SPI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

at-spi_compile: $(STATEDIR)/at-spi.compile

at-spi_compile_deps = $(call deps_compile, AT-SPI)

$(STATEDIR)/at-spi.compile: $(at-spi_compile_deps)
	@$(call targetinfo, $@)
	cd $(AT-SPI_DIR) && $(AT-SPI_PATH) make 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

at-spi_install: $(STATEDIR)/at-spi.install

at-spi_install_deps = $(call deps_install, AT-SPI)

$(STATEDIR)/at-spi.install: $(at-spi_install_deps)
	@$(call targetinfo, $@)
	@$(call install, AT-SPI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

at-spi_targetinstall: $(STATEDIR)/at-spi.targetinstall

at-spi_targetinstall_deps = $(call deps_targetinstall, AT-SPI)

$(STATEDIR)/at-spi.targetinstall: $(at-spi_targetinstall_deps)
	@$(call targetinfo, $@)
	# FIXME: something to add to the target for at-spi? 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

at-spi_clean:
	rm -rf $(STATEDIR)/at-spi.*
	rm -rf $(AT-SPI_DIR)

# vim: syntax=make
