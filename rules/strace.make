# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003      by Auerswald GmbH & Co. KG, Schandelah, Germany
#           (C) 2003-2008 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_STRACE) += strace

#
# Paths and names
#
STRACE_VERSION	:= 4.5.15
STRACE		:= strace-$(STRACE_VERSION)
STRACE_SUFFIX	:= tar.bz2
STRACE_URL	:= $(PTXCONF_SETUP_SFMIRROR)/strace/$(STRACE).$(STRACE_SUFFIX)
STRACE_SOURCE	:= $(SRCDIR)/$(STRACE).$(STRACE_SUFFIX)
STRACE_DIR	:= $(BUILDDIR)/$(STRACE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/strace.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(STRACE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, STRACE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/strace.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(STRACE_DIR))
	@$(call extract, STRACE)
	@$(call patchin, STRACE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

STRACE_PATH	:= PATH=$(CROSS_PATH)
STRACE_ENV 	:= $(CROSS_ENV)

ifndef PTXCONF_STRACE_SHARED
STRACE_ENV	+=  LDFLAGS=-static
endif

#
# autoconf
#

STRACE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/strace.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(STRACE_DIR)/config.cache)
	cd $(STRACE_DIR) && \
		$(STRACE_PATH) $(STRACE_ENV) \
		./configure $(STRACE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/strace.compile:
	@$(call targetinfo, $@)
	cd $(STRACE_DIR) && $(STRACE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/strace.install:
	@$(call targetinfo, $@)
	@$(call install, STRACE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/strace.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, strace)
	@$(call install_fixup, strace,PACKAGE,strace)
	@$(call install_fixup, strace,PRIORITY,optional)
	@$(call install_fixup, strace,VERSION,$(STRACE_VERSION))
	@$(call install_fixup, strace,SECTION,base)
	@$(call install_fixup, strace,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, strace,DEPENDS,)
	@$(call install_fixup, strace,DESCRIPTION,missing)

	@$(call install_copy, strace, 0, 0, 0755, $(STRACE_DIR)/strace, /usr/bin/strace)

	@$(call install_finish, strace)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

strace_clean:
	rm -rf $(STATEDIR)/strace.*
	rm -rf $(IMAGEDIR)/strace_*
	rm -rf $(STRACE_DIR)

# vim: syntax=make
