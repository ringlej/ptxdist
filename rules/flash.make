# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_FLASH))
PACKAGES += flash
endif

#
# Paths and names 
#
FLASH			= flash-0.9.5
FLASH_URL 		= http://www.netsoc.ucd.ie/flash/$(FLASH).tar.gz
FLASH_SOURCE		= $(SRCDIR)/$(FLASH).tar.gz
FLASH_DIR 		= $(BUILDDIR)/$(FLASH)
FLASH_EXTRACT		= gzip -dc

FLASH_PATCH		= flash-0.9.5-ptx2.diff
FLASH_PATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FLASH_PATCH)
FLASH_PATCH_SOURCE	= $(SRCDIR)/$(FLASH_PATCH)
FLASH_PATCH_EXTRACT	= cat


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

flash_get: $(STATEDIR)/flash.get

flash_get_deps	=  $(FLASH_SOURCE)
flash_get_deps	+= $(FLASH_PATCH_SOURCE)
flash_get_deps	+= $(STATEDIR)/flash-patches.get

$(STATEDIR)/flash.get: $(flash_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/flash-patches.get:
	@$(call targetinfo, $@)
	@$(call get_patches, $(FLASH))
	touch $@

$(FLASH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(FLASH_URL))

$(FLASH_PATCH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(FLASH_PATCH_URL))


# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

flash_extract: $(STATEDIR)/flash.extract

$(STATEDIR)/flash.extract: $(STATEDIR)/flash.get
	@$(call targetinfo, $@)
	$(FLASH_EXTRACT) $(FLASH_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	cd $(FLASH_DIR) && patch -p1 < $(FLASH_PATCH_SOURCE)
	@$(call patchin, $(FLASH), $(FLASH_DIR))
	touch $@


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

flash_prepare: $(STATEDIR)/flash.prepare

#
# dependencies
#
flash_prepare_deps =  \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/ncurses.compile \
	$(STATEDIR)/autoconf257.install \
        $(STATEDIR)/flash.extract

FLASH_PATH	= PATH=$(PTXCONF_PREFIX)/$(AUTOCONF257)/bin:$(CROSS_PATH)
FLASH_ENV	= $(CROSS_ENV)

#
# autoconf
#
FLASH_AUTOCONF	=  --prefix=/usr
FLASH_AUTOCONF	+= --build=$(GNU_HOST)
FLASH_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
FLASH_AUTOCONF	+= --with-ncurses-path=$(NCURSES_DIR)

$(STATEDIR)/flash.prepare: $(flash_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FLASH_BUILDDIR))
	mkdir -p $(FLASH_DIR)
	rm -f $(FLASH_DIR)/configure
	cd $(FLASH_DIR) && autoconf
#	# Workaround for broken autoconf magic for cross compilation
	cd $(FLASH_DIR) && \
		ac_cv_func_getpgrp_void=yes	\
		ac_cv_func_setpgrp_void=yes	\
		ac_cv_sizeof_long_long=8	\
		ac_cv_func_memcmp_clean=yes	\
		ac_cv_func_getrlimit=yes	\
		$(FLASH_PATH) $(FLASH_ENV) $(FLASH_DIR)/configure $(FLASH_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

flash_compile: $(STATEDIR)/flash.compile

$(STATEDIR)/flash.compile: $(STATEDIR)/flash.prepare 
	@$(call targetinfo, $@)
	$(FLASH_PATH) $(FLASH_ENV) make -C $(FLASH_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

flash_install: $(STATEDIR)/flash.install

$(STATEDIR)/flash.install: $(STATEDIR)/flash.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

flash_targetinstall: $(STATEDIR)/flash.targetinstall

flash_targetinstall_deps =  $(STATEDIR)/flash.install
flash_targetinstall_deps += $(STATEDIR)/ncurses.targetinstall

$(STATEDIR)/flash.targetinstall: $(flash_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/usr/bin
	install $(FLASH_DIR)/flash $(ROOTDIR)/usr/bin
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/flash
	install -d $(ROOTDIR)/usr/lib/flash/
	install $(FLASH_DIR)/modules/alarms $(ROOTDIR)/usr/lib/flash/
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/lib/flash/alarms
	install $(FLASH_DIR)/modules/background $(ROOTDIR)/usr/lib/flash/
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/lib/flash/background
	install $(FLASH_DIR)/modules/countdown $(ROOTDIR)/usr/lib/flash/
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/lib/flash/countdown
	touch $@
# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

flash_clean: 
	rm -rf $(STATEDIR)/flash.* $(FLASH_DIR)

# vim: syntax=make
