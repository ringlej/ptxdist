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
WESTON_VERSION	:= 4.0.0
LIBWESTON_MAJOR := 4
WESTON_MD5	:= 33709aa4d5916f89643fca0fc0064b39
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
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--enable-shared \
	--disable-devdocs \
	--$(call ptx/endis, PTXCONF_WESTON_GL)-egl \
	--disable-setuid-install \
	--$(call ptx/endis, PTXCONF_WESTON_XWAYLAND)-xwayland \
	--disable-xwayland-test \
	--disable-x11-compositor \
	--$(call ptx/endis, PTXCONF_WESTON_DRM_COMPOSITOR)-drm-compositor \
	--$(call ptx/endis, PTXCONF_WESTON_GL)-wayland-compositor \
	--$(call ptx/endis, PTXCONF_WESTON_HEADLESS_COMPOSITOR)-headless-compositor \
	--$(call ptx/endis, PTXCONF_WESTON_FBDEV_COMPOSITOR)-fbdev-compositor \
	--disable-rdp-compositor \
	--disable-screen-sharing \
	--disable-vaapi-recorder \
	--enable-simple-clients \
	--$(call ptx/endis, PTXCONF_WESTON_GL)-simple-egl-clients \
	--disable-simple-dmabuf-drm-client \
	--disable-simple-dmabuf-v4l-client \
	--enable-clients \
	--enable-resize-optimization \
	--$(call ptx/endis, PTXCONF_WESTON_LAUNCH)-weston-launch \
	--enable-fullscreen-shell \
	--disable-colord \
	--$(call ptx/endis, PTXCONF_WESTON_SYSTEMD_LOGIND)-dbus \
	--$(call ptx/endis, PTXCONF_WESTON_SYSTEMD_LOGIND)-systemd-login \
	--disable-junit-xml \
	--disable-ivi-shell \
	--$(call ptx/endis, PTXCONF_WESTON_WCAP_TOOLS)-wcap-tools \
	--disable-demo-clients-install \
	--disable-lcms \
	--$(call ptx/endis, PTXCONF_WESTON_SYSTEMD)-systemd-notify \
	--with-cairo=$(call ptx/ifdef, PTXCONF_WESTON_GL,glesv2,image) \
	--with-jpeg \
	--without-webp


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
ifdef PTXCONF_WESTON_LAUNCH
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-launch)
endif
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/weston-terminal)

ifdef PTXCONF_WESTON_WCAP_TOOLS
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/bin/wcap-decode)
endif

	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR))
	@$(call install_lib, weston, 0, 0, 0644, libweston-desktop-$(LIBWESTON_MAJOR))
ifdef PTXCONF_WESTON_XWAYLAND
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/xwayland)
endif
ifdef PTXCONF_WESTON_DRM_COMPOSITOR
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/drm-backend)
endif
ifdef PTXCONF_WESTON_HEADLESS_COMPOSITOR
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/headless-backend)
endif
ifdef PTXCONF_WESTON_FBDEV_COMPOSITOR
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/fbdev-backend)
endif
ifdef PTXCONF_WESTON_GL
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/wayland-backend)
	@$(call install_lib, weston, 0, 0, 0644, libweston-$(LIBWESTON_MAJOR)/gl-renderer)
endif
	@$(call install_lib, weston, 0, 0, 0644, weston/desktop-shell)
	@$(call install_lib, weston, 0, 0, 0644, weston/fullscreen-shell)
ifdef PTXCONF_WESTON_SYSTEMD
	@$(call install_lib, weston, 0, 0, 0644, weston/systemd-notify)
endif

	@$(call install_copy, weston, 0, 0, 0755, -, /usr/libexec/weston-simple-im)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/libexec/weston-screenshooter)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/libexec/weston-desktop-shell)
	@$(call install_copy, weston, 0, 0, 0755, -, /usr/libexec/weston-keyboard)


	@$(foreach image, \
		border.png \
		icon_window.png \
		pattern.png \
		sign_close.png \
		sign_maximize.png \
		sign_minimize.png \
		terminal.png \
		wayland.png \
		wayland.svg, \
		$(call install_copy, weston, 0, 0, 0644, -, /usr/share/weston/$(image))$(ptx/nl))


	@$(call install_finish, weston)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/weston.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, WESTON)

# vim: syntax=make
