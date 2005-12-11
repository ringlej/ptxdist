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

clock_get_deps = $(CLOCK_SOURCE)

$(STATEDIR)/clock.get: $(clock_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CLOCK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(CLOCK_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

clock_extract: $(STATEDIR)/clock.extract

clock_extract_deps = $(STATEDIR)/clock.get

$(STATEDIR)/clock.extract: $(clock_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CLOCK_DIR))
	@$(call extract, $(CLOCK_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

clock_prepare: $(STATEDIR)/clock.prepare

#
# dependencies
#
clock_prepare_deps = \
	$(STATEDIR)/clock.extract \
	$(STATEDIR)/virtual-xchain.install

CLOCK_PATH	=  PATH=$(CROSS_PATH)
CLOCK_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/clock.prepare: $(clock_prepare_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

clock_compile: $(STATEDIR)/clock.compile

clock_compile_deps = $(STATEDIR)/clock.prepare

$(STATEDIR)/clock.compile: $(clock_compile_deps)
	@$(call targetinfo, $@)
	$(CLOCK_PATH) $(CLOCK_ENV) make -C $(CLOCK_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

clock_install: $(STATEDIR)/clock.install

$(STATEDIR)/clock.install: $(STATEDIR)/clock.compile
	@$(call targetinfo, $@)
	# FIXME
	#@$(call install, CLOCK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

clock_targetinstall: $(STATEDIR)/clock.targetinstall

clock_targetinstall_deps = $(STATEDIR)/clock.compile

$(STATEDIR)/clock.targetinstall: $(clock_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,clock)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(CLOCK_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(CLOCK_DIR)/clock, /sbin/clock)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

clock_clean:
	rm -rf $(STATEDIR)/clock.*
	rm -rf $(IMAGEDIR)/clock_*
	rm -rf $(CLOCK_DIR)

# vim: syntax=make
