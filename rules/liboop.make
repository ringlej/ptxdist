# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LIBOOP
PACKAGES += liboop
endif

#
# Paths and names
#
LIBOOP_VERSION	= 0.9
LIBOOP		= liboop-$(LIBOOP_VERSION)
LIBOOP_SUFFIX	= tar.bz2
LIBOOP_URL	= http://download.ofb.net/liboop/$(LIBOOP).$(LIBOOP_SUFFIX)
LIBOOP_SOURCE	= $(SRCDIR)/$(LIBOOP).$(LIBOOP_SUFFIX)
LIBOOP_DIR	= $(BUILDDIR)/$(LIBOOP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

liboop_get: $(STATEDIR)/liboop.get

liboop_get_deps = $(LIBOOP_SOURCE)

$(STATEDIR)/liboop.get: $(liboop_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(LIBOOP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBOOP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

liboop_extract: $(STATEDIR)/liboop.extract

liboop_extract_deps = $(STATEDIR)/liboop.get

$(STATEDIR)/liboop.extract: $(liboop_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBOOP_DIR))
	@$(call extract, $(LIBOOP_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

liboop_prepare: $(STATEDIR)/liboop.prepare

#
# dependencies
#
liboop_prepare_deps = \
	$(STATEDIR)/liboop.extract \
	$(STATEDIR)/virtual-xchain.install

LIBOOP_PATH	=  PATH=$(CROSS_PATH)
#
# override glibc-config to prevent from using the host system's
#
LIBOOP_ENV = \
	$(CROSS_ENV) \
	ac_cv_prog_PROG_GLIB_CONFIG=

#
# autoconf
#
LIBOOP_AUTOCONF	= \
	--prefix=$(CROSS_LIB_DIR) \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--without-tcl \
	--without-glib

$(STATEDIR)/liboop.prepare: $(liboop_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBOOP_DIR)/config.cache)
	cd $(LIBOOP_DIR) && \
		$(LIBOOP_PATH) $(LIBOOP_ENV) \
		./configure $(LIBOOP_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

liboop_compile: $(STATEDIR)/liboop.compile

liboop_compile_deps = $(STATEDIR)/liboop.prepare

$(STATEDIR)/liboop.compile: $(liboop_compile_deps)
	@$(call targetinfo, $@)
	$(LIBOOP_PATH) make -C $(LIBOOP_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

liboop_install: $(STATEDIR)/liboop.install

$(STATEDIR)/liboop.install: $(STATEDIR)/liboop.compile
	@$(call targetinfo, $@)
	$(LIBOOP_PATH) make -C $(LIBOOP_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

liboop_targetinstall: $(STATEDIR)/liboop.targetinstall

liboop_targetinstall_deps = $(STATEDIR)/liboop.compile

$(STATEDIR)/liboop.targetinstall: $(liboop_targetinstall_deps)
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/lib
	cp -a $(PTXCONF_PREFIX)/lib/liboop.so* $(ROOTDIR)/usr/lib/
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/usr/lib/liboop.so*
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

liboop_clean:
	rm -rf $(STATEDIR)/liboop.*
	rm -rf $(LIBOOP_DIR)

# vim: syntax=make
