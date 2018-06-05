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
SSMTP_LICENSE		:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SSMTP_PATH := PATH=$(CROSS_PATH)
SSMTP_CONF_ENV := $(CROSS_ENV)

#
# autoconf
#
SSMTP_CONF_TOOL := autoconf
SSMTP_CONF_OPT  := $(CROSS_AUTOCONF_USR) \
    --$(call ptx/endis, PTXCONF_SSMTP_REWRITE_DOMAIN)-rewrite-domain \
    --$(call ptx/endis, PTXCONF_SSMTP_SSL)-ssl \
    --$(call ptx/endis, PTXCONF_GLOBAL_IPV6)-inet6 \
    --$(call ptx/endis, PTXCONF_SSMTP_MD5AUTH)-md5auth

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

	@$(call install_copy, ssmtp, 0, 0, 0755, -, /usr/sbin/ssmtp)

	@$(call install_alternative, ssmtp, 0, 0, 0644, /etc/ssmtp/ssmtp.conf)
	@$(call install_replace, ssmtp, /etc/ssmtp/ssmtp.conf, @HOSTNAME@, \
		$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_HOSTNAME)))

ifdef PTXCONF_SSMTP_SENDMAIL
	@$(call install_link, ssmtp, /usr/sbin/ssmtp, /usr/sbin/sendmail)
	@$(call install_link, ssmtp, /usr/sbin/sendmail, /usr/lib/sendmail)
endif

	@$(call install_finish, ssmtp)

	@$(call touch)

# vim: syntax=make
