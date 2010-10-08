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
PACKAGES-$(PTXCONF_LIBMEMCACHE) += libmemcache

#
# Paths and names
#
LIBMEMCACHE_VERSION	:= 1.4.0.rc2
LIBMEMCACHE_MD5		:= 402c957cd71538c07a263542eeb513d1
LIBMEMCACHE		:= libmemcache-$(LIBMEMCACHE_VERSION)
LIBMEMCACHE_SUFFIX	:= tar.bz2
LIBMEMCACHE_URL		:= http://people.freebsd.org/~seanc/libmemcache/$(LIBMEMCACHE).$(LIBMEMCACHE_SUFFIX)
LIBMEMCACHE_SOURCE	:= $(SRCDIR)/$(LIBMEMCACHE).$(LIBMEMCACHE_SUFFIX)
LIBMEMCACHE_DIR		:= $(BUILDDIR)/$(LIBMEMCACHE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMEMCACHE_ENV := \
	$(CROSS_ENV) \
	ac_cv_setsockopt_SO_RCVTIMEO=no \
	ac_cv_setsockopt_SO_SNDTIMEO=no

#
# autoconf
#
LIBMEMCACHE_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmemcache.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmemcache)
	@$(call install_fixup, libmemcache, PRIORITY, optional)
	@$(call install_fixup, libmemcache, SECTION, base)
	@$(call install_fixup, libmemcache, AUTHOR, "NovaTech-LLC")
	@$(call install_fixup, libmemcache, DESCRIPTION, missing)

	@$(call install_lib, libmemcache, 0, 0, 0644, libmemcache)

	@$(call install_finish, libmemcache)

	@$(call touch)

# vim: syntax=make
