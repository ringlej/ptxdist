# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EVENTLOG) += eventlog

#
# Paths and names
#
EVENTLOG_VERSION	:= 0.2.7
EVENTLOG		:= eventlog-$(EVENTLOG_VERSION)
EVENTLOG_SUFFIX		:= tar.gz
EVENTLOG_URL		:= http://www.balabit.com/downloads/files/syslog-ng/sources/2.0/src/$(EVENTLOG).$(EVENTLOG_SUFFIX)
EVENTLOG_SOURCE		:= $(SRCDIR)/$(EVENTLOG).$(EVENTLOG_SUFFIX)
EVENTLOG_DIR		:= $(BUILDDIR)/$(EVENTLOG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(EVENTLOG_SOURCE):
	@$(call targetinfo)
	@$(call get, EVENTLOG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

EVENTLOG_PATH	:= PATH=$(CROSS_PATH)
EVENTLOG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
EVENTLOG_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/eventlog.targetinstall:
	@$(call targetinfo)

	@$(call install_init, eventlog)
	@$(call install_fixup, eventlog,PACKAGE,eventlog)
	@$(call install_fixup, eventlog,PRIORITY,optional)
	@$(call install_fixup, eventlog,VERSION,$(EVENTLOG_VERSION))
	@$(call install_fixup, eventlog,SECTION,base)
	@$(call install_fixup, eventlog,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, eventlog,DEPENDS,)
	@$(call install_fixup, eventlog,DESCRIPTION,missing)

	@$(call install_copy, eventlog, 0, 0, 0644, -, \
		/usr/lib/libevtlog.so.0.0.0)

	@$(call install_link, eventlog, \
		libevtlog.so.0.0.0, /usr/lib/libevtlog.so.0)

	@$(call install_link, eventlog, \
		libevtlog.so.0.0.0, /usr/lib/libevtlog.so)

	@$(call install_finish, eventlog)

	@$(call touch)

# vim: syntax=make
