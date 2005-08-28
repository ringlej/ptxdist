# -*-makefile-*-
# $Id: template 2922 2005-07-11 19:17:53Z rsc $
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
ifdef PTXCONF_XLIBS_XDMCP
PACKAGES += xlibs-xdmcp
endif

#
# Paths and names
#
XLIBS_XDMCP_VERSION	= 0.99.0
XLIBS_XDMCP		= libXdmcp-$(XLIBS_XDMCP_VERSION)
XLIBS_XDMCP_SUFFIX	= tar.bz2
XLIBS_XDMCP_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/lib/$(XLIBS_XDMCP).$(XLIBS_XDMCP_SUFFIX)
XLIBS_XDMCP_SOURCE	= $(SRCDIR)/$(XLIBS_XDMCP).$(XLIBS_XDMCP_SUFFIX)
XLIBS_XDMCP_DIR		= $(BUILDDIR)/$(XLIBS_XDMCP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xdmcp_get: $(STATEDIR)/xlibs-xdmcp.get

xlibs-xdmcp_get_deps = $(XLIBS_XDMCP_SOURCE)

$(STATEDIR)/xlibs-xdmcp.get: $(xlibs-xdmcp_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_XDMCP))
	touch $@

$(XLIBS_XDMCP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_XDMCP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xdmcp_extract: $(STATEDIR)/xlibs-xdmcp.extract

xlibs-xdmcp_extract_deps = $(STATEDIR)/xlibs-xdmcp.get

$(STATEDIR)/xlibs-xdmcp.extract: $(xlibs-xdmcp_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XDMCP_DIR))
	@$(call extract, $(XLIBS_XDMCP_SOURCE))
	@$(call patchin, $(XLIBS_XDMCP))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xdmcp_prepare: $(STATEDIR)/xlibs-xdmcp.prepare

#
# dependencies
#
xlibs-xdmcp_prepare_deps = \
	$(STATEDIR)/xlibs-xdmcp.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_XDMCP_PATH	=  PATH=$(CROSS_PATH)
XLIBS_XDMCP_ENV 	=  $(CROSS_ENV)
XLIBS_XDMCP_ENV		+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_XDMCP_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_XDMCP_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xdmcp.prepare: $(xlibs-xdmcp_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XDMCP_DIR)/config.cache)
	cd $(XLIBS_XDMCP_DIR) && \
		$(XLIBS_XDMCP_PATH) $(XLIBS_XDMCP_ENV) \
		./configure $(XLIBS_XDMCP_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xdmcp_compile: $(STATEDIR)/xlibs-xdmcp.compile

xlibs-xdmcp_compile_deps = $(STATEDIR)/xlibs-xdmcp.prepare

$(STATEDIR)/xlibs-xdmcp.compile: $(xlibs-xdmcp_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_XDMCP_DIR) && $(XLIBS_XDMCP_ENV) $(XLIBS_XDMCP_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xdmcp_install: $(STATEDIR)/xlibs-xdmcp.install

$(STATEDIR)/xlibs-xdmcp.install: $(STATEDIR)/xlibs-xdmcp.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_XDMCP_DIR) && $(XLIBS_XDMCP_ENV) $(XLIBS_XDMCP_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xdmcp_targetinstall: $(STATEDIR)/xlibs-xdmcp.targetinstall

xlibs-xdmcp_targetinstall_deps = $(STATEDIR)/xlibs-xdmcp.compile

$(STATEDIR)/xlibs-xdmcp.targetinstall: $(xlibs-xdmcp_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-xdmcp)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_XDMCP_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_XDMCP_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xdmcp_clean:
	rm -rf $(STATEDIR)/xlibs-xdmcp.*
	rm -rf $(IMAGEDIR)/xlibs-xdmcp_*
	rm -rf $(XLIBS_XDMCP_DIR)

# vim: syntax=make
