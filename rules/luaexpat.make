# -*-makefile-*-
#
# Copyright (C) 2013 by Joerg Platte <joerg.platte@googlemail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LUAEXPAT) += luaexpat

#
# Paths and names
#
LUAEXPAT_VERSION	:= 1.2.0
LUAEXPAT_MD5		:= 03efe50c7f30a34580701e6527d7bfee
LUAEXPAT		:= luaexpat-$(LUAEXPAT_VERSION)
LUAEXPAT_SUFFIX		:= tar.gz
LUAEXPAT_URL		:= http://matthewwild.co.uk/projects/luaexpat/$(LUAEXPAT).$(LUAEXPAT_SUFFIX)
LUAEXPAT_SOURCE		:= $(SRCDIR)/$(LUAEXPAT).$(LUAEXPAT_SUFFIX)
LUAEXPAT_DIR		:= $(BUILDDIR)/$(LUAEXPAT)
LUAEXPAT_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LUAEXPAT_CONF_TOOL := NO

LUAEXPAT_MAKE_OPT := \
	$(CROSS_ENV_CC) \
	LUA_VERSION_NUM=501 \
	LUA_INC=. \
	EXPAT_INC=.

LUAEXPAT_INSTALL_OPT := \
	$(LUAEXPAT_MAKE_OPT) \
	LUA_LIBDIR=$(LUAEXPAT_PKGDIR)/usr/lib/lua/5.1 \
	LUA_DIR=$(LUAEXPAT_PKGDIR)/usr/share/lua/5.1 \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/luaexpat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, luaexpat)
	@$(call install_fixup, luaexpat,PRIORITY,optional)
	@$(call install_fixup, luaexpat,SECTION,base)
	@$(call install_fixup, luaexpat,AUTHOR,"Joerg Platte <joerg.platte@googlemail.com>")
	@$(call install_fixup, luaexpat,DESCRIPTION,missing)

	@$(call install_copy, luaexpat, 0, 0, 0644, -, /usr/share/lua/5.1/lxp/lom.lua)
	@$(call install_lib, luaexpat, 0, 0, 0644, lua/5.1/lxp)
	@$(call install_finish, luaexpat)

	@$(call touch)

# vim: syntax=make
