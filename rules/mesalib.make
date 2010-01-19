# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME, we only need the source tree, do we still need the package ?


#
# We provide this package
#
PACKAGES-$(PTXCONF_MESALIB) += mesalib

#
# Paths and names
#
MESALIB_VERSION	:= 7.5.2
MESALIB		:= MesaLib-$(MESALIB_VERSION)
MESALIB_SUFFIX	:= tar.bz2
MESALIB_SOURCE	:= $(SRCDIR)/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_DIR	:= $(BUILDDIR)/Mesa-$(MESALIB_VERSION)

MESALIB_URL	:= \
	$(PTXCONF_SETUP_SFMIRROR)/mesa3d/$(MESADEMOS).$(MESALIB_SUFFIX) \
	ftp://ftp.freedesktop.org/pub/mesa/7.5.2/$(MESALIB).$(MESALIB_SUFFIX)

MESADEMOS		:= MesaDemos-$(MESALIB_VERSION)
MESADEMOS_SOURCE	:= $(SRCDIR)/$(MESADEMOS).$(MESALIB_SUFFIX)

MESADEMOS_URL		:= \
	$(PTXCONF_SETUP_SFMIRROR)/mesa3d/$(MESADEMOS).$(MESALIB_SUFFIX) \
	ftp://ftp.freedesktop.org/pub/mesa/7.5.2/$(MESADEMOS).$(MESALIB_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MESALIB_SOURCE):
	@$(call targetinfo)
	@$(call get, MESALIB)

$(MESADEMOS_SOURCE):
	@$(call targetinfo)
	@$(call get, MESADEMOS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ifdef PTXCONF_MESALIB_TOOLS
$(STATEDIR)/mesalib.get: $(MESADEMOS_SOURCE)
endif

$(STATEDIR)/mesalib.extract:
	@$(call targetinfo)
	@$(call extract, MESALIB)
ifdef PTXCONF_MESALIB_TOOLS
	@$(call extract, MESADEMOS)
endif
	@$(call patchin, MESALIB, $(MESALIB_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MESALIB_PATH       := PATH=$(CROSS_PATH)
MESALIB_ENV        := $(CROSS_ENV)
MESALIB_COMPILE_ENV := $(CROSS_ENV_CC_FOR_BUILD)

MESALIB_DRIVERS-$(PTXCONF_MESALIB_DRIVER_XLIB)		+= xlib
MESALIB_DRIVERS-$(PTXCONF_MESALIB_DRIVER_DRI)		+= dri
MESALIB_DRIVERS-$(PTXCONF_MESALIB_DRIVER_OSMESA)	+= osmesa

MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_I915)		+= i915
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_SWRAST)	+= swrast
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_I810)		+= i810
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_I965)		+= i965
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_MACH64)	+= mach64
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_MGA)		+= mga
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_R128)		+= r128
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_R200)		+= r200
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_R300)		+= r300
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_RADEON)	+= radeon
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_S3V)		+= s3v
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_SAVAGE)	+= savage
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_SIS)		+= sis
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_TDFX)		+= tdfx
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_TRIDENT)	+= trident
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_UNICHROME)	+= unichrome
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_FFB)		+= ffb

MESALIB_AUTOCONF   := \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-shared \
	--disable-debug \
	--enable-asm \
	--enable-pic \
	--disable-selinux \
	--enable-xcb \
	--disable-glx-tls \
	--enable-driglx-direct \
	--enable-glu \
	--disable-glw \
	--disable-motif \
	--disable-glut \
	--with-driver=$(subst $(space),$(comma),$(MESALIB_DRIVERS-y)) \
	--with-dri-drivers=$(subst $(space),$(comma),$(MESALIB_DRI_DRIVERS-y))

# the 32/64 bit options result in CFLAGS -> -m32 and -m64 which seem
# only to be available on x86

ifdef PTXCONF_ARCH_X86
MESALIB_AUTOCONF += \
	--enable-32-bit \
	--disable-64-bit
endif

ifdef PTXCONF_MESALIB_DRIVER_XLIB
	MESALIB_AUTOCONF += --enable-gl-osmesa
endif
ifdef PTXCONF_MESALIB_DRIVER_DRI
	MESALIB_AUTOCONF += --enable-gl-osmesa
endif
ifdef PTXCONF_MESALIB_DRIVER_OSMESA
	MESALIB_AUTOCONF += --disable-gl-osmesa
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

MESALIB_GL_VERSION-$(PTXCONF_MESALIB_DRIVER_DRI)  := 1.2
MESALIB_GL_VERSION-$(PTXCONF_MESALIB_DRIVER_XLIB) := 1.5.070502

$(STATEDIR)/mesalib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mesalib)
	@$(call install_fixup, mesalib,PACKAGE,mesalib)
	@$(call install_fixup, mesalib,PRIORITY,optional)
	@$(call install_fixup, mesalib,VERSION,$(MESALIB_VERSION))
	@$(call install_fixup, mesalib,SECTION,base)
	@$(call install_fixup, mesalib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mesalib,DEPENDS,)
	@$(call install_fixup, mesalib,DESCRIPTION,missing)

