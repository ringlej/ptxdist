# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
LAZY_PACKAGES-$(PTXCONF_HOST_UNFS3) += host-unfs3

#
# Paths and names
#
HOST_UNFS3_VERSION	:= 0.9.22
HOST_UNFS3_MD5		:= ddf679a5d4d80096a59f3affc64f16e5
HOST_UNFS3		:= unfs3-$(HOST_UNFS3_VERSION)
HOST_UNFS3_SUFFIX	:= tar.gz
HOST_UNFS3_URL		:= $(call ptx/mirror, SF, unfs3/$(HOST_UNFS3).$(HOST_UNFS3_SUFFIX))
HOST_UNFS3_SOURCE	:= $(SRCDIR)/$(HOST_UNFS3).$(HOST_UNFS3_SUFFIX)
HOST_UNFS3_DIR		:= $(HOST_BUILDDIR)/$(HOST_UNFS3)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_UNFS3_CONF_TOOL	:= autoconf
HOST_UNFS3_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-cluster

HOST_UNFS3_MAKE_PAR	:= NO

# vim: syntax=make
