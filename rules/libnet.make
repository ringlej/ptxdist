# -*-makefile-*-
# $Id: libnet.make,v 1.1 2003/09/06 02:05:02 mkl Exp $
#
# (c) 2003 by Marc Kleine-Budde
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LIBNET
PACKAGES += libnet
endif

#
# Paths and names
#
LIBNET_VERSION	= 0.10.11
LIBNET		= libnet-$(LIBNET_VERSION)
LIBNET_SUFFIX	= tar.gz
LIBNET_URL	= http://belnet.dl.sourceforge.net/sourceforge/libnet/$(LIBNET).$(LIBNET_SUFFIX)
LIBNET_SOURCE	= $(SRCDIR)/$(LIBNET).$(LIBNET_SUFFIX)
LIBNET_DIR	= $(BUILDDIR)/libnet

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libnet_get: $(STATEDIR)/libnet.get

libnet_get_deps	=  $(LIBNET_SOURCE)

$(STATEDIR)/libnet.get: $(libnet_get_deps)
	@$(call targetinfo, libnet.get)
	touch $@

$(LIBNET_SOURCE):
	@$(call targetinfo, $(LIBNET_SOURCE))
	@$(call get, $(LIBNET_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libnet_extract: $(STATEDIR)/libnet.extract

libnet_extract_deps	=  $(STATEDIR)/libnet.get

$(STATEDIR)/libnet.extract: $(libnet_extract_deps)
	@$(call targetinfo, libnet.extract)
	@$(call clean, $(LIBNET_DIR))
	@$(call extract, $(LIBNET_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libnet_prepare: $(STATEDIR)/libnet.prepare

#
# dependencies
#
libnet_prepare_deps =  \
	$(STATEDIR)/libnet.extract \
	$(STATEDIR)/virtual-xchain.install

LIBNET_PATH	=  PATH=$(CROSS_PATH)
LIBNET_MAKEVARS	=  $(CROSS_ENV)

$(STATEDIR)/libnet.prepare: $(libnet_prepare_deps)
	@$(call targetinfo, libnet.prepare)
	@$(call clean, $(LIBNET_BUILDDIR))
	cd $(LIBNET_DIR) && \
		install -m 644 makfiles/linux.mak port.mak
	perl -i -p -e "s@/usr/local@$(CROSS_LIB_DIR)@" $(LIBNET_DIR)/port.mak
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libnet_compile: $(STATEDIR)/libnet.compile

libnet_compile_deps =  $(STATEDIR)/libnet.prepare

$(STATEDIR)/libnet.compile: $(libnet_compile_deps)
	@$(call targetinfo, libnet.compile)
	$(LIBNET_PATH) make -C $(LIBNET_DIR) $(LIBNET_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libnet_install: $(STATEDIR)/libnet.install

$(STATEDIR)/libnet.install: $(STATEDIR)/libnet.compile
	@$(call targetinfo, libnet.install)
	$(LIBNET_PATH) $(LIBNET_ENV) make -C $(LIBNET_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libnet_targetinstall: $(STATEDIR)/libnet.targetinstall

libnet_targetinstall_deps	=  $(STATEDIR)/libnet.compile

$(STATEDIR)/libnet.targetinstall: $(libnet_targetinstall_deps)
	@$(call targetinfo, libnet.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libnet_clean:
	rm -rf $(STATEDIR)/libnet.*
	rm -rf $(LIBNET_DIR)

# vim: syntax=make
