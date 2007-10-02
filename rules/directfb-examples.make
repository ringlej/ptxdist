# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DIRECTFB_EXAMPLES) += directfb-examples

#
# Paths and names
#
DIRECTFB_EXAMPLES_VERSION	:= 1.0.0
DIRECTFB_EXAMPLES		:= DirectFB-examples-$(DIRECTFB_EXAMPLES_VERSION)
DIRECTFB_EXAMPLES_SUFFIX	:= tar.gz
DIRECTFB_EXAMPLES_URL		:= http://www.directfb.org/downloads/Extras/$(DIRECTFB_EXAMPLES).$(DIRECTFB_EXAMPLES_SUFFIX)
DIRECTFB_EXAMPLES_SOURCE	:= $(SRCDIR)/$(DIRECTFB_EXAMPLES).$(DIRECTFB_EXAMPLES_SUFFIX)
DIRECTFB_EXAMPLES_DIR		:= $(BUILDDIR)/$(DIRECTFB_EXAMPLES)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

directfb-examples_get: $(STATEDIR)/directfb-examples.get

$(STATEDIR)/directfb-examples.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DIRECTFB_EXAMPLES_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DIRECTFB_EXAMPLES)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

directfb-examples_extract: $(STATEDIR)/directfb-examples.extract

$(STATEDIR)/directfb-examples.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(DIRECTFB_EXAMPLES_DIR))
	@$(call extract, DIRECTFB_EXAMPLES)
	@$(call patchin, DIRECTFB_EXAMPLES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

directfb-examples_prepare: $(STATEDIR)/directfb-examples.prepare

DIRECTFB_EXAMPLES_PATH	:= PATH=$(CROSS_PATH)
DIRECTFB_EXAMPLES_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DIRECTFB_EXAMPLES_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/directfb-examples.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(DIRECTFB_EXAMPLES_DIR)/config.cache)
	cd $(DIRECTFB_EXAMPLES_DIR) && \
		$(DIRECTFB_EXAMPLES_PATH) $(DIRECTFB_EXAMPLES_ENV) \
		./configure $(DIRECTFB_EXAMPLES_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

directfb-examples_compile: $(STATEDIR)/directfb-examples.compile

$(STATEDIR)/directfb-examples.compile:
	@$(call targetinfo, $@)
	cd $(DIRECTFB_EXAMPLES_DIR) && $(DIRECTFB_EXAMPLES_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

directfb-examples_install: $(STATEDIR)/directfb-examples.install

$(STATEDIR)/directfb-examples.install:
	@$(call targetinfo, $@)
	@$(call install, DIRECTFB_EXAMPLES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

directfb-examples_targetinstall: $(STATEDIR)/directfb-examples.targetinstall

$(STATEDIR)/directfb-examples.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, directfb-examples)
	@$(call install_fixup, directfb-examples,PACKAGE,directfb-examples)
	@$(call install_fixup, directfb-examples,PRIORITY,optional)
	@$(call install_fixup, directfb-examples,VERSION,$(DIRECTFB_EXAMPLES_VERSION))
	@$(call install_fixup, directfb-examples,SECTION,base)
	@$(call install_fixup, directfb-examples,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, directfb-examples,DEPENDS,)
	@$(call install_fixup, directfb-examples,DESCRIPTION,missing)

# 	@$(call install_copy, directfb-examples, 0, 0, 0755, $(DIRECTFB_EXAMPLES_DIR)/foobar, /dev/null)

	@$(call install_finish, directfb-examples)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

directfb-examples_clean:
	rm -rf $(STATEDIR)/directfb-examples.*
	rm -rf $(IMAGEDIR)/directfb-examples_*
	rm -rf $(DIRECTFB_EXAMPLES_DIR)

# vim: syntax=make
