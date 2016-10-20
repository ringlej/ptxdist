# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_DUMMY_INSTALL_INFO) += host-dummy-install-info
HOST_DUMMY_INSTALL_INFO_LICENSE := ignore

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-dummy-install-info.install:
	@$(call targetinfo)
	@ln -sfv /bin/true $(PTXDIST_SYSROOT_HOST)/bin/install-info
	@$(call touch)

# vim: syntax=make
