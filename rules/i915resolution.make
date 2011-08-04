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
I915RESOLUTION_MD5	:= ed287778a53d02c31a7a6a52bc146291
I915RESOLUTION		:= 915resolution-$(I915RESOLUTION_VERSION)
I915RESOLUTION_SUFFIX	:= tar.gz
I915RESOLUTION_URL	:= http://915resolution.mango-lang.org/$(I915RESOLUTION).$(I915RESOLUTION_SUFFIX)
I915RESOLUTION_SOURCE	:= $(SRCDIR)/$(I915RESOLUTION).$(I915RESOLUTION_SUFFIX)
I915RESOLUTION_DIR	:= $(BUILDDIR)/$(I915RESOLUTION)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(I915RESOLUTION_SOURCE):
	@$(call targetinfo)
	@$(call get, I915RESOLUTION)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/i915resolution.install:
	@$(call targetinfo)
	install -D -m 755 $(I915RESOLUTION_DIR)/915resolution \
		$(I915RESOLUTION_PKGDIR)/usr/sbin/915resolution
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/i915resolution.targetinstall:
	@$(call targetinfo)

	@$(call install_init, i915resolution)
	@$(call install_fixup, i915resolution,PRIORITY,optional)
	@$(call install_fixup, i915resolution,SECTION,base)
	@$(call install_fixup, i915resolution,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, i915resolution,DESCRIPTION,missing)

	@$(call install_copy, i915resolution, 0, 0, 0755, -, /usr/sbin/915resolution)

	@$(call install_finish, i915resolution)

	@$(call touch)

# vim: syntax=make
