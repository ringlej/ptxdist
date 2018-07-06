# -*-makefile-*-
#
# Copyright (C) 2007 by Luotao Fu <l.fu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TIMEZONE) += timezone

#
# Paths and names
#
TIMEZONE_VERSION	:= 1.0
TIMEZONE		:= timezone-$(TIMEZONE_VERSION)
TIMEZONE_LICENSE	:= public_domain

TIMEZONE_LOCALTIME_FILE	:= /usr/share/zoneinfo/$(PTXCONF_TIMEZONE_LOCALTIME)

TIMEZONE-$(PTXCONF_TIMEZONE_AFRICA) := "Africa"
TIMEZONE-$(PTXCONF_TIMEZONE_AMERICA) += "America"
TIMEZONE-$(PTXCONF_TIMEZONE_ANTARCTICA) += "Antarctica"
TIMEZONE-$(PTXCONF_TIMEZONE_ARCTIC) += "Arctic"
TIMEZONE-$(PTXCONF_TIMEZONE_ASIA) += "Asia"
TIMEZONE-$(PTXCONF_TIMEZONE_ATLANTIC) += "Atlantic"
TIMEZONE-$(PTXCONF_TIMEZONE_AUSTRALIA) += "Australia"
TIMEZONE-$(PTXCONF_TIMEZONE_BRAZIL) += "Brazil"
TIMEZONE-$(PTXCONF_TIMEZONE_CANADA) += "Canada"
TIMEZONE-$(PTXCONF_TIMEZONE_CHILE) += "Chile"
TIMEZONE-$(PTXCONF_TIMEZONE_ETC) += "Etc"
TIMEZONE-$(PTXCONF_TIMEZONE_EUROPE) += "Europe"
TIMEZONE-$(PTXCONF_TIMEZONE_INDIAN) += "Indian"
TIMEZONE-$(PTXCONF_TIMEZONE_MEXICO) += "Mexico"
TIMEZONE-$(PTXCONF_TIMEZONE_PACIFIC) += "Pacific"
TIMEZONE-$(PTXCONF_TIMEZONE_US) += "US"
TIMEZONE-$(PTXCONF_TIMEZONE_CET) += "CET"
TIMEZONE-$(PTXCONF_TIMEZONE_CST6CDT) += "CST6CDT"
TIMEZONE-$(PTXCONF_TIMEZONE_CUBA) += "Cuba"
TIMEZONE-$(PTXCONF_TIMEZONE_EET) += "EET"
TIMEZONE-$(PTXCONF_TIMEZONE_EGYPT) += "Egypt"
TIMEZONE-$(PTXCONF_TIMEZONE_EIRE) += "Eire"
TIMEZONE-$(PTXCONF_TIMEZONE_EST) += "EST"
TIMEZONE-$(PTXCONF_TIMEZONE_EST5EDT) += "EST5EDT"
TIMEZONE-$(PTXCONF_TIMEZONE_FACTORY) += "Factory"
TIMEZONE-$(PTXCONF_TIMEZONE_GB) += "GB"
TIMEZONE-$(PTXCONF_TIMEZONE_GMT) += "GMT"
TIMEZONE-$(PTXCONF_TIMEZONE_GMT0) += "GMT-0" "GMT0" "GMT+0"
TIMEZONE-$(PTXCONF_TIMEZONE_HONGKONG) += "Hongkong"
TIMEZONE-$(PTXCONF_TIMEZONE_HST) += "HST"
TIMEZONE-$(PTXCONF_TIMEZONE_ICELAND) += "Iceland"
TIMEZONE-$(PTXCONF_TIMEZONE_IRAN) += "Iran"
TIMEZONE-$(PTXCONF_TIMEZONE_ISRAEL) += "Israel"
TIMEZONE-$(PTXCONF_TIMEZONE_JAMAICA) += "Jamaica"
TIMEZONE-$(PTXCONF_TIMEZONE_JAPAN) += "Japan"
TIMEZONE-$(PTXCONF_TIMEZONE_KWAJALEIN) += "Kwajalein"
TIMEZONE-$(PTXCONF_TIMEZONE_LIBYA) += "Libya"
TIMEZONE-$(PTXCONF_TIMEZONE_MET) += "MET"
TIMEZONE-$(PTXCONF_TIMEZONE_MST) += "MST"
TIMEZONE-$(PTXCONF_TIMEZONE_MST7MDT) += "MST7MDT"
TIMEZONE-$(PTXCONF_TIMEZONE_NAVAJO) += "Navajo"
TIMEZONE-$(PTXCONF_TIMEZONE_NZ) += "NZ"
TIMEZONE-$(PTXCONF_TIMEZONE_NZ_CHAT) += "NZ-CHAT"
TIMEZONE-$(PTXCONF_TIMEZONE_POLAND) += "Poland"
TIMEZONE-$(PTXCONF_TIMEZONE_PORTUGAL) += "Portugal"
TIMEZONE-$(PTXCONF_TIMEZONE_PRC) += "PRC"
TIMEZONE-$(PTXCONF_TIMEZONE_PST8PDT) += "PST8PDT"
TIMEZONE-$(PTXCONF_TIMEZONE_ROC) += "ROC"
TIMEZONE-$(PTXCONF_TIMEZONE_ROK) += "ROK"
TIMEZONE-$(PTXCONF_TIMEZONE_SINGAPORE) += "Singapore"
TIMEZONE-$(PTXCONF_TIMEZONE_TURKEY) += "Turkey"
TIMEZONE-$(PTXCONF_TIMEZONE_UCT) += "UCT"
TIMEZONE-$(PTXCONF_TIMEZONE_UNIVERSAL) += "Universal"
TIMEZONE-$(PTXCONF_TIMEZONE_UTC) += "UTC"
TIMEZONE-$(PTXCONF_TIMEZONE_WET) += "WET"
TIMEZONE-$(PTXCONF_TIMEZONE_WSU) += "W-SU"
TIMEZONE-$(PTXCONF_TIMEZONE_ZULU) += "Zulu"

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/timezone.install:
	@$(call targetinfo)
	@for target in $(TIMEZONE-y); do \
		$(call add_zoneinfo, $$target, $(TIMEZONE_PKGDIR)/usr/share, $(PTXDIST_SYSROOT_HOST)/usr); \
	done
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/timezone.targetinstall:
	@$(call targetinfo)

	@$(call install_init, timezone)
	@$(call install_fixup, timezone,PRIORITY,optional)
	@$(call install_fixup, timezone,SECTION,base)
	@$(call install_fixup, timezone,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, timezone,DESCRIPTION,missing)

	@$(call install_copy, timezone, 0, 0, 0755, /usr/share/zoneinfo)
	@for d in `find ${TIMEZONE_PKGDIR}/usr/share/zoneinfo/ -type d | awk -v FS="zoneinfo/" '{print $$2}'`; do \
		$(call install_copy, timezone, 0, 0, 0755, /usr/share/zoneinfo/$$d); \
	done

	@for f in `find ${TIMEZONE_PKGDIR}/usr/share/zoneinfo/ -type f | awk -v FS="zoneinfo/" '{print $$2}'`; do \
		$(call install_copy, timezone, 0, 0, 0644, -, /usr/share/zoneinfo/$$f,n); \
        done

ifneq ($(call remove_quotes,$(PTXCONF_TIMEZONE_LOCALTIME)),)
	@$(call install_link, timezone, ..$(TIMEZONE_LOCALTIME_FILE), \
		/etc/localtime)
endif

	@$(call install_finish, timezone)

	@$(call touch)

# vim: syntax=make
