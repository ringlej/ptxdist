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
# bloody hack, I'm sorry (mkl)
#
ifndef PTXCONF_CROSSTOOL
PACKAGES-$(PTXCONF_GLIBC) += glibc
endif

GLIBC := glibc-$(GLIBC_VERSION)


-include $(call package_depfile)

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
	@$(call install_copy_toolchain_dl, glibc, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_LIBC
	@$(call install_copy_toolchain_lib, glibc, libc.so.6, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_PTHREAD
	@$(call install_copy_toolchain_lib, glibc, libpthread.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_THREAD_DB
	@$(call install_copy_toolchain_lib, glibc, libthread_db.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_LIBRT
	@$(call install_copy_toolchain_lib, glibc, librt.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_DL
	@$(call install_copy_toolchain_lib, glibc, libdl.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_CRYPT
	@$(call install_copy_toolchain_lib, glibc, libcrypt.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_UTIL
	@$(call install_copy_toolchain_lib, glibc, libutil.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_LIBM
	@$(call install_copy_toolchain_lib, glibc, libm.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_DNS
	@$(call install_copy_toolchain_lib, glibc, libnss_dns.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_FILES
	@$(call install_copy_toolchain_lib, glibc, libnss_files.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_HESIOD
	@$(call install_copy_toolchain_lib, glibc, libnss_hesiod.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_NIS
	@$(call install_copy_toolchain_lib, glibc, libnss_nis.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_NISPLUS
	@$(call install_copy_toolchain_lib, glibc, libnss_nisplus.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_COMPAT
	@$(call install_copy_toolchain_lib, glibc, libnss_compat.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_RESOLV
	@$(call install_copy_toolchain_lib, glibc, libresolv.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSL
	@$(call install_copy_toolchain_lib, glibc, libnsl.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_GCONV
	@$(call install_copy, glibc, 0, 0, 0755, /usr/lib/gconv)
endif

ifdef PTXCONF_GLIBC_GCONV_ISO8859_1
	@$(call install_copy_toolchain_lib, glibc, gconv/ISO8859-1.so, /lib, $(GLIBC_STRIP))
	echo "module INTERNAL ISO-8859-1// ISO8859-1 1" \
		>> $(ROOTDIR)/usr/lib/gconv/gconv-modules
	if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then			\
		echo "module INTERNAL ISO-8859-1// ISO8859-1 1" 	\
			>> $(ROOTDIR)/usr/lib/gconv/gconv-modules;	\
	fi
endif

# Zonefiles
	@$(call install_copy, glibc, 0, 0, 0755, /usr/share/zoneinfo)
	for target in $(GLIBC_ZONEFILES-y); do 				\
		$(call install_copy, glibc, 0, 0, 0644, $(GLIBC_ZONEDIR)/zoneinfo/$$target, /usr/share/zoneinfo/$$target)	\
	done;

	@$(call install_finish, glibc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glibc_clean: 
	-rm -rf $(STATEDIR)/glibc*

# vim: syntax=make
