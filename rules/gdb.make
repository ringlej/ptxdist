# -*-makefile-*-
#
# Copyright (C) 2002-2008 by Pengutronix e.K., Hildesheim, Germany
#               2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
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
PACKAGES-$(PTXCONF_GDB) += gdb

#
# Paths and names
#
GDB_VERSION	 = $(SHARED_GDB_VERSION)
GDB_MD5		 = $(SHARED_GDB_MD5)
GDB		:= gdb-$(GDB_VERSION)
GDB_SUFFIX	:= tar.xz
GDB_SOURCE	:= $(SRCDIR)/$(GDB).$(GDB_SUFFIX)
GDB_DIR		:= $(BUILDDIR)/$(GDB)
GDB_LICENSE	:= GPL-3.0-or-later

GDB_URL := \
	$(call ptx/mirror, GNU, gdb/$(GDB).$(GDB_SUFFIX)) \
	ftp://sourceware.org/pub/gdb/snapshots/current/$(GDB).$(GDB_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_ARCH_X86
GDB_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_PIE
endif

GDB_ENV := \
	$(CROSS_ENV) \
	$(CROSS_ENV_FLAGS_FOR_TARGET) \
	host_configargs='--disable-tui --disable-rpath --without-expat'

ifndef PTXCONF_GDB_SHARED
GDB_MAKEVARS := LDFLAGS=-static
endif

#
# autoconf
#
GDB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--with-build-sysroot=$(SYSROOT) \
	--disable-werror


GDB_BUILD_OOT := YES

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gdb.install:
	@$(call targetinfo)
	@$(call world/install, GDB)
#	# don't install static libraries to sysroot
	@rm -rf $(GDB_PKGDIR)/usr/lib
	@$(call touch)

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
