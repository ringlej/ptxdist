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

$(STATEDIR)/fbutils.get: $(fbutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FBUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, FBUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fbutils_extract: $(STATEDIR)/fbutils.extract

$(STATEDIR)/fbutils.extract: $(fbutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FBUTILS_DIR))
	@$(call extract, FBUTILS)
	@$(call patchin, FBUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

fbutils_prepare: $(STATEDIR)/fbutils.prepare

FBUTILS_PATH	=  PATH=$(CROSS_PATH)
FBUTILS_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/fbutils.prepare: $(fbutils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

fbutils_compile: $(STATEDIR)/fbutils.compile

$(STATEDIR)/fbutils.compile: $(fbutils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FBUTILS_DIR) && $(FBUTILS_ENV) $(FBUTILS_PATH) make $(FBUTILS_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fbutils_install: $(STATEDIR)/fbutils.install

$(STATEDIR)/fbutils.install: $(fbutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fbutils_targetinstall: $(STATEDIR)/fbutils.targetinstall

$(STATEDIR)/fbutils.targetinstall: $(fbutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, fbutils)
	@$(call install_fixup, fbutils,PACKAGE,fbutils)
	@$(call install_fixup, fbutils,PRIORITY,optional)
	@$(call install_fixup, fbutils,VERSION,$(FBUTILS_VERSION))
	@$(call install_fixup, fbutils,SECTION,base)
	@$(call install_fixup, fbutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, fbutils,DEPENDS,)
	@$(call install_fixup, fbutils,DESCRIPTION,missing)

ifdef PTXCONF_FBUTILS_FBSET
	@$(call install_copy, fbutils, 0, 0, 0755, $(FBUTILS_DIR)/fbset/fbset, /sbin/fbset)
endif
ifdef PTXCONF_FBUTILS_FBCMAP
	@$(call install_copy, fbutils, 0, 0, 0755, $(FBUTILS_DIR)/fbcmap/fbcmap, /sbin/fbcmap)
endif
ifdef PTXCONF_FBUTILS_FBCONVERT
	@$(call install_copy, fbutils, 0, 0, 0755, $(FBUTILS_DIR)/fbconvert/fbconvert, /sbin/fbconvert)
endif
ifdef PTXCONF_FBUTILS_FBCONVERT
	@$(call install_copy, fbutils, 0, 0, 0755, $(FBUTILS_DIR)/fbconvert/fbconvert, /sbin/fbconvert)
endif
ifdef PTXCONF_FBUTILS_CON2FBMAP
	@$(call install_copy, fbutils, 0, 0, 0755, $(FBUTILS_DIR)/con2fbmap/con2fbmap, /sbin/con2fbmap)
endif
	@$(call install_finish, fbutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fbutils_clean:
	rm -rf $(STATEDIR)/fbutils.*
	rm -rf $(PKGDIR)/fbutils_*
	rm -rf $(FBUTILS_DIR)

# vim: syntax=make
