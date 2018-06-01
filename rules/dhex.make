# -*-makefile-*-
#
# Copyright (C) 2011 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DHEX) += dhex

#
# Paths and names
#
DHEX_VERSION	:= 0.65
DHEX_MD5	:= 2d4ee5cc0cd95da5a1c7630b971e986d
DHEX		:= dhex_$(DHEX_VERSION)
DHEX_SUFFIX	:= tar.gz
DHEX_URL	:= http://www.dettus.net/dhex/$(DHEX).$(DHEX_SUFFIX)
DHEX_SOURCE	:= $(SRCDIR)/$(DHEX).$(DHEX_SUFFIX)
DHEX_DIR	:= $(BUILDDIR)/$(DHEX)
DHEX_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DHEX_CONF_TOOL		:= NO
DHEX_MAKE_OPT		:= $(CROSS_ENV_PROGS) LDFLAGS="" CPPFLAGS=""
DHEX_INSTALL_OPT	:= \
	DESTDIR=$(DHEX_PKGDIR)/usr \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dhex.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  dhex)
	@$(call install_fixup, dhex,PACKAGE,dhex)
	@$(call install_fixup, dhex,PRIORITY,optional)
	@$(call install_fixup, dhex,VERSION,$(DHEX_VERSION))
	@$(call install_fixup, dhex,SECTION,base)
	@$(call install_fixup, dhex,AUTHOR,"Bart vdr. Meulen <bartvdrmeulen@gmail.com>")
	@$(call install_fixup, dhex,DEPENDS,)
	@$(call install_fixup, dhex,DESCRIPTION,missing)

	@$(call install_copy, dhex, 0, 0, 0755, -, /usr/bin/dhex)

	@$(call install_finish, dhex)

	@$(call touch)

# vim: syntax=make
