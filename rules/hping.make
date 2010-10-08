# -*-makefile-*-
#
# Copyright (C) 2009 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HPING) += hping

#
# Paths and names
#
HPING_VERSION	:= 3-20051105
HPING_MD5	:= ca4ea4e34bcc2162aedf25df8b2d1747
HPING		:= hping$(HPING_VERSION)
HPING_SUFFIX	:= tar.gz
HPING_URL	:= http://www.hping.org/$(HPING).$(HPING_SUFFIX)
HPING_SOURCE	:= $(SRCDIR)/$(HPING).$(HPING_SUFFIX)
HPING_DIR	:= $(BUILDDIR)/$(HPING)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HPING_SOURCE):
	@$(call targetinfo)
	@$(call get, HPING)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HPING_PATH	:= PATH=$(CROSS_PATH)
HPING_ENV 	:= \
	$(CROSS_ENV) \
	MANPATH=/usr/man

HPING_MAKEVARS	:= $(CROSS_ENV)

#
# autoconf
#
HPING_AUTOCONF := --no-tcl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hping.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hping)
	@$(call install_fixup, hping,PRIORITY,optional)
	@$(call install_fixup, hping,SECTION,base)
	@$(call install_fixup, hping,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, hping,DESCRIPTION,missing)

	@$(call install_copy, hping, 0, 0, 0755, -, /usr/sbin/hping3)

	@$(call install_finish, hping)

	@$(call touch)

# vim: syntax=make
