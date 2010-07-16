# -*-makefile-*-
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
PACKAGES-$(PTXCONF_LIBUCDAEMON) += libucdaemon

#
# Paths and names
#
LIBUCDAEMON_VERSION	:= 0.0.5
LIBUCDAEMON		:= libucdaemon-$(LIBUCDAEMON_VERSION)
LIBUCDAEMON_SUFFIX	:= tar.bz2
LIBUCDAEMON_URL		:= http://www.pengutronix.de/software/libucdaemon/download/$(LIBUCDAEMON).$(LIBUCDAEMON_SUFFIX)
LIBUCDAEMON_SOURCE	:= $(SRCDIR)/$(LIBUCDAEMON).$(LIBUCDAEMON_SUFFIX)
LIBUCDAEMON_DIR		:= $(BUILDDIR)/$(LIBUCDAEMON)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBUCDAEMON_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBUCDAEMON)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBUCDAEMON_PATH	:= PATH=$(CROSS_PATH)
LIBUCDAEMON_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBUCDAEMON_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libucdaemon.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libucdaemon)
	@$(call install_fixup, libucdaemon,PRIORITY,optional)
	@$(call install_fixup, libucdaemon,SECTION,base)
	@$(call install_fixup, libucdaemon,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libucdaemon,DESCRIPTION,missing)

	@$(call install_copy, libucdaemon, 0, 0, 0644, -, \
		/usr/lib/libucdaemon.so.0.0.0)

	@$(call install_link, libucdaemon, libucdaemon.so.0.0.0, \
		/usr/lib/libucdaemon.so.0)
	@$(call install_link, libucdaemon, libucdaemon.so.0.0.0, \
		/usr/lib/libucdaemon.so)

	@$(call install_finish, libucdaemon)

	@$(call touch)

# vim: syntax=make
