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
ifdef PTXCONF_GLIBC
PACKAGES	+= glibc
endif

GLIBC			= glibc-$(GLIBC_VERSION)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glibc_get: $(STATEDIR)/glibc.get

$(STATEDIR)/glibc.get:
	@$(call targetinfo, $@)
	touch $@


# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glibc_extract: $(STATEDIR)/glibc.extract

glibc_extract_deps =  $(STATEDIR)/glibc.get

$(STATEDIR)/glibc.extract: $(glibc_extract_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glibc_prepare: $(STATEDIR)/glibc.prepare

glibc_prepare_deps = $(STATEDIR)/glibc.extract

$(STATEDIR)/glibc.prepare: $(glibc_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glibc_compile: $(STATEDIR)/glibc.compile

glibc_compile_deps = $(STATEDIR)/glibc.prepare 

$(STATEDIR)/glibc.compile: $(glibc_compile_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glibc_install: $(STATEDIR)/glibc.install

glibc_install_deps = $(STATEDIR)/glibc.compile

$(STATEDIR)/glibc.install: $(glibc_install_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glibc_targetinstall: $(STATEDIR)/glibc.targetinstall

glibc_targetinstall_deps = $(STATEDIR)/glibc.install

ifdef PTXCONF_GLIBC_DEBUG
GLIBC_STRIP	= n
else
GLIBC_STRIP	= y
endif

$(STATEDIR)/glibc.targetinstall: $(glibc_targetinstall_deps)
	@$(call targetinfo, $@)

ifdef PTXCONF_GLIBC_INSTALL
	@$(call copy_toolchain_dl_root, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_LIBC
	@$(call copy_toolchain_lib_root, libc.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_PTHREAD
	@$(call copy_toolchain_lib_root, libpthread.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_THREAD_DB
	@$(call copy_toolchain_lib_root, libthread_db.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_LIBRT
	@$(call copy_toolchain_lib_root, librt.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_DL
	@$(call copy_toolchain_lib_root, libdl.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_CRYPT
	@$(call copy_toolchain_lib_root, libcrypt.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_UTIL
	@$(call copy_toolchain_lib_root, libutil.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_LIBM
	@$(call copy_toolchain_lib_root, libm.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_DNS
	@$(call copy_toolchain_lib_root, libnss_dns.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_FILES
	@$(call copy_toolchain_lib_root, libnss_files.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_HESIOD
	@$(call copy_toolchain_lib_root, libnss_hesiod.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_NIS
	@$(call copy_toolchain_lib_root, libnss_nis.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_NISPLUS
	@$(call copy_toolchain_lib_root, libnss_nisplus.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_COMPAT
	@$(call copy_toolchain_lib_root, libnss_compat.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_RESOLV
	@$(call copy_toolchain_lib_root, libresolv.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSL
	@$(call copy_toolchain_lib_root, libnsl.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_GCONV
	install -d $(ROOTDIR)/usr/lib/gconv
	rm -f $(ROOTDIR)/usr/lib/gconv/gconv-modules
endif

ifdef PTXCONF_GLIBC_GCONV_ISO8859_1
	@$(call copy_toolchain_lib_root, gconv/ISO8859-1.so, /lib, $(GLIBC_STRIP))
	echo "module INTERNAL ISO-8859-1// ISO8859-1 1" \
		>> $(ROOTDIR)/usr/lib/gconv/gconv-modules
endif

# Zonefiles
	$(call copy_root, 0, 0, 0755, /usr/share/zoneinfo)
	for target in $(GLIBC_ZONEFILES-y); do 							\
		cp -a $(GLIBC_ZONEDIR)/zoneinfo/$$target $(ROOTDIR)/usr/share/zoneinfo/;	\
	done;

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glibc_clean: 
	-rm -rf $(STATEDIR)/glibc*

# vim: syntax=make
