# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_XVKBD
PACKAGES += xvkbd
endif

#
# Paths and names
#
XVKBD_VERSION		= 2.5a
XVKBD			= xvkbd-$(XVKBD_VERSION)
XVKBD_SUFFIX		= tar.gz
XVKBD_URL		= http://member.nifty.ne.jp/tsato/xvkbd/$(XVKBD).$(XVKBD_SUFFIX)
XVKBD_SOURCE		= $(SRCDIR)/$(XVKBD).$(XVKBD_SUFFIX)
XVKBD_DIR		= $(BUILDDIR)/$(XVKBD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xvkbd_get: $(STATEDIR)/xvkbd.get

xvkbd_get_deps	=  $(XVKBD_SOURCE)

$(STATEDIR)/xvkbd.get: $(xvkbd_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(XVKBD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XVKBD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xvkbd_extract: $(STATEDIR)/xvkbd.extract

xvkbd_extract_deps	=  $(STATEDIR)/xvkbd.get

$(STATEDIR)/xvkbd.extract: $(xvkbd_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XVKBD_DIR))
	@$(call extract, $(XVKBD_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xvkbd_prepare: $(STATEDIR)/xvkbd.prepare

#
# dependencies
#
xvkbd_prepare_deps =  \
	$(STATEDIR)/xvkbd.extract \
	$(STATEDIR)/virtual-xchain.install

XVKBD_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
XVKBD_ENV 	=  $(CROSS_ENV)
#XVKBD_ENV	+=

$(STATEDIR)/xvkbd.prepare: $(xvkbd_prepare_deps)
	@$(call targetinfo, $@)
	cd $(XVKBD_DIR) && \
		$(XVKBD_PATH) $(XVKBD_ENV) \
		xmkmf
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xvkbd_compile: $(STATEDIR)/xvkbd.compile

xvkbd_compile_deps =  $(STATEDIR)/xvkbd.prepare

$(STATEDIR)/xvkbd.compile: $(xvkbd_compile_deps)
	@$(call targetinfo, $@)
	$(XVKBD_PATH) $(XVKBD_ENV) make -C $(XVKBD_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xvkbd_install: $(STATEDIR)/xvkbd.install

$(STATEDIR)/xvkbd.install: $(STATEDIR)/xvkbd.compile
	@$(call targetinfo, $@)
	$(XVKBD_PATH) $(XVKBD_ENV) make -C $(XVKBD_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xvkbd_targetinstall: $(STATEDIR)/xvkbd.targetinstall

xvkbd_targetinstall_deps	=  $(STATEDIR)/xvkbd.compile

$(STATEDIR)/xvkbd.targetinstall: $(xvkbd_targetinstall_deps)
	@$(call targetinfo, $@)
	install $(XVKBD_DIR)/xvkbd $(ROOTDIR)/usr/X11R6/bin/
	install $(XVKBD_DIR)/XVkbd-common.ad $(ROOTDIR)/etc/X11/app-defaults/XVkbd-common
	install $(XVKBD_DIR)/XVkbd-german.ad $(ROOTDIR)/etc/X11/app-defaults/XVkbd-german
	echo '#include "XVkbd-german"' > $(ROOTDIR)/etc/X11/app-defaults/XVkbd
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xvkbd_clean:
	rm -rf $(STATEDIR)/xvkbd.*
	rm -rf $(XVKBD_DIR)

# vim: syntax=make
