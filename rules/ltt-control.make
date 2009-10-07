# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LTT_CONTROL) += ltt-control

#
# Paths and names
#
LTT_CONTROL_VERSION	:= 0.63-03012009
LTT_CONTROL		:= ltt-control-$(LTT_CONTROL_VERSION)
LTT_CONTROL_SUFFIX	:= tar.gz
LTT_CONTROL_URL		:= http://ltt.polymtl.ca/files/lttng/$(LTT_CONTROL).$(LTT_CONTROL_SUFFIX)
LTT_CONTROL_SOURCE	:= $(SRCDIR)/$(LTT_CONTROL).$(LTT_CONTROL_SUFFIX)
LTT_CONTROL_DIR		:= $(BUILDDIR)/$(LTT_CONTROL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltt-control_get: $(STATEDIR)/ltt-control.get

$(STATEDIR)/ltt-control.get: $(ltt-control_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LTT_CONTROL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LTT_CONTROL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltt-control_extract: $(STATEDIR)/ltt-control.extract

$(STATEDIR)/ltt-control.extract: $(ltt-control_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LTT_CONTROL_DIR))
	@$(call extract, LTT_CONTROL)
	@$(call patchin, LTT_CONTROL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltt-control_prepare: $(STATEDIR)/ltt-control.prepare

LTT_CONTROL_PATH	:= PATH=$(CROSS_PATH)
LTT_CONTROL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LTT_CONTROL_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/ltt-control.prepare: $(ltt-control_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LTT_CONTROL_DIR)/config.cache)
	cd $(LTT_CONTROL_DIR) && \
		$(LTT_CONTROL_PATH) $(LTT_CONTROL_ENV) \
		./configure $(LTT_CONTROL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltt-control_compile: $(STATEDIR)/ltt-control.compile

$(STATEDIR)/ltt-control.compile: $(ltt-control_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LTT_CONTROL_DIR) && $(LTT_CONTROL_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltt-control_install: $(STATEDIR)/ltt-control.install

$(STATEDIR)/ltt-control.install: $(ltt-control_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LTT_CONTROL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltt-control_targetinstall: $(STATEDIR)/ltt-control.targetinstall

$(STATEDIR)/ltt-control.targetinstall: $(ltt-control_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, ltt-control)
	@$(call install_fixup, ltt-control,PACKAGE,ltt-control)
	@$(call install_fixup, ltt-control,PRIORITY,optional)
	@$(call install_fixup, ltt-control,VERSION,$(LTT_CONTROL_VERSION))
	@$(call install_fixup, ltt-control,SECTION,base)
	@$(call install_fixup, ltt-control,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltt-control,DEPENDS,)
	@$(call install_fixup, ltt-control,DESCRIPTION,missing)

	@$(call install_copy, ltt-control, 0, 0, 0755, $(LTT_CONTROL_DIR)/lttctl/lttctl, /usr/bin/lttctl)
	@$(call install_copy, ltt-control, 0, 0, 0755, $(LTT_CONTROL_DIR)/lttd/lttd, /usr/bin/lttd)

	@$(call install_copy, ltt-control, 0, 0, 0644, \
		$(LTT_CONTROL_DIR)/liblttctl/.libs/liblttctl.so.0.0.0, \
		/usr/lib/liblttctl.so.0.0.0)
	@$(call install_link, ltt-control, liblttctl.so.0.0.0, /usr/lib/liblttctl.so)
	@$(call install_link, ltt-control, liblttctl.so.0.0.0, /usr/lib/liblttctl.so.0)

	@$(call install_finish, ltt-control)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltt-control_clean:
	rm -rf $(STATEDIR)/ltt-control.*
	rm -rf $(PKGDIR)/ltt-control_*
	rm -rf $(LTT_CONTROL_DIR)

# vim: syntax=make
