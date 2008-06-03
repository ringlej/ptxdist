# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by BSP
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ETHERWAKE) += etherwake

#
# Paths and names
#
ETHERWAKE_VERSION	= 1.08
ETHERWAKE		= etherwake-$(ETHERWAKE_VERSION).orig
ETHERWAKE_SUFFIX	= tar.gz
ETHERWAKE_URL		= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/e/etherwake/etherwake_$(ETHERWAKE_VERSION).orig.$(ETHERWAKE_SUFFIX)
ETHERWAKE_SOURCE	= $(SRCDIR)/etherwake_$(ETHERWAKE_VERSION).orig.$(ETHERWAKE_SUFFIX)
ETHERWAKE_DIR		= $(BUILDDIR)/$(ETHERWAKE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

etherwake_get: $(STATEDIR)/etherwake.get

$(STATEDIR)/etherwake.get: $(etherwake_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ETHERWAKE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, ETHERWAKE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

etherwake_extract: $(STATEDIR)/etherwake.extract

$(STATEDIR)/etherwake.extract: $(etherwake_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ETHERWAKE_DIR))
	@$(call extract, ETHERWAKE)
	@$(call patchin, ETHERWAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

etherwake_prepare: $(STATEDIR)/etherwake.prepare

ETHERWAKE_PATH	=  PATH=$(CROSS_PATH)
ETHERWAKE_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/etherwake.prepare: $(etherwake_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ETHERWAKE_DIR)/config.cache)
	cd $(ETHERWAKE_DIR) && \
		perl -i -p -e 's/CC.*=.*//' $(ETHERWAKE_DIR)/Makefile
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

etherwake_compile: $(STATEDIR)/etherwake.compile

$(STATEDIR)/etherwake.compile: $(etherwake_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(ETHERWAKE_DIR) && $(ETHERWAKE_ENV) $(ETHERWAKE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

etherwake_install: $(STATEDIR)/etherwake.install

$(STATEDIR)/etherwake.install: $(etherwake_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	#@$(call install, ETHERWAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

etherwake_targetinstall: $(STATEDIR)/etherwake.targetinstall

$(STATEDIR)/etherwake.targetinstall: $(etherwake_targetinstall_deps_default)
	@$(call targetinfo, $@)
	
	@$(call install_init, etherwake)
	@$(call install_fixup, etherwake,PACKAGE,etherwake)
	@$(call install_fixup, etherwake,PRIORITY,optional)
	@$(call install_fixup, etherwake,VERSION,$(ETHERWAKE_VERSION))
	@$(call install_fixup, etherwake,SECTION,base)
	@$(call install_fixup, etherwake,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, etherwake,DEPENDS,)
	@$(call install_fixup, etherwake,DESCRIPTION,missing)
	
	@$(call install_copy, etherwake, 0, 0, 0755, $(ETHERWAKE_DIR)/etherwake, /usr/sbin/etherwake)

	@$(call install_finish, etherwake)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

etherwake_clean:
	rm -rf $(STATEDIR)/etherwake.*
	rm -rf $(PKGDIR)/etherwake_*
	rm -rf $(ETHERWAKE_DIR)

# vim: syntax=make
