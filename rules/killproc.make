# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
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
PACKAGES-$(PTXCONF_KILLPROC) += killproc

#
# Paths and names
#
KILLPROC_VERSION	:= 2.13
KILLPROC		:= killproc-$(KILLPROC_VERSION)
KILLPROC_SUFFIX		:= tar.gz
KILLPROC_URL		:= http://ftp.suse.com/pub/projects/init/$(KILLPROC).$(KILLPROC_SUFFIX)
KILLPROC_SOURCE		:= $(SRCDIR)/$(KILLPROC).$(KILLPROC_SUFFIX)
KILLPROC_DIR		:= $(BUILDDIR)/$(KILLPROC)
KILLPROC_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(KILLPROC_SOURCE):
	@$(call targetinfo)
	@$(call get, KILLPROC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KILLPROC_PATH	:= PATH=$(CROSS_PATH)
KILLPROC_ENV 	:= $(CROSS_ENV)

KILLPROC_MAKEVARS := \
	CC=$(CROSS_CC) \
	INSTBINFLAGS="-m 0755"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/killproc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, killproc)
	@$(call install_fixup, killproc,PRIORITY,optional)
	@$(call install_fixup, killproc,SECTION,base)
	@$(call install_fixup, killproc,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, killproc,DESCRIPTION,missing)

ifdef PTXCONF_KILLPROC_CHECKPROC
	@$(call install_copy, killproc, 0, 0, 0755, -, /sbin/checkproc)
endif
ifdef PTXCONF_KILLPROC_KILLPROC
	@$(call install_copy, killproc, 0, 0, 0755, -, /sbin/killproc)
endif
ifdef PTXCONF_KILLPROC_STARTPROC
	@$(call install_copy, killproc, 0, 0, 0755, -, /sbin/startproc)
endif
ifdef PTXCONF_KILLPROC_USLEEP
	@$(call install_copy, killproc, 0, 0, 0755, -, /bin/usleep)
endif
	@$(call install_finish, killproc)

	@$(call touch)

# vim: syntax=make
