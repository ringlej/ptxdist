# -*-makefile-*-
# $Id: template 3288 2005-11-02 06:10:51Z rsc $
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
PACKAGES-$(PTXCONF_MYGHTY) += myghty

#
# Paths and names
#
MYGHTY_VERSION	= 0.99
MYGHTY		= Myghty-$(MYGHTY_VERSION)
MYGHTY_SUFFIX	= tar.gz
MYGHTY_URL	= $(PTXCONF_SETUP_SFMIRROR)/myghty/$(MYGHTY).$(MYGHTY_SUFFIX)
MYGHTY_SOURCE	= $(SRCDIR)/$(MYGHTY).$(MYGHTY_SUFFIX)
MYGHTY_DIR	= $(BUILDDIR)/$(MYGHTY)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

myghty_get: $(STATEDIR)/myghty.get

myghty_get_deps = $(MYGHTY_SOURCE)

$(STATEDIR)/myghty.get: $(myghty_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MYGHTY_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MYGHTY_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

myghty_extract: $(STATEDIR)/myghty.extract

myghty_extract_deps = $(STATEDIR)/myghty.get

$(STATEDIR)/myghty.extract: $(myghty_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MYGHTY_DIR))
	@$(call extract, $(MYGHTY_SOURCE))
	@$(call patchin, $(MYGHTY))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

myghty_prepare: $(STATEDIR)/myghty.prepare

#
# dependencies
#
myghty_prepare_deps = \
	$(STATEDIR)/myghty.extract \
	$(STATEDIR)/virtual-xchain.install

MYGHTY_PATH	=  PATH=$(CROSS_PATH)
MYGHTY_ENV 	=  $(CROSS_ENV)
MYGHTY_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
MYGHTY_AUTOCONF =  $(CROSS_AUTOCONF)
MYGHTY_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/myghty.prepare: $(myghty_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MYGHTY_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

myghty_compile: $(STATEDIR)/myghty.compile

myghty_compile_deps = $(STATEDIR)/myghty.prepare

$(STATEDIR)/myghty.compile: $(myghty_compile_deps)
	@$(call targetinfo, $@)
	#cd $(MYGHTY_DIR) && $(MYGHTY_ENV) $(MYGHTY_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

myghty_install: $(STATEDIR)/myghty.install

$(STATEDIR)/myghty.install: $(STATEDIR)/myghty.compile
	@$(call targetinfo, $@)
	# FIXME
	# @$(call install, MYGHTY)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

myghty_targetinstall: $(STATEDIR)/myghty.targetinstall

myghty_targetinstall_deps = $(STATEDIR)/myghty.compile

$(STATEDIR)/myghty.targetinstall: $(myghty_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,myghty)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(MYGHTY_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	#@$(call install_copy, 0, 0, 0755, $(MYGHTY_DIR)/foobar, /dev/null)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

myghty_clean:
	rm -rf $(STATEDIR)/myghty.*
	rm -rf $(IMAGEDIR)/myghty_*
	rm -rf $(MYGHTY_DIR)

# vim: syntax=make
