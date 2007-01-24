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
PACKAGES-$(PTXCONF_NANO) += nano

#
# Paths and names
#
NANO_VERSION		= 1.3.10
NANO			= nano-$(NANO_VERSION)
NANO_SUFFIX		= tar.gz
NANO_URL		= http://www.nano-editor.org/dist/v1.3/$(NANO).$(NANO_SUFFIX)
NANO_SOURCE		= $(SRCDIR)/$(NANO).$(NANO_SUFFIX)
NANO_DIR		= $(BUILDDIR)/$(NANO)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

nano_get: $(STATEDIR)/nano.get

$(STATEDIR)/nano.get: $(nano_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(NANO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, NANO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

nano_extract: $(STATEDIR)/nano.extract

$(STATEDIR)/nano.extract: $(nano_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NANO_DIR))
	@$(call extract, NANO)
	@$(call patchin, NANO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

nano_prepare: $(STATEDIR)/nano.prepare

NANO_PATH	=  PATH=$(CROSS_PATH)
NANO_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
NANO_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

$(STATEDIR)/nano.prepare: $(nano_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NANO_DIR)/config.cache)
	cd $(NANO_DIR) && \
		$(NANO_PATH) $(NANO_ENV) \
		./configure $(NANO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nano_compile: $(STATEDIR)/nano.compile

$(STATEDIR)/nano.compile: $(nano_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(NANO_DIR) && $(NANO_ENV) $(NANO_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nano_install: $(STATEDIR)/nano.install

$(STATEDIR)/nano.install: $(nano_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, NANO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

nano_targetinstall: $(STATEDIR)/nano.targetinstall

$(STATEDIR)/nano.targetinstall: $(nano_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, nano)
	@$(call install_fixup,nano,PACKAGE,nano)
	@$(call install_fixup,nano,PRIORITY,optional)
	@$(call install_fixup,nano,VERSION,$(NANO_VERSION))
	@$(call install_fixup,nano,SECTION,base)
	@$(call install_fixup,nano,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,nano,DEPENDS,)
	@$(call install_fixup,nano,DESCRIPTION,missing)

	@$(call install_copy, nano, 0, 0, 0755, $(NANO_DIR)/src/nano, /usr/bin/nano)
	@$(call install_finish,nano)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nano_clean:
	rm -rf $(STATEDIR)/nano.*
	rm -rf $(NANO_DIR)

# vim: syntax=make
