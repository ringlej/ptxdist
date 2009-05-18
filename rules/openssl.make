# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Jochen Striepe for Pengutronix e.K., Hildesheim, Germany
#               2003-2008 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENSSL) += openssl

#
# Paths and names
#
OPENSSL_VERSION		:= 0.9.7g
OPENSSL			:= openssl-$(OPENSSL_VERSION)
OPENSSL_URL 		:= http://www.openssl.org/source/$(OPENSSL).tar.gz
OPENSSL_SOURCE		:= $(SRCDIR)/$(OPENSSL).tar.gz
OPENSSL_DIR 		:= $(BUILDDIR)/$(OPENSSL)

ifeq ($(PTXCONF_ARCH_ARM)$(PTXCONF_ENDIAN_LITTLE),yy)
	OPENSSL_THUD := linux-arm
endif

ifeq ($(PTXCONF_ARCH_ARM)$(PTXCONF_ENDIAN_BIG),yy)
	OPENSSL_THUD := linux-armeb
endif

ifdef PTXCONF_ARCH_M68K
	OPENSSL_THUD = linux-m68k
endif

ifeq ($(PTXCONF_ARCH_MIPS)$(PTXCONF_ENDIAN_LITTLE),yy)
	OPENSSL_THUD := linux-mipsel
endif

ifeq ($(PTXCONF_ARCH_MIPS)$(PTXCONF_ENDIAN_BIG),yy)
	OPENSSL_THUD := linux-mips
endif

ifdef PTXCONF_ARCH_X86
ifdef PTXCONF_ARCH_I586
	OPENSSL_THUD := linux-i386-i586
else
ifdef PTXCONF_ARCH_I686
	OPENSSL_THUD := linux-i386-i686/cmov
else
	OPENSSL_THUD := linux-i386
endif
endif
endif

ifdef PTXCONF_ARCH_PPC
	OPENSSL_THUD := linux-ppc
endif

ifdef PTXCONF_ARCH_SPARC
	OPENSSL_THUD := linux-sparc
endif

ifdef PTXCONF_ARCH_SH
ifeq ($(PTXCONF_ARCH_SH_SH3)$(PTXCONF_ENDIAN_LITTLE),yy)
	OPENSSL_THUD := linux-sh3
endif
ifeq ($(PTXCONF_ARCH_SH_SH3)$(PTXCONF_ENDIAN_BIG),yy)
	OPENSSL_THUD := linux-sh3eb
endif
ifeq ($(PTXCONF_ARCH_SH_SH4)$(PTXCONF_ENDIAN_LITTLE),yy)
	OPENSSL_THUD := linux-sh4
endif
ifeq ($(PTXCONF_ARCH_SH_SH4)$(PTXCONF_ENDIAN_BIG),yy)
	OPENSSL_THUD := linux-sh4eb
endif
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(OPENSSL_SOURCE):
	@$(call targetinfo)
	@$(call get, OPENSSL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENSSL_PATH	= PATH=$(CROSS_PATH)
OPENSSL_MAKEVARS = \
	$(CROSS_ENV_CC) \
	$(CROSS_ENV_RANLIB) \
	AR='$(CROSS_AR) r' \
	MANDIR=/man

OPENSSL_AUTOCONF = \
	--openssldir=/etc/ssl

ifdef PTXCONF_OPENSSL_SHARED
OPENSSL_AUTOCONF	+= shared
else
OPENSSL_AUTOCONF	+= no-shared
endif

$(STATEDIR)/openssl.prepare: $(openssl_prepare_deps_default)
	@$(call targetinfo)
	cd $(OPENSSL_DIR) && \
		$(OPENSSL_PATH) \
		./Configure $(OPENSSL_THUD) $(OPENSSL_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/openssl.compile:
	@$(call targetinfo)
#
# generate openssl.pc with correct path inside
#
	cd $(OPENSSL_DIR) && $(OPENSSL_PATH) $(MAKE) INSTALLTOP=$(SYSROOT) openssl.pc
	cd $(OPENSSL_DIR) && $(OPENSSL_PATH) $(MAKE) $(OPENSSL_MAKEVARS) $(PARALLELMFLAGS_BROKEN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openssl.install:
	@$(call targetinfo)
#
# broken Makefile, generates dir with wrong permissions...
# chmod 755 fixed that
#
	mkdir -p $(SYSROOT)/lib/pkgconfig
	chmod 755 $(SYSROOT)/lib/pkgconfig
	$(OPENSSL_PATH) make -C $(OPENSSL_DIR) install $(OPENSSL_MAKEVARS) \
		INSTALL_PREFIX=$(SYSROOT) INSTALLTOP=''
	chmod 755 $(SYSROOT)/lib/pkgconfig
#
# FIXME:
# 	OPENSSL=${D}/usr/bin/openssl /usr/bin/perl tools/c_rehash ${D}/etc/ssl/certs
#
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openssl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, openssl)
	@$(call install_fixup, openssl,PACKAGE,openssl)
	@$(call install_fixup, openssl,PRIORITY,optional)
	@$(call install_fixup, openssl,VERSION,$(OPENSSL_VERSION))
	@$(call install_fixup, openssl,SECTION,base)
	@$(call install_fixup, openssl,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, openssl,DEPENDS,)
	@$(call install_fixup, openssl,DESCRIPTION,missing)

ifdef PTXCONF_OPENSSL_BIN
	@$(call install_copy, openssl, 0, 0, 0755, $(OPENSSL_DIR)/apps/openssl, /usr/bin/openssl)
endif

ifdef PTXCONF_OPENSSL_SHARED
	@$(call install_copy, openssl, 0, 0, 0644, $(OPENSSL_DIR)/libssl.so.0.9.7, /usr/lib/libssl.so.0.9.7)
	@$(call install_link, openssl, libssl.so.0.9.7, /usr/lib/libssl.so.0)
	@$(call install_link, openssl, libssl.so.0.9.7, /usr/lib/libssl.so)

	@$(call install_copy, openssl, 0, 0, 0644, $(OPENSSL_DIR)/libcrypto.so.0.9.7, /usr/lib/libcrypto.so.0.9.7)
	@$(call install_link, openssl, libcrypto.so.0.9.7, /usr/lib/libcrypto.so.0)
	@$(call install_link, openssl, libcrypto.so.0.9.7, /usr/lib/libcrypto.so)
endif
	@$(call install_finish, openssl)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openssl_clean:
	rm -rf $(STATEDIR)/openssl.*
	rm -rf $(PKGDIR)/openssl_*
	rm -rf $(OPENSSL_DIR)

# vim: syntax=make
