# -*-makefile-*-
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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

$(HACKBENCH_SOURCE):
	@$(call targetinfo)
	@$(call get, HACKBENCH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HACKBENCH_PATH	:= PATH=$(CROSS_PATH)
HACKBENCH_ENV 	:= $(CROSS_ENV)

$(STATEDIR)/hackbench.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/hackbench.compile:
	@$(call targetinfo)
	cd $(HACKBENCH_DIR) && $(HACKBENCH_PATH) CC=$(CROSS_CC) $(MAKE) $(PARALLELMFLAGS) hackbench
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hackbench.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hackbench.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hackbench)
	@$(call install_fixup, hackbench,PRIORITY,optional)
	@$(call install_fixup, hackbench,SECTION,base)
	@$(call install_fixup, hackbench,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, hackbench,DESCRIPTION,missing)

	@$(call install_copy, hackbench, 0, 0, 0755, $(HACKBENCH_DIR)/hackbench, /usr/bin/hackbench)

	@$(call install_finish, hackbench)

	@$(call touch)

# vim: syntax=make
