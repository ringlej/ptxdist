# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNET) += libnet

#
# Paths and names
#
LIBNET_VERSION	= 1.1.3-RC-01
LIBNET		= libnet-$(LIBNET_VERSION)
LIBNET_SUFFIX	= tar.gz
LIBNET_URL     = http://www.pengutronix.de/software/ptxdist/temporary-src/$(LIBNET).$(LIBNET_SUFFIX)
# (temprary?) offline, 20061103
#LIBNET_URL	= http://www.packetfactory.net/libnet/dist/$(LIBNET).$(LIBNET_SUFFIX)
LIBNET_SOURCE	= $(SRCDIR)/$(LIBNET).$(LIBNET_SUFFIX)
LIBNET_DIR	= $(BUILDDIR)/$(LIBNET)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libnet_get: $(STATEDIR)/libnet.get

$(STATEDIR)/libnet.get: $(libnet_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBNET_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBNET)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libnet_extract: $(STATEDIR)/libnet.extract

$(STATEDIR)/libnet.extract: $(libnet_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBNET_DIR))
	@$(call extract, LIBNET)
	mv $(BUILDDIR)/libnet $(LIBNET_DIR)
	@$(call patchin, LIBNET, $(LIBNET_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libnet_prepare: $(STATEDIR)/libnet.prepare

LIBNET_PATH	=  PATH=$(CROSS_PATH)
LIBNET_ENV 	=  $(CROSS_ENV)
LIBNET_ENV	+= ac_libnet_have_packet_socket=yes

#
# autoconf
#
LIBNET_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
LIBNET_AUTOCONF += --with-pf_packet=yes

$(STATEDIR)/libnet.prepare: $(libnet_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBNET_BUILDDIR))
	cd $(LIBNET_DIR) && \
		$(LIBNET_PATH) $(LIBNET_ENV) \
		./configure $(LIBNET_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libnet_compile: $(STATEDIR)/libnet.compile

$(STATEDIR)/libnet.compile: $(libnet_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBNET_DIR) && $(LIBNET_PATH) $(LIBNET_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libnet_install: $(STATEDIR)/libnet.install

$(STATEDIR)/libnet.install: $(libnet_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBNET)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libnet_targetinstall: $(STATEDIR)/libnet.targetinstall

$(STATEDIR)/libnet.targetinstall: $(libnet_targetinstall_deps_default)
	@$(call targetinfo, $@)
	# FIXME: nothing to do?
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libnet_clean:
	rm -rf $(STATEDIR)/libnet.*
	rm -rf $(IMAGEDIR)/libnet_*
	rm -rf $(LIBNET_DIR)

# vim: syntax=make
