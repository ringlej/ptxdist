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
NFTABLES_VERSION	:= 0.8.3
NFTABLES_MD5		:= a604501c10a302fa417410b16f293d2c
NFTABLES		:= nftables-$(NFTABLES_VERSION)
NFTABLES_SUFFIX		:= tar.bz2
NFTABLES_URL		:= http://ftp.netfilter.org/pub/nftables/$(NFTABLES).$(NFTABLES_SUFFIX)
NFTABLES_SOURCE		:= $(SRCDIR)/$(NFTABLES).$(NFTABLES_SUFFIX)
NFTABLES_DIR		:= $(BUILDDIR)/$(NFTABLES)
NFTABLES_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NFTABLES_CONF_TOOL	:= autoconf
NFTABLES_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_NFTABLES_DEBUG)-debug \
	--disable-man-doc \
	--disable-pdf-doc \
	--$(call ptx/wwo, PTXCONF_NFTABLES_MGMP)-mini-gmp \
	--without-cli \
	--without-xtables

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
	@$(call install_alternative, nftables, 0, 0, 0755, /etc/nftables.conf)

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_NFTABLES_STARTSCRIPT
	@$(call install_alternative, nftables, 0, 0, 0755, /etc/init.d/nftables)

ifneq ($(call remove_quotes,$(PTXCONF_NFTABLES_BBINIT_LINK)),)
	@$(call install_link, nftables, ../init.d/nftables, \
		/etc/rc.d/$(PTXCONF_NFTABLES_BBINIT_LINK))
endif
endif
endif

	@$(call install_finish, nftables)

	@$(call touch)

# vim: syntax=make
