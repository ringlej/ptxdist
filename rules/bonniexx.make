# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BONNIEXX) += bonniexx

#
# Paths and names
#
BONNIEXX_VERSION	= 1.03a
BONNIEXX		= bonnie++-$(BONNIEXX_VERSION)
BONNIEXX_SUFFIX		= tgz
BONNIEXX_URL		= http://www.coker.com.au/bonnie++/$(BONNIEXX).$(BONNIEXX_SUFFIX)
BONNIEXX_SOURCE		= $(SRCDIR)/$(BONNIEXX).$(BONNIEXX_SUFFIX)
BONNIEXX_DIR		= $(BUILDDIR)/$(BONNIEXX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bonniexx_get: $(STATEDIR)/bonniexx.get

$(STATEDIR)/bonniexx.get: $(bonniexx_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BONNIEXX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, BONNIEXX)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bonniexx_extract: $(STATEDIR)/bonniexx.extract

$(STATEDIR)/bonniexx.extract: $(bonniexx_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BONNIEXX_DIR))
	@$(call extract, BONNIEXX)
	@$(call patchin, BONNIEXX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bonniexx_prepare: $(STATEDIR)/bonniexx.prepare

BONNIEXX_PATH	  =  PATH=$(CROSS_PATH)
BONNIEXX_ENV 	  =  $(CROSS_ENV)
BONNIEXX_MAKEVARS =  prefix=$(SYSROOT) 

#
# autoconf without automake :-(
#
# - stripping does not work, because bonnie's Makefile uses wrong
#   install version (for host)

BONNIEXX_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--disable-stripping

$(STATEDIR)/bonniexx.prepare: $(bonniexx_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BONNIEXX_DIR)/config.cache)
	cd $(BONNIEXX_DIR) && \
		$(BONNIEXX_PATH) $(BONNIEXX_ENV) \
		./configure $(BONNIEXX_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

bonniexx_compile: $(STATEDIR)/bonniexx.compile

$(STATEDIR)/bonniexx.compile: $(bonniexx_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(BONNIEXX_DIR) && $(BONNIEXX_ENV) $(BONNIEXX_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bonniexx_install: $(STATEDIR)/bonniexx.install

$(STATEDIR)/bonniexx.install: $(bonniexx_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, BONNIEXX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bonniexx_targetinstall: $(STATEDIR)/bonniexx.targetinstall

$(STATEDIR)/bonniexx.targetinstall: $(bonniexx_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, bonniexx)
	@$(call install_fixup, bonniexx,PACKAGE,bonniexx)
	@$(call install_fixup, bonniexx,PRIORITY,optional)
	@$(call install_fixup, bonniexx,VERSION,$(COREUTILS_VERSION))
	@$(call install_fixup, bonniexx,SECTION,base)
	@$(call install_fixup, bonniexx,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, bonniexx,DEPENDS,)
	@$(call install_fixup, bonniexx,DESCRIPTION,missing)

	@$(call install_copy, bonniexx, 0, 0, 0755, $(BONNIEXX_DIR)/bonnie++, /usr/bin/bonnie++)

	@$(call install_finish, bonniexx)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bonniexx_clean:
	rm -rf $(STATEDIR)/bonniexx.*
	rm -rf $(PKGDIR)/bonniexx_*
	rm -rf $(BONNIEXX_DIR)

# vim: syntax=make
