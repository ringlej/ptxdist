# -*-makefile-*-
# $Id: template 2878 2005-07-03 17:54:38Z rsc $
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
ifdef PTXCONF_XMLSTARLET
PACKAGES += xmlstarlet
endif

#
# Paths and names
#
XMLSTARLET_VERSION	= 1.0.1
XMLSTARLET		= xmlstarlet-$(XMLSTARLET_VERSION)
XMLSTARLET_SUFFIX	= tar.gz
XMLSTARLET_URL		= $(PTXCONF_SETUP_SFMIRROR)/xmlstar/$(XMLSTARLET).$(XMLSTARLET_SUFFIX)
XMLSTARLET_SOURCE	= $(SRCDIR)/$(XMLSTARLET).$(XMLSTARLET_SUFFIX)
XMLSTARLET_DIR		= $(BUILDDIR)/$(XMLSTARLET)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xmlstarlet_get: $(STATEDIR)/xmlstarlet.get

xmlstarlet_get_deps = $(XMLSTARLET_SOURCE)

$(STATEDIR)/xmlstarlet.get: $(xmlstarlet_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XMLSTARLET))
	touch $@

$(XMLSTARLET_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XMLSTARLET_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xmlstarlet_extract: $(STATEDIR)/xmlstarlet.extract

xmlstarlet_extract_deps = $(STATEDIR)/xmlstarlet.get

$(STATEDIR)/xmlstarlet.extract: $(xmlstarlet_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XMLSTARLET_DIR))
	@$(call extract, $(XMLSTARLET_SOURCE))
	@$(call patchin, $(XMLSTARLET))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xmlstarlet_prepare: $(STATEDIR)/xmlstarlet.prepare

#
# dependencies
#
xmlstarlet_prepare_deps =  $(STATEDIR)/xmlstarlet.extract
xmlstarlet_prepare_deps += $(STATEDIR)/virtual-xchain.install
xmlstarlet_prepare_deps += $(STATEDIR)/libxml2.install
xmlstarlet_prepare_deps += $(STATEDIR)/libxslt.install

XMLSTARLET_PATH	=  PATH=$(CROSS_PATH)
XMLSTARLET_ENV 	=  $(CROSS_ENV)
#XMLSTARLET_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#XMLSTARLET_ENV	+=

#
# autoconf
#
XMLSTARLET_AUTOCONF =  $(CROSS_AUTOCONF)
XMLSTARLET_AUTOCONF += --prefix=$(CROSS_LIB_DIR)
XMLSTARLET_AUTOCONF += --with-libxml-prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
XMLSTARLET_AUTOCONF += --with-libxslt-prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)

$(STATEDIR)/xmlstarlet.prepare: $(xmlstarlet_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XMLSTARLET_DIR)/config.cache)
	cd $(XMLSTARLET_DIR) && \
		$(XMLSTARLET_PATH) $(XMLSTARLET_ENV) \
		./configure $(XMLSTARLET_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xmlstarlet_compile: $(STATEDIR)/xmlstarlet.compile

xmlstarlet_compile_deps = $(STATEDIR)/xmlstarlet.prepare

$(STATEDIR)/xmlstarlet.compile: $(xmlstarlet_compile_deps)
	@$(call targetinfo, $@)
	cd $(XMLSTARLET_DIR) && $(XMLSTARLET_ENV) $(XMLSTARLET_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xmlstarlet_install: $(STATEDIR)/xmlstarlet.install

$(STATEDIR)/xmlstarlet.install: $(STATEDIR)/xmlstarlet.compile
	@$(call targetinfo, $@)
	cd $(XMLSTARLET_DIR) && $(XMLSTARLET_ENV) $(XMLSTARLET_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xmlstarlet_targetinstall: $(STATEDIR)/xmlstarlet.targetinstall

xmlstarlet_targetinstall_deps =  $(STATEDIR)/xmlstarlet.compile
xmlstarlet_targetinstall_deps += $(STATEDIR)/libxml2.targetinstall
xmlstarlet_targetinstall_deps += $(STATEDIR)/libxslt.targetinstall

$(STATEDIR)/xmlstarlet.targetinstall: $(xmlstarlet_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xmlstarlet)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XMLSTARLET_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XMLSTARLET_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xmlstarlet_clean:
	rm -rf $(STATEDIR)/xmlstarlet.*
	rm -rf $(IMAGEDIR)/xmlstarlet_*
	rm -rf $(XMLSTARLET_DIR)

# vim: syntax=make
