# -*-makefile-*-
# $Id: template 3288 2005-11-02 06:10:51Z rsc $
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
ifdef PTXCONF_XMLBENCH
PACKAGES += xmlbench
endif

#
# Paths and names
#
XMLBENCH_VERSION	= 1.3.0
XMLBENCH		= xmlbench-$(XMLBENCH_VERSION)
XMLBENCH_SUFFIX		= tar.bz2
XMLBENCH_URL		= $(PTXCONF_SETUP_SFMIRROR)/xmlbench/$(XMLBENCH).$(XMLBENCH_SUFFIX)
XMLBENCH_SOURCE		= $(SRCDIR)/$(XMLBENCH).$(XMLBENCH_SUFFIX)
XMLBENCH_DIR		= $(BUILDDIR)/$(XMLBENCH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xmlbench_get: $(STATEDIR)/xmlbench.get

xmlbench_get_deps = $(XMLBENCH_SOURCE)

$(STATEDIR)/xmlbench.get: $(xmlbench_get_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

$(XMLBENCH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XMLBENCH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xmlbench_extract: $(STATEDIR)/xmlbench.extract

xmlbench_extract_deps = $(STATEDIR)/xmlbench.get

$(STATEDIR)/xmlbench.extract: $(xmlbench_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XMLBENCH_DIR))
	@$(call extract, $(XMLBENCH_SOURCE))
	mv $(BUILDDIR)/xmlbench $(XMLBENCH_DIR)
	@$(call patchin, $(XMLBENCH))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xmlbench_prepare: $(STATEDIR)/xmlbench.prepare

#
# dependencies
#
xmlbench_prepare_deps = \
	$(STATEDIR)/xmlbench.extract \
	$(STATEDIR)/virtual-xchain.install

XMLBENCH_PATH	=  PATH=$(CROSS_PATH)
XMLBENCH_ENV 	=  $(CROSS_ENV)
XMLBENCH_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XMLBENCH_AUTOCONF =  $(CROSS_AUTOCONF)
XMLBENCH_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xmlbench.prepare: $(xmlbench_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XMLBENCH_DIR)/config.cache)
	cd $(XMLBENCH_DIR) && \
		$(XMLBENCH_PATH) $(XMLBENCH_ENV) \
		./configure $(XMLBENCH_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xmlbench_compile: $(STATEDIR)/xmlbench.compile

xmlbench_compile_deps = $(STATEDIR)/xmlbench.prepare

$(STATEDIR)/xmlbench.compile: $(xmlbench_compile_deps)
	@$(call targetinfo, $@)
	cd $(XMLBENCH_DIR) && $(XMLBENCH_ENV) $(XMLBENCH_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xmlbench_install: $(STATEDIR)/xmlbench.install

$(STATEDIR)/xmlbench.install: $(STATEDIR)/xmlbench.compile
	@$(call targetinfo, $@)
	cd $(XMLBENCH_DIR) && $(XMLBENCH_ENV) $(XMLBENCH_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xmlbench_targetinstall: $(STATEDIR)/xmlbench.targetinstall

xmlbench_targetinstall_deps = $(STATEDIR)/xmlbench.compile

$(STATEDIR)/xmlbench.targetinstall: $(xmlbench_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xmlbench)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XMLBENCH_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XMLBENCH_DIR)/foobar, /dev/null)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xmlbench_clean:
	rm -rf $(STATEDIR)/xmlbench.*
	rm -rf $(IMAGEDIR)/xmlbench_*
	rm -rf $(XMLBENCH_DIR)

# vim: syntax=make
