# -*-makefile-*-
#
# Copyright (C) 2017 by Bastian Stender
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IPERF3) += iperf3

#
# Paths and names
#
IPERF3_VERSION	:= 3.6
IPERF3_MD5	:= 6114c34ef6c3a69bc75de12e5366789b
IPERF3		:= iperf-$(IPERF3_VERSION)
IPERF3_SUFFIX	:= tar.gz
IPERF3_URL	:= http://downloads.es.net/pub/iperf/$(IPERF3).$(IPERF3_SUFFIX)
IPERF3_SOURCE	:= $(SRCDIR)/$(IPERF3).$(IPERF3_SUFFIX)
IPERF3_DIR	:= $(BUILDDIR)/$(IPERF3)
IPERF3_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
IPERF3_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-openssl=$(PTXDIST_SYSROOT_TARGET)/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iperf3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iperf3)
	@$(call install_fixup, iperf3,PRIORITY,optional)
	@$(call install_fixup, iperf3,SECTION,base)
	@$(call install_fixup, iperf3,AUTHOR,"Bastian Stender <bst@pengutronix.de>")
	@$(call install_fixup, iperf3,DESCRIPTION,missing)

	@$(call install_copy, iperf3, 0, 0, 0755, -, /usr/bin/iperf3)
	@$(call install_lib, iperf3, 0, 0, 0644, libiperf)

	@$(call install_finish, iperf3)

	@$(call touch)

# vim: syntax=make
