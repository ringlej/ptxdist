# -*-makefile-*-
# $Id: template 3079 2005-09-02 18:09:51Z rsc $
#
# Copyright (C) 2005 by Sascha Hauer
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_TSLIB
PACKAGES += tslib
endif

#
# Paths and names
#
TSLIB_VERSION	= 0.0.2
TSLIB		= tslib-$(TSLIB_VERSION)
TSLIB_SUFFIX		= tar.bz2
TSLIB_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(TSLIB).$(TSLIB_SUFFIX)
TSLIB_SOURCE		= $(SRCDIR)/$(TSLIB).$(TSLIB_SUFFIX)
TSLIB_DIR		= $(BUILDDIR)/$(TSLIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

tslib_get: $(STATEDIR)/tslib.get

tslib_get_deps = $(TSLIB_SOURCE)

$(STATEDIR)/tslib.get: $(tslib_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(TSLIB))
	$(call touch, $@)

$(TSLIB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(TSLIB_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tslib_extract: $(STATEDIR)/tslib.extract

tslib_extract_deps = $(STATEDIR)/tslib.get

$(STATEDIR)/tslib.extract: $(tslib_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(TSLIB_DIR))
	@$(call extract, $(TSLIB_SOURCE))
	@$(call patchin, $(TSLIB))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tslib_prepare: $(STATEDIR)/tslib.prepare

#
# dependencies
#
tslib_prepare_deps = \
	$(STATEDIR)/tslib.extract \
	$(STATEDIR)/virtual-xchain.install

TSLIB_PATH	=  PATH=$(CROSS_PATH)
TSLIB_ENV 	=  $(CROSS_ENV)
TSLIB_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
TSLIB_AUTOCONF =  $(CROSS_AUTOCONF)
TSLIB_AUTOCONF += --prefix=/usr
TSLIB_AUTOCONF += --sysconfdir=/etc


$(STATEDIR)/tslib.prepare: $(tslib_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(TSLIB_DIR)/config.cache)
	cd $(TSLIB_DIR) && \
		$(TSLIB_PATH) $(TSLIB_ENV) \
		./configure $(TSLIB_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

tslib_compile: $(STATEDIR)/tslib.compile

tslib_compile_deps = $(STATEDIR)/tslib.prepare

$(STATEDIR)/tslib.compile: $(tslib_compile_deps)
	@$(call targetinfo, $@)
	cd $(TSLIB_DIR) && $(TSLIB_ENV) $(TSLIB_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tslib_install: $(STATEDIR)/tslib.install

$(STATEDIR)/tslib.install: $(STATEDIR)/tslib.compile
	@$(call targetinfo, $@)
	cd $(TSLIB_DIR) && $(TSLIB_ENV) $(TSLIB_PATH) make install DESTDIR=$(CROSS_LIB_DIR)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tslib_targetinstall: $(STATEDIR)/tslib.targetinstall

tslib_targetinstall_deps = $(STATEDIR)/tslib.compile

$(STATEDIR)/tslib.targetinstall: $(tslib_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,tslib)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(TSLIB_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(TSLIB_DIR)/src/.libs/libts-0.0.so.0.1.1, /usr/lib/libts-0.0.so.0.1.1)
	@$(call install_link, libts-0.0.so.0.1.1, /usr/lib/libts.so)
	@$(call install_link, libts-0.0.so.0.1.1, /usr/lib/libts-0.0.so.0)

ifdef PTXCONF_TSLIB_TS_CALIBRATE
	@$(call install_copy, 0, 0, 0755, $(TSLIB_DIR)/tests/.libs/ts_calibrate, /usr/bin/ts_calibrate)
endif
ifdef PTXCONF_TSLIB_TS_TEST
	@$(call install_copy, 0, 0, 0755, $(TSLIB_DIR)/tests/.libs/ts_test, /usr/bin/ts_test)
endif

	@$(call install_copy, 0, 0, 0755, $(TSLIB_DIR)/plugins/.libs/input.so, /usr/lib/ts/input.so)
	@$(call install_copy, 0, 0, 0755, $(TSLIB_DIR)/plugins/.libs/pthres.so, /usr/lib/ts/pthres.so)
	@$(call install_copy, 0, 0, 0755, $(TSLIB_DIR)/plugins/.libs/variance.so, /usr/lib/ts/variance.so)
	@$(call install_copy, 0, 0, 0755, $(TSLIB_DIR)/plugins/.libs/dejitter.so, /usr/lib/ts/dejitter.so)
	@$(call install_copy, 0, 0, 0755, $(TSLIB_DIR)/plugins/.libs/linear.so, /usr/lib/ts/linear.so)
	
	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tslib_clean:
	rm -rf $(STATEDIR)/tslib.*
	rm -rf $(IMAGEDIR)/tslib_*
	rm -rf $(TSLIB_DIR)

# vim: syntax=make
