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

$(STATEDIR)/myghty.get: $(myghty_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MYGHTY_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MYGHTY)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

myghty_extract: $(STATEDIR)/myghty.extract

$(STATEDIR)/myghty.extract: $(myghty_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MYGHTY_DIR))
	@$(call extract, MYGHTY)
	@$(call patchin, MYGHTY)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

myghty_prepare: $(STATEDIR)/myghty.prepare

MYGHTY_PATH	=  PATH=$(CROSS_PATH)
MYGHTY_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
MYGHTY_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/myghty.prepare: $(myghty_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MYGHTY_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

myghty_compile: $(STATEDIR)/myghty.compile

$(STATEDIR)/myghty.compile: $(myghty_compile_deps_default)
	@$(call targetinfo, $@)
	#cd $(MYGHTY_DIR) && $(MYGHTY_ENV) $(MYGHTY_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

myghty_install: $(STATEDIR)/myghty.install

$(STATEDIR)/myghty.install: $(myghty_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	# @$(call install, MYGHTY)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

myghty_targetinstall: $(STATEDIR)/myghty.targetinstall

$(STATEDIR)/myghty.targetinstall: $(myghty_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, myghty)
	@$(call install_fixup, myghty,PACKAGE,myghty)
	@$(call install_fixup, myghty,PRIORITY,optional)
	@$(call install_fixup, myghty,VERSION,$(MYGHTY_VERSION))
	@$(call install_fixup, myghty,SECTION,base)
	@$(call install_fixup, myghty,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, myghty,DEPENDS,)
	@$(call install_fixup, myghty,DESCRIPTION,missing)

	#@$(call install_copy, myghty, 0, 0, 0755, $(MYGHTY_DIR)/foobar, /dev/null)

	@$(call install_finish, myghty)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

myghty_clean:
	rm -rf $(STATEDIR)/myghty.*
	rm -rf $(PKGDIR)/myghty_*
	rm -rf $(MYGHTY_DIR)

# vim: syntax=make
