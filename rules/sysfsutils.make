# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSFSUTILS) += sysfsutils

#
# Paths and names
#
SYSFSUTILS_VERSION	= 1.3.0
SYSFSUTILS		= sysfsutils-$(SYSFSUTILS_VERSION)
SYSFSUTILS_SUFFIX	= tar.gz
SYSFSUTILS_URL		= $(PTXCONF_SETUP_SFMIRROR)/linux-diag/$(SYSFSUTILS).$(SYSFSUTILS_SUFFIX)
SYSFSUTILS_SOURCE	= $(SRCDIR)/$(SYSFSUTILS).$(SYSFSUTILS_SUFFIX)
SYSFSUTILS_DIR		= $(BUILDDIR)/$(SYSFSUTILS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sysfsutils_get: $(STATEDIR)/sysfsutils.get

sysfsutils_get_deps = $(SYSFSUTILS_SOURCE)

$(STATEDIR)/sysfsutils.get: $(sysfsutils_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(SYSFSUTILS))
	@$(call touch, $@)

$(SYSFSUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SYSFSUTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sysfsutils_extract: $(STATEDIR)/sysfsutils.extract

sysfsutils_extract_deps = $(STATEDIR)/sysfsutils.get

$(STATEDIR)/sysfsutils.extract: $(sysfsutils_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SYSFSUTILS_DIR))
	@$(call extract, $(SYSFSUTILS_SOURCE))
	@$(call patchin, $(SYSFSUTILS))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sysfsutils_prepare: $(STATEDIR)/sysfsutils.prepare

#
# dependencies
#
sysfsutils_prepare_deps = \
	$(STATEDIR)/sysfsutils.extract \
	$(STATEDIR)/virtual-xchain.install

SYSFSUTILS_PATH	=  PATH=$(CROSS_PATH)
SYSFSUTILS_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
SYSFSUTILS_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/sysfsutils.prepare: $(sysfsutils_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SYSFSUTILS_DIR)/config.cache)
	cd $(SYSFSUTILS_DIR) && \
		$(SYSFSUTILS_PATH) $(SYSFSUTILS_ENV) \
		./configure $(SYSFSUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sysfsutils_compile: $(STATEDIR)/sysfsutils.compile

sysfsutils_compile_deps = $(STATEDIR)/sysfsutils.prepare

$(STATEDIR)/sysfsutils.compile: $(sysfsutils_compile_deps)
	@$(call targetinfo, $@)
	cd $(SYSFSUTILS_DIR) && $(SYSFSUTILS_ENV) $(SYSFSUTILS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sysfsutils_install: $(STATEDIR)/sysfsutils.install

$(STATEDIR)/sysfsutils.install: $(STATEDIR)/sysfsutils.compile
	@$(call targetinfo, $@)
	@$(call install, SYSFSUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sysfsutils_targetinstall: $(STATEDIR)/sysfsutils.targetinstall

sysfsutils_targetinstall_deps = $(STATEDIR)/sysfsutils.compile

$(STATEDIR)/sysfsutils.targetinstall: $(sysfsutils_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,sysfsutils)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(SYSFSUTILS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
ifdef PTXCONF_SYSFSUTILS_LIB
	@$(call install_copy, 0, 0, 0644, $(SYSFSUTILS_DIR)/lib/.libs/libsysfs.so.1.0.3, /lib/libsysfs.so.1.0.3)
	@$(call install_link, libsysfs.so.1.0.3, /lib/libsysfs.so.1)
	@$(call install_link, libsysfs.so.1.0.3, /lib/libsysfs.so)
endif
ifdef PTXCONF_SYSFSUTILS_SYSTOOL
	@$(call install_copy, 0, 0, 0775, $(SYSFSUTILS_DIR)/cmd/systool, /bin/systool, n)
endif
	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sysfsutils_clean:
	rm -rf $(STATEDIR)/sysfsutils.*
	rm -rf $(IMAGEDIR)/sysfsutils_*
	rm -rf $(SYSFSUTILS_DIR)

# vim: syntax=make
