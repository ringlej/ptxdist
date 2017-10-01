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
LUAEXPAT_VERSION	:= 1.3.0
LUAEXPAT_MD5		:= 3c20b5795e7107f847f8da844fbfe2da
LUAEXPAT		:= luaexpat-$(LUAEXPAT_VERSION)
LUAEXPAT_SUFFIX		:= tar.gz
LUAEXPAT_URL		:= http://matthewwild.co.uk/projects/luaexpat/$(LUAEXPAT).$(LUAEXPAT_SUFFIX)
LUAEXPAT_SOURCE		:= $(SRCDIR)/$(LUAEXPAT).$(LUAEXPAT_SUFFIX)
LUAEXPAT_DIR		:= $(BUILDDIR)/$(LUAEXPAT)
LUAEXPAT_LICENSE	:= MIT
LUAEXPAT_LICENSE_FILES	:= file://doc/us/license.html;md5=9e100888b4a39ac08c37fb127fefc458

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LUAEXPAT_CONF_TOOL := NO

LUAEXPAT_LUA_VERSION	= $(basename $(LUA_VERSION))
LUAEXPAT_MAKE_ENV	= \
	$(CROSS_ENV) \
	LUA_V=$(LUAEXPAT_LUA_VERSION) \
	LUA_INC= \
	EXPAT_INC=

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

	@$(call install_copy, luaexpat, 0, 0, 0644, -, \
		/usr/share/lua/$(LUAEXPAT_LUA_VERSION)/lxp/lom.lua)
	@$(call install_lib, luaexpat, 0, 0, 0644, \
		lua/$(LUAEXPAT_LUA_VERSION)/lxp)
	@$(call install_finish, luaexpat)

	@$(call touch)

# vim: syntax=make
