# $Id: openssl.make,v 1.3 2003/06/16 12:05:16 bsp Exp $
#
# (c) 2002 by Jochen Striepe for Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_OPENSSL))
PACKAGES += openssl
endif

#
# Paths and names 
#
OPENSSL			= openssl-0.9.7b
OPENSSL_URL 		= http://www.openssl.org/source/$(OPENSSL).tar.gz
OPENSSL_SOURCE		= $(SRCDIR)/$(OPENSSL).tar.gz
OPENSSL_DIR 		= $(BUILDDIR)/$(OPENSSL)
OPENSSL_EXTRACT		= gzip -dc

ifeq (y,$(PTXCONF_ARCH_ARM))
    THUD = linux-elf-arm
endif
ifeq (y,$(PTXCONF_ARCH_X86))
    THUD = linux-elf
endif
ifeq (y,$(PTXCONF_OPT_I686))
    THUD = linux-ppro
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

openssl_get: $(STATEDIR)/openssl.get

$(STATEDIR)/openssl.get: $(OPENSSL_SOURCE)
	touch $@

$(OPENSSL_SOURCE):
	@$(call targetinfo, openssl.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(OPENSSL_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

openssl_extract: $(STATEDIR)/openssl.extract

$(STATEDIR)/openssl.extract: $(STATEDIR)/openssl.get
	@$(call targetinfo, openssl.extract)
	$(OPENSSL_EXTRACT) $(OPENSSL_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

openssl_prepare: $(STATEDIR)/openssl.prepare

openssl_prepare_deps =  $(STATEDIR)/openssl.extract 
openssl_prepare_deps += $(STATEDIR)/zlib.install 
openssl_prepare_deps += $(STATEDIR)/glibc.install

$(STATEDIR)/openssl.prepare: $(openssl_prepare_deps)
	@$(call targetinfo, openssl.prepare)
	cd $(OPENSSL_DIR) && ./Configure $(THUD) --prefix=$(PTXCONF_PREFIX) no-shared
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

openssl_compile: $(STATEDIR)/openssl.compile

$(STATEDIR)/openssl.compile: $(STATEDIR)/openssl.prepare 
	@$(call targetinfo, openssl.compile)
	cd $(OPENSSL_DIR) && PATH=$(PTXCONF_PREFIX)/bin:$$PATH make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

openssl_install: $(STATEDIR)/openssl.install

$(STATEDIR)/openssl.install: $(STATEDIR)/openssl.compile
	@$(call targetinfo, openssl.install)
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH make -C $(OPENSSL_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

openssl_targetinstall: $(STATEDIR)/openssl.targetinstall

$(STATEDIR)/openssl.targetinstall: $(STATEDIR)/openssl.install
	@$(call targetinfo, openssl.targetinstall)
	echo NO TARGET INSTALL FOR STATIC LIBS
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openssl_clean: 
	rm -rf $(STATEDIR)/openssl.* $(OPENSSL_DIR)

# vim: syntax=make
