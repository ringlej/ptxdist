# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Sascha Hauer <sascha.hauer@gyro-net.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_SETMIXER
PACKAGES += setmixer
endif

#
# Paths and names
#
SETMIXER		= setmixer_27DEC94.orig
SETMIXER_SUFFIX		= tar.gz
SETMIXER_URL		= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/s/setmixer/$(SETMIXER).$(SETMIXER_SUFFIX)
SETMIXER_SOURCE		= $(SRCDIR)/$(SETMIXER).$(SETMIXER_SUFFIX)
SETMIXER_DIR		= $(BUILDDIR)/setmixer-27DEC94.orig

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

setmixer_get: $(STATEDIR)/setmixer.get

setmixer_get_deps = $(SETMIXER_SOURCE)

$(STATEDIR)/setmixer.get: $(setmixer_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(SETMIXER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SETMIXER_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

setmixer_extract: $(STATEDIR)/setmixer.extract

setmixer_extract_deps = $(STATEDIR)/setmixer.get

$(STATEDIR)/setmixer.extract: $(setmixer_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SETMIXER_DIR))
	@$(call extract, $(SETMIXER_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

setmixer_prepare: $(STATEDIR)/setmixer.prepare

#
# dependencies
#
setmixer_prepare_deps = \
	$(STATEDIR)/setmixer.extract \
	$(STATEDIR)/virtual-xchain.install

SETMIXER_PATH	=  PATH=$(CROSS_PATH)
SETMIXER_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/setmixer.prepare: $(setmixer_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SETMIXER_DIR)/config.cache)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

setmixer_compile: $(STATEDIR)/setmixer.compile

setmixer_compile_deps = $(STATEDIR)/setmixer.prepare

$(STATEDIR)/setmixer.compile: $(setmixer_compile_deps)
	@$(call targetinfo, $@)
	$(SETMIXER_PATH) make CC=$(PTXCONF_GNU_TARGET)-gcc  \
	      CFLAGS=$(TARGET_CFLAGS) -C $(SETMIXER_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

setmixer_install: $(STATEDIR)/setmixer.install

$(STATEDIR)/setmixer.install: $(STATEDIR)/setmixer.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

setmixer_targetinstall: $(STATEDIR)/setmixer.targetinstall

setmixer_targetinstall_deps = $(STATEDIR)/setmixer.compile

$(STATEDIR)/setmixer.targetinstall: $(setmixer_targetinstall_deps)
	@$(call targetinfo, $@)
	install $(SETMIXER_DIR)/setmixer $(ROOTDIR)/usr/bin
	$(CROSSSTRIP) $(ROOTDIR)/usr/bin/setmixer
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

setmixer_clean:
	rm -rf $(STATEDIR)/setmixer.*
	rm -rf $(SETMIXER_DIR)

# vim: syntax=make
