# -*-makefile-*-
# $Id: template-make 8785 2008-08-26 07:48:06Z wsa $
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LTRACE) += ltrace

#
# Paths and names
#
LTRACE_VERSION	:= 0.5
LTRACE_SUFFIX	:= orig.tar.gz
LTRACE		:= ltrace-$(LTRACE_VERSION)
LTRACE_TARBALL	:= ltrace_$(LTRACE_VERSION).$(LTRACE_SUFFIX)
LTRACE_URL	:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/l/ltrace/$(LTRACE_TARBALL)
LTRACE_SOURCE	:= $(SRCDIR)/$(LTRACE_TARBALL)
LTRACE_DIR	:= $(BUILDDIR)/$(LTRACE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LTRACE_SOURCE):
	@$(call targetinfo)
	@$(call get, LTRACE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ltrace.extract:
	@$(call targetinfo)
	@$(call clean, $(LTRACE_DIR))
	@$(call extract, LTRACE)
	@$(call patchin, LTRACE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LTRACE_PATH	:= PATH=$(CROSS_PATH)
LTRACE_ENV 	:= $(CROSS_ENV)
LTRACE_MAKEVARS	:= \
	OS=linux-gnu \
	ARCH=$(PTXCONF_KERNEL_ARCH_STRING)

#
# autoconf
#
LTRACE_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltrace.install:
	@$(call targetinfo)
	@$(call install, LTRACE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltrace.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltrace)
	@$(call install_fixup, ltrace,PACKAGE,ltrace)
	@$(call install_fixup, ltrace,PRIORITY,optional)
	@$(call install_fixup, ltrace,VERSION,$(LTRACE_VERSION))
	@$(call install_fixup, ltrace,SECTION,base)
	@$(call install_fixup, ltrace,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de> <your@email.please>")
	@$(call install_fixup, ltrace,DEPENDS,)
	@$(call install_fixup, ltrace,DESCRIPTION,missing)

	@$(call install_copy, ltrace, 0, 0, 0755, $(LTRACE_DIR)/ltrace, /usr/bin/ltrace)

	@$(call install_finish, ltrace)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltrace_clean:
	rm -rf $(STATEDIR)/ltrace.*
	rm -rf $(PKGDIR)/ltrace_*
	rm -rf $(LTRACE_DIR)

# vim: syntax=make
