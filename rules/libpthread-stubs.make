# -*-makefile-*-
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPTHREAD_STUBS) += libpthread-stubs

#
# Paths and names
#
LIBPTHREAD_STUBS_VERSION	:= 0.1
LIBPTHREAD_STUBS_MD5		:= 774eabaf33440d534efe108ef9130a7d
LIBPTHREAD_STUBS		:= libpthread-stubs-$(LIBPTHREAD_STUBS_VERSION)
LIBPTHREAD_STUBS_SUFFIX		:= tar.bz2
LIBPTHREAD_STUBS_URL		:= http://xcb.freedesktop.org/dist/$(LIBPTHREAD_STUBS).$(LIBPTHREAD_STUBS_SUFFIX)
LIBPTHREAD_STUBS_SOURCE		:= $(SRCDIR)/$(LIBPTHREAD_STUBS).$(LIBPTHREAD_STUBS_SUFFIX)
LIBPTHREAD_STUBS_DIR		:= $(BUILDDIR)/$(LIBPTHREAD_STUBS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBPTHREAD_STUBS_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBPTHREAD_STUBS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPTHREAD_STUBS_PATH	:= PATH=$(CROSS_PATH)
LIBPTHREAD_STUBS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBPTHREAD_STUBS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared=no

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpthread-stubs.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
