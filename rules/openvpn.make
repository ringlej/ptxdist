# -*-makefile-*-
#
# Copyright (C) 2007 by Carsten Schlote <c.schlote@konzeptpark.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENVPN) += openvpn

#
# Paths and names
#
OPENVPN_VERSION		:= 2.1.1
OPENVPN_MD5		:= b273ed2b5ec8616fb9834cde8634bce7
OPENVPN			:= openvpn-$(OPENVPN_VERSION)
OPENVPN_SUFFIX		:= tar.gz
OPENVPN_URL		:= http://openvpn.net/release/$(OPENVPN).$(OPENVPN_SUFFIX)
OPENVPN_SOURCE		:= $(SRCDIR)/$(OPENVPN).$(OPENVPN_SUFFIX)
OPENVPN_DIR		:= $(BUILDDIR)/$(OPENVPN)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENVPN_PATH	:= PATH=$(CROSS_PATH)
OPENVPN_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
OPENVPN_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_OPENVPN_LZO
OPENVPN_AUTOCONF += --enable-lzo
else
OPENVPN_AUTOCONF += --disable-lzo
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openvpn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, openvpn)
	@$(call install_fixup, openvpn,PRIORITY,optional)
	@$(call install_fixup, openvpn,SECTION,base)
	@$(call install_fixup, openvpn,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, openvpn,DESCRIPTION,missing)

	@$(call install_copy, openvpn, 0, 0, 0755, -, /usr/sbin/openvpn)

	@$(call install_copy, openvpn, 0, 0, 0755, /etc/openvpn)

	@$(call install_finish, openvpn)

	@$(call touch)

# vim: syntax=make

