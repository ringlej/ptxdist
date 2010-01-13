# -*-makefile-*-
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
#               2002-2008 by Pengutronix e.K., Hildesheim, Germany
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
PACKAGES-$(PTXCONF_GDBSERVER) += gdbserver

GDBSERVER		= gdbserver-$(GDB_VERSION)
GDBSERVER_BUILDDIR	= $(BUILDDIR)/$(GDB)-server-build
GDBSERVER_LICENSE	:= GPLv3+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/gdbserver.get: $(STATEDIR)/gdb.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/gdbserver.extract: $(STATEDIR)/gdb.extract
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GDBSERVER_PATH	:= $(GDB_PATH)
GDBSERVER_ENV	:= $(GDB_ENV)

ifndef PTXCONF_GDBSERVER_SHARED
GDBSERVER_ENV	+=  LDFLAGS=-static
endif

#
# autoconf
#
GDBSERVER_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--with-build-sysroot=$(SYSROOT)

$(STATEDIR)/gdbserver.prepare:
	@$(call targetinfo)
	@$(call clean, $(GDBSERVER_BUILDDIR))
	mkdir -p $(GDBSERVER_BUILDDIR)
	cd $(GDBSERVER_BUILDDIR) && $(GDBSERVER_PATH) $(GDBSERVER_ENV) \
		$(GDB_DIR)/gdb/gdbserver/configure $(GDBSERVER_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gdbserver.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gdbserver)
	@$(call install_fixup, gdbserver,PACKAGE,gdbserver)
	@$(call install_fixup, gdbserver,PRIORITY,optional)
	@$(call install_fixup, gdbserver,VERSION,$(GDB_VERSION))
	@$(call install_fixup, gdbserver,SECTION,base)
	@$(call install_fixup, gdbserver,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gdbserver,DEPENDS,)
	@$(call install_fixup, gdbserver,DESCRIPTION,missing)

	@$(call install_copy, gdbserver, 0, 0, 0755, \
		$(GDBSERVER_BUILDDIR)/gdbserver, /usr/bin/gdbserver)

	@$(call install_finish, gdbserver)

	@$(call touch)

# vim: syntax=make
