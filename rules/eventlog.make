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
EVENTLOG_VERSION	:= 0.2.12
EVENTLOG_MD5		:= f9c32814f78ea2629850f0440de5ff34
EVENTLOG		:= eventlog_$(EVENTLOG_VERSION)
EVENTLOG_SUFFIX		:= tar.gz
EVENTLOG_URL		:= https://my.balabit.com/downloads/syslog-ng/sources/3.2.2/source/$(EVENTLOG).$(EVENTLOG_SUFFIX)
EVENTLOG_SOURCE		:= $(SRCDIR)/$(EVENTLOG).$(EVENTLOG_SUFFIX)
EVENTLOG_DIR		:= $(BUILDDIR)/$(EVENTLOG)
EVENTLOG_LICENSE	:= BSD-3-Clause

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
	@$(call install_fixup, eventlog,PRIORITY,optional)
	@$(call install_fixup, eventlog,SECTION,base)
	@$(call install_fixup, eventlog,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, eventlog,DESCRIPTION,missing)

	@$(call install_lib, eventlog, 0, 0, 0644, libevtlog)

	@$(call install_finish, eventlog)

	@$(call touch)

# vim: syntax=make
