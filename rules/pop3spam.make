# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#               2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POP3SPAM) += pop3spam

#
# Paths and names
#
POP3SPAM_VERSION	:= 0.9
POP3SPAM_MD5		:= 54a8cdb35e6450187dbebb0053e04bcd
POP3SPAM		:= pop3spam-$(POP3SPAM_VERSION)
POP3SPAM_SUFFIX		:= tar.bz2
POP3SPAM_URL		:= $(call ptx/mirror, SF, pop3spam/$(POP3SPAM).$(POP3SPAM_SUFFIX))
POP3SPAM_SOURCE		:= $(SRCDIR)/$(POP3SPAM).$(POP3SPAM_SUFFIX)
POP3SPAM_DIR		:= $(BUILDDIR)/$(POP3SPAM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(POP3SPAM_SOURCE):
	@$(call targetinfo)
	@$(call get, POP3SPAM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POP3SPAM_PATH	:= PATH=$(CROSS_PATH)
POP3SPAM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
POP3SPAM_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pop3spam.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pop3spam)
	@$(call install_fixup, pop3spam,PRIORITY,optional)
	@$(call install_fixup, pop3spam,SECTION,base)
	@$(call install_fixup, pop3spam,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pop3spam,DESCRIPTION,missing)

	@$(call install_copy, pop3spam, 0, 0, 0755, -, /usr/bin/pop3spam)

	@$(call install_finish, pop3spam)
	@$(call touch)

# vim: syntax=make
