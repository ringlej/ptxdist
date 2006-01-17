# -*-makefile-*-
#
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: RSC: do something on targetinstall

#
# We provide this package
#
PACKAGES-$(PTXCONF_XLIBS-RENDER) += xlibs-render

#
# Paths and names
#
XLIBS-RENDER_VERSION	= 20041103-1
XLIBS-RENDER		= Render-$(XLIBS-RENDER_VERSION)
XLIBS-RENDER_SUFFIX	= tar.bz2
XLIBS-RENDER_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XLIBS-RENDER).$(XLIBS-RENDER_SUFFIX)
XLIBS-RENDER_SOURCE	= $(SRCDIR)/$(XLIBS-RENDER).$(XLIBS-RENDER_SUFFIX)
XLIBS-RENDER_DIR	= $(BUILDDIR)/$(XLIBS-RENDER)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-render_get: $(STATEDIR)/xlibs-render.get

$(STATEDIR)/xlibs-render.get: $(xlibs-render_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-RENDER))
	@$(call touch, $@)

$(XLIBS-RENDER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-RENDER_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-render_extract: $(STATEDIR)/xlibs-render.extract

$(STATEDIR)/xlibs-render.extract: $(xlibs-render_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-RENDER_DIR))
	@$(call extract, $(XLIBS-RENDER_SOURCE))
	@$(call patchin, $(XLIBS-RENDER))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-render_prepare: $(STATEDIR)/xlibs-render.prepare

XLIBS-RENDER_PATH	=  PATH=$(CROSS_PATH)
XLIBS-RENDER_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
XLIBS-RENDER_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/xlibs-render.prepare: $(xlibs-render_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-RENDER_DIR)/config.cache)
	chmod a+x $(XLIBS-RENDER_DIR)/configure
	cd $(XLIBS-RENDER_DIR) && \
		$(XLIBS-RENDER_PATH) $(XLIBS-RENDER_ENV) \
		./configure $(XLIBS-RENDER_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-render_compile: $(STATEDIR)/xlibs-render.compile

$(STATEDIR)/xlibs-render.compile: $(xlibs-render_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XLIBS-RENDER_DIR) && $(XLIBS-RENDER_ENV) $(XLIBS-RENDER_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-render_install: $(STATEDIR)/xlibs-render.install

$(STATEDIR)/xlibs-render.install: $(xlibs-render_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XLIBS-RENDER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-render_targetinstall: $(STATEDIR)/xlibs-render.targetinstall

$(STATEDIR)/xlibs-render.targetinstall: $(xlibs-render_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-render_clean:
	rm -rf $(STATEDIR)/xlibs-render.*
	rm -rf $(XLIBS-RENDER_DIR)

# vim: syntax=make
