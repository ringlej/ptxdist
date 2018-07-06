# -*-makefile-*-
#
# Copyright (C) 2017 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_NSS) += host-nss

HOST_NSS_SUBDIR	:= nss

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_NSS_CONF_TOOL	:= NO

HOST_NSS_MAKE_ENV   := \
	$(HOST_ENV) \
	BUILD_OPT=1 \
	FREEBL_NO_DEPEND=1 \
	FREEBL_LOWHASH=1 \
	NS_USE_GCC=1 \
	NSS_ENABLE_ECC=1 \
	NSS_DISABLE_GTESTS=1 \
	NSPR_INCLUDE_DIR=$(PTXDIST_SYSROOT_HOST)/include/nspr \
	USE_64=1

HOST_NSS_MAKE_PAR := NO

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_NSS_LIBS := \
	libnss3 \
	libnssutil3 \
	libsmime3 \
	libssl3 \
	libfreebl3 \
	libfreeblpriv3 \
	libnssckbi \
	libnssdbm3 \
	libsoftokn3


$(STATEDIR)/host-nss.install:
	@$(call targetinfo)
	@$(call world/install, HOST_NSS)

	@$(foreach lib,$(HOST_NSS_LIBS), \
		install -v -m644 -D $(HOST_NSS_DIR)/dist/*/lib/$(lib).so \
			$(HOST_NSS_PKGDIR)/lib/$(lib).so$(ptx/nl))

	install -d $(HOST_NSS_PKGDIR)/lib/pkgconfig/
	VERSION=$(NSS_VERSION) ptxd_replace_magic \
		$(HOST_NSS_DIR)/nss/nss.pc.in > $(HOST_NSS_PKGDIR)/lib/pkgconfig/nss.pc

	install -d $(PTXDIST_SYSROOT_HOST)/include/nss
	install -m 644 -t $(PTXDIST_SYSROOT_HOST)/include/nss $(HOST_NSS_DIR)/dist/public/nss/*

	@$(call touch)


# vim: syntax=make
