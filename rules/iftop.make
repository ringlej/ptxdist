# -*-makefile-*-
#
# Copyright (C) 2017 by Alexander Dahl <post@lespocky.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IFTOP) += iftop

#
# Paths and names
#
IFTOP_VERSION	:= 1.0pre4
IFTOP_MD5	:= 7e6decb4958e8a4890cccac335239f24
IFTOP		:= iftop-$(IFTOP_VERSION)
IFTOP_SUFFIX	:= tar.gz
IFTOP_URL	:= http://www.ex-parrot.com/pdw/iftop/download/$(IFTOP).$(IFTOP_SUFFIX)
IFTOP_SOURCE	:= $(SRCDIR)/$(IFTOP).$(IFTOP_SUFFIX)
IFTOP_DIR	:= $(BUILDDIR)/$(IFTOP)
IFTOP_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IFTOP_CONF_TOOL	:= autoconf
IFTOP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--with-resolver=netdb \
	--with-libpcap

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iftop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iftop)
	@$(call install_fixup, iftop,PRIORITY,optional)
	@$(call install_fixup, iftop,SECTION,base)
	@$(call install_fixup, iftop,AUTHOR,"Alexander Dahl <post@lespocky.de>")
	@$(call install_fixup, iftop,DESCRIPTION,missing)

	@$(call install_copy, iftop, 0, 0, 0755, -, /usr/sbin/iftop)

	@$(call install_finish, iftop)

	@$(call touch)

# vim: ft=make noet
