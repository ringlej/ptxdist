# -*-makefile-*-
# $Id: strace.make,v 1.6 2003/10/26 21:00:06 mkl Exp $
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_STRACE
PACKAGES += strace
endif

#
# Paths and names 
#
STRACE			= strace-4.4.98
STRACE_URL		= http://umn.dl.sourceforge.net/sourceforge/strace/$(STRACE).tar.bz2
STRACE_SOURCE		= $(SRCDIR)/$(STRACE).tar.bz2
STRACE_DIR		= $(BUILDDIR)/$(STRACE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

strace_get: $(STATEDIR)/strace.get

$(STATEDIR)/strace.get: $(STRACE_SOURCE)
	@$(call targetinfo, $@)
	@$(call get_patches, $(STRACE))
	touch $@

$(STRACE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(STRACE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

strace_extract: $(STATEDIR)/strace.extract

strace_extract_deps = \
	$(STATEDIR)/strace.get

$(STATEDIR)/strace.extract: $(strace_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(STRACE_DIR))
	@$(call extract, $(STRACE_SOURCE))
	@$(call patchin, $(STRACE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

strace_prepare: $(STATEDIR)/strace.prepare

strace_prepare_deps = \
	$(STATEDIR)/strace.extract \
	$(STATEDIR)/virtual-xchain.install

STRACE_PATH	=  PATH=$(CROSS_PATH)
STRACE_ENV	=  $(CROSS_ENV)

ifndef PTXCONF_STRACE_SHARED
STRACE_ENV	=  LDFLAGS=-static
endif

STRACE_AUTOCONF	=  \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--target=$(PTXCONF_GNU_TARGET) \
	--prefix=/usr \
	--disable-sanity-checks

$(STATEDIR)/strace.prepare: $(strace_prepare_deps)
	@$(call targetinfo, $@)
	cd $(STRACE_DIR) && \
		$(STRACE_PATH) $(STRACE_ENV) \
		./configure $(STRACE_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

strace_compile: $(STATEDIR)/strace.compile

$(STATEDIR)/strace.compile: $(STATEDIR)/strace.prepare 
	@$(call targetinfo, $@)
	$(STRACE_PATH) $(STRACE_ENV) make -C $(STRACE_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

strace_install: $(STATEDIR)/strace.install

$(STATEDIR)/strace.install: $(STATEDIR)/strace.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

strace_targetinstall: $(STATEDIR)/strace.targetinstall

$(STATEDIR)/strace.targetinstall: $(STATEDIR)/strace.compile
	@$(call targetinfo, $@)
	install -D $(STRACE_DIR)/strace $(ROOTDIR)/usr/bin/strace
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/strace
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

strace_clean: 
	rm -rf $(STATEDIR)/strace.* $(STRACE_DIR)

# vim: syntax=make
