# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_WIRELESS
PACKAGES += wireless
endif

#
# Paths and names 
#
WIRELESS_VERSION	= 26
WIRELESS		= wireless_tools.$(WIRELESS_VERSION)
WIRELESS_SUFFIX		= tar.gz
WIRELESS_URL		= http://pcmcia-cs.sourceforge.net/ftp/contrib/$(WIRELESS).$(WIRELESS_SUFFIX)
WIRELESS_SOURCE		= $(SRCDIR)/$(WIRELESS).$(WIRELESS_SUFFIX)
WIRELESS_DIR 		= $(BUILDDIR)/$(WIRELESS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

wireless_get: $(STATEDIR)/wireless.get

wireless_get_deps	= $(WIRELESS_SOURCE)

$(STATEDIR)/wireless.get: $(wireless_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(WIRELESS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(WIRELESS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

wireless_extract: $(STATEDIR)/wireless.extract

wireless_extract_deps	= $(STATEDIR)/wireless.get

$(STATEDIR)/wireless.extract: $(wireless_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(WIRELESS_DIR))
	@$(call extract, $(WIRELESS_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

wireless_prepare: $(STATEDIR)/wireless.prepare

wireless_prepare_deps	= $(STATEDIR)/wireless.extract

$(STATEDIR)/wireless.prepare: $(wireless_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------
WIRELESS_PATH	=  PATH=$(CROSS_PATH)
WIRELESS_ENV 	=  $(CROSS_ENV)

wireless_compile: $(STATEDIR)/wireless.compile

wireless_compile_deps	= $(STATEDIR)/wireless.prepare

$(STATEDIR)/wireless.compile: $(wireless_compile_deps) 
	@$(call targetinfo, $@)
	cd $(WIRELESS_DIR) && $(WIRELESS_PATH) $(WIRELESS_ENV) make CC=${CROSS_CC}
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

wireless_install: $(STATEDIR)/wireless.install

wireless_compile_deps	= $(STATEDIR)/wireless.compile

$(STATEDIR)/wireless.install: $(wireless_compile_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

wireless_targetinstall: $(STATEDIR)/wireless.targetinstall

$(STATEDIR)/wireless.targetinstall: $(STATEDIR)/wireless.install
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/usr/sbin 
	install $(WIRELESS_DIR)/iwconfig $(ROOTDIR)/usr/sbin
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/iwconfig
	install $(WIRELESS_DIR)/iwlist   $(ROOTDIR)/usr/sbin
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/iwlist
	install $(WIRELESS_DIR)/iwpriv   $(ROOTDIR)/usr/sbin
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/iwpriv
	install $(WIRELESS_DIR)/iwspy    $(ROOTDIR)/usr/sbin
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/iwspy
	install $(WIRELESS_DIR)/iwgetid  $(ROOTDIR)/usr/sbin
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/iwgetid
	install $(WIRELESS_DIR)/iwevent  $(ROOTDIR)/usr/sbin
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/iwevent
	touch $@
# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

wireless_clean: 
	rm -rf $(STATEDIR)/wireless.* $(WIRELESS_DIR)

# vim: syntax=make
