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
ifdef PTXCONF_OPROFILE
PACKAGES += oprofile
endif

#
# Paths and names
#
OPROFILE_VERSION	= 0.8
OPROFILE		= oprofile-$(OPROFILE_VERSION)
OPROFILE_SUFFIX		= tar.gz
OPROFILE_URL		= $(PTXCONF_SFMIRROR)/oprofile/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_SOURCE		= $(SRCDIR)/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_DIR		= $(BUILDDIR)/$(OPROFILE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

oprofile_get: $(STATEDIR)/oprofile.get

oprofile_get_deps	=  $(OPROFILE_SOURCE)

$(STATEDIR)/oprofile.get: $(oprofile_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(OPROFILE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(OPROFILE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

oprofile_extract: $(STATEDIR)/oprofile.extract

oprofile_extract_deps	=  $(STATEDIR)/oprofile.get

$(STATEDIR)/oprofile.extract: $(oprofile_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(OPROFILE_DIR))
	@$(call extract, $(OPROFILE_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

oprofile_prepare: $(STATEDIR)/oprofile.prepare

#
# dependencies
#
oprofile_prepare_deps =  \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/popt.install \
	$(STATEDIR)/oprofile.extract

OPROFILE_PATH	=  PATH=$(CROSS_PATH)
OPROFILE_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
OPROFILE_AUTOCONF	=  $(CROSS_AUTOCONF)
OPROFILE_AUTOCONF	+= --prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
OPROFILE_AUTOCONF	+= --with-kernel-support
#
# note: we must use here the kernel's makevars (ARCH=fo CROSS_COMPILE=bar)
#       (see kernel.make) because oprofile includes the kernel's makefile
#       in it's modules subdir, and there it doesn't care about the CC
#       we gave him at ./configure-time....
#
OPROFILE_MAKEVARS	=  $(KERNEL_MAKEVARS)

$(STATEDIR)/oprofile.prepare: $(oprofile_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(OPROFILE_DIR)/config.cache)
	cd $(OPROFILE_DIR) && \
		$(OPROFILE_PATH) $(OPROFILE_ENV) \
		./configure $(OPROFILE_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

oprofile_compile: $(STATEDIR)/oprofile.compile

oprofile_compile_deps =  $(STATEDIR)/oprofile.prepare

$(STATEDIR)/oprofile.compile: $(oprofile_compile_deps)
	@$(call targetinfo, $@)
	$(OPROFILE_PATH) make -C $(OPROFILE_DIR) $(OPROFILE_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

oprofile_install: $(STATEDIR)/oprofile.install

$(STATEDIR)/oprofile.install: $(STATEDIR)/oprofile.compile
	@$(call targetinfo, $@)
	$(OPROFILE_PATH) make -C $(OPROFILE_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

oprofile_targetinstall: $(STATEDIR)/oprofile.targetinstall

oprofile_targetinstall_deps	=  $(STATEDIR)/oprofile.compile

$(STATEDIR)/oprofile.targetinstall: $(oprofile_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

oprofile_clean:
	rm -rf $(STATEDIR)/oprofile.*
	rm -rf $(OPROFILE_DIR)

# vim: syntax=make
