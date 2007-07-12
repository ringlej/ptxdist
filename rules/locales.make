# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
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
LOCALES_DIR		:= $(BUILDDIR)/$(LOCALES)-temp

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

locales_get: $(STATEDIR)/locales.get

$(STATEDIR)/locales.get: $(locales_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LOCALES_SOURCE):
	@$(call targetinfo, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

locales_extract: $(STATEDIR)/locales.extract

$(STATEDIR)/locales.extract: $(locales_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

locales_prepare: $(STATEDIR)/locales.prepare

#
# autoconf
#
LOCALES_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/locales.prepare: $(locales_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LOCALES_DIR)/config.cache)
	@mkdir -p $(LOCALES_DIR)/usr/lib/locale
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

locales_compile: $(STATEDIR)/locales.compile

$(STATEDIR)/locales.compile: $(locales_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

locales_install: $(STATEDIR)/locales.install

$(STATEDIR)/locales.install: $(locales_install_deps_default)
	@$(call targetinfo, $@)
ifdef PTXCONF_LOCALES_EN_US
	@$(call add_locale, en_US, en_US, ISO-8859-1, $(LOCALES_DIR))
endif
ifdef PTXCONF_LOCALES_EN_GB
	@$(call add_locale, en_GB, en_GB, ISO-8859-1, $(LOCALES_DIR))
endif
ifdef PTXCONF_LOCALES_DE_DE
	@$(call add_locale, de_DE, de_DE, ISO-8859-1, $(LOCALES_DIR))
endif
ifdef PTXCONF_LOCALES_DE_DE_EURO
	@$(call add_locale, de_DE@euro, de_DE@euro, ISO-8859-15, $(LOCALES_DIR))
endif
ifdef PTXCONF_LOCALES_ZH_CN
	@$(call add_locale, zh_CN, zh_CN, GB2312, $(LOCALES_DIR))
endif
ifdef PTXCONF_LOCALES_ZH_CN_GBK
	@$(call add_locale, zh_CN.GBK, zh_CN, GBK, $(LOCALES_DIR))
endif
ifdef PTXCONF_LOCALES_ZH_CN_GB18030
	@$(call add_locale, zh_CN.GB18030, zh_CN, GB18030, $(LOCALES_DIR))
endif
ifdef PTXCONF_LOCALES_ZH_TW
	@$(call add_locale, zh_TW, zh_TW, BIG5, $(LOCALES_DIR))
endif
ifdef PTXCONF_LOCALES_ZH_HK
	@$(call add_locale, zh_HK, zh_HK, BIG5-HKSCS, $(LOCALES_DIR))
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

locales_targetinstall: $(STATEDIR)/locales.targetinstall

$(STATEDIR)/locales.targetinstall: $(locales_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, locales)
	@$(call install_fixup, locales,PACKAGE,locales)
	@$(call install_fixup, locales,PRIORITY,optional)
	@$(call install_fixup, locales,VERSION,$(LOCALES_VERSION))
	@$(call install_fixup, locales,SECTION,base)
	@$(call install_fixup, locales,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, locales,DEPENDS,)
	@$(call install_fixup, locales,DESCRIPTION,missing)

	@$(call install_copy, locales, 0, 0, 0755, $(LOCALES_DIR)/usr/lib/locale/locale-archive, \
		/usr/lib/locale/locale-archive, n);
	@$(call install_finish, locales)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

locales_clean:
	rm -rf $(STATEDIR)/locales.*
	rm -rf $(IMAGEDIR)/locales_*
	rm -rf $(LOCALES_DIR)

# vim: syntax=make
