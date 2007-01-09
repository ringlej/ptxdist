# -*-makefile-*-
# $Id$
#
# Copyright (C) 2005 by Marc Kleine-Budde <mkl@pengutronix.de>, Pengutronix e.K., Hildesheim, Germany
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLIBC) += glibc
GLIBC_VERSION	:= 1.0
GLIBC 		:= glibc-$(GLIBC_VERSION)
GLIBC_DIR	:= $(BUILDDIR)/glibc
LOCALE_GENERATE_DIR	:= $(GLIBC_DIR)-gen
# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glibc_get: $(STATEDIR)/glibc.get

$(STATEDIR)/glibc.get: $(glibc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)


# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glibc_extract: $(STATEDIR)/glibc.extract

$(STATEDIR)/glibc.extract: $(glibc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glibc_prepare: $(STATEDIR)/glibc.prepare

$(STATEDIR)/glibc.prepare: $(glibc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glibc_compile: $(STATEDIR)/glibc.compile

$(STATEDIR)/glibc.compile: $(glibc_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glibc_install: $(STATEDIR)/glibc.install

$(STATEDIR)/glibc.install: $(glibc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glibc_targetinstall: $(STATEDIR)/glibc.targetinstall

$(STATEDIR)/glibc.targetinstall: $(glibc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, glibc)
	@$(call install_fixup, glibc,PACKAGE,glibc)
	@$(call install_fixup, glibc,PRIORITY,optional)
	@$(call install_fixup, glibc,VERSION,$(GLIBC_VERSION))
	@$(call install_fixup, glibc,SECTION,base)
	@$(call install_fixup, glibc,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, glibc,DEPENDS,)
	@$(call install_fixup, glibc,DESCRIPTION,missing)

ifdef PTXCONF_GLIBC
	@$(call install_copy_toolchain_dl, glibc, /lib)
endif

ifdef PTXCONF_GLIBC_LIBC
	@$(call install_copy_toolchain_lib, glibc, libc.so.6)
endif

ifdef PTXCONF_GLIBC_PTHREAD
	@$(call install_copy_toolchain_lib, glibc, libpthread.so)
endif

ifdef PTXCONF_GLIBC_THREAD_DB
	@$(call install_copy_toolchain_lib, glibc, libthread_db.so)
endif

ifdef PTXCONF_GLIBC_LIBRT
	@$(call install_copy_toolchain_lib, glibc, librt.so)
endif

ifdef PTXCONF_GLIBC_DL
	@$(call install_copy_toolchain_lib, glibc, libdl.so)
endif

ifdef PTXCONF_GLIBC_CRYPT
	@$(call install_copy_toolchain_lib, glibc, libcrypt.so)
endif

ifdef PTXCONF_GLIBC_UTIL
	@$(call install_copy_toolchain_lib, glibc, libutil.so)
endif

ifdef PTXCONF_GLIBC_LIBM
	@$(call install_copy_toolchain_lib, glibc, libm.so)
endif

ifdef PTXCONF_GLIBC_NSS_DNS
	@$(call install_copy_toolchain_lib, glibc, libnss_dns.so)
endif

ifdef PTXCONF_GLIBC_NSS_FILES
	@$(call install_copy_toolchain_lib, glibc, libnss_files.so)
endif

ifdef PTXCONF_GLIBC_NSS_HESIOD
	@$(call install_copy_toolchain_lib, glibc, libnss_hesiod.so)
endif

ifdef PTXCONF_GLIBC_NSS_NIS
	@$(call install_copy_toolchain_lib, glibc, libnss_nis.so)
endif

ifdef PTXCONF_GLIBC_NSS_NISPLUS
	@$(call install_copy_toolchain_lib, glibc, libnss_nisplus.so)
endif

ifdef PTXCONF_GLIBC_NSS_COMPAT
	@$(call install_copy_toolchain_lib, glibc, libnss_compat.so)
endif

ifdef PTXCONF_GLIBC_RESOLV
	@$(call install_copy_toolchain_lib, glibc, libresolv.so)
endif

ifdef PTXCONF_GLIBC_NSL
	@$(call install_copy_toolchain_lib, glibc, libnsl.so)
endif

ifdef PTXCONF_GLIBC_GCONV
	@$(call install_copy, glibc, 0, 0, 0755, /usr/lib/gconv)
	@$(call install_copy_toolchain_lib, glibc, gconv/gconv-modules, /usr/lib/gconv, n)
endif

ifdef PTXCONF_GLIBC_GCONV_ISO8859_1
	@$(call install_copy_toolchain_lib, glibc, gconv/ISO8859-1.so, /usr/lib/gconv)
endif

ifdef PTXCONF_GLIBC_GCONV_ISO8859_15
	@$(call install_copy_toolchain_lib, glibc, gconv/ISO8859-15.so, /usr/lib/gconv)
endif

ifdef PTXCONF_GLIBC_I18N_BIN_LOCALE
	@$(call install_copy_toolchain_usr, glibc, bin/locale)
endif

ifdef PTXCONF_GLIBC_I18N_BIN_LOCALEDEF
	@$(call install_copy_toolchain_usr, glibc, bin/localedef)
endif

ifdef PTXCONF_GLIBC_I18N_RAWDATA
	@$(call install_copy_toolchain_usr, glibc, share/i18n/charmaps/*,,n)
	@$(call install_copy_toolchain_usr, glibc, share/i18n/locales/*,,n)
	@$(call install_copy_toolchain_usr, glibc, share/locale/locale.alias,,n)
endif

ifdef PTXCONF_LOCALES
	@$(call install_copy_toolchain_usr, glibc, share/locale/locale.alias,,n)
endif

# Zonefiles are BROKEN
# 	@$(call install_copy, glibc, 0, 0, 0755, /usr/share/zoneinfo)
# 	@for target in $(GLIBC_ZONEFILES-y); do \
# 		$(call install_copy, glibc, 0, 0, 0644, \
# 		$(GLIBC_ZONEDIR)/zoneinfo/$$target, \
# 		/usr/share/zoneinfo/$$target) \
# 	done;
	@$(call install_finish, glibc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glibc_clean:
	-rm -rf $(STATEDIR)/glibc*

# vim: syntax=make
