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
PACKAGES-$(PTXCONF_I855RESOLUTION) += i855resolution

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

i855resolution_get: $(STATEDIR)/i855resolution.get

$(STATEDIR)/i855resolution.get: $(i855resolution_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(I855RESOLUTION_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, I855RESOLUTION)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

i855resolution_extract: $(STATEDIR)/i855resolution.extract

$(STATEDIR)/i855resolution.extract: $(i855resolution_extract_deps_default)
	@$(call targetinfo, $@)
ifdef ARCH_X86
	@$(call clean, $(I855RESOLUTION_DIR))
	@$(call extract, I855RESOLUTION)
	@$(call patchin, I855RESOLUTION)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

i855resolution_prepare: $(STATEDIR)/i855resolution.prepare

I855RESOLUTION_PATH	:=  PATH=$(CROSS_PATH)
I855RESOLUTION_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
I855RESOLUTION_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/i855resolution.prepare: $(i855resolution_prepare_deps_default)
	@$(call targetinfo, $@)
ifdef ARCH_X86
	cd $(I855RESOLUTION_DIR) && $(I855RESOLUTION_PATH) make clean
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

i855resolution_compile: $(STATEDIR)/i855resolution.compile

$(STATEDIR)/i855resolution.compile: $(i855resolution_compile_deps_default)
	@$(call targetinfo, $@)
ifdef ARCH_X86
	cd $(I855RESOLUTION_DIR) && $(I855RESOLUTION_ENV) $(I855RESOLUTION_PATH) make
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

i855resolution_install: $(STATEDIR)/i855resolution.install

$(STATEDIR)/i855resolution.install: $(i855resolution_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

i855resolution_targetinstall: $(STATEDIR)/i855resolution.targetinstall

$(STATEDIR)/i855resolution.targetinstall: $(i855resolution_targetinstall_deps_default)
	@$(call targetinfo, $@)

ifdef ARCH_X86
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
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

i855resolution_clean:
	rm -rf $(STATEDIR)/i855resolution.*
	rm -rf $(PKGDIR)/i855resolution_*
	rm -rf $(I855RESOLUTION_DIR)

# vim: syntax=make
