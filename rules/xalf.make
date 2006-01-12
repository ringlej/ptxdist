# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XALF) += xalf

#
# Paths and names
#
XALF_VERSION		= 0.12
XALF			= xalf-$(XALF_VERSION)
XALF_SUFFIX		= tgz
XALF_URL		= http://www.lysator.liu.se/~astrand/projects/xalf/$(XALF).$(XALF_SUFFIX)
XALF_SOURCE		= $(SRCDIR)/$(XALF).$(XALF_SUFFIX)
XALF_DIR		= $(BUILDDIR)/$(XALF)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xalf_get: $(STATEDIR)/xalf.get

$(STATEDIR)/xalf.get: $(XALF_SOURCE)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XALF_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XALF_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xalf_extract: $(STATEDIR)/xalf.extract

$(STATEDIR)/xalf.extract: $(xalf_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XALF_DIR))
	@$(call extract, $(XALF_SOURCE))
	@$(call patchin, $(XALF))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xalf_prepare: $(STATEDIR)/xalf.prepare

XALF_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
XALF_ENV 	=  $(CROSS_ENV)
#XALF_ENV	+=

#
# autoconf
#
XALF_AUTOCONF	=  $(CROSS_AUTOCONF_USR)

#XALF_AUTOCONF	+= 

$(STATEDIR)/xalf.prepare: $(xalf_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XALF_BUILDDIR))
	cd $(XALF_DIR) && \
		$(XALF_PATH) $(XALF_ENV) \
		./configure $(XALF_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xalf_compile: $(STATEDIR)/xalf.compile

$(STATEDIR)/xalf.compile: $(xalf_compile_deps_default)
	@$(call targetinfo, $@)
	$(XALF_PATH) $(XALF_ENV) make -C $(XALF_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xalf_install: $(STATEDIR)/xalf.install

$(STATEDIR)/xalf.install: $(xalf_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XALF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xalf_targetinstall: $(STATEDIR)/xalf.targetinstall

$(STATEDIR)/xalf.targetinstall: $(xalf_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xalf)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XALF_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XALF_DIR)/src/xalf, /usr/bin/xalf)
	
	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xalf_clean:
	rm -rf $(STATEDIR)/xalf.*
	rm -rf $(IMAGEDIR)/xalf_*
	rm -rf $(XALF_DIR)

# vim: syntax=make
