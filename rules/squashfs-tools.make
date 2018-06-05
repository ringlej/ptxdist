# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SQUASHFS_TOOLS) += squashfs-tools

#
# Paths and names
#
SQUASHFS_TOOLS_VERSION	:= $(call ptx/ifdef, PTXCONF_HOST_SQUASHFS_TOOLS_V3X, 3.4, 4.2)
ifdef PTXCONF_HOST_SQUASHFS_TOOLS_V3X
SQUASHFS_TOOLS_MD5	:= 2a4d2995ad5aa6840c95a95ffa6b1da6
else
SQUASHFS_TOOLS_MD5	:= 1b7a781fb4cf8938842279bd3e8ee852
endif
SQUASHFS_TOOLS		:= squashfs$(SQUASHFS_TOOLS_VERSION)
SQUASHFS_TOOLS_SUFFIX	:= tar.gz
SQUASHFS_TOOLS_URL	:= $(call ptx/mirror, SF, squashfs/$(SQUASHFS_TOOLS).$(SQUASHFS_TOOLS_SUFFIX))
SQUASHFS_TOOLS_SOURCE	:= $(SRCDIR)/$(SQUASHFS_TOOLS).$(SQUASHFS_TOOLS_SUFFIX)
SQUASHFS_TOOLS_DIR	:= $(BUILDDIR)/$(SQUASHFS_TOOLS)
SQUASHFS_TOOLS_SUBDIR	:= squashfs-tools
SQUASHFS_TOOLS_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SQUASHFS_TOOLS_MAKE_PAR := NO
SQUASHFS_TOOLS_MAKE_ENV := \
	$(CROSS_ENV)

SQUASHFS_TOOLS_INSTALL_OPT := \
	INSTALL_DIR="$(SQUASHFS_TOOLS_PKGDIR)/usr/sbin" \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/squashfs-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  squashfs-tools)
	@$(call install_fixup, squashfs-tools,PRIORITY,optional)
	@$(call install_fixup, squashfs-tools,SECTION,base)
	@$(call install_fixup, squashfs-tools,AUTHOR,"Erwin Rol")
	@$(call install_fixup, squashfs-tools,DESCRIPTION,missing)


ifdef PTXCONF_SQUASHFS_TOOLS_MKSQUASHFS
	@$(call install_copy, squashfs-tools, 0, 0, 0755, -, /usr/sbin/mksquashfs)
endif
ifdef PTXCONF_SQUASHFS_TOOLS_UNSQUASHFS
	@$(call install_copy, squashfs-tools, 0, 0, 0755, -, /usr/sbin/unsquashfs)
endif

	@$(call install_finish, squashfs-tools)

	@$(call touch)

# vim: syntax=make
