# -*-makefile-*-
#
# Copyright (C) 2018 by Lucas Stach <l.stach@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SBC) += sbc

#
# Paths and names
#
SBC_VERSION	:= 1.3
SBC_MD5		:= 2d8b7841f2c11ab287718d562f2b981c
SBC		:= sbc-$(SBC_VERSION)
SBC_SUFFIX	:= tar.xz
SBC_URL		:= https://www.kernel.org/pub/linux/bluetooth/$(SBC).$(SBC_SUFFIX)
SBC_SOURCE	:= $(SRCDIR)/$(SBC).$(SBC_SUFFIX)
SBC_DIR		:= $(BUILDDIR)/$(SBC)
SBC_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SBC_CONF_TOOL	:= autoconf
SBC_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-optimization \
	--disable-debug \
	--$(call ptx/endis, PTXCONF_TARGET_HARDEN_PIE)-pie \
	--enable-high-precision \
	--disable-tools \
	--disable-tester

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sbc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sbc)
	@$(call install_fixup, sbc,PRIORITY,optional)
	@$(call install_fixup, sbc,SECTION,base)
	@$(call install_fixup, sbc,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, sbc,DESCRIPTION,missing)

	@$(call install_lib, sbc, 0, 0, 0644, libsbc)

	@$(call install_finish, sbc)

	@$(call touch)

# vim: syntax=make
