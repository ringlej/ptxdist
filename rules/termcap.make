# -*-makefile-*-
#
# Copyright (C) 2003, 2004, 2009 by Marc Kleine-Budde <kleine-budde@gmx.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TERMCAP) += termcap

#
# Paths and names
#
TERMCAP_VERSION	:= 1.3.1
TERMCAP_MD5	:= ffe6f86e63a3a29fa53ac645faaabdfa
TERMCAP		:= termcap-$(TERMCAP_VERSION)
TERMCAP_SUFFIX	:= tar.gz
TERMCAP_URL	:= $(call ptx/mirror, GNU, termcap/$(TERMCAP).$(TERMCAP_SUFFIX))
TERMCAP_SOURCE	:= $(SRCDIR)/$(TERMCAP).$(TERMCAP_SUFFIX)
TERMCAP_DIR	:= $(BUILDDIR)/$(TERMCAP)
TERMCAP_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(TERMCAP_SOURCE):
	@$(call targetinfo)
	@$(call get, TERMCAP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TERMCAP_PATH	:= PATH=$(CROSS_PATH)
TERMCAP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
TERMCAP_AUTOCONF := \
	--prefix= \
	$(CROSS_AUTOCONF_ARCH) \
	--enable-install-termcap

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/termcap.targetinstall:
	@$(call targetinfo)

	@$(call install_init, termcap)
	@$(call install_fixup, termcap,PRIORITY,optional)
	@$(call install_fixup, termcap,SECTION,base)
	@$(call install_fixup, termcap,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, termcap,DESCRIPTION,missing)

ifdef PTXCONF_TERMCAP_TERMCAP
	@$(call install_copy, termcap, 0, 0, 0755, -, /etc/termcap)
endif
	@$(call install_finish, termcap)

	@$(call touch)

# vim: syntax=make
