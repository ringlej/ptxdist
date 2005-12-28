# -*-makefile-*-
# $Id: template 3502 2005-12-11 12:46:17Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNETPBM) += libnetpbm

#
# Paths and names
#
LIBNETPBM_VERSION	= 10.31
LIBNETPBM		= netpbm-$(LIBNETPBM_VERSION)
LIBNETPBM_SUFFIX	= tgz
LIBNETPBM_URL		= http://puzzle.dl.sourceforge.net/sourceforge/netpbm/$(LIBNETPBM).$(LIBNETPBM_SUFFIX)
LIBNETPBM_SOURCE	= $(SRCDIR)/$(LIBNETPBM).$(LIBNETPBM_SUFFIX)
LIBNETPBM_DIR		= $(BUILDDIR)/$(LIBNETPBM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libnetpbm_get: $(STATEDIR)/libnetpbm.get

libnetpbm_get_deps = $(LIBNETPBM_SOURCE)

$(STATEDIR)/libnetpbm.get: $(libnetpbm_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBNETPBM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBNETPBM_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libnetpbm_extract: $(STATEDIR)/libnetpbm.extract

libnetpbm_extract_deps = $(STATEDIR)/libnetpbm.get

$(STATEDIR)/libnetpbm.extract: $(libnetpbm_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBNETPBM_DIR))
	@$(call extract, $(LIBNETPBM_SOURCE))
	@$(call patchin, $(LIBNETPBM))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libnetpbm_prepare: $(STATEDIR)/libnetpbm.prepare

#
# dependencies
#
libnetpbm_prepare_deps = \
	$(STATEDIR)/libnetpbm.extract \
	$(STATEDIR)/virtual-xchain.install

LIBNETPBM_PATH	=  PATH=$(CROSS_PATH)
LIBNETPBM_ENV 	=  $(CROSS_ENV)
LIBNETPBM_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
LIBNETPBM_AUTOCONF =  $(CROSS_AUTOCONF)
LIBNETPBM_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/libnetpbm.prepare: $(libnetpbm_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBNETPBM_DIR)/config.cache)
	cd $(LIBNETPBM_DIR) && \
		$(LIBNETPBM_PATH) $(LIBNETPBM_ENV) \
		./configure $(LIBNETPBM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libnetpbm_compile: $(STATEDIR)/libnetpbm.compile

libnetpbm_compile_deps = $(STATEDIR)/libnetpbm.prepare

$(STATEDIR)/libnetpbm.compile: $(libnetpbm_compile_deps)
	@$(call targetinfo, $@)
	cd $(LIBNETPBM_DIR) && $(LIBNETPBM_ENV) $(LIBNETPBM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libnetpbm_install: $(STATEDIR)/libnetpbm.install

$(STATEDIR)/libnetpbm.install: $(STATEDIR)/libnetpbm.compile
	@$(call targetinfo, $@)
	@$(call install, LIBNETPBM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libnetpbm_targetinstall: $(STATEDIR)/libnetpbm.targetinstall

libnetpbm_targetinstall_deps = $(STATEDIR)/libnetpbm.compile

$(STATEDIR)/libnetpbm.targetinstall: $(libnetpbm_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,libnetpbm)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBNETPBM_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(LIBNETPBM_DIR)/foobar, /dev/null)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libnetpbm_clean:
	rm -rf $(STATEDIR)/libnetpbm.*
	rm -rf $(IMAGEDIR)/libnetpbm_*
	rm -rf $(LIBNETPBM_DIR)

# vim: syntax=make
