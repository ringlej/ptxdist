# -*-makefile-*-
#
# Copyright (C) 2013 by Philipp Zabel <p.zabel@pengutronix.de>
#               2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WESTON) += weston

#
# Paths and names
#
WESTON_VERSION	:= 1.7.0
WESTON_MD5	:= 1fde8a44f48cd177438522850d6ba4be
WESTON		:= weston-$(WESTON_VERSION)
WESTON_SUFFIX	:= tar.xz
WESTON_URL	:= http://wayland.freedesktop.org/releases/$(WESTON).$(WESTON_SUFFIX)
WESTON_SOURCE	:= $(SRCDIR)/$(WESTON).$(WESTON_SUFFIX)
WESTON_DIR	:= $(BUILDDIR)/$(WESTON)
WESTON_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
WESTON_CONF_TOOL	:= autoconf
WESTON_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-shared \
	--$(call ptx/endis, PTXCONF_WESTON_GL)-egl \
	--enable-xkbcommon \
	--disable-setuid-install \
	--$(call ptx/endis, PTXCONF_WESTON_XWAYLAND)-xwayland \
	--disable-xwayland-test \
	--disable-x11-compositor \
	--$(call ptx/endis, PTXCONF_WESTON_DRM_COMPOSITOR)-drm-compositor \
	--$(call ptx/endis, PTXCONF_WESTON_GL)-wayland-compositor \
	--$(call ptx/endis, PTXCONF_WESTON_HEADLESS_COMPOSITOR)-headless-compositor \
	--disable-rpi-compositor \
	--$(call ptx/endis, PTXCONF_WESTON_FBDEV_COMPOSITOR)-fbdev-compositor \
	--disable-rdp-compositor \
	--disable-screen-sharing \
	--disable-vaapi-recorder \
	--enable-simple-clients \
	--$(call ptx/endis, PTXCONF_WESTON_GL)-simple-egl-clients \
	--enable-clients \
	--enable-resize-optimization \
	--disable-weston-launch \
	--enable-fullscreen-shell \
	--disable-colord \
	--disable-dbus \
	--disable-ivi-shell \
	--$(call ptx/endis, PTXCONF_WESTON_WCAP_TOOLS)-wcap-tools \
	--disable-libunwind \
	--disable-demo-clients-install \
	--with-cairo=$(call ptx/ifdef, PTXCONF_WESTON_GL,glesv2,image)


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/weston.targetinstall:
	@$(call targetinfo)

	@$(call install_init, weston)
	@$(call install_fixup, weston,PRIORITY,optional)
	@$(call install_fixup, weston,SECTION,base)
	@$(call install_fixup, weston,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, weston,DESCRIPTION,"wayland reference compositor implementation")

	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-info)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-terminal)

ifdef PTXCONF_WESTON_WCAP_TOOLS
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/wcap-decode)
endif

ifdef PTXCONF_WESTON_XWAYLAND
	@$(call install_lib, weston, 0, 0, 0644, weston/xwayland)
endif
ifdef PTXCONF_WESTON_DRM_COMPOSITOR
	@$(call install_lib, weston, 0, 0, 0644, weston/drm-backend)
endif
ifdef PTXCONF_WESTON_HEADLESS_COMPOSITOR
	@$(call install_lib, weston, 0, 0, 0644, weston/headless-backend)
endif
ifdef PTXCONF_WESTON_FBDEV_COMPOSITOR
	@$(call install_lib, weston, 0, 0, 0644, weston/fbdev-backend)
endif
ifdef PTXCONF_WESTON_GL
	@$(call install_lib, weston, 0, 0, 0644, weston/wayland-backend)
	@$(call install_lib, weston, 0, 0, 0644, weston/gl-renderer)
endif
	@$(call install_lib, weston, 0, 0, 0644, weston/desktop-shell)
	@$(call install_lib, weston, 0, 0, 0644, weston/fullscreen-shell)

	@$(call install_copy, weston, 0, 0, 0755, -, /usr/libexec/weston-simple-im)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/libexec/weston-screenshooter)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/libexec/weston-desktop-shell)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/libexec/weston-keyboard)


	@$(foreach image, \
		wayland.svg \
		terminal.png \
		wayland.png \
		border.png \
		pattern.png \
		sign_maximize.png \
		icon_window.png \
		sign_close.png \
		sign_maximize.png, \
		$(call install_copy, weston, 0, 0, 0644, -, /usr/share/weston/$(image));)


	@$(call install_finish, weston)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/weston.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, WESTON)

# vim: syntax=make
