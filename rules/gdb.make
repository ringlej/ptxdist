# -*-makefile-*-
#
# Copyright (C) 2002-2008 by Pengutronix e.K., Hildesheim, Germany
#               2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
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
PACKAGES-$(PTXCONF_GDB) += gdb

#
# Paths and names
#
GDB_VERSION	:= $(call remove_quotes,$(PTXCONF_GDB_VERSION))
GDB_MD5		:= $(call remove_quotes,$(PTXCONF_GDB_MD5))
GDB		:= gdb-$(GDB_VERSION)
GDB_SUFFIX	:= tar.bz2
GDB_SOURCE	:= $(SRCDIR)/$(GDB).$(GDB_SUFFIX)
GDB_DIR		:= $(BUILDDIR)/$(GDB)
GDB_BUILDDIR	:= $(BUILDDIR)/$(GDB)-build
GDB_LICENSE	:= GPLv3+

GDB_URL		:= \
	$(PTXCONF_SETUP_GNUMIRROR)/gdb/$(GDB).$(GDB_SUFFIX) \
	ftp://sourceware.org/pub/gdb/snapshots/current/$(GDB).$(GDB_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GDB_SOURCE):
	@$(call targetinfo)
	@$(call get, GDB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

#
# extra dep for the gdbserver
#
$(STATEDIR)/gdb.extract: $(GDB_SOURCE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GDB_PATH	:= PATH=$(CROSS_PATH)
GDB_ENV		:= \
	$(CROSS_ENV) \
	$(CROSS_ENV_FLAGS_FOR_TARGET)

ifndef PTXCONF_GDB_SHARED
GDB_MAKEVARS	:=  LDFLAGS=-static
endif

#
# autoconf
#
GDB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--with-build-sysroot=$(SYSROOT) \
	--disable-werror

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gdb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gdb)
	@$(call install_fixup, gdb,PRIORITY,optional)
	@$(call install_fixup, gdb,SECTION,base)
	@$(call install_fixup, gdb,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gdb,DESCRIPTION,missing)

	@$(call install_copy, gdb, 0, 0, 0755, -, /usr/bin/gdb)

	@$(call install_finish, gdb)
	@$(call touch)

# vim: syntax=make
