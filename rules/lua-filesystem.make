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
PACKAGES-$(PTXCONF_LUA_FILESYSTEM) += lua-filesystem

#
# Paths and names
#
LUA_FILESYSTEM_VERSION	:= 1.5.0
LUA_FILESYSTEM_MD5	:= af4c07a7d9c0834e4f52fc0572180ef9
LUA_FILESYSTEM		:= lua-filesystem_1.5.0+16+g84f1af5
LUA_FILESYSTEM_SUFFIX	:= orig.tar.gz
LUA_FILESYSTEM_URL	:= $(call ptx/mirror, DEB, pool/main/l/lua-filesystem/$(LUA_FILESYSTEM).$(LUA_FILESYSTEM_SUFFIX))
LUA_FILESYSTEM_SOURCE	:= $(SRCDIR)/$(LUA_FILESYSTEM).$(LUA_FILESYSTEM_SUFFIX)
LUA_FILESYSTEM_DIR	:= $(BUILDDIR)/$(LUA_FILESYSTEM)
LUA_FILESYSTEM_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LUA_FILESYSTEM_MAKE_OPT := \
	$(CROSS_ENV_CC) \
	LUA_INC=.

LUA_FILESYSTEM_INSTALL_OPT := \
	$(LUA_FILESYSTEM_MAKE_OPT) \
	LUA_LIBDIR=$(LUA_FILESYSTEM_PKGDIR)/usr/lib/lua/5.1 \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lua-filesystem.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lua-filesystem)
	@$(call install_fixup, lua-filesystem,PRIORITY,optional)
	@$(call install_fixup, lua-filesystem,SECTION,base)
	@$(call install_fixup, lua-filesystem,AUTHOR,"Joerg Platte <joerg.platte@googlemail.com>")
	@$(call install_fixup, lua-filesystem,DESCRIPTION,missing)

	@$(call install_lib, lua-filesystem, 0, 0, 0644, lua/5.1/lfs)

	@$(call install_finish, lua-filesystem)

	@$(call touch)

# vim: syntax=make
