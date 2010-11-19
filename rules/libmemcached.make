# -*-makefile-*-
#
# Copyright (C) 2010 by NovaTech-LLC
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMEMCACHED) += libmemcached

#
# Paths and names
#
LIBMEMCACHED_VERSION		:= 0.44
LIBMEMCACHED			:= libmemcached-$(LIBMEMCACHED_VERSION)
LIBMEMCACHED_SUFFIX		:= tar.gz
LIBMEMCACHED_URL		:= http://launchpad.net/libmemcached/1.0/$(LIBMEMCACHED_VERSION)/+download/$(LIBMEMCACHED).$(LIBMEMCACHED_SUFFIX)
LIBMEMCACHED_SOURCE		:= $(SRCDIR)/$(LIBMEMCACHED).$(LIBMEMCACHED_SUFFIX)
LIBMEMCACHED_DIR		:= $(BUILDDIR)/$(LIBMEMCACHED)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMEMCACHED_ENV := \
	$(CROSS_ENV)

#We have libevent but disable it so clients/memslap doesn't build. 
#It fails to link because __sync_fetch_and_sub_4 is missing.
LIBMEMCACHED_ENV += ac_cv_libevent=no

#
# autoconf
#
LIBMEMCACHED_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--without-memcached \
	--without-docs \
	--disable-libevent \
	--disable-libinnodb \
	--disable-sasl \
	--disable-murmur_hash
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmemcached.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmemcached)
	@$(call install_fixup, libmemcached, PRIORITY, optional)
	@$(call install_fixup, libmemcached, SECTION, base)
	@$(call install_fixup, libmemcached, AUTHOR, "NovaTech-LLC")
	@$(call install_fixup, libmemcached, DESCRIPTION, missing)

	@$(call install_lib, libmemcached, 0, 0, 0644, libmemcached)

ifdef PTXCONF_LIBMEMCACHED_LIBHASHKIT
	@$(call install_lib, libmemcached, 0, 0, 0644, libhashkit)
endif

ifdef PTXCONF_LIBMEMCACHED_LIBMEMCACHEDUTIL
	@$(call install_lib, libmemcached, 0, 0, 0644, libmemcachedutil)
endif

ifdef PTXCONF_LIBMEMCACHED_LIBMEMCACHEDPROTOCOL
	@$(call install_lib, libmemcached, 0, 0, 0644, libmemcachedprotocol)
endif

	@$(call install_finish,libmemcached)

	@$(call touch)

# vim: syntax=make
