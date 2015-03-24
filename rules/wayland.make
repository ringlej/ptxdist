# -*-makefile-*-
#
# Copyright (C) 2013 by Philipp Zabel <p.zabel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WAYLAND) += wayland

#
# Paths and names
#
WAYLAND_VERSION	:= 1.7.0
WAYLAND_MD5	:= 6f46ac47c3a18c6503a40b5fa58a1066
WAYLAND		:= wayland-$(WAYLAND_VERSION)
WAYLAND_SUFFIX	:= tar.xz
WAYLAND_URL	:= http://wayland.freedesktop.org/releases/$(WAYLAND).$(WAYLAND_SUFFIX)
WAYLAND_SOURCE	:= $(SRCDIR)/$(WAYLAND).$(WAYLAND_SUFFIX)
WAYLAND_DIR	:= $(BUILDDIR)/$(WAYLAND)
WAYLAND_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
WAYLAND_CONF_TOOL	:= autoconf
WAYLAND_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--disable-scanner \
	--disable-documentation

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wayland.install.post:
	@$(call targetinfo)
	@$(call world/install.post, WAYLAND)
	@sed 's;^prefix=.*;prefix=$(PTXDIST_SYSROOT_HOST);' \
		$(PTXDIST_SYSROOT_HOST)/lib/pkgconfig/wayland-scanner.pc \
		> $(PTXDIST_SYSROOT_TARGET)/usr/lib/pkgconfig/wayland-scanner.pc
	@$(call touch)
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wayland.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wayland)
	@$(call install_fixup, wayland,PRIORITY,optional)
	@$(call install_fixup, wayland,SECTION,base)
	@$(call install_fixup, wayland,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, wayland,DESCRIPTION,wayland client and server libraries)

	@$(call install_lib, wayland, 0, 0, 0644, libwayland-client)
	@$(call install_lib, wayland, 0, 0, 0644, libwayland-server)
	@$(call install_lib, wayland, 0, 0, 0644, libwayland-cursor)

	@$(call install_finish, wayland)

	@$(call touch)

# vim: syntax=make
