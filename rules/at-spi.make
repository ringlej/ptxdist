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
PACKAGES-$(PTXCONF_AT_SPI) += at-spi

#
# Paths and names
#
AT_SPI_VERSION	= 1.3.13
AT_SPI		= at-spi-$(AT_SPI_VERSION)
AT_SPI_SUFFIX	= tar.bz2
AT_SPI_URL	= ftp://ftp.gnome.org/pub/GNOME/sources/at-spi/1.3/$(AT_SPI).$(AT_SPI_SUFFIX)
AT_SPI_SOURCE	= $(SRCDIR)/$(AT_SPI).$(AT_SPI_SUFFIX)
AT_SPI_DIR	= $(BUILDDIR)/$(AT_SPI)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

at-spi_get: $(STATEDIR)/at-spi.get

$(STATEDIR)/at-spi.get: $(at-spi_get_deps_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(AT_SPI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(AT_SPI_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

at-spi_extract: $(STATEDIR)/at-spi.extract

$(STATEDIR)/at-spi.extract: $(at-spi_extract_deps_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(AT_SPI_DIR))
	@$(call extract, $(AT_SPI_SOURCE))
	@$(call patchin, $(AT_SPI))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

at-spi_prepare: $(STATEDIR)/at-spi.prepare

AT_SPI_PATH	=  PATH=$(CROSS_PATH)
AT_SPI_ENV 	=  $(CROSS_ENV)
#AT_SPI_ENV	+=

#
# autoconf
#
AT_SPI_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/at-spi.prepare: $(at-spi_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(AT_SPI_DIR)/config.cache)
	cd $(AT_SPI_DIR) && \
		$(AT_SPI_PATH) $(AT_SPI_ENV) \
		./configure $(AT_SPI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

at-spi_compile: $(STATEDIR)/at-spi.compile

$(STATEDIR)/at-spi.compile: $(at-spi_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(AT_SPI_DIR) && $(AT_SPI_PATH) make 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

at-spi_install: $(STATEDIR)/at-spi.install

$(STATEDIR)/at-spi.install: $(at-spi_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, AT_SPI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

at-spi_targetinstall: $(STATEDIR)/at-spi.targetinstall

$(STATEDIR)/at-spi.targetinstall: $(at-spi_targetinstall_deps_default)
	@$(call targetinfo, $@)
	# FIXME: something to add to the target for at-spi? 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

at-spi_clean:
	rm -rf $(STATEDIR)/at-spi.*
	rm -rf $(AT_SPI_DIR)

# vim: syntax=make
