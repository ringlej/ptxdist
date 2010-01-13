# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_URSHD) += urshd

#
# Paths and names
#
URSHD_VERSION	:= 1.0.2
URSHD		:= urshd-$(URSHD_VERSION)
URSHD_SUFFIX	:= tar.bz2
URSHD_URL	:= http://www.pengutronix.de/software/urshd/download/v1.0/$(URSHD).$(URSHD_SUFFIX)
URSHD_SOURCE	:= $(SRCDIR)/$(URSHD).$(URSHD_SUFFIX)
URSHD_DIR	:= $(BUILDDIR)/$(URSHD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(URSHD_SOURCE):
	@$(call targetinfo)
	@$(call get, URSHD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

URSHD_PATH	:= PATH=$(CROSS_PATH)
URSHD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
URSHD_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/urshd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, urshd)
	@$(call install_fixup, urshd,PACKAGE,urshd)
	@$(call install_fixup, urshd,PRIORITY,optional)
	@$(call install_fixup, urshd,VERSION,$(URSHD_VERSION))
	@$(call install_fixup, urshd,SECTION,base)
	@$(call install_fixup, urshd,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, urshd,DEPENDS,)
	@$(call install_fixup, urshd,DESCRIPTION,missing)

	@$(call install_copy, urshd, 0, 0, 0755, -, \
		/usr/bin/urshd)

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_URSHD_STARSCRIPT
	@$(call install_copy, urshd, 0, 0, 0755, /etc/init.d)
	@$(call install_alternative, urshd, 0, 0, 0755, /etc/init.d/urshd)
endif
endif
	@$(call install_finish, urshd)

	@$(call touch)

# vim: syntax=make
