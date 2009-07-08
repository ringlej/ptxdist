# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KILLPROC) += killproc

#
# Paths and names
#
KILLPROC_VERSION	:= 2.13
KILLPROC		:= killproc-$(KILLPROC_VERSION)
KILLPROC_SUFFIX		:= tar.gz
KILLPROC_URL		:= http://ftp.suse.com/pub/projects/init/$(KILLPROC).$(KILLPROC_SUFFIX)
KILLPROC_SOURCE		:= $(SRCDIR)/$(KILLPROC).$(KILLPROC_SUFFIX)
KILLPROC_DIR		:= $(BUILDDIR)/$(KILLPROC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

killproc_get: $(STATEDIR)/killproc.get

$(STATEDIR)/killproc.get: $(killproc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(KILLPROC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, KILLPROC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

killproc_extract: $(STATEDIR)/killproc.extract

$(STATEDIR)/killproc.extract: $(killproc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(KILLPROC_DIR))
	@$(call extract, KILLPROC)
	@$(call patchin, KILLPROC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

killproc_prepare: $(STATEDIR)/killproc.prepare

KILLPROC_PATH	:= PATH=$(CROSS_PATH)
KILLPROC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
KILLPROC_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/killproc.prepare: $(killproc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

killproc_compile: $(STATEDIR)/killproc.compile

$(STATEDIR)/killproc.compile: $(killproc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(KILLPROC_DIR) && $(KILLPROC_PATH) $(MAKE) $(PARALLELMFLAGS) CC=$(CROSS_CC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

killproc_install: $(STATEDIR)/killproc.install

$(STATEDIR)/killproc.install: $(killproc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, KILLPROC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

killproc_targetinstall: $(STATEDIR)/killproc.targetinstall

$(STATEDIR)/killproc.targetinstall: $(killproc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, killproc)
	@$(call install_fixup, killproc,PACKAGE,killproc)
	@$(call install_fixup, killproc,PRIORITY,optional)
	@$(call install_fixup, killproc,VERSION,$(KILLPROC_VERSION))
	@$(call install_fixup, killproc,SECTION,base)
	@$(call install_fixup, killproc,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, killproc,DEPENDS,)
	@$(call install_fixup, killproc,DESCRIPTION,missing)

ifdef PTXCONF_KILLPROC_CHECKPROC
	@$(call install_copy, killproc, 0, 0, 0755, $(KILLPROC_DIR)/checkproc, /usr/bin/checkproc)
endif
ifdef PTXCONF_KILLPROC_KILLPROC
	@$(call install_copy, killproc, 0, 0, 0755, $(KILLPROC_DIR)/checkproc, /usr/bin/killproc)
endif
ifdef PTXCONF_KILLPROC_STARTPROC
	@$(call install_copy, killproc, 0, 0, 0755, $(KILLPROC_DIR)/checkproc, /usr/bin/startproc)
endif
ifdef PTXCONF_KILLPROC_USLEEP
	@$(call install_copy, killproc, 0, 0, 0755, $(KILLPROC_DIR)/checkproc, /usr/bin/usleep)
endif

	@$(call install_finish, killproc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

killproc_clean:
	rm -rf $(STATEDIR)/killproc.*
	rm -rf $(IMAGEDIR)/killproc_*
	rm -rf $(KILLPROC_DIR)

# vim: syntax=make
