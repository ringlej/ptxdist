# -*-makefile-*-
#
# Copyright (C) 2005 by Steven Scholz <steven.scholz@imc-berlin.de>
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
PACKAGES-$(PTXCONF_SSMTP) += ssmtp

#
# Paths and names
#
SSMTP_VERSION		:= 2.64
SSMTP_MD5		:= 65b4e0df4934a6cd08c506cabcbe584f
SSMTP			:= ssmtp-$(SSMTP_VERSION)
SSMTP_SUFFIX		:= tar.bz2
SSMTP_SRC		:= ssmtp_$(SSMTP_VERSION).orig.$(SSMTP_SUFFIX)
SSMTP_URL		:= $(call ptx/mirror, DEB, pool/main/s/ssmtp/$(SSMTP_SRC))
SSMTP_SOURCE		:= $(SRCDIR)/$(SSMTP_SRC)
SSMTP_DIR		:= $(BUILDDIR)/ssmtp-$(SSMTP_VERSION)
SSMTP_LICENSE		:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SSMTP_SOURCE):
	@$(call targetinfo)
	@$(call get, SSMTP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SSMTP_PATH := PATH=$(CROSS_PATH)
SSMTP_CONF_ENV := $(CROSS_ENV)

#
# autoconf
#
SSMTP_AUTOCONF := $(CROSS_AUTOCONF_ROOT)

ifndef PTXCONF_SSMTP_REWRITE_DOMAIN
SSMTP_AUTOCONF  += --disable-rewrite-domain
endif

ifdef PTXCONF_SSMTP_SSL
SSMTP_AUTOCONF  += --enable-ssl
endif

ifdef PTXCONF_SSMTP_INET6
SSMTP_AUTOCONF  += --enable-inet6
endif

ifdef PTXCONF_SSMTP_MD5AUTH
SSMTP_AUTOCONF  += --enable-md5auth
endif

SSMTP_MAKE_ENV := $(CROSS_ENV)
SSMTP_MAKE_PAR := NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ssmtp.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  ssmtp)
	@$(call install_fixup, ssmtp,PRIORITY,optional)
	@$(call install_fixup, ssmtp,SECTION,base)
	@$(call install_fixup, ssmtp,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ssmtp,DESCRIPTION,missing)

	@$(call install_copy, ssmtp, 0, 0, 0755, -, /sbin/ssmtp)

	@$(call install_finish, ssmtp)

	@$(call touch)

# vim: syntax=make
