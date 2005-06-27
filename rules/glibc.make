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

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,glibc)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(GLIBC_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_GLIBC_INSTALL
	@$(call install_copy_toolchain_dl, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_LIBC
	@$(call install_copy_toolchain_lib, libc.so.6, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_PTHREAD
	@$(call install_copy_toolchain_lib, libpthread.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_THREAD_DB
	@$(call install_copy_toolchain_lib, libthread_db.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_LIBRT
	@$(call install_copy_toolchain_lib, librt.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_DL
	@$(call install_copy_toolchain_lib, libdl.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_CRYPT
	@$(call install_copy_toolchain_lib, libcrypt.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_UTIL
	@$(call install_copy_toolchain_lib, libutil.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_LIBM
	@$(call install_copy_toolchain_lib, libm.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_DNS
	@$(call install_copy_toolchain_lib, libnss_dns.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_FILES
	@$(call install_copy_toolchain_lib, libnss_files.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_HESIOD
	@$(call install_copy_toolchain_lib, libnss_hesiod.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_NIS
	@$(call install_copy_toolchain_lib, libnss_nis.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_NISPLUS
	@$(call install_copy_toolchain_lib, libnss_nisplus.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSS_COMPAT
	@$(call install_copy_toolchain_lib, libnss_compat.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_RESOLV
	@$(call install_copy_toolchain_lib, libresolv.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_NSL
	@$(call install_copy_toolchain_lib, libnsl.so, /lib, $(GLIBC_STRIP))
endif

ifdef PTXCONF_GLIBC_GCONV
	@$(call install_copy, 0, 0, 0755, /usr/lib/gconv)
	rm -f $(ROOTDIR)/usr/lib/gconv/gconv-modules
endif

ifdef PTXCONF_GLIBC_GCONV_ISO8859_1
	@$(call install_copy_toolchain_lib, gconv/ISO8859-1.so, /lib, $(GLIBC_STRIP))
	echo "module INTERNAL ISO-8859-1// ISO8859-1 1" \
		>> $(ROOTDIR)/usr/lib/gconv/gconv-modules
	if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then			\
		echo "module INTERNAL ISO-8859-1// ISO8859-1 1" 	\
			>> $(ROOTDIR)/usr/lib/gconv/gconv-modules;	\
	fi
endif

# Zonefiles
	@$(call install_copy, 0, 0, 0755, /usr/share/zoneinfo)
	for target in $(GLIBC_ZONEFILES-y); do 				\
		$(call install_copy, 0, 0, 0644, $(GLIBC_ZONEDIR)/zoneinfo/$$target, /usr/share/zoneinfo/$$target)	\
	done;

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glibc_clean: 
	-rm -rf $(STATEDIR)/glibc*

# vim: syntax=make
