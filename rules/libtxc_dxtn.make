# -*-makefile-*-
#
# Copyright (C) 2016 by Lucas Stach <l.stach@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTXC_DXTN) += libtxc_dxtn

#
# Paths and names
#
LIBTXC_DXTN_VERSION	:= 1.0.1
LIBTXC_DXTN_MD5		:= 7105107f07ac49753f4b61ba9d0c79c5
LIBTXC_DXTN		:= libtxc_dxtn-$(LIBTXC_DXTN_VERSION)
LIBTXC_DXTN_SUFFIX	:= tar.bz2
LIBTXC_DXTN_URL		:= http://people.freedesktop.org/~cbrill/libtxc_dxtn/$(LIBTXC_DXTN).$(LIBTXC_DXTN_SUFFIX)
LIBTXC_DXTN_SOURCE	:= $(SRCDIR)/$(LIBTXC_DXTN).$(LIBTXC_DXTN_SUFFIX)
LIBTXC_DXTN_DIR		:= $(BUILDDIR)/$(LIBTXC_DXTN)
LIBTXC_DXTN_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBTXC_DXTN_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtxc_dxtn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtxc_dxtn)
	@$(call install_fixup, libtxc_dxtn,PRIORITY,optional)
	@$(call install_fixup, libtxc_dxtn,SECTION,base)
	@$(call install_fixup, libtxc_dxtn,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, libtxc_dxtn,DESCRIPTION,missing)

	@$(call install_lib, libtxc_dxtn, 0, 0, 0644, libtxc_dxtn)

	@$(call install_finish, libtxc_dxtn)

	@$(call touch)

# vim: syntax=make
