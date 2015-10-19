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
MESALIB_VERSION	:= 10.3.3
MESALIB_MD5	:= 4fe6fc9e28fb2a88a2387e5d3a49ae8b
MESALIB		:= MesaLib-$(MESALIB_VERSION)
MESALIB_SUFFIX	:= tar.bz2
MESALIB_URL	:= ftp://ftp.freedesktop.org/pub/mesa/older-versions/10.x/$(subst .0,,$(MESALIB_VERSION))/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_SOURCE	:= $(SRCDIR)/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_DIR	:= $(BUILDDIR)/Mesa-$(MESALIB_VERSION)
MESALIB_LICENSE	:= MIT
MESALIB_LICENSE_FILES := \
	file://docs/license.html;md5=6a23445982a7a972ac198e93cc1cb3de

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
ifdef PTXCONF_ARCH_ARM
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_VC4)	+= vc4
endif

MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_SWRAST)	+= swrast

MESALIB_DRI_LIBS-y += \
	$(subst nouveau,nouveau_vieux,$(MESALIB_DRI_DRIVERS-y)) \
	$(subst freedreno,kgsl,$(MESALIB_GALLIUM_DRIVERS-y))

ifeq ($(MESALIB_GALLIUM_DRIVERS-y),)
MESALIB_GALLIUM_EGL	:=
MESALIB_GALLIUM_GBM	:=
else
MESALIB_GALLIUM_EGL	:= $(PTXCONF_MESALIB_EGL)
MESALIB_GALLIUM_GBM	:= $(PTXCONF_MESALIB_GBM)
endif

MESALIB_LIBS-y				:= libglapi
MESALIB_LIBS-$(PTXCONF_MESALIB_GLX)	+= libGL
MESALIB_LIBS-$(PTXCONF_MESALIB_GLES1)	+= libGLESv1_CM
MESALIB_LIBS-$(PTXCONF_MESALIB_GLES2)	+= libGLESv2
MESALIB_LIBS-$(PTXCONF_MESALIB_OPENVG)	+= libOpenVG
MESALIB_LIBS-$(PTXCONF_MESALIB_EGL)	+= libEGL
MESALIB_LIBS-$(MESALIB_GALLIUM_EGL)	+= egl/egl_gallium
MESALIB_LIBS-$(PTXCONF_MESALIB_GBM)	+= libgbm
MESALIB_LIBS-$(MESALIB_GALLIUM_GBM)	+= gbm/gbm_gallium_drm

MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_X11)	+= x11
MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_DRM)	+= drm
MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_WAYLAND)	+= wayland

MESALIB_LIBS-$(PTXCONF_MESALIB_EGL_WAYLAND)	+= libwayland-egl

MESALIB_CONF_TOOL	:= autoconf
MESALIB_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-shared \
	--disable-debug \
	--disable-mangling \
	--disable-texture-float \
	--disable-asm \
	--disable-selinux \
	--$(call ptx/endis, PTXCONF_MESALIB_OPENGL)-opengl \
	--$(call ptx/endis, PTXCONF_MESALIB_GLES1)-gles1 \
	--$(call ptx/endis, PTXCONF_MESALIB_GLES2)-gles2 \
	--$(call ptx/endis, PTXCONF_MESALIB_OPENVG)-openvg \
	--enable-dri \
	--disable-dri3 \
	--$(call ptx/endis, PTXCONF_MESALIB_GLX)-glx \
	--disable-osmesa \
	--disable-gallium-osmesa \
	--$(call ptx/endis, PTXCONF_MESALIB_EGL)-egl \
	--disable-xa \
	--$(call ptx/endis, PTXCONF_MESALIB_GBM)-gbm \
	--disable-xvmc \
	--disable-vdpau \
	--disable-omx \
	--disable-opencl \
	--disable-opencl-icd \
	--disable-xlib-glx \
	--$(call ptx/endis, MESALIB_GALLIUM_EGL)-gallium-egl \
	--$(call ptx/endis, MESALIB_GALLIUM_GBM)-gallium-gbm \
	--disable-r600-llvm-compiler \
	--disable-gallium-tests \
	--enable-shared-glapi \
	--disable-sysfs \
	--enable-driglx-direct \
	--enable-glx-tls \
	--disable-gallium-llvm \
	--enable-llvm-shared-libs \
	--with-gallium-drivers=$(subst $(space),$(comma),$(MESALIB_GALLIUM_DRIVERS-y)) \
	--with-dri-driverdir=/usr/lib/dri \
	--with-dri-drivers=$(subst $(space),$(comma),$(MESALIB_DRI_DRIVERS-y)) \
	--with-egl-platforms="$(MESALIBS_EGL_PLATFORMS-y)"

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/mesalib.compile:
	@$(call targetinfo)
	cp $(PTXCONF_SYSROOT_HOST)/bin/mesa/glsl_compiler $(MESALIB_DIR)/src/glsl/
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
