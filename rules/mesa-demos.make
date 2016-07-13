# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MESA_DEMOS) += mesa-demos

#
# Paths and names
#
MESA_DEMOS_VERSION	:= 8.3.0
MESA_DEMOS_MD5		:= 628e75c23c17394f11a316c36f8e4164
MESA_DEMOS		:= mesa-demos-$(MESA_DEMOS_VERSION)
MESA_DEMOS_SUFFIX	:= tar.bz2
MESA_DEMOS_URL		:= ftp://ftp.freedesktop.org/pub/mesa/demos/$(MESA_DEMOS_VERSION)/$(MESA_DEMOS).$(MESA_DEMOS_SUFFIX)
MESA_DEMOS_SOURCE	:= $(SRCDIR)/$(MESA_DEMOS).$(MESA_DEMOS_SUFFIX)
MESA_DEMOS_DIR		:= $(BUILDDIR)/$(MESA_DEMOS)
MESA_DEMOS_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
MESA_DEMOS_CONF_TOOL	:= autoconf
MESA_DEMOS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--$(call ptx/endis, PTXCONF_MESA_DEMOS_EGL)-egl \
	--$(call ptx/endis, PTXCONF_MESA_DEMOS_GLES1)-gles1 \
	--$(call ptx/endis, PTXCONF_MESA_DEMOS_GLES2)-gles2 \
	--disable-vg \
	--disable-osmesa \
	--disable-libdrm \
	--$(call ptx/endis, PTXCONF_MESA_DEMOS_X11)-x11 \
	--$(call ptx/endis, PTXCONF_MESA_DEMOS_WAYLAND)-wayland \
	--disable-gbm \
	--disable-freetype2 \
	--disable-rbug \
	--without-glut


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLSYNC)		+= glsync
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLTHREADS)		+= glthreads
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXCONTEXTS)	+= glxcontexts
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXDEMO)		+= glxdemo
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXGEARS)		+= glxgears
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXGEARS_FBCONFIG)	+= glxgears_fbconfig
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXGEARS_PIXMAP)	+= glxgears_pixmap
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXHEADS)		+= glxheads
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXINFO)		+= glxinfo
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXPBDEMO)		+= glxpbdemo
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXPIXMAP)		+= glxpixmap
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXSNOOP)		+= glxsnoop
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXSWAPCONTROL)	+= glxswapcontrol
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_MANYWIN)		+= manywin
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_MULTICTX)		+= multictx
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_OFFSET)		+= offset
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_OVERLAY)		+= overlay
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_PBDEMO)		+= pbdemo
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_PBINFO)		+= pbinfo
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_SHAPE)		+= shape
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_SHAREDTEX)		+= sharedtex
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_SHAREDTEX_MT)	+= sharedtex_mt
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_TEXTURE_FROM_PIXMAP)+= texture_from_pixmap
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_WINCOPY)		+= wincopy
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_XFONT)		+= xfont
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_XROTFONTDEMO)	+= xrotfontdemo
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_ES2_INFO)		+= es2_info
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_ES2GEARS_WAYLAND)	+= es2gears_wayland
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_ES2GEARS_X11)	+= es2gears_x11
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_ES2TRI)		+= es2tri

$(STATEDIR)/mesa-demos.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mesa-demos)
	@$(call install_fixup, mesa-demos,PRIORITY,optional)
	@$(call install_fixup, mesa-demos,SECTION,base)
	@$(call install_fixup, mesa-demos,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, mesa-demos,DESCRIPTION,missing)

	@$(foreach bin, $(MESA_DEMOS_BIN-y), \
		$(call install_copy, mesa-demos, 0, 0, 0755, -, /usr/bin/$(bin));)

	@$(call install_finish, mesa-demos)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/mesa-demos.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, MESA_DEMOS)

# vim: syntax=make
