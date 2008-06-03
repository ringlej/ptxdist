# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by BSP
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CLOCK) += clock

#
# Paths and names
#
CLOCK_VERSION		= 1.5.1
CLOCK			= clock-$(CLOCK_VERSION)
CLOCK_SUFFIX		= tar.gz
CLOCK_URL		= http://ftp.linux.org.uk/pub/linux/people/alex/$(CLOCK).$(CLOCK_SUFFIX)
CLOCK_SOURCE		= $(SRCDIR)/$(CLOCK).$(CLOCK_SUFFIX)
CLOCK_DIR		= $(BUILDDIR)/$(CLOCK)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

clock_get: $(STATEDIR)/clock.get

$(STATEDIR)/clock.get: $(clock_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CLOCK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CLOCK)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

clock_extract: $(STATEDIR)/clock.extract

$(STATEDIR)/clock.extract: $(clock_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CLOCK_DIR))
	@$(call extract, CLOCK)
	@$(call patchin, CLOCK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

clock_prepare: $(STATEDIR)/clock.prepare

CLOCK_PATH	=  PATH=$(CROSS_PATH)
CLOCK_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/clock.prepare: $(clock_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

clock_compile: $(STATEDIR)/clock.compile

$(STATEDIR)/clock.compile: $(clock_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CLOCK_DIR) && $(CLOCK_PATH) $(CLOCK_ENV) make $(CLOCK_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

clock_install: $(STATEDIR)/clock.install

$(STATEDIR)/clock.install: $(clock_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	#@$(call install, CLOCK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

clock_targetinstall: $(STATEDIR)/clock.targetinstall

$(STATEDIR)/clock.targetinstall: $(clock_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, clock)
	@$(call install_fixup, clock,PACKAGE,clock)
	@$(call install_fixup, clock,PRIORITY,optional)
	@$(call install_fixup, clock,VERSION,$(CLOCK_VERSION))
	@$(call install_fixup, clock,SECTION,base)
	@$(call install_fixup, clock,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, clock,DEPENDS,)
	@$(call install_fixup, clock,DESCRIPTION,missing)

	@$(call install_copy, clock, 0, 0, 0755, $(CLOCK_DIR)/clock, /sbin/clock)

	@$(call install_finish, clock)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

clock_clean:
	rm -rf $(STATEDIR)/clock.*
	rm -rf $(PKGDIR)/clock_*
	rm -rf $(CLOCK_DIR)

# vim: syntax=make
