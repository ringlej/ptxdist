# -*-makefile-*-
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
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
PACKAGES-$(PTXCONF_PROFTPD) += proftpd

#
# Paths and names
#
PROFTPD_VERSION		:= 1.3.3a
PROFTPD			:= proftpd-$(PROFTPD_VERSION)
PROFTPD_SUFFIX		:= tar.gz
PROFTPD_URL		:= ftp://ftp.proftpd.org/distrib/source/$(PROFTPD).$(PROFTPD_SUFFIX)
PROFTPD_SOURCE		:= $(SRCDIR)/$(PROFTPD).$(PROFTPD_SUFFIX)
PROFTPD_DIR		:= $(BUILDDIR)/$(PROFTPD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PROFTPD_SOURCE):
	@$(call targetinfo)
	@$(call get, PROFTPD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PROFTPD_PATH		:= PATH=$(CROSS_PATH)
PROFTPD_ENV		:= $(CROSS_ENV)

PROFTPD_COMPILE_ENV	:= $(CROSS_ENV_CC_FOR_BUILD)

#
# autoconf
#
PROFTPD_AUTOCONF	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION)

ifdef PTXCONF_PROFTPD_PAM
PROFTPD_AUTOCONF += --enable-auth-pam
else
PROFTPD_AUTOCONF += --disable-auth-pam
endif

ifdef PTXCONF_PROFTPD_SENDFILE
PROFTPD_AUTOCONF += --enable-sendfile
else
PROFTPD_AUTOCONF += --disable-sendfile
endif

ifdef PTXCONF_PROFTPD_SHADOW
PROFTPD_AUTOCONF += --enable-shadow
else
PROFTPD_AUTOCONF += --disable-shadow
endif

ifdef PTXCONF_PROFTPD_AUTOSHADOW
PROFTPD_AUTOCONF += --enable-autoshadow
else
PROFTPD_AUTOCONF += --disable-autoshadow
endif

PROFTPD_MAKE_PAR := NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/proftpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, proftpd)
	@$(call install_fixup, proftpd,PRIORITY,optional)
	@$(call install_fixup, proftpd,SECTION,base)
	@$(call install_fixup, proftpd,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, proftpd,DESCRIPTION,missing)

	@$(call install_copy, proftpd, 0, 0, 0755, -, \
		/usr/sbin/proftpd)

	@$(call install_alternative, proftpd, 0, 0, 0644, /etc/proftpd.conf)

#	#
#	# busybox init
#	#
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_PROFTPD_STARTSCRIPT
	@$(call install_alternative, proftpd, 0, 0, 0755, /etc/init.d/proftpd)

ifneq ($(call remove_quotes,$(PTXCONF_PROFTPD_BBINIT_LINK)),)
	@$(call install_link, proftpd, \
		../init.d/proftpd, \
		/etc/rc.d/$(PTXCONF_PROFTPD_BBINIT_LINK))
endif
endif
endif

	@$(call install_finish, proftpd)

	@$(call touch)

# vim: syntax=make
