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
PACKAGES-$(PTXCONF_LIBGLADE) += libglade

#
# Paths and names
#
LIBGLADE_VERSION	= 2.3.2
LIBGLADE		= libglade-$(LIBGLADE_VERSION)
LIBGLADE_SUFFIX		= tar.bz2
LIBGLADE_URL		= ftp://ftp.gnome.org/pub/GNOME/sources/libglade/2.3/$(LIBGLADE).$(LIBGLADE_SUFFIX)
LIBGLADE_SOURCE		= $(SRCDIR)/$(LIBGLADE).$(LIBGLADE_SUFFIX)
LIBGLADE_DIR		= $(BUILDDIR)/$(LIBGLADE)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libglade_get: $(STATEDIR)/libglade.get

libglade_get_deps = $(LIBGLADE_SOURCE)

$(STATEDIR)/libglade.get: $(libglade_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBGLADE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBGLADE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libglade_extract: $(STATEDIR)/libglade.extract

libglade_extract_deps = $(STATEDIR)/libglade.get

$(STATEDIR)/libglade.extract: $(libglade_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGLADE_DIR))
	@$(call extract, $(LIBGLADE_SOURCE))
	@$(call patchin, $(LIBGLADE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libglade_prepare: $(STATEDIR)/libglade.prepare

#
# dependencies
#
libglade_prepare_deps = \
	$(STATEDIR)/libglade.extract \
	$(STATEDIR)/libxml2.install \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/gtk22.install	

LIBGLADE_PATH	=  PATH=$(CROSS_PATH)
LIBGLADE_ENV 	=  $(CROSS_ENV)
LIBGLADE_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
LIBGLADE_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libglade.prepare: $(libglade_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGLADE_DIR)/config.cache)
	cd $(LIBGLADE_DIR) && \
		$(LIBGLADE_PATH) $(LIBGLADE_ENV) \
		./configure $(LIBGLADE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libglade_compile: $(STATEDIR)/libglade.compile

libglade_compile_deps = $(STATEDIR)/libglade.prepare

$(STATEDIR)/libglade.compile: $(libglade_compile_deps)
	@$(call targetinfo, $@)
	cd $(LIBGLADE_DIR) && $(LIBGLADE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libglade_install: $(STATEDIR)/libglade.install

$(STATEDIR)/libglade.install: $(STATEDIR)/libglade.compile
	@$(call targetinfo, $@)
	# FIXME: this is not a hosttool -> targetinstall? 
	@$(call install, LIBGLADE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libglade_targetinstall: $(STATEDIR)/libglade.targetinstall

libglade_targetinstall_deps = $(STATEDIR)/libglade.compile

$(STATEDIR)/libglade.targetinstall: $(libglade_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libglade_clean:
	rm -rf $(STATEDIR)/libglade.*
	rm -rf $(IMAGEDIR)/libglade_*
	rm -rf $(LIBGLADE_DIR)

# vim: syntax=make
