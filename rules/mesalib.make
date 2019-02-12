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
MESALIB_VERSION	:= 18.3.1
MESALIB_MD5	:= d60828056d77bfdbae0970f9b15fb1be
MESALIB		:= mesa-$(MESALIB_VERSION)
MESALIB_SUFFIX	:= tar.xz
MESALIB_URL	:= \
	ftp://ftp.freedesktop.org/pub/mesa/$(MESALIB_VERSION)/$(MESALIB).$(MESALIB_SUFFIX) \
	ftp://ftp.freedesktop.org/pub/mesa/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_SOURCE	:= $(SRCDIR)/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_DIR	:= $(BUILDDIR)/Mesa-$(MESALIB_VERSION)
MESALIB_LICENSE	:= MIT
MESALIB_LICENSE_FILES := \
	file://docs/license.html;md5=725f991a1cc322aa7a0cd3a2016621c4

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MESALIB_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_prog_PYTHON2=$(PTXDIST_TOPDIR)/bin/python

ifdef PTXCONF_ARCH_X86
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_I915)		+= i915
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_I965)		+= i965
endif
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_NOUVEAU_VIEUX)+= nouveau
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_R200)		+= r200

ifndef PTXCONF_ARCH_ARM # broken: https://bugs.freedesktop.org/show_bug.cgi?id=72064
ifndef PTXCONF_ARCH_X86 # needs llvm
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_R300)	+= r300
endif
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_R600)	+= r600
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_RADEONSI)	+= radeonsi
endif

MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_NOUVEAU)	+= nouveau
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_FREEDRENO)+= freedreno
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_ETNAVIV)	+= etnaviv
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_IMX)	+= imx
ifdef PTXCONF_ARCH_ARM
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_V3D)	+= v3d
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_VC4)	+= vc4
endif

MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_SWRAST)	+= swrast

MESALIB_DRI_LIBS-y += \
	$(subst nouveau,nouveau_vieux,$(MESALIB_DRI_DRIVERS-y)) \
	$(subst imx,imx-drm,$(subst freedreno,kgsl,$(MESALIB_GALLIUM_DRIVERS-y)))

MESALIB_LIBS-y				:= libglapi
MESALIB_LIBS-$(PTXCONF_MESALIB_GLX)	+= libGL
MESALIB_LIBS-$(PTXCONF_MESALIB_GLES1)	+= libGLESv1_CM
MESALIB_LIBS-$(PTXCONF_MESALIB_GLES2)	+= libGLESv2
MESALIB_LIBS-$(PTXCONF_MESALIB_EGL)	+= libEGL
MESALIB_LIBS-$(PTXCONF_MESALIB_GBM)	+= libgbm

MESALIBS_EGL_PLATFORMS-y				:= surfaceless
MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_X11)	+= x11
MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_DRM)	+= drm
MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_WAYLAND)	+= wayland

MESALIB_BUILD_OOT	:= YES
MESALIB_CONF_TOOL	:= autoconf
MESALIB_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_GLOBAL_LARGE_FILE)-largefile \
	--disable-static \
	--enable-shared \
	--disable-pwr8 \
	--disable-debug \
	--disable-profile \
	--disable-sanitize \
	--disable-asm \
	--disable-selinux \
	--disable-llvm-shared-libs \
	--disable-libunwind \
	--$(call ptx/endis, PTXCONF_MESALIB_OPENGL)-opengl \
	--$(call ptx/endis, PTXCONF_MESALIB_GLES1)-gles1 \
	--$(call ptx/endis, PTXCONF_MESALIB_GLES2)-gles2 \
	--enable-dri \
	--$(call ptx/endis, PTXCONF_MESALIB_EXTENDED_HUD)-gallium-extra-hud \
	--$(call ptx/endis, PTXCONF_MESALIB_LMSENSORS)-lmsensors \
	--disable-dri3 \
	--$(call ptx/endis, PTXCONF_MESALIB_GLX)-glx \
	--disable-osmesa \
	--disable-gallium-osmesa \
	--$(call ptx/endis, PTXCONF_MESALIB_EGL)-egl \
	--disable-xa \
	--$(call ptx/endis, PTXCONF_MESALIB_GBM)-gbm \
	--disable-nine \
	--disable-xvmc \
	--disable-vdpau \
	--disable-omx-tizonia \
	--disable-omx-bellagio \
	--disable-va \
	--disable-opencl \
	--disable-opencl-icd \
	--disable-gallium-tests \
	--disable-libglvnd \
	--disable-mangling \
	--enable-shared-glapi \
	--enable-driglx-direct \
	--enable-glx-tls \
	--disable-glx-read-only-text \
	--disable-xlib-lease \
	--disable-llvm \
	--disable-valgrind \
	--with-gallium-drivers=$(subst $(space),$(comma),$(MESALIB_GALLIUM_DRIVERS-y)) \
	--with-platforms=$(subst $(space),$(comma),$(MESALIBS_EGL_PLATFORMS-y)) \
	--with-dri-driverdir=/usr/lib/dri \
	--with-dri-searchpath=/usr/lib/dri \
	--with-dri-drivers=$(subst $(space),$(comma),$(MESALIB_DRI_DRIVERS-y)) \
	--without-vulkan-drivers \
	--with-vulkan-icddir=/etc/vulkan/icd.d \
	--with-osmesa-bits=8 \
	--with-clang-libdir=/usr/lib \
	--with-xvmc-libdir=/usr/lib \
	--with-vdpau-libdir=/usr/lib/vdpau \
	--with-omx-bellagio-libdir=/usr/lib/dri \
	--with-omx-tizonia-libdir=/usr/lib/dri \
	--with-va-libdir=/usr/lib/dri \
	--with-d3d-libdir=/usr/lib/d3d \
	--with-swr-archs=

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/mesalib.compile:
	@$(call targetinfo)
	cp $(PTXCONF_SYSROOT_HOST)/bin/mesa/glsl_compiler $(MESALIB_DIR)/src/compiler/
	@$(call world/compile, MESALIB)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mesalib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mesalib)
	@$(call install_fixup, mesalib,PRIORITY,optional)
	@$(call install_fixup, mesalib,SECTION,base)
	@$(call install_fixup, mesalib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mesalib,DESCRIPTION,missing)

	@$(foreach lib, $(MESALIB_DRI_LIBS-y), \
		$(call install_copy, mesalib, 0, 0, 0644, -, \
		/usr/lib/dri/$(lib)_dri.so);)

	@$(foreach lib, $(MESALIB_LIBS-y), \
		$(call install_lib, mesalib, 0, 0, 0644, $(lib));)

	@$(call install_finish, mesalib)

	@$(call touch)


# vim: syntax=make
