# -*-makefile-*-
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
#               2003-2008 by Pengutronix e.K., Hildesheim, Germany
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
PACKAGES-$(PTXCONF_STRACE) += strace

#
# Paths and names
#
STRACE_VERSION	:= 4.5.19
STRACE		:= strace-$(STRACE_VERSION)
STRACE_SUFFIX	:= tar.bz2
STRACE_URL	:= $(PTXCONF_SETUP_SFMIRROR)/strace/$(STRACE).$(STRACE_SUFFIX)
STRACE_SOURCE	:= $(SRCDIR)/$(STRACE).$(STRACE_SUFFIX)
STRACE_DIR	:= $(BUILDDIR)/$(STRACE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STRACE_SOURCE):
	@$(call targetinfo)
	@$(call get, STRACE)

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

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/strace.targetinstall:
	@$(call targetinfo)

	@$(call install_init, strace)
	@$(call install_fixup, strace,PACKAGE,strace)
	@$(call install_fixup, strace,PRIORITY,optional)
	@$(call install_fixup, strace,VERSION,$(STRACE_VERSION))
	@$(call install_fixup, strace,SECTION,base)
	@$(call install_fixup, strace,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, strace,DEPENDS,)
	@$(call install_fixup, strace,DESCRIPTION,missing)

	@$(call install_copy, strace, 0, 0, 0755, -, /usr/bin/strace)

	@$(call install_finish, strace)

	@$(call touch)

# vim: syntax=make
