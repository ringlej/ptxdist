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
MESALIB_VERSION	:= 8.0.3
MESALIB_MD5	:= cc5ee15e306b8c15da6a478923797171
MESALIB		:= MesaLib-$(MESALIB_VERSION)
MESALIB_SUFFIX	:= tar.bz2
MESALIB_URL	:= ftp://ftp.freedesktop.org/pub/mesa/$(MESALIB_VERSION)/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_SOURCE	:= $(SRCDIR)/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_DIR	:= $(BUILDDIR)/Mesa-$(MESALIB_VERSION)

ifdef PTXCONF_MESALIB
ifeq ($(shell $(PTXDIST_TOPDIR)/bin/python -c 'import libxml2' 2>/dev/null || echo no),no)
    $(warning *** libxml2 Python module is required for Mesa)
    $(error please install python-libxml2 (debian))
endif
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MESALIB_CONF_ENV := \
	ac_cv_prog_PYTHON2=$(PTXDIST_TOPDIR)/bin/python

ifdef PTXCONF_ARCH_X86
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_I915)		+= i915
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_I965)		+= i965
endif
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_NOUVEAU)	+= nouveau
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_R200)		+= r200
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_RADEON)	+= radeon
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_SWRAST)	+= swrast

ifdef PTXCONF_ARCH_X86
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_I915)	+= i915
endif
ifndef PTXCONF_ARCH_X86 # needs llvm
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_R300)	+= r300
endif
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_R600)	+= r600
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_NOUVEAU)	+= nouveau
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_SWRAST)	+= swrast

MESALIB_DRI_LIBS-y += $(MESALIB_DRI_DRIVERS-y) $(MESALIB_GALLIUM_DRIVERS-y)

MESALIB_CONF_TOOL	:= autoconf
MESALIB_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-shared \
	--disable-debug \
	--disable-mangling \
	--disable-texture-float \
	--disable-asm \
	--enable-pic \
	--disable-selinux \
	--enable-opengl \
	--disable-gles1 \
	--disable-gles2 \
	--disable-openvg \
	--$(call ptx/endis, PTXCONF_MESALIB_DRI)-dri \
	--$(call ptx/endis, PTXCONF_MESALIB_GLX)-glx \
	--$(call ptx/endis, PTXCONF_MESALIB_OSMESA)-osmesa \
	--disable-egl \
	--disable-xorg \
	--disable-xa \
	--disable-d3d1x \
	--disable-gbm \
	--disable-xvmc \
	--disable-vdpau \
	--disable-va \
	--$(call ptx/endis, PTXCONF_MESALIB_XLIB_GLX)-xlib-glx \
	--disable-gallium-egl \
	--disable-gallium-gbm \
	--disable-shared-glapi \
	--enable-driglx-direct \
	--disable-shared-dricore \
	--$(call ptx/endis,PTXCONF_XORG_SERVER_OPT_GLX_TLS)-glx-tls \
	--disable-gallium-g3dvl \
	--enable-glu \
	--disable-gallium-llvm \
	--with-gallium-drivers=$(subst $(space),$(comma),$(MESALIB_GALLIUM_DRIVERS-y)) \
	--with-dri-drivers=$(subst $(space),$(comma),$(MESALIB_DRI_DRIVERS-y)) \
	--with-expat=$(SYSROOT)/usr


# the 32/64 bit options result in CFLAGS -> -m32 and -m64 which seem
# only to be available on x86

ifdef PTXCONF_ARCH_X86
MESALIB_CONF_OPT += \
	--enable-32-bit \
	--disable-64-bit
endif

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

MESALIB_MAKE_OPT := HOST_CC=$(HOSTCC)

$(STATEDIR)/mesalib.compile:
	@$(call targetinfo)
	cp $(PTXCONF_SYSROOT_HOST)/bin/mesa/* $(MESALIB_DIR)/src/glsl/
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

ifdef PTXCONF_MESALIB_DRI
	@$(foreach lib, $(MESALIB_DRI_LIBS-y), \
		$(call install_copy, mesalib, 0, 0, 0644, -, /usr/lib/dri/$(lib)_dri.so);)
endif

	@$(call install_lib, mesalib, 0, 0, 0644, libGL)
	@$(call install_lib, mesalib, 0, 0, 0644, libGLU)
ifdef PTXCONF_MESALIB_OSMESA
	@$(call install_lib, mesalib, 0, 0, 0644, libOSMesa)
endif

	@$(call install_finish, mesalib)

	@$(call touch)


# vim: syntax=make
