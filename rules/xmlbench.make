# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#

#
# FIXME: Broken Package
#
ifdef PTXCONF_XMLBENCH
PACKAGES-$(PTXCONF_XMLBENCH) += xmlbench
endif

#
# Paths and names
#
XMLBENCH_VERSION	:= 1.3.0
XMLBENCH_MD5		:=
XMLBENCH		:= xmlbench-$(XMLBENCH_VERSION)
XMLBENCH_SUFFIX		:= tar.bz2
XMLBENCH_URL		:= $(call ptx/mirror, SF, xmlbench/$(XMLBENCH).$(XMLBENCH_SUFFIX))
XMLBENCH_SOURCE		:= $(SRCDIR)/$(XMLBENCH).$(XMLBENCH_SUFFIX)
XMLBENCH_DIR		:= $(BUILDDIR)/$(XMLBENCH)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XMLBENCH_SOURCE):
	@$(call targetinfo)
	@$(call get, XMLBENCH)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/xmlbench.extract:
	@$(call targetinfo)
	@$(call clean, $(XMLBENCH_DIR))
	@$(call extract, XMLBENCH)
	mv $(BUILDDIR)/xmlbench $(XMLBENCH_DIR)
	@$(call patchin, XMLBENCH)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XMLBENCH_PATH	:= PATH=$(CROSS_PATH)
XMLBENCH_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XMLBENCH_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xmlbench.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xmlbench)
	@$(call install_fixup, xmlbench,PRIORITY,optional)
	@$(call install_fixup, xmlbench,SECTION,base)
	@$(call install_fixup, xmlbench,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xmlbench,DESCRIPTION,missing)

	@$(call install_copy, xmlbench, 0, 0, 0755, $(XMLBENCH_DIR)/foobar, /dev/null)

	@$(call install_finish, xmlbench)

	@$(call touch)

# vim: syntax=make
