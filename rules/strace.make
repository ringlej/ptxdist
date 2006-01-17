# -*-makefile-*-
# $Id$
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
PACKAGES-$(PTXCONF_STRACE) += strace

#
# Paths and names 
#
STRACE_VERSION		= 4.5.7
STRACE			= strace-$(STRACE_VERSION)
STRACE_URL		= $(PTXCONF_SETUP_SFMIRROR)/strace/$(STRACE).tar.bz2
STRACE_SOURCE		= $(SRCDIR)/$(STRACE).tar.bz2
STRACE_DIR		= $(BUILDDIR)/$(STRACE)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

strace_get: $(STATEDIR)/strace.get

$(STATEDIR)/strace.get: $(strace_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(STRACE))
	@$(call touch, $@)

$(STRACE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(STRACE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

strace_extract: $(STATEDIR)/strace.extract

$(STATEDIR)/strace.extract: $(strace_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(STRACE_DIR))
	@$(call extract, $(STRACE_SOURCE))
	@$(call patchin, $(STRACE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

strace_prepare: $(STATEDIR)/strace.prepare

STRACE_PATH	=  PATH=$(CROSS_PATH)
STRACE_ENV	=  $(CROSS_ENV)

ifndef PTXCONF_STRACE_SHARED
STRACE_ENV	=  LDFLAGS=-static
endif

STRACE_AUTOCONF =  $(CROSS_AUTOCONF_USR)
STRACE_AUTOCONF	+= \
	--target=$(PTXCONF_GNU_TARGET) \
	--disable-sanity-checks

$(STATEDIR)/strace.prepare: $(strace_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(STRACE_DIR) && \
		$(STRACE_PATH) $(STRACE_ENV) \
		./configure $(STRACE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

strace_compile: $(STATEDIR)/strace.compile

$(STATEDIR)/strace.compile: $(strace_compile_deps_default)
	@$(call targetinfo, $@)
	$(STRACE_PATH) $(STRACE_ENV) make -C $(STRACE_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

strace_install: $(STATEDIR)/strace.install

$(STATEDIR)/strace.install: $(strace_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

strace_targetinstall: $(STATEDIR)/strace.targetinstall

$(STATEDIR)/strace.targetinstall: $(strace_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,strace)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(STRACE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(STRACE_DIR)/strace, /usr/bin/strace)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

strace_clean: 
	rm -rf $(STATEDIR)/strace.* $(STRACE_DIR)

# vim: syntax=make
