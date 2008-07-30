# -*-makefile-*-
# $Id: template-make 8509 2008-06-12 12:45:40Z mkl $
#
# Copyright (C) 2008 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LUA) += lua

#
# Paths and names
#
LUA_VERSION	:= 5.1.3
LUA		:= lua-$(LUA_VERSION)
LUA_SUFFIX	:= tar.gz
LUA_URL		:= http://www.lua.org/ftp//$(LUA).$(LUA_SUFFIX)
LUA_SOURCE	:= $(SRCDIR)/$(LUA).$(LUA_SUFFIX)
LUA_DIR		:= $(BUILDDIR)/$(LUA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LUA_SOURCE):
	@$(call targetinfo)
	@$(call get, LUA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/lua.extract:
	@$(call targetinfo)
	@$(call clean, $(LUA_DIR))
	@$(call extract, LUA)
	@$(call patchin, LUA)
	cd $(LUA_DIR) && chmod +x configure
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LUA_PATH	:= PATH=$(CROSS_PATH)
LUA_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LUA_AUTOCONF := $(CROSS_AUTOCONF_USR)
ifdef PTXCONF_LUA_READLINE
LUA_AUTOCONF += --with-readline
else
LUA_AUTOCONF += --without-readline
endif

$(STATEDIR)/lua.prepare:
	@$(call targetinfo)
	@$(call clean, $(LUA_DIR)/config.cache)
	cd $(LUA_DIR) && \
		$(LUA_PATH) $(LUA_ENV) \
		./configure $(LUA_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/lua.compile:
	@$(call targetinfo)
	cd $(LUA_DIR) && $(LUA_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lua.install:
	@$(call targetinfo)
	@$(call install, LUA)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lua.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lua)
	@$(call install_fixup, lua,PACKAGE,lua)
	@$(call install_fixup, lua,PRIORITY,optional)
	@$(call install_fixup, lua,VERSION,$(LUA_VERSION))
	@$(call install_fixup, lua,SECTION,base)
	@$(call install_fixup, lua,AUTHOR,"Erwin Rol <erwin\@erwinrol.com>")
	@$(call install_fixup, lua,DEPENDS,)
	@$(call install_fixup, lua,DESCRIPTION,missing)

ifdef PTXCONF_LUA_INSTALL_LUA
	@$(call install_copy, lua, 0, 0, 0755, $(LUA_DIR)/src/lua, /usr/bin/lua)
endif
ifdef PTXCONF_LUA_INSTALL_LUAC
	@$(call install_copy, lua, 0, 0, 0755, $(LUA_DIR)/src/luac, /usr/bin/luac)
endif
ifdef PTXCONF_LUA_INSTALL_LIBLUA
	@$(call install_copy, lua, 0, 0, 0644, \
		$(LUA_DIR)/src/.libs/liblua-5.1.3.so, \
		/usr/lib/liblua-5.1.3.so)
	@$(call install_link, lua, liblua-5.1.3.so, /usr/lib/liblua.so )
endif
	@$(call install_finish, lua)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lua_clean:
	rm -rf $(STATEDIR)/lua.*
	rm -rf $(PKGDIR)/lua_*
	rm -rf $(LUA_DIR)

# vim: syntax=make
