# -*-makefile-*-
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
#               2002-2008 by Pengutronix e.K., Hildesheim, Germany
#               2009, 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GDBSERVER) += gdbserver

GDBSERVER_VERSION	:= $(call remove_quotes,$(PTXCONF_GDB_VERSION))
GDBSERVER_MD5		:= $(call remove_quotes,$(PTXCONF_GDB_MD5))
GDBSERVER		:= gdb-$(GDBSERVER_VERSION)
GDBSERVER_SUFFIX	:= tar.bz2
GDBSERVER_SOURCE	:= $(SRCDIR)/$(GDBSERVER).$(GDBSERVER_SUFFIX)
GDBSERVER_DIR		:= $(BUILDDIR)/gdbserver-$(GDBSERVER_VERSION)
GDBSERVER_LICENSE	:= GPLv3+

GDBSERVER_URL := \
	$(call ptx/mirror, GNU, gdb/$(GDBSERVER).$(GDBSERVER_SUFFIX)) \
	ftp://sourceware.org/pub/gdb/snapshots/current/$(GDBSERVER).$(GDBSERVER_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GDBSERVER_ENV := $(GDB_ENV)

ifndef PTXCONF_GDBSERVER_SHARED
GDBSERVER_ENV +=  LDFLAGS=-static
endif

GDBSERVER_CONF_TOOL := autoconf

GDBSERVER_BUILD_OOT := YES
GDBSERVER_SUBDIR := gdb/gdbserver

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gdbserver.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gdbserver)
	@$(call install_fixup, gdbserver,PRIORITY,optional)
	@$(call install_fixup, gdbserver,SECTION,base)
	@$(call install_fixup, gdbserver,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gdbserver,DESCRIPTION,missing)

	@$(call install_copy, gdbserver, 0, 0, 0755, -, /usr/bin/gdbserver)

	@$(call install_finish, gdbserver)

	@$(call touch)

# vim: syntax=make
