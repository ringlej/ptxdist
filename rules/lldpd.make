# -*-makefile-*-
#
# Copyright (C) 2013 by Alexander Dahl <post@lespocky.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LLDPD) += lldpd

#
# Paths and names
#
LLDPD_VERSION	:= 0.7.6
LLDPD_MD5		:= dbd90a68b91448dcb94a4a77c5d8ef65
LLDPD			:= lldpd-$(LLDPD_VERSION)
LLDPD_SUFFIX	:= tar.gz
LLDPD_URL		:= http://media.luffy.cx/files/lldpd//$(LLDPD).$(LLDPD_SUFFIX)
LLDPD_SOURCE	:= $(SRCDIR)/$(LLDPD).$(LLDPD_SUFFIX)
LLDPD_DIR		:= $(BUILDDIR)/$(LLDPD)
LLDPD_LICENSE	:= ICS

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LLDPD_CONF_TOOL	:= autoconf
LLDPD_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	--disable-doxygen-doc \
	--without-embedded-libevent \
	--$(call ptx/endis, PTXCONF_LLDPD_CDP)-cdp \
	--$(call ptx/endis, PTXCONF_LLDPD_FDP)-fdp \
	--$(call ptx/endis, PTXCONF_LLDPD_EDP)-edp \
	--$(call ptx/endis, PTXCONF_LLDPD_SONMP)-sonmp \
	--$(call ptx/endis, PTXCONF_LLDPD_LLDPMED)-lldpmed \
	--$(call ptx/endis, PTXCONF_LLDPD_DOT1)-dot1 \
	--$(call ptx/endis, PTXCONF_LLDPD_DOT3)-dot3 \
	--$(call ptx/endis, PTXCONF_LLDPD_OLDIES)-oldies \
	--$(call ptx/wwo, PTXCONF_LLDPD_SNMP)-snmp \
	--$(call ptx/wwo, PTXCONF_LLDPD_XML)-xml \
	--with-privsep-user="$(PTXCONF_LLDPD_PRIVSEP_USER)" \
	--with-privsep-group="$(PTXCONF_LLDPD_PRIVSEP_GROUP)" \
	--with-privsep-chroot="$(PTXCONF_LLDPD_PRIVSEP_CHROOT)"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lldpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lldpd)
	@$(call install_fixup, lldpd,PRIORITY,optional)
	@$(call install_fixup, lldpd,SECTION,base)
	@$(call install_fixup, lldpd,AUTHOR,"Alexander Dahl <post@lespocky.de>")
	@$(call install_fixup, lldpd,DESCRIPTION,missing)

	@$(call install_copy, lldpd, 0, 0, 0755, -, /usr/sbin/lldpd)
	@$(call install_copy, lldpd, $(PTXCONF_LLDPD_PRIVSEP_USER), \
		$(PTXCONF_LLDPD_PRIVSEP_GROUP), 4750, -, /usr/sbin/lldpcli)
	@$(call install_link, lldpd, lldpcli, /usr/sbin/lldpctl)

	@$(call install_lib, lldpd, 0, 0, 0644, liblldpctl)

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_LLDPD_STARTSCRIPT
	@$(call install_alternative, lldpd, 0, 0, 0755, /etc/init.d/lldpd)
	@$(call install_replace, lldpd, /etc/init.d/lldpd, \
		@DAEMON_ARGS@, $(PTXCONF_LLDPD_DAEMON_ARGS))
	@$(call install_replace, lldpd, /etc/init.d/lldpd, \
		@PRIVSEP_CHROOT@, $(PTXCONF_LLDPD_PRIVSEP_CHROOT))

ifneq ($(call remove_quotes,$(PTXCONF_LLDPD_BBINIT_LINK)),)
	@$(call install_link, lldpd, ../init.d/lldpd, \
		/etc/rc.d/$(PTXCONF_LLDPD_BBINIT_LINK))
endif
endif
endif

	@$(call install_finish, lldpd)

	@$(call touch)

# vim: ft=make noet
