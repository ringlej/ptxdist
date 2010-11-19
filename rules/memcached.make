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
PACKAGES-$(PTXCONF_MEMCACHED) += memcached

#
# Paths and names
#
MEMCACHED_VERSION	:= 1.4.5
MEMCACHED		:= memcached-$(MEMCACHED_VERSION)
MEMCACHED_SUFFIX	:= tar.gz
MEMCACHED_URL		:= http://memcached.googlecode.com/files/$(MEMCACHED).$(MEMCACHED_SUFFIX)
MEMCACHED_SOURCE	:= $(SRCDIR)/$(MEMCACHED).$(MEMCACHED_SUFFIX)
MEMCACHED_DIR		:= $(BUILDDIR)/$(MEMCACHED)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MEMCACHED_ENV := \
	$(CROSS_ENV) \
	ac_cv_c_alignment=need

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/memcached.targetinstall:
	@$(call targetinfo)

	@$(call install_init, memcached)
	@$(call install_fixup, memcached, PRIORITY, optional)
	@$(call install_fixup, memcached, SECTION, base)
	@$(call install_fixup, memcached, AUTHOR,"NovaTech-LLC")
	@$(call install_fixup, memcached, DESCRIPTION, missing)

	@$(call install_copy, memcached, 0, 0, 0755, -, /usr/bin/memcached)
	@$(call install_copy, memcached, 0, 0, 0700, /var/run/memcached)

	@$(call install_finish, memcached)

	@$(call touch)

# vim: syntax=make
