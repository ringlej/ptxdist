# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SMTPCLIENT) += smtpclient

#
# Paths and names
#
SMTPCLIENT_VERSION	:= 1.0.0
SMTPCLIENT		:= smtpclient-$(SMTPCLIENT_VERSION)
SMTPCLIENT_SUFFIX	:= tar.gz
SMTPCLIENT_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(SMTPCLIENT).$(SMTPCLIENT_SUFFIX)
SMTPCLIENT_SOURCE	:= $(SRCDIR)/$(SMTPCLIENT).$(SMTPCLIENT_SUFFIX)
SMTPCLIENT_DIR		:= $(BUILDDIR)/$(SMTPCLIENT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SMTPCLIENT_SOURCE):
	@$(call targetinfo)
	@$(call get, SMTPCLIENT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SMTPCLIENT_PATH	:= PATH=$(CROSS_PATH)
SMTPCLIENT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SMTPCLIENT_AUTOCONF := $(CROSS_AUTOCONF_USR)

SMTPCLIENT_INSTALL_OPT := prefix=$(SMTPCLIENT_PKGDIR)/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/smtpclient.targetinstall:
	@$(call targetinfo)
	
	@$(call install_init, smtpclient)
	@$(call install_fixup, smtpclient,PACKAGE,smtpclient)
	@$(call install_fixup, smtpclient,PRIORITY,optional)
	@$(call install_fixup, smtpclient,VERSION,$(SMTPCLIENT_VERSION))
	@$(call install_fixup, smtpclient,SECTION,base)
	@$(call install_fixup, smtpclient,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, smtpclient,DEPENDS,)
	@$(call install_fixup, smtpclient,DESCRIPTION,missing)

	@$(call install_copy, smtpclient, 0, 0, 0755, -, /usr/bin/smtpclient)

	@$(call install_finish, smtpclient)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

smtpclient_clean:
	rm -rf $(STATEDIR)/smtpclient.*
	rm -rf $(PKGDIR)/smtpclient_*
	rm -rf $(SMTPCLIENT_DIR)

# vim: syntax=make
