# -*-makefile-*-
# $Id: openssl.make,v 1.7 2003/07/16 04:23:28 mkl Exp $
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

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

openssl_get: $(STATEDIR)/openssl.get

$(STATEDIR)/openssl.get: $(OPENSSL_SOURCE)
	@$(call targetinfo, openssl.get)
	touch $@

$(OPENSSL_SOURCE):
	@$(call targetinfo, $(OPENSSL_SOURCE))
	@$(call get, $(OPENSSL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

openssl_extract: $(STATEDIR)/openssl.extract

$(STATEDIR)/openssl.extract: $(STATEDIR)/openssl.get
	@$(call targetinfo, openssl.extract)
	@$(call clean, $(OPENSSL_DIR))
	@$(call extract, $(OPENSSL_SOURCE))
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

$(STATEDIR)/openssl.prepare: $(openssl_prepare_deps)
	@$(call targetinfo, openssl.prepare)
	perl -p -i -e 's/-m486//' $(OPENSSL_DIR)/Configure
	cd $(OPENSSL_DIR) && \
		$(OPENSSL_PATH) \
		./Configure $(THUD) --prefix=$(CROSS_LIB_DIR) no-shared
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

openssl_compile: $(STATEDIR)/openssl.compile

$(STATEDIR)/openssl.compile: $(STATEDIR)/openssl.prepare 
	@$(call targetinfo, openssl.compile)
	$(OPENSSL_PATH) make -C $(OPENSSL_DIR) $(OPENSSL_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

openssl_install: $(STATEDIR)/openssl.install

$(STATEDIR)/openssl.install: $(STATEDIR)/openssl.compile
	@$(call targetinfo, openssl.install)
	$(OPENSSL_PATH) make -C $(OPENSSL_DIR) install  $(OPENSSL_MAKEVARS)
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
