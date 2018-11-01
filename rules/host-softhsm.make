# -*-makefile-*-
#
# Copyright (C) 2018 by Juergen Borleis <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SOFTHSM) += host-softhsm

#
# Paths and names
#
HOST_SOFTHSM_VERSION	:= 2.4.0
HOST_SOFTHSM_MD5	:= 1c960f83ced41244c3ff8f514a276d88
HOST_SOFTHSM		:= softhsm-$(HOST_SOFTHSM_VERSION)
HOST_SOFTHSM_SUFFIX	:= tar.gz
HOST_SOFTHSM_URL	:= https://dist.opendnssec.org/source/$(HOST_SOFTHSM).$(HOST_SOFTHSM_SUFFIX)
HOST_SOFTHSM_SOURCE	:= $(SRCDIR)/$(HOST_SOFTHSM).$(HOST_SOFTHSM_SUFFIX)
HOST_SOFTHSM_DIR	:= $(HOST_BUILDDIR)/$(HOST_SOFTHSM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_SOFTHSM_CONF_TOOL	:= autoconf
HOST_SOFTHSM_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-non-paged-memory \
	--disable-gost \
	--with-crypto-backend=openssl \
	--with-objectstore-backend-db \
	--without-migrate \
	--with-p11-kit=/share/p11-kit/modules

# vim: syntax=make
