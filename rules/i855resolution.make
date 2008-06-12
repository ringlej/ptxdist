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
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_I855RESOLUTION) += i855resolution

#
# Paths and names
#
I855RESOLUTION_VERSION	:= 0.4
I855RESOLUTION		:= 855resolution-$(I855RESOLUTION_VERSION)
I855RESOLUTION_SUFFIX	:= tgz
I855RESOLUTION_URL	:= http://perso.orange.fr/apoirier/$(I855RESOLUTION).$(I855RESOLUTION_SUFFIX)
I855RESOLUTION_SOURCE	:= $(SRCDIR)/$(I855RESOLUTION).$(I855RESOLUTION_SUFFIX)
I855RESOLUTION_DIR	:= $(BUILDDIR)/855resolution

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(I855RESOLUTION_SOURCE):
	@$(call targetinfo)
	@$(call get, I855RESOLUTION)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

I855RESOLUTION_PATH	:=  PATH=$(CROSS_PATH)
I855RESOLUTION_MAKEVARS	:=  $(CROSS_ENV_CC)

$(STATEDIR)/i855resolution.prepare:
	@$(call targetinfo)
	cd $(I855RESOLUTION_DIR) && $(I855RESOLUTION_PATH) $(MAKE) clean
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/i855resolution.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/i855resolution.targetinstall:
	@$(call targetinfo)

	@$(call install_init, i855resolution)
	@$(call install_fixup,i855resolution,PACKAGE,i855resolution)
	@$(call install_fixup,i855resolution,PRIORITY,optional)
	@$(call install_fixup,i855resolution,VERSION,$(I855RESOLUTION_VERSION))
	@$(call install_fixup,i855resolution,SECTION,base)
	@$(call install_fixup,i855resolution,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,i855resolution,DEPENDS,)
	@$(call install_fixup,i855resolution,DESCRIPTION,missing)

	@$(call install_copy, i855resolution, 0, 0, 0755, $(I855RESOLUTION_DIR)/855resolution, /usr/sbin/855resolution)

	@$(call install_finish,i855resolution)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

i855resolution_clean:
	rm -rf $(STATEDIR)/i855resolution.*
	rm -rf $(PKGDIR)/i855resolution_*
	rm -rf $(I855RESOLUTION_DIR)

# vim: syntax=make
