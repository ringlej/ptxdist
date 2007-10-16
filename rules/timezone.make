# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
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
TIMEZONE		:= timezone
TIMEZONE_DIR		:= $(BUILDDIR)/$(TIMEZONE)-temp/usr/share/
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_AFRICA) := "Africa"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_ATLANTIC) += "Atlantic"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_EUROPE) += "Europe"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_EST5EDT) += "EST5EDT"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_CANADA) += "Canada"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_FACTORY) += "Factory"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_GMT0) += "GMT-0"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_ICELAND) += "Iceland"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_JAPAN) += "Japan"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_MST7MDT) += "MST7MDT"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_NAVAJO) += "Navajo"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_WSU) += "W-SU"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_AMERICA) += "America"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_AUSTRALIA) += "Australia"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_CHILE) += "Chile"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_EGYPT) += "Egypt"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_GB) += "GB"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_GMT0) += "GMT0"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_INDIAN) += "Indian"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_KWAJALEIN) += "Kwajalein"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_MEXICO) += "Mexico"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_PRC) += "PRC"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_ROC) += "ROC"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_UCT) += "UCT"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_WET) += "WET"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_ANTARCTICA) += "Antarctica"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_BRAZIL) += "Brazil"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_CUBA) += "Cuba"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_EIRE) += "Eire"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_IRAN) += "Iran"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_LIBYA) += "Libya"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_MIDEAST) += "Mideast"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_PST8PDT) += "PST8PDT"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_ROK) += "ROK"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_US) += "US"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_ZULU) += "Zulu"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_ARCTIC) += "Arctic"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_CET) += "CET"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_EET) += "EET"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_ETC) += "Etc"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_GMT) += "GMT"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_HST) += "HST"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_ISRAEL) += "Israel"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_MET) += "MET"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_NZ) += "NZ"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_PACIFIC) += "Pacific"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_SINGAPORE) += "Singapore"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_UTC) += "UTC"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_ASIA) += "Asia"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_CST6CDT) += "CST6CDT"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_EST) += "EST"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_GMT0) += "GMT+0"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_HONGKONG) += "Hongkong"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_JAMAICA) += "Jamaica"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_MST) += "MST"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_NZ_CHAT) += "NZ-CHAT"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_SYSTEMV) += "SystemV"
GLIBC_ZONEFILES-$(PTXCONF_TIMEZONE_UNIVERSAL) += "Universal"

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

timezone_get: $(STATEDIR)/timezone.get

$(STATEDIR)/timezone.get: $(timezone_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(TIMEZONE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, TIMEZONE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

timezone_extract: $(STATEDIR)/timezone.extract

$(STATEDIR)/timezone.extract: $(timezone_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TIMEZONE_DIR))
	@mkdir -p $(TIMEZONE_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

timezone_prepare: $(STATEDIR)/timezone.prepare

$(STATEDIR)/timezone.prepare: $(timezone_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

timezone_compile: $(STATEDIR)/timezone.compile

$(STATEDIR)/timezone.compile: $(timezone_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

timezone_install: $(STATEDIR)/timezone.install

$(STATEDIR)/timezone.install: $(timezone_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

timezone_targetinstall: $(STATEDIR)/timezone.targetinstall

$(STATEDIR)/timezone.targetinstall: $(timezone_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, timezone)
	@$(call install_fixup, timezone,PACKAGE,timezone)
	@$(call install_fixup, timezone,PRIORITY,optional)
	@$(call install_fixup, timezone,VERSION,$(TIMEZONE_VERSION))
	@$(call install_fixup, timezone,SECTION,base)
	@$(call install_fixup, timezone,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, timezone,DEPENDS,)
	@$(call install_fixup, timezone,DESCRIPTION,missing)

	@for target in $(GLIBC_ZONEFILES-y); do \
		$(call add_zoneinfo, $$target, $(TIMEZONE_DIR)); \
	done

	@$(call install_copy, timezone, 0, 0, 0755, /usr/share/zoneinfo)
	@for d in `find ${TIMEZONE_DIR}/zoneinfo/ -type d | awk -v FS="zoneinfo/" '{print $$2}'`; do \
		$(call install_copy, timezone, 0, 0, 0755, /usr/share/zoneinfo/$$d); \
	done

	@for f in `find ${TIMEZONE_DIR}/zoneinfo/ -type f | awk -v FS="zoneinfo/" '{print $$2}'`; do \
		$(call install_copy, timezone, 0, 0, 0655, $(TIMEZONE_DIR)/zoneinfo/$$f, /usr/share/zoneinfo/$$f,n); \
        done

ifdef PTXCONF_GLIBC_LOCALTIME_LINK
	@$(call install_link, timezone, $(PTXCONF_GLIBC_LOCALTIME_LINK), /etc/localtime)
endif

	@$(call install_finish, timezone)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

timezone_clean:
	rm -rf $(STATEDIR)/timezone.*
	rm -rf $(IMAGEDIR)/timezone_*
	rm -rf $(TIMEZONE_DIR)

# vim: syntax=make
