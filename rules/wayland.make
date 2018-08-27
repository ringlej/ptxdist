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
WAYLAND_VERSION	:= 1.16.0
WAYLAND_MD5	:= 0c215e53de71d6fb26f7102cdc6432d3
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
	--disable-fatal-warnings \
	--enable-libraries \
	--disable-documentation \
	--disable-dtd-validation \
	--with-host-scanner

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wayland.install.post:
	@$(call targetinfo)
#	# target wayland-scanner is not needed. Make sure nobody tries to use it
	@rm -f $(WAYLAND_PKGDIR)/usr/bin/wayland-scanner
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
