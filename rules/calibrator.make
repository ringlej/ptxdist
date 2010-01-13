# -*-makefile-*-
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
PACKAGES-$(PTXCONF_CALIBRATOR) += calibrator

#
# Paths and names
#
CALIBRATOR_VERSION	:= 20070821-1
CALIBRATOR		:= calibrator-$(CALIBRATOR_VERSION)
CALIBRATOR_SUFFIX	:= tar.bz2
CALIBRATOR_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(CALIBRATOR).$(CALIBRATOR_SUFFIX)
CALIBRATOR_SOURCE	:= $(SRCDIR)/$(CALIBRATOR).$(CALIBRATOR_SUFFIX)
CALIBRATOR_DIR		:= $(BUILDDIR)/$(CALIBRATOR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CALIBRATOR_SOURCE):
	@$(call targetinfo)
	@$(call get, CALIBRATOR)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

CALIBRATOR_PATH		:= PATH=$(CROSS_PATH)
CALIBRATOR_MAKE_ENV	:= $(CROSS_ENV) LDFLAGS=-lm
CALIBRATOR_MAKE_OPT	:= calibrator

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/calibrator.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/calibrator.targetinstall:
	@$(call targetinfo)

	@$(call install_init, calibrator)
	@$(call install_fixup, calibrator,PACKAGE,calibrator)
	@$(call install_fixup, calibrator,PRIORITY,optional)
	@$(call install_fixup, calibrator,VERSION,$(CALIBRATOR_VERSION))
	@$(call install_fixup, calibrator,SECTION,base)
	@$(call install_fixup, calibrator,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, calibrator,DEPENDS,)
	@$(call install_fixup, calibrator,DESCRIPTION,missing)

	@$(call install_copy, calibrator, 0, 0, 0755, $(CALIBRATOR_DIR)/calibrator, /usr/bin/calibrator)

	@$(call install_finish, calibrator)

	@$(call touch)

# vim: syntax=make
