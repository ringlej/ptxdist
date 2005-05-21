# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_THTTPD
PACKAGES += thttpd
endif

#
# Paths and names
#
THTTPD_VERSION	= 2.24
THTTPD		= thttpd-$(THTTPD_VERSION)
THTTPD_SUFFIX	= tar.gz
THTTPD_URL	= http://www.acme.com/software/thttpd/$(THTTPD).$(THTTPD_SUFFIX)
THTTPD_SOURCE	= $(SRCDIR)/$(THTTPD).$(THTTPD_SUFFIX)
THTTPD_DIR	= $(BUILDDIR)/$(THTTPD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

thttpd_get: $(STATEDIR)/thttpd.get

thttpd_get_deps = $(THTTPD_SOURCE)

$(STATEDIR)/thttpd.get: $(thttpd_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(THTTPD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(THTTPD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

thttpd_extract: $(STATEDIR)/thttpd.extract

thttpd_extract_deps = $(STATEDIR)/thttpd.get

$(STATEDIR)/thttpd.extract: $(thttpd_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(THTTPD_DIR))
	@$(call extract, $(THTTPD_SOURCE))
	@$(call patchin, $(THTTPD))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

thttpd_prepare: $(STATEDIR)/thttpd.prepare

#
# dependencies
#
thttpd_prepare_deps = \
	$(STATEDIR)/thttpd.extract \
	$(STATEDIR)/virtual-xchain.install

THTTPD_PATH	=  PATH=$(CROSS_PATH)
THTTPD_ENV 	=  $(CROSS_ENV)
#THTTPD_ENV	+=

#
# autoconf
#
THTTPD_AUTOCONF =  $(CROSS_AUTOCONF)
THTTPD_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/thttpd.prepare: $(thttpd_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(THTTPD_DIR)/config.cache)
	cd $(THTTPD_DIR) && \
		$(THTTPD_PATH) $(THTTPD_ENV) \
		./configure $(THTTPD_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

thttpd_compile: $(STATEDIR)/thttpd.compile

thttpd_compile_deps = $(STATEDIR)/thttpd.prepare

$(STATEDIR)/thttpd.compile: $(thttpd_compile_deps)
	@$(call targetinfo, $@)
	$(THTTPD_PATH) make -C $(THTTPD_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

thttpd_install: $(STATEDIR)/thttpd.install

$(STATEDIR)/thttpd.install: $(STATEDIR)/thttpd.compile
	@$(call targetinfo, $@)
	$(THTTPD_PATH) make -C $(THTTPD_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

thttpd_targetinstall: $(STATEDIR)/thttpd.targetinstall

thttpd_targetinstall_deps = $(STATEDIR)/thttpd.compile

$(STATEDIR)/thttpd.targetinstall: $(thttpd_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,thttpd)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(THTTPD_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0555, (THTTPD_DIR)/thttpd, /sbin/thttpd)

	@$(call install_finish)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

thttpd_clean:
	rm -rf $(STATEDIR)/thttpd.*
	rm -rf $(IMAGEDIR)/thttpd_*
	rm -rf $(THTTPD_DIR)

# vim: syntax=make
