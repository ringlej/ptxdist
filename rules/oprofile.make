# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger <b.spranger@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPROFILE) += oprofile

#
# Paths and names
#
OPROFILE_VERSION	= 0.8
OPROFILE		= oprofile-$(OPROFILE_VERSION)
OPROFILE_SUFFIX		= tar.gz
OPROFILE_URL		= $(PTXCONF_SETUP_SFMIRROR)/oprofile/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_SOURCE		= $(SRCDIR)/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_DIR		= $(BUILDDIR)/$(OPROFILE)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

oprofile_get: $(STATEDIR)/oprofile.get

$(STATEDIR)/oprofile.get: $(oprofile_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(OPROFILE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(OPROFILE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

oprofile_extract: $(STATEDIR)/oprofile.extract

$(STATEDIR)/oprofile.extract: $(oprofile_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(OPROFILE_DIR))
	@$(call extract, $(OPROFILE_SOURCE))
	@$(call patchin, $(OPROFILE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

oprofile_prepare: $(STATEDIR)/oprofile.prepare

OPROFILE_PATH	=  PATH=$(CROSS_PATH)
OPROFILE_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
OPROFILE_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
OPROFILE_AUTOCONF	+= --with-kernel-support
#
# note: we must use here the kernel's makevars (ARCH=fo CROSS_COMPILE=bar)
#       (see kernel.make) because oprofile includes the kernel's makefile
#       in it's modules subdir, and there it doesn't care about the CC
#       we gave him at ./configure-time....
#
OPROFILE_MAKEVARS	=  $(KERNEL_MAKEVARS)

$(STATEDIR)/oprofile.prepare: $(oprofile_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(OPROFILE_DIR)/config.cache)
	cd $(OPROFILE_DIR) && \
		$(OPROFILE_PATH) $(OPROFILE_ENV) \
		./configure $(OPROFILE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

oprofile_compile: $(STATEDIR)/oprofile.compile

$(STATEDIR)/oprofile.compile: $(oprofile_compile_deps_default)
	@$(call targetinfo, $@)
	$(OPROFILE_PATH) make -C $(OPROFILE_DIR) $(OPROFILE_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

oprofile_install: $(STATEDIR)/oprofile.install

$(STATEDIR)/oprofile.install: $(STATEDIR)/oprofile.compile
	@$(call targetinfo, $@)
	@$(call install, OPROFILE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

oprofile_targetinstall: $(STATEDIR)/oprofile.targetinstall

$(STATEDIR)/oprofile.targetinstall: $(oprofile_targetinstall_deps_default)
	@$(call targetinfo, $@)
	# FIXME: nothing to do on targetinstall? 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

oprofile_clean:
	rm -rf $(STATEDIR)/oprofile.*
	rm -rf $(OPROFILE_DIR)

# vim: syntax=make
