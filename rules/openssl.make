# -*-makefile-*-
# $Id: openssl.make,v 1.8 2003/10/23 15:01:19 mkl Exp $
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
OPENSSL			= openssl-0.9.7b
OPENSSL_URL 		= http://www.openssl.org/source/$(OPENSSL).tar.gz
OPENSSL_SOURCE		= $(SRCDIR)/$(OPENSSL).tar.gz
OPENSSL_DIR 		= $(BUILDDIR)/$(OPENSSL)

ifeq (y,$(PTXCONF_ARCH_ARM))
    THUD = linux-elf-arm
endif
ifeq (y,$(PTXCONF_ARCH_X86))
    THUD = linux-elf
endif
ifeq (y,$(PTXCONF_OPT_i586))
    THUD = linux-pentium
endif
ifeq (y,$(PTXCONF_OPT_I686))
    THUD = linux-ppro
endif
ifeq (y,$(PTXCONF_ARCH_PPC))
    THUD = linux-ppc
endif
ifeq (y,$(PTXCONF_ARCH_SPARC))
    THUD = linux-sparcv7
endif
# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

openssl_get: $(STATEDIR)/openssl.get

$(STATEDIR)/openssl.get: $(OPENSSL_SOURCE)
	@$(call targetinfo, $@)
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
	perl -p -i -e 's/-m486//' $(OPENSSL_DIR)/Configure
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

openssl_prepare: $(STATEDIR)/openssl.prepare

openssl_prepare_deps =  \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/zlib.install \
	$(STATEDIR)/openssl.extract 

OPENSSL_PATH	= PATH=$(CROSS_PATH)
OPENSSL_MAKEVARS= $(CROSS_ENV_CC) $(CROSS_ENV_RANLIB) AR='$(PTXCONF_GNU_TARGET)-ar r'

OPENSSL_AUTOCONF = \
	--prefix=/usr \
#	--openssldir=/etc/ssl

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
	$(OPENSSL_PATH) make -C $(OPENSSL_DIR) $(OPENSSL_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

openssl_install: $(STATEDIR)/openssl.install

$(STATEDIR)/openssl.install: $(STATEDIR)/openssl.compile
	@$(call targetinfo, $@)
	$(OPENSSL_PATH) make -C $(OPENSSL_DIR) install $(OPENSSL_MAKEVARS) INSTALL_PREFIX=$(CROSS_LIB_DIR) INSTALLTOP=''
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

openssl_targetinstall: $(STATEDIR)/openssl.targetinstall

$(STATEDIR)/openssl.targetinstall: $(STATEDIR)/openssl.install
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openssl_clean: 
	rm -rf $(STATEDIR)/openssl.* $(OPENSSL_DIR)

# vim: syntax=make
