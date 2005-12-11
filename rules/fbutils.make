# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by Sascha Hauer
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FBUTILS) += fbutils

#
# Paths and names
#
FBUTILS_VERSION	= 20041102-1
FBUTILS		= fbutils-$(FBUTILS_VERSION)
FBUTILS_SUFFIX	= tar.gz
FBUTILS_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FBUTILS).$(FBUTILS_SUFFIX)
FBUTILS_SOURCE	= $(SRCDIR)/$(FBUTILS).$(FBUTILS_SUFFIX)
FBUTILS_DIR	= $(BUILDDIR)/$(FBUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

fbutils_get: $(STATEDIR)/fbutils.get

fbutils_get_deps = $(FBUTILS_SOURCE)

$(STATEDIR)/fbutils.get: $(fbutils_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(FBUTILS))
	@$(call touch, $@)

$(FBUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(FBUTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fbutils_extract: $(STATEDIR)/fbutils.extract

fbutils_extract_deps = $(STATEDIR)/fbutils.get

$(STATEDIR)/fbutils.extract: $(fbutils_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FBUTILS_DIR))
	@$(call extract, $(FBUTILS_SOURCE))
	@$(call patchin, $(FBUTILS))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

fbutils_prepare: $(STATEDIR)/fbutils.prepare

#
# dependencies
#
fbutils_prepare_deps = \
	$(STATEDIR)/fbutils.extract \
	$(STATEDIR)/virtual-xchain.install

FBUTILS_PATH	=  PATH=$(CROSS_PATH)
FBUTILS_ENV 	=  $(CROSS_ENV)
#FBUTILS_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#FBUTILS_ENV	+=

$(STATEDIR)/fbutils.prepare: $(fbutils_prepare_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

fbutils_compile: $(STATEDIR)/fbutils.compile

fbutils_compile_deps = $(STATEDIR)/fbutils.prepare

$(STATEDIR)/fbutils.compile: $(fbutils_compile_deps)
	@$(call targetinfo, $@)
	cd $(FBUTILS_DIR) && $(FBUTILS_ENV) $(FBUTILS_PATH) make $(CROSS_ENV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fbutils_install: $(STATEDIR)/fbutils.install

$(STATEDIR)/fbutils.install: $(STATEDIR)/fbutils.compile
	@$(call targetinfo, $@)
	@$(call install, FBUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fbutils_targetinstall: $(STATEDIR)/fbutils.targetinstall

fbutils_targetinstall_deps = $(STATEDIR)/fbutils.compile

$(STATEDIR)/fbutils.targetinstall: $(fbutils_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,fbutils)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(FBUTILS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_FBUTILS_FBSET
	@$(call install_copy, 0, 0, 0755, $(FBUTILS_DIR)/fbset/fbset, /sbin/fbset)
endif
ifdef PTXCONF_FBUTILS_FBCMAP
	@$(call install_copy, 0, 0, 0755, $(FBUTILS_DIR)/fbcmap/fbcmap, /sbin/fbcmap)
endif
ifdef PTXCONF_FBUTILS_FBCONVERT
	@$(call install_copy, 0, 0, 0755, $(FBUTILS_DIR)/fbconvert/fbconvert, /sbin/fbconvert)
endif
ifdef PTXCONF_FBUTILS_FBCONVERT
	@$(call install_copy, 0, 0, 0755, $(FBUTILS_DIR)/fbconvert/fbconvert, /sbin/fbconvert)
endif
ifdef PTXCONF_FBUTILS_CON2FBMAP
	@$(call install_copy, 0, 0, 0755, $(FBUTILS_DIR)/con2fbmap/con2fbmap, /sbin/con2fbmap)
endif
	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fbutils_clean:
	rm -rf $(STATEDIR)/fbutils.*
	rm -rf $(IMAGEDIR)/fbutils_*
	rm -rf $(FBUTILS_DIR)

# vim: syntax=make
