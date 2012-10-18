# -*-makefile-*-
#
# Copyright (C) 2012 by Jan Luebbe <jlu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_WRAPPER) += host-wrapper

#
# Paths and names
#
HOST_WRAPPER_VERSION	:= 1
HOST_WRAPPER		:= wrapper-$(HOST_WRAPPER_VERSION)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-wrapper.install:
	@$(call targetinfo)
	mkdir -p $(HOST_WRAPPER_PKGDIR)/bin
	ln -s ${PTXDIST_PLATFORMDIR}/selected_toolchain/${CROSS_CC} $(HOST_WRAPPER_PKGDIR)/bin/${CROSS_CC}.real
	ln -s ${PTXDIST_PLATFORMDIR}/selected_toolchain/${CROSS_CXX} $(HOST_WRAPPER_PKGDIR)/bin/${CROSS_CXX}.real
	ln -s ${PTXDIST_PLATFORMDIR}/selected_toolchain/${CROSS_LD} $(HOST_WRAPPER_PKGDIR)/bin/${CROSS_LD}.real
	ln -s $(PTXDIST_TOPDIR)/scripts/wrapper/cc-wrapper $(HOST_WRAPPER_PKGDIR)/bin/${CROSS_CC}
	ln -s $(PTXDIST_TOPDIR)/scripts/wrapper/c++-wrapper $(HOST_WRAPPER_PKGDIR)/bin/${CROSS_CXX}
	ln -s $(PTXDIST_TOPDIR)/scripts/wrapper/ld-wrapper $(HOST_WRAPPER_PKGDIR)/bin/${CROSS_LD}
	@$(call touch)

# vim: syntax=make
