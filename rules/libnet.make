# -*-makefile-*-
# $Id: libnet.make,v 1.4 2003/09/07 18:29:42 mkl Exp $
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
LIBNET_VERSION	= 1.1.0
LIBNET		= libnet-$(LIBNET_VERSION)
LIBNET_SUFFIX	= tar.gz
LIBNET_URL	= http://www.packetfactory.net/libnet/dist/$(LIBNET).$(LIBNET_SUFFIX)
LIBNET_SOURCE	= $(SRCDIR)/$(LIBNET).$(LIBNET_SUFFIX)
LIBNET_DIR	= $(BUILDDIR)/Libnet-latest

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

libnet_extract_deps = \
	$(STATEDIR)/automake15.install \
	$(STATEDIR)/libnet.get

$(STATEDIR)/libnet.extract: $(libnet_extract_deps)
	@$(call targetinfo, libnet.extract)
	@$(call clean, $(LIBNET_DIR))
	@$(call extract, $(LIBNET_SOURCE))
	$(call patchin,$(LIBNET_DIR),$(LIBNET))
	cd $(LIBNET_DIR) && \
		$(PTXCONF_PREFIX)/$(AUTOMAKE15)/bin/aclocal && \
		$(PTXCONF_PREFIX)/$(AUTOMAKE15)/bin/automake && \
		$(PTXCONF_PREFIX)/$(AUTOCONF257)/bin/autoconf
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
LIBNET_ENV 	=  $(CROSS_ENV)
LIBNET_ENV 	+= ac_libnet_have_packet_socket=yes

#
# autoconf
#
LIBNET_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
LIBNET_AUTOCONF	+= --build=$(GNU_HOST)
LIBNET_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
LIBNET_AUTOCONF	+= --with-pf_packet=yes

$(STATEDIR)/libnet.prepare: $(libnet_prepare_deps)
	@$(call targetinfo, libnet.prepare)
	@$(call clean, $(LIBNET_BUILDDIR))
	cd $(LIBNET_DIR) && \
		$(LIBNET_PATH) $(LIBNET_ENV) \
		./configure $(LIBNET_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libnet_compile: $(STATEDIR)/libnet.compile

libnet_compile_deps =  $(STATEDIR)/libnet.prepare

$(STATEDIR)/libnet.compile: $(libnet_compile_deps)
	@$(call targetinfo, libnet.compile)
	$(LIBNET_PATH) $(LIBNET_ENV) make -C $(LIBNET_DIR)
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
