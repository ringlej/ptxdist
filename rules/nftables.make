# -*-makefile-*-
#
# Copyright (C) 2016 by Andreas Geisenhainer <andreas.geisenhainer@atsonline.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NFTABLES) += nftables

#
# Paths and names
#
NFTABLES_VERSION	:= 0.6
NFTABLES_MD5		:= fd320e35fdf14b7be795492189b13dae
NFTABLES		:= nftables-$(NFTABLES_VERSION)
NFTABLES_SUFFIX		:= tar.bz2
NFTABLES_URL		:= http://ftp.netfilter.org/pub/nftables/$(NFTABLES).$(NFTABLES_SUFFIX)
NFTABLES_SOURCE		:= $(SRCDIR)/$(NFTABLES).$(NFTABLES_SUFFIX)
NFTABLES_DIR		:= $(BUILDDIR)/$(NFTABLES)
NFTABLES_LICENSE	:= GPL-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NFTABLES_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_prog_DOCBOOK2X_MAN=no \
	ac_cv_prog_DOCBOOK2MAN=no \
	ac_cv_prog_DB2X_DOCBOOK2MAN=no \
	ac_cv_prog_DBLATEX=no

#
# autoconf
#
NFTABLES_CONF_TOOL	:= autoconf
NFTABLES_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_NFTABLES_DEBUG)-debug \
	--$(call ptx/wwo, PTXCONF_NFTABLES_MGMP)-mini-gmp

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nftables.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nftables)
	@$(call install_fixup, nftables,PRIORITY,optional)
	@$(call install_fixup, nftables,SECTION,base)
	@$(call install_fixup, nftables,AUTHOR,"Andreas Geisenhainer <andreas.geisenhainer@atsonline.de")
	@$(call install_fixup, nftables,DESCRIPTION,missing)

	@$(call install_copy, nftables, 0, 0, 0755, -, /usr/sbin/nft)

	@$(call install_finish, nftables)

	@$(call touch)

# vim: syntax=make
