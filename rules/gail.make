# -*-makefile-*-
# $Id: gail.make,v 1.1 2004/02/25 06:20:08 bsp Exp $
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
ifdef PTXCONF_GAIL
PACKAGES += gail
endif

#
# Paths and names
#
GAIL_VERSION	= 1.5.5
GAIL		= gail-$(GAIL_VERSION)
GAIL_SUFFIX	= tar.bz2
GAIL_URL	= ftp://ftp.gnome.org/pub/GNOME/sources/gail/1.5/$(GAIL).$(GAIL_SUFFIX)
GAIL_SOURCE	= $(SRCDIR)/$(GAIL).$(GAIL_SUFFIX)
GAIL_DIR	= $(BUILDDIR)/$(GAIL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gail_get: $(STATEDIR)/gail.get

gail_get_deps = $(GAIL_SOURCE)

$(STATEDIR)/gail.get: $(gail_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(GAIL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GAIL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gail_extract: $(STATEDIR)/gail.extract

gail_extract_deps = $(STATEDIR)/gail.get

$(STATEDIR)/gail.extract: $(gail_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GAIL_DIR))
	@$(call extract, $(GAIL_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gail_prepare: $(STATEDIR)/gail.prepare

#
# dependencies
#
gail_prepare_deps = \
	$(STATEDIR)/gail.extract \
	$(STATEDIR)/virtual-xchain.install

GAIL_PATH	=  PATH=$(CROSS_PATH)
GAIL_ENV 	=  $(CROSS_ENV)
GAIL_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
GAIL_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/gail.prepare: $(gail_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GAIL_DIR)/config.cache)
	cd $(GAIL_DIR) && \
		$(GAIL_PATH) $(GAIL_ENV) \
		./configure $(GAIL_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gail_compile: $(STATEDIR)/gail.compile

gail_compile_deps = $(STATEDIR)/gail.prepare

$(STATEDIR)/gail.compile: $(gail_compile_deps)
	@$(call targetinfo, $@)
	cd $(GAIL_DIR) && \
	$(GAIL_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gail_install: $(STATEDIR)/gail.install

$(STATEDIR)/gail.install: $(STATEDIR)/gail.compile
	@$(call targetinfo, $@)
	cd $(GAIL_DIR) && \
	   $(GAIL_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gail_targetinstall: $(STATEDIR)/gail.targetinstall

gail_targetinstall_deps = $(STATEDIR)/gail.compile

$(STATEDIR)/gail.targetinstall: $(gail_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gail_clean:
	rm -rf $(STATEDIR)/gail.*
	rm -rf $(GAIL_DIR)

# vim: syntax=make
