# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DAEMONIZE) += daemonize

#
# Paths and names
#
DAEMONIZE_VERSION	:= 1.4
DAEMONIZE		:= daemonize-$(DAEMONIZE_VERSION)
DAEMONIZE_SUFFIX	:= tar.gz
DAEMONIZE_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(DAEMONIZE).$(DAEMONIZE_SUFFIX)
DAEMONIZE_SOURCE	:= $(SRCDIR)/$(DAEMONIZE).$(DAEMONIZE_SUFFIX)
DAEMONIZE_DIR		:= $(BUILDDIR)/$(DAEMONIZE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DAEMONIZE_SOURCE):
	@$(call targetinfo)
	@$(call get, DAEMONIZE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DAEMONIZE_PATH	:= PATH=$(CROSS_PATH)
DAEMONIZE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DAEMONIZE_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/daemonize.targetinstall:
	@$(call targetinfo)

	@$(call install_init, daemonize)
	@$(call install_fixup,daemonize,PRIORITY,optional)
	@$(call install_fixup,daemonize,SECTION,base)
	@$(call install_fixup,daemonize,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,daemonize,DESCRIPTION,missing)

	@$(call install_copy, daemonize, 0, 0, 0755, -, \
		/usr/sbin/daemonize)

	@$(call install_finish,daemonize)

	@$(call touch)

# vim: syntax=make
