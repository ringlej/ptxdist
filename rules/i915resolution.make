# -*-makefile-*-
# $Id: template 5709 2006-06-09 13:55:00Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_I915RESOLUTION) += i915resolution

#
# Paths and names
#
I915RESOLUTION_VERSION	:= 0.5.2
I915RESOLUTION		:= 915resolution-$(I915RESOLUTION_VERSION)
I915RESOLUTION_SUFFIX	:= tar.gz
I915RESOLUTION_URL	:= http://www.geocities.com/stomljen/$(I915RESOLUTION).$(I915RESOLUTION_SUFFIX)
I915RESOLUTION_SOURCE	:= $(SRCDIR)/$(I915RESOLUTION).$(I915RESOLUTION_SUFFIX)
I915RESOLUTION_DIR	:= $(BUILDDIR)/$(I915RESOLUTION)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

i915resolution_get: $(STATEDIR)/i915resolution.get

$(STATEDIR)/i915resolution.get: $(i915resolution_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(I915RESOLUTION_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, I915RESOLUTION)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

i915resolution_extract: $(STATEDIR)/i915resolution.extract

$(STATEDIR)/i915resolution.extract: $(i915resolution_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(I915RESOLUTION_DIR))
	@$(call extract, I915RESOLUTION)
	@$(call patchin, I915RESOLUTION)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

i915resolution_prepare: $(STATEDIR)/i915resolution.prepare

I915RESOLUTION_PATH	:=  PATH=$(CROSS_PATH)
I915RESOLUTION_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
I915RESOLUTION_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/i915resolution.prepare: $(i915resolution_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(I915RESOLUTION_DIR) && $(I915RESOLUTION_PATH) make clean
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

i915resolution_compile: $(STATEDIR)/i915resolution.compile

$(STATEDIR)/i915resolution.compile: $(i915resolution_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(I915RESOLUTION_DIR) && $(I915RESOLUTION_ENV) $(I915RESOLUTION_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

i915resolution_install: $(STATEDIR)/i915resolution.install

$(STATEDIR)/i915resolution.install: $(i915resolution_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

i915resolution_targetinstall: $(STATEDIR)/i915resolution.targetinstall

$(STATEDIR)/i915resolution.targetinstall: $(i915resolution_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, i915resolution)
	@$(call install_fixup,i915resolution,PACKAGE,i915resolution)
	@$(call install_fixup,i915resolution,PRIORITY,optional)
	@$(call install_fixup,i915resolution,VERSION,$(I915RESOLUTION_VERSION))
	@$(call install_fixup,i915resolution,SECTION,base)
	@$(call install_fixup,i915resolution,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,i915resolution,DEPENDS,)
	@$(call install_fixup,i915resolution,DESCRIPTION,missing)

	@$(call install_copy, i915resolution, 0, 0, 0755, $(I915RESOLUTION_DIR)/915resolution, /usr/sbin/915resolution)

	@$(call install_finish,i915resolution)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

i915resolution_clean:
	rm -rf $(STATEDIR)/i915resolution.*
	rm -rf $(IMAGEDIR)/i915resolution_*
	rm -rf $(I915RESOLUTION_DIR)

# vim: syntax=make
