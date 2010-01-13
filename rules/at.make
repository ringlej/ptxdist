# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_AT) += at

#
# Paths and names
#
AT_VERSION	:= 3.1.12
AT_SUFFIX	:= tar.gz
AT		:= at-$(AT_VERSION)
AT_TARBALL	:= at_$(AT_VERSION).orig.$(AT_SUFFIX)
AT_URL		:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/a/at/$(AT_TARBALL)
AT_SOURCE	:= $(SRCDIR)/$(AT_TARBALL)
AT_DIR		:= $(BUILDDIR)/$(AT)
AT_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(AT_SOURCE):
	@$(call targetinfo)
	@$(call get, AT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

AT_PATH	:= PATH=$(CROSS_PATH)
AT_ENV 	:= $(CROSS_ENV)

ifdef PTXCONF_AT_MAIL
AT_SENDMAIL := $(PTXCONF_AT_SENDMAIL)
else
AT_SENDMAIL := /bin/true
endif

#
# autoconf
#
AT_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--with-loadavg_mx=1.5 \
	--with-jobdir=/var/spool/cron/atjobs \
	--with-atspool=/var/spool/cron/atspool \
	--with-daemon_username=root \
	--with-daemon_groupname=root \
	SENDMAIL=$(AT_SENDMAIL)

AT_MAKE_PAR := NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/at.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  at)
	@$(call install_fixup, at,PACKAGE,at)
	@$(call install_fixup, at,PRIORITY,optional)
	@$(call install_fixup, at,VERSION,$(AT_VERSION))
	@$(call install_fixup, at,SECTION,base)
	@$(call install_fixup, at,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, at,DEPENDS,)
	@$(call install_fixup, at,DESCRIPTION,missing)

	@$(call install_alternative, at, 0, 0, 0640, /etc/at.deny)

	@$(call install_copy, at, 0, 0, 1770, /var/spool/cron/atjobs)
	@$(call install_copy, at, 0, 0, 1770, /var/spool/cron/atspool)
	@$(call install_copy, at, 0, 0, 0600, -, /var/spool/cron/atjobs/.SEQ)

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_AT_STARTSCRIPT
	@$(call install_alternative, at, 0, 0, 0755, /etc/init.d/atd)
endif
endif

ifdef PTXCONF_AT_ATD
	@$(call install_copy, at, 0, 0, 0755, -, /usr/sbin/atd)
endif

ifdef PTXCONF_AT_AT
	@$(call install_copy, at, 0, 0, 6755, -, /usr/bin/at)
endif

ifdef PTXCONF_AT_ATQ
	@$(call install_link, at, at, /usr/bin/atq)
endif

ifdef PTXCONF_AT_ATRM
	@$(call install_link, at, at, /usr/bin/atrm)
endif

ifdef PTXCONF_AT_BATCH
	@$(call install_copy, at, 0, 0, 0755, -, /usr/bin/batch)
endif

	@$(call install_finish, at)

	@$(call touch)

# vim: syntax=make