ifdef PTXCONF_MESALIB_DRIVER_DRI

ifdef PTXCONF_MESALIB_DRI_I915
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/i915_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_SWRAST
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/swrast_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_I810
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/i810_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_I965
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/i965_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_MACH64
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/mach64_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_MGA
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/mga_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_R128
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/r128_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_R200
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/r200_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_R300
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/r300_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_RADEON
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/radeon_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_S3V
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/s3v_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_SAVAGE
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/savage_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_SIS
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/sis_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_TDFX
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/tdfx_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_TRIDENT
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/trident_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_UNICHROME
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/unichrome_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_FFB
	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/ffb_dri.so)
endif

endif

ifdef PTXCONF_MESALIB_TOOLS_CORENDER
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/corender, /usr/bin/corender)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLSYNC
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glsync, /usr/bin/glsync)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLTHREADS
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glthreads, /usr/bin/glthreads)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLXCONTEXTS
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glxcontexts, /usr/bin/glxcontexts)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLXDEMO
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glxdemo, /usr/bin/glxdemo)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLXGEARS
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glxgears, /usr/bin/glxgears)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLXGEARS_FBCONFIG
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glxgears_fbconfig, /usr/bin/glxgears_fbconfig)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLXGEARS_PIXMAP
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glxgears_pixmap, /usr/bin/glxgears_pixmap)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLXHEADS
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glxheads, /usr/bin/glxheads)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLXINFO
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glxinfo, /usr/bin/glxinfo)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLXPBDEMO
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glxpbdemo, /usr/bin/glxpbdemo)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLXPIXMAP
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glxpixmap, /usr/bin/glxpixmap)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLXSNOOP
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glxsnoop, /usr/bin/glxsnoop)
endif
ifdef PTXCONF_MESALIB_TOOLS_GLXSWAPCONTROL
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/glxswapcontrol, /usr/bin/glxswapcontrol)
endif
ifdef PTXCONF_MESALIB_TOOLS_MANYWIN
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/manywin, /usr/bin/manywin)
endif
ifdef PTXCONF_MESALIB_TOOLS_OFFSET
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/offset, /usr/bin/offset)
endif
ifdef PTXCONF_MESALIB_TOOLS_OVERLAY
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/overlay, /usr/bin/overlay)
endif
ifdef PTXCONF_MESALIB_TOOLS_PBDEMO
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/pbdemo, /usr/bin/pbdemo)
endif
ifdef PTXCONF_MESALIB_TOOLS_PBINFO
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/pbinfo, /usr/bin/pbinfo)
endif
ifdef PTXCONF_MESALIB_TOOLS_SHAREDTEX
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/sharedtex, /usr/bin/sharedtex)
endif
ifdef PTXCONF_MESALIB_TOOLS_SHAREDTEX_MT
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/sharedtex_mt, /usr/bin/sharedtex_mt)
endif
ifdef PTXCONF_MESALIB_TOOLS_TEXTURE_FROM_PIXMAP
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/texture_from_pixmap, /usr/bin/texture_from_pixmap)
endif
ifdef PTXCONF_MESALIB_TOOLS_WINCOPY
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/wincopy, /usr/bin/wincopy)
endif
ifdef PTXCONF_MESALIB_TOOLS_XFONT
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/xfont, /usr/bin/xfont)
endif
ifdef PTXCONF_MESALIB_TOOLS_XROTFONTDEMO
	@$(call install_copy, mesalib, 0, 0, 0755, $(MESALIB_DIR)/progs/xdemos/xrotfontdemo, /usr/bin/xrotfontdemo)
endif

ifndef PTXCONF_MESALIB_DRIVER_OSMESA
	@$(call install_copy, mesalib, 0, 0, 0644, -, \
		 /usr/lib/libGL.so.$(MESALIB_GL_VERSION-y))
	@$(call install_link, mesalib, libGL.so.$(MESALIB_GL_VERSION-y), /usr/lib/libGL.so.1)
	@$(call install_link, mesalib, libGL.so.$(MESALIB_GL_VERSION-y), /usr/lib/libGL.so)
endif

	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/libGLU.so.1.3.070502)
	@$(call install_link, mesalib, libGLU.so.1.3.070502, /usr/lib/libGLU.so.1)
	@$(call install_link, mesalib, libGLU.so.1.3.070502, /usr/lib/libGLU.so)

	@$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/libOSMesa.so.7.5.2)
	@$(call install_link, mesalib, libOSMesa.so.7.5.2, /usr/lib/libOSMesa.so.7)
	@$(call install_link, mesalib, libOSMesa.so.7.5.2, /usr/lib/libOSMesa.so)

	@$(call install_finish, mesalib)

	@$(call touch)


# vim: syntax=make
