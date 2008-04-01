# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Jochen Striepe for Pengutronix e.K., Hildesheim, Germany
#               2003 by Pengutronix e.K., Hildesheim, Germany
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
OPENSSL_VERSION		= 0.9.7g
OPENSSL			= openssl-$(OPENSSL_VERSION)
OPENSSL_URL 		= http://www.openssl.org/source/$(OPENSSL).tar.gz
OPENSSL_SOURCE		= $(SRCDIR)/$(OPENSSL).tar.gz
OPENSSL_DIR 		= $(BUILDDIR)/$(OPENSSL)

ifeq ($(PTXCONF_ARCH_ARM)$(PTXCONF_ENDIAN_LITTLE),yy)
	THUD = linux-arm
endif

ifeq ($(PTXCONF_ARCH_ARM)$(PTXCONF_ENDIAN_BIG),yy)
	THUD = linux-armeb
endif

ifeq ($(PTXCONF_ARCH_MIPS)$(PTXCONF_ENDIAN_LITTLE),yy)
	THUD = linux-mipsel
endif

ifeq ($(PTXCONF_ARCH_MIPS)$(PTXCONF_ENDIAN_BIG),yy)
	THUD = linux-mips
endif

ifdef PTXCONF_ARCH_X86
ifdef PTXCONF_ARCH_I586
	THUD = linux-i386-i586
else
ifdef PTXCONF_ARCH_I686
	THUD = linux-i386-i686/cmov
else
	THUD = linux-i386
endif
endif
endif

ifdef PTXCONF_ARCH_PPC
	THUD = linux-ppc
endif

ifdef PTXCONF_ARCH_SPARC
	THUD = linux-sparc
endif


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

openssl_get: $(STATEDIR)/openssl.get

$(STATEDIR)/openssl.get: $(openssl_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(OPENSSL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, OPENSSL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

openssl_extract: $(STATEDIR)/openssl.extract

$(STATEDIR)/openssl.extract: $(openssl_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(OPENSSL_DIR))
	@$(call extract, OPENSSL)
	@$(call patchin, OPENSSL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

openssl_prepare: $(STATEDIR)/openssl.prepare

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
	@$(call targetinfo, $@)
	cd $(OPENSSL_DIR) && \
		$(OPENSSL_PATH) \
		./Configure $(THUD) $(OPENSSL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

openssl_compile: $(STATEDIR)/openssl.compile

$(STATEDIR)/openssl.compile: $(openssl_compile_deps_default)
	@$(call targetinfo, $@)
#
# generate openssl.pc with correct path inside
#
	cd $(OPENSSL_DIR) && $(OPENSSL_PATH) make INSTALLTOP=$(SYSROOT) openssl.pc
	cd $(OPENSSL_DIR) && $(OPENSSL_PATH) make $(OPENSSL_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

openssl_install: $(STATEDIR)/openssl.install

$(STATEDIR)/openssl.install: $(openssl_install_deps_default)
	@$(call targetinfo, $@)
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
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

openssl_targetinstall: $(STATEDIR)/openssl.targetinstall

$(STATEDIR)/openssl.targetinstall: $(openssl_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, openssl)
	@$(call install_fixup, openssl,PACKAGE,openssl)
	@$(call install_fixup, openssl,PRIORITY,optional)
	@$(call install_fixup, openssl,VERSION,$(OPENSSL_VERSION))
	@$(call install_fixup, openssl,SECTION,base)
	@$(call install_fixup, openssl,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, openssl,DEPENDS,)
	@$(call install_fixup, openssl,DESCRIPTION,missing)

ifdef PTXCONF_OPENSSL_SHARED
	@$(call install_copy, openssl, 0, 0, 0644, $(OPENSSL_DIR)/libssl.so.0.9.7, /usr/lib/libssl.so.0.9.7)
	@$(call install_link, openssl, libssl.so.0.9.7, /usr/lib/libssl.so.0)
	@$(call install_link, openssl, libssl.so.0.9.7, /usr/lib/libssl.so)

	@$(call install_copy, openssl, 0, 0, 0644, $(OPENSSL_DIR)/libcrypto.so.0.9.7, /usr/lib/libcrypto.so.0.9.7)
	@$(call install_link, openssl, libcrypto.so.0.9.7, /usr/lib/libcrypto.so.0)
	@$(call install_link, openssl, libcrypto.so.0.9.7, /usr/lib/libcrypto.so)
endif
	@$(call install_finish, openssl)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openssl_clean:
	rm -rf $(STATEDIR)/openssl.*
	rm -rf $(IMAGEDIR)/openssl_*
	rm -rf $(OPENSSL_DIR)

# vim: syntax=make
