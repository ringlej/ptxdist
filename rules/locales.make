# -*-makefile-*-
#
# Copyright (C) 2007 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LOCALES) += locales

#
# Paths and names
#
LOCALES			:= locales
LOCALES_VERSION		:= 1.0

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/locales.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/locales.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/locales.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/locales.install:
	@$(call targetinfo)

	@$(call clean, $(LOCALES_PKGDIR))
	@mkdir -p $(LOCALES_PKGDIR)/usr/lib/locale

ifdef PTXCONF_LOCALES_EN_US
	@$(call add_locale, en_US, en_US, ISO-8859-1, $(LOCALES_PKGDIR))
endif
ifdef PTXCONF_LOCALES_EN_GB
	@$(call add_locale, en_GB, en_GB, ISO-8859-1, $(LOCALES_PKGDIR))
endif
ifdef PTXCONF_LOCALES_DE_DE
	@$(call add_locale, de_DE, de_DE, ISO-8859-1, $(LOCALES_PKGDIR))
endif
ifdef PTXCONF_LOCALES_DE_DE_EURO
	@$(call add_locale, de_DE@euro, de_DE@euro, ISO-8859-15, $(LOCALES_PKGDIR))
endif
ifdef PTXCONF_LOCALES_ZH_CN
	@$(call add_locale, zh_CN, zh_CN, GB2312, $(LOCALES_PKGDIR))
endif
ifdef PTXCONF_LOCALES_ZH_CN_GBK
	@$(call add_locale, zh_CN.GBK, zh_CN, GBK, $(LOCALES_PKGDIR))
endif
ifdef PTXCONF_LOCALES_ZH_CN_GB18030
	@$(call add_locale, zh_CN.GB18030, zh_CN, GB18030, $(LOCALES_PKGDIR))
endif
ifdef PTXCONF_LOCALES_ZH_TW
	@$(call add_locale, zh_TW, zh_TW, BIG5, $(LOCALES_PKGDIR))
endif
ifdef PTXCONF_LOCALES_ZH_HK
	@$(call add_locale, zh_HK, zh_HK, BIG5-HKSCS, $(LOCALES_PKGDIR))
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/locales.targetinstall:
	@$(call targetinfo)

	@$(call install_init, locales)
	@$(call install_fixup, locales,PRIORITY,optional)
	@$(call install_fixup, locales,SECTION,base)
	@$(call install_fixup, locales,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, locales,DESCRIPTION,missing)

	@$(call install_copy, locales, 0, 0, 0755, -, \
		/usr/lib/locale/locale-archive, n)

	@$(call install_finish, locales)

	@$(call touch)

# vim: syntax=make
