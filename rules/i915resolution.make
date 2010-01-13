# -*-makefile-*-
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
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_I915RESOLUTION) += i915resolution

#
# Paths and names
#
I915RESOLUTION_VERSION	:= 0.5.3
I915RESOLUTION		:= 915resolution-$(I915RESOLUTION_VERSION)
I915RESOLUTION_SUFFIX	:= tar.gz
I915RESOLUTION_URL	:= http://www.geocities.com/stomljen/$(I915RESOLUTION).$(I915RESOLUTION_SUFFIX)
I915RESOLUTION_SOURCE	:= $(SRCDIR)/$(I915RESOLUTION).$(I915RESOLUTION_SUFFIX)
I915RESOLUTION_DIR	:= $(BUILDDIR)/$(I915RESOLUTION)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(I915RESOLUTION_SOURCE):
	@$(call targetinfo)
	@$(call get, I915RESOLUTION)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

I915RESOLUTION_PATH	:= PATH=$(CROSS_PATH)
I915RESOLUTION_MAKEVARS	:=  $(CROSS_ENV_CC)

$(STATEDIR)/i915resolution.prepare:
	@$(call targetinfo)
	cd $(I915RESOLUTION_DIR) && $(I915RESOLUTION_PATH) $(MAKE) clean
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/i915resolution.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/i915resolution.targetinstall:
	@$(call targetinfo)

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

	@$(call touch)

# vim: syntax=make
