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
ifdef PTXCONF_OPENSSL
PACKAGES += openssl
endif

#
# Paths and names 
#
OPENSSL_VERSION		= 0.9.7d
OPENSSL			= openssl-$(OPENSSL_VERSION)
OPENSSL_URL 		= http://www.openssl.org/source/$(OPENSSL).tar.gz
OPENSSL_SOURCE		= $(SRCDIR)/$(OPENSSL).tar.gz
OPENSSL_DIR 		= $(BUILDDIR)/$(OPENSSL)

ifdef PTXCONF_ARM_ARCH_LE
	THUD = linux-arm
endif
ifdef PTXCONF_ARM_ARCH_BE
	THUD = linux-armeb
endif
ifdef PTXCONF_MIPS_ARCH_LE
	THUD = linux-mipsel
endif
ifdef PTXCONF_MIPS_ARCH_BE
	THUD = linux-mips
endif
ifdef PTXCONF_ARCH_X86
	THUD = linux-i386
endif
ifdef PTXCONF_OPT_i586
	THUD = linux-i386-i586
endif
ifdef PTXCONF_OPT_I686
	THUD = linux-i386-i686
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

$(STATEDIR)/openssl.get: $(OPENSSL_SOURCE)
	@$(call targetinfo, $@)
	@$(call get_patches, $(OPENSSL))
	touch $@

$(OPENSSL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(OPENSSL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

openssl_extract: $(STATEDIR)/openssl.extract

$(STATEDIR)/openssl.extract: $(STATEDIR)/openssl.get
	@$(call targetinfo, $@)
	@$(call clean, $(OPENSSL_DIR))
	@$(call extract, $(OPENSSL_SOURCE))
	@$(call patchin, $(OPENSSL))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

openssl_prepare: $(STATEDIR)/openssl.prepare

openssl_prepare_deps =  \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/openssl.extract 

OPENSSL_PATH	= PATH=$(CROSS_PATH)
OPENSSL_MAKEVARS = \
	$(CROSS_ENV_CC) \
	$(CROSS_ENV_RANLIB) \
	AR='$(PTXCONF_GNU_TARGET)-ar r' \
	MANDIR=/man

OPENSSL_AUTOCONF = \
	--prefix=/usr \
	--openssldir=/etc/ssl

ifdef PTXCONF_OPENSSL_SHARED
OPENSSL_AUTOCONF	+= shared
else
OPENSSL_AUTOCONF	+= no-shared
endif

$(STATEDIR)/openssl.prepare: $(openssl_prepare_deps)
	@$(call targetinfo, $@)
	cd $(OPENSSL_DIR) && \
		$(OPENSSL_PATH) \
		./Configure $(THUD) $(OPENSSL_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

openssl_compile: $(STATEDIR)/openssl.compile

$(STATEDIR)/openssl.compile: $(STATEDIR)/openssl.prepare 
	@$(call targetinfo, $@)
#
# generate openssl.pc with correct path inside
#
	cd $(OPENSSL_DIR) && $(OPENSSL_PATH) make INSTALLTOP=$(CROSS_LIB_DIR) openssl.pc
	cd $(OPENSSL_DIR) && $(OPENSSL_PATH) make $(OPENSSL_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

openssl_install: $(STATEDIR)/openssl.install

$(STATEDIR)/openssl.install: $(STATEDIR)/openssl.compile
	@$(call targetinfo, $@)
#
# broken Makefile, generates dir with wrong permissions...
# chmod 755 fixed that
#
	mkdir -p $(CROSS_LIB_DIR)/lib/pkgconfig
	chmod 755 $(CROSS_LIB_DIR)/lib/pkgconfig
	$(OPENSSL_PATH) make -C $(OPENSSL_DIR) install $(OPENSSL_MAKEVARS) \
		INSTALL_PREFIX=$(CROSS_LIB_DIR) INSTALLTOP=''
	chmod 755 $(CROSS_LIB_DIR)/lib/pkgconfig
#
# FIXME:
# 	OPENSSL=${D}/usr/bin/openssl /usr/bin/perl tools/c_rehash ${D}/etc/ssl/certs
#
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

openssl_targetinstall: $(STATEDIR)/openssl.targetinstall

openssl_targetinstall_deps = \
	$(STATEDIR)/openssl.install

$(STATEDIR)/openssl.targetinstall: $(openssl_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,openssl)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(OPENSSL_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)
	
ifdef PTXCONF_OPENSSL_SHARED
	mkdir -p $(ROOTDIR)/usr/lib

	# FIXME: wildcard copy
	@$(call install_copy, 0, 0, 0644, \
		$(OPENSSL_DIR)/libssl.so*, \
		/usr/lib/)

	@$(call install_copy, 0, 0, 0644, \
		$(OPENSSL_DIR)/libcrypto.so*, \
		/usr/lib/)
endif
	@$(call install_finish)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openssl_clean: 
	rm -rf $(STATEDIR)/openssl.* 
	rm -rf $(IMAGEDIR)/openssl_* 
	rm -rf $(OPENSSL_DIR)

# vim: syntax=make
