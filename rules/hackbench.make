# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HACKBENCH) += hackbench

#
# Paths and names
#
HACKBENCH_VERSION	:= 20070821-1
HACKBENCH		:= hackbench-$(HACKBENCH_VERSION)
HACKBENCH_SUFFIX	:= tar.bz2
HACKBENCH_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(HACKBENCH).$(HACKBENCH_SUFFIX)
HACKBENCH_SOURCE	:= $(SRCDIR)/$(HACKBENCH).$(HACKBENCH_SUFFIX)
HACKBENCH_DIR		:= $(BUILDDIR)/$(HACKBENCH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hackbench_get: $(STATEDIR)/hackbench.get

$(STATEDIR)/hackbench.get: $(hackbench_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HACKBENCH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HACKBENCH)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hackbench_extract: $(STATEDIR)/hackbench.extract

$(STATEDIR)/hackbench.extract: $(hackbench_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HACKBENCH_DIR))
	@$(call extract, HACKBENCH)
	@$(call patchin, HACKBENCH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hackbench_prepare: $(STATEDIR)/hackbench.prepare

HACKBENCH_PATH	:= PATH=$(CROSS_PATH)
HACKBENCH_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
HACKBENCH_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/hackbench.prepare: $(hackbench_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hackbench_compile: $(STATEDIR)/hackbench.compile

$(STATEDIR)/hackbench.compile: $(hackbench_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HACKBENCH_DIR) && $(HACKBENCH_PATH) CC=$(CROSS_CC) $(MAKE) $(PARALLELMFLAGS) hackbench
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hackbench_install: $(STATEDIR)/hackbench.install

$(STATEDIR)/hackbench.install: $(hackbench_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hackbench_targetinstall: $(STATEDIR)/hackbench.targetinstall

$(STATEDIR)/hackbench.targetinstall: $(hackbench_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, hackbench)
	@$(call install_fixup, hackbench,PACKAGE,hackbench)
	@$(call install_fixup, hackbench,PRIORITY,optional)
	@$(call install_fixup, hackbench,VERSION,$(HACKBENCH_VERSION))
	@$(call install_fixup, hackbench,SECTION,base)
	@$(call install_fixup, hackbench,AUTHOR,"Michael Olbrich <m.olbrich\@pengutronix.de>")
	@$(call install_fixup, hackbench,DEPENDS,)
	@$(call install_fixup, hackbench,DESCRIPTION,missing)

	@$(call install_copy, hackbench, 0, 0, 0755, $(HACKBENCH_DIR)/hackbench, /usr/bin/hackbench)

	@$(call install_finish, hackbench)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hackbench_clean:
	rm -rf $(STATEDIR)/hackbench.*
	rm -rf $(IMAGEDIR)/hackbench_*
	rm -rf $(HACKBENCH_DIR)

# vim: syntax=make
