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
MESALIB_VERSION	:= 9.2.0
MESALIB_MD5	:= 4185b6aae890bc62a964f4b24cc1aca8
MESALIB		:= MesaLib-$(MESALIB_VERSION)
MESALIB_SUFFIX	:= tar.bz2
MESALIB_URL	:= ftp://ftp.freedesktop.org/pub/mesa/9.2/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_SOURCE	:= $(SRCDIR)/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_DIR	:= $(BUILDDIR)/Mesa-$(MESALIB_VERSION)

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

ifndef PTXCONF_ARCH_X86 # needs llvm
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_R300)	+= r300
endif
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_R600)	+= r600
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_RADEONSI)	+= radeonsi

MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_NOUVEAU)	+= nouveau
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_FREEDRENO)+= freedreno

MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_SWRAST)	+= swrast

MESALIB_DRI_LIBS-y += \
	$(MESALIB_DRI_DRIVERS-y) \
	$(subst freedreno,kgsl,$(MESALIB_GALLIUM_DRIVERS-y))

MESALIB_LIBS-y				:= libglapi
ifneq ($(MESALIB_DRI_DRIVERS-y),)
MESALIB_LIBS-y				+= libdricore$(MESALIB_VERSION)
endif
MESALIB_LIBS-$(PTXCONF_MESALIB_GLX)	+= libGL
MESALIB_LIBS-$(PTXCONF_MESALIB_GLES1)	+= libGLESv1_CM
MESALIB_LIBS-$(PTXCONF_MESALIB_GLES2)	+= libGLESv2
MESALIB_LIBS-$(PTXCONF_MESALIB_OPENVG)	+= libOpenVG
MESALIB_LIBS-$(PTXCONF_MESALIB_EGL)	+= libEGL egl/egl_gallium
MESALIB_LIBS-$(PTXCONF_MESALIB_GBM)	+= libgbm gbm/gbm_gallium_drm

MESALIB_LIBS-y += $(addprefix gallium-pipe/pipe_,$(filter-out freedreno,$(MESALIB_GALLIUM_DRIVERS-y)))

MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_X11)	+= x11
MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_DRM)	+= drm
MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_WAYLAND)	+= wayland

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
	--$(call ptx/endis, PTXCONF_MESALIB_GLX)-glx \
	--disable-osmesa \
	--disable-gallium-osmesa \
	--$(call ptx/endis, PTXCONF_MESALIB_EGL)-egl \
	--disable-xorg \
	--disable-xa \
	--$(call ptx/endis, PTXCONF_MESALIB_GBM)-gbm \
	--disable-xvmc \
	--disable-vdpau \
	--disable-opencl \
	--disable-xlib-glx \
	--$(call ptx/endis, PTXCONF_MESALIB_EGL)-gallium-egl \
	--$(call ptx/endis, PTXCONF_MESALIB_GBM)-gallium-gbm \
	--disable-r600-llvm-compiler \
	--disable-gallium-tests \
	--enable-shared-glapi \
	--enable-driglx-direct \
	--enable-glx-tls \
	--disable-gallium-llvm \
	--with-gallium-drivers=$(subst $(space),$(comma),$(MESALIB_GALLIUM_DRIVERS-y)) \
	--with-dri-drivers=$(subst $(space),$(comma),$(MESALIB_DRI_DRIVERS-y)) \
	--with-expat=$(SYSROOT)/usr \
	--with-egl-platforms="$(MESALIBS_EGL_PLATFORMS-y)"

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

MESALIB_MAKE_OPT := HOST_CC=$(HOSTCC)

$(STATEDIR)/mesalib.compile:
	@$(call targetinfo)
	cp $(PTXCONF_SYSROOT_HOST)/bin/mesa/builtin_compiler $(MESALIB_DIR)/src/glsl/builtin_compiler/
	@$(call compile, MESALIB)
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
