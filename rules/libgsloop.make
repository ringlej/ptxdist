# -*-makefile-*-
# $Id: template 3079 2005-09-02 18:09:51Z rsc $
#
# Copyright (C) 2005 Pengutronix, Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LIBGSLOOP
PACKAGES += libgsloop
endif

#
# Paths and names
#
LIBGSLOOP_VERSION	= 0.0.3
LIBGSLOOP		= libgsloop-$(LIBGSLOOP_VERSION)
LIBGSLOOP_SUFFIX	= tar.bz2
LIBGSLOOP_URL		= http://www.pengutronix.de/software/libgsloop/downlaod/$(LIBGSLOOP).$(LIBGSLOOP_SUFFIX)
LIBGSLOOP_SOURCE	= $(SRCDIR)/$(LIBGSLOOP).$(LIBGSLOOP_SUFFIX)
LIBGSLOOP_DIR		= $(BUILDDIR)/$(LIBGSLOOP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libgsloop_get: $(STATEDIR)/libgsloop.get

libgsloop_get_deps = $(LIBGSLOOP_SOURCE)

$(STATEDIR)/libgsloop.get: $(libgsloop_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(LIBGSLOOP))
	touch $@

$(LIBGSLOOP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBGSLOOP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libgsloop_extract: $(STATEDIR)/libgsloop.extract

libgsloop_extract_deps = $(STATEDIR)/libgsloop.get

$(STATEDIR)/libgsloop.extract: $(libgsloop_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGSLOOP_DIR))
	@$(call extract, $(LIBGSLOOP_SOURCE))
	@$(call patchin, $(LIBGSLOOP))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libgsloop_prepare: $(STATEDIR)/libgsloop.prepare

#
# dependencies
#
libgsloop_prepare_deps = \
	$(STATEDIR)/libgsloop.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/librn.install

LIBGSLOOP_PATH	=  PATH=$(CROSS_PATH)
LIBGSLOOP_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LIBGSLOOP_AUTOCONF =  $(CROSS_AUTOCONF)
LIBGSLOOP_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/libgsloop.prepare: $(libgsloop_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGSLOOP_DIR)/config.cache)
	cd $(LIBGSLOOP_DIR) && \
		$(LIBGSLOOP_PATH) $(LIBGSLOOP_ENV) \
		./configure $(LIBGSLOOP_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libgsloop_compile: $(STATEDIR)/libgsloop.compile

libgsloop_compile_deps = $(STATEDIR)/libgsloop.prepare

$(STATEDIR)/libgsloop.compile: $(libgsloop_compile_deps)
	@$(call targetinfo, $@)
	cd $(LIBGSLOOP_DIR) && $(LIBGSLOOP_ENV) $(LIBGSLOOP_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libgsloop_install: $(STATEDIR)/libgsloop.install

$(STATEDIR)/libgsloop.install: $(STATEDIR)/libgsloop.compile
	@$(call targetinfo, $@)
	cd $(LIBGSLOOP_DIR) && $(LIBGSLOOP_ENV) $(LIBGSLOOP_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libgsloop_targetinstall: $(STATEDIR)/libgsloop.targetinstall

libgsloop_targetinstall_deps = \
	$(STATEDIR)/libgsloop.compile \
	$(STATEDIR)/librn.targetinstall

$(STATEDIR)/libgsloop.targetinstall: $(libgsloop_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,libgsloop)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBGSLOOP_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(LIBGSLOOP_DIR)/src/.libs/libgsloop.so.0.0.0, /usr/lib/libgsloop.so.0.0.0)
	@$(call install_link, libgsloop.so.0.0.0, /usr/lib/libgsloop.so.0)
	@$(call install_link, libgsloop.so.0.0.0, /usr/lib/libgsloop.so)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libgsloop_clean:
	rm -rf $(STATEDIR)/libgsloop.*
	rm -rf $(IMAGEDIR)/libgsloop_*
	rm -rf $(LIBGSLOOP_DIR)

# vim: syntax=make
