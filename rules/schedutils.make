# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by lfu
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SCHEDUTILS) += schedutils

#
# Paths and names
#
SCHEDUTILS_VERSION	:= 1.5.0
SCHEDUTILS		:= schedutils-$(SCHEDUTILS_VERSION)
SCHEDUTILS_SUFFIX	:= tar.gz
SCHEDUTILS_URL		:= http://rlove.org/schedutils/$(SCHEDUTILS).$(SCHEDUTILS_SUFFIX)
SCHEDUTILS_SOURCE	:= $(SRCDIR)/$(SCHEDUTILS).$(SCHEDUTILS_SUFFIX)
SCHEDUTILS_DIR		:= $(BUILDDIR)/$(SCHEDUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

schedutils_get: $(STATEDIR)/schedutils.get

$(STATEDIR)/schedutils.get: $(schedutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SCHEDUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SCHEDUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

schedutils_extract: $(STATEDIR)/schedutils.extract

$(STATEDIR)/schedutils.extract: $(schedutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SCHEDUTILS_DIR))
	@$(call extract, SCHEDUTILS)
	@$(call patchin, SCHEDUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

schedutils_prepare: $(STATEDIR)/schedutils.prepare

SCHEDUTILS_PATH	:=  PATH=$(CROSS_PATH)
SCHEDUTILS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
#SCHEDUTILS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/schedutils.prepare: $(schedutils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

schedutils_compile: $(STATEDIR)/schedutils.compile

$(STATEDIR)/schedutils.compile: $(schedutils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SCHEDUTILS_DIR) && $(SCHEDUTILS_PATH) make $(SCHEDUTILS_ENV) chrt
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

schedutils_install: $(STATEDIR)/schedutils.install

$(STATEDIR)/schedutils.install: $(schedutils_install_deps_default)
	@$(call targetinfo, $@)
#	@$(call install, SCHEDUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

schedutils_targetinstall: $(STATEDIR)/schedutils.targetinstall

$(STATEDIR)/schedutils.targetinstall: $(schedutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, schedutils)
	@$(call install_fixup,schedutils,PACKAGE,schedutils)
	@$(call install_fixup,schedutils,PRIORITY,optional)
	@$(call install_fixup,schedutils,VERSION,$(SCHEDUTILS_VERSION))
	@$(call install_fixup,schedutils,SECTION,base)
	@$(call install_fixup,schedutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,schedutils,DEPENDS,)
	@$(call install_fixup,schedutils,DESCRIPTION,missing)

	@$(call install_copy, schedutils, 0, 0, 0755, $(SCHEDUTILS_DIR)/chrt, /usr/bin/chrt)

	@$(call install_finish,schedutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

schedutils_clean:
	rm -rf $(STATEDIR)/schedutils.*
	rm -rf $(IMAGEDIR)/schedutils_*
	rm -rf $(SCHEDUTILS_DIR)

# vim: syntax=make
