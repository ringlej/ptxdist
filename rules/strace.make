# -*-makefile-*-
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
#               2003-2008 by Pengutronix e.K., Hildesheim, Germany
#               2009, 2010, 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
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
STRACE_VERSION	:= 4.7
STRACE_MD5	:= 6054c3880a00c6703f83b57f15e04642
STRACE		:= strace-$(STRACE_VERSION)
STRACE_SUFFIX	:= tar.xz
STRACE_URL	:= $(call ptx/mirror, SF, strace/$(STRACE).$(STRACE_SUFFIX))
STRACE_SOURCE	:= $(SRCDIR)/$(STRACE).$(STRACE_SUFFIX)
STRACE_DIR	:= $(BUILDDIR)/$(STRACE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

STRACE_ENV 	:= $(CROSS_ENV)

ifndef PTXCONF_STRACE_SHARED
STRACE_ENV	+=  LDFLAGS=-static
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/strace.targetinstall:
	@$(call targetinfo)

	@$(call install_init, strace)
	@$(call install_fixup, strace,PRIORITY,optional)
	@$(call install_fixup, strace,SECTION,base)
	@$(call install_fixup, strace,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, strace,DESCRIPTION,missing)

	@$(call install_copy, strace, 0, 0, 0755, -, /usr/bin/strace)

	@$(call install_finish, strace)

	@$(call touch)

# vim: syntax=make
