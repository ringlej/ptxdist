# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBCAP) += host-libcap

#
# Paths and names
#
HOST_LIBCAP_VERSION	:= 2.18
HOST_LIBCAP		:= libcap-$(HOST_LIBCAP_VERSION)
HOST_LIBCAP_SUFFIX	:= tar.gz
HOST_LIBCAP_URL		:= http://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/$(HOST_LIBCAP).$(HOST_LIBCAP_SUFFIX)
HOST_LIBCAP_SOURCE	:= $(SRCDIR)/$(HOST_LIBCAP).$(HOST_LIBCAP_SUFFIX)
HOST_LIBCAP_DIR		:= $(HOST_BUILDDIR)/$(HOST_LIBCAP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_LIBCAP_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_LIBCAP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBCAP_MAKE_OPT := prefix= PAM_CAP=no LIBATTR=no lib=lib
HOST_LIBCAP_INSTALL_OPT := $(HOST_LIBCAP_MAKE_OPT) install

# vim: syntax=make
