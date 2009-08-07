# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
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
MESALIB_VERSION	:= 7.5
MESALIB		:= MesaLib-$(MESALIB_VERSION)
MESALIB_SUFFIX	:= tar.bz2
MESALIB_URL	:= $(PTXCONF_SETUP_SFMIRROR)/mesa3d/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_SOURCE	:= $(SRCDIR)/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_DIR	:= $(BUILDDIR)/Mesa-$(MESALIB_VERSION)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MESALIB_SOURCE):
	@$(call targetinfo)
	@$(call get, MESALIB)

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
MESALIB_GL_VERSION-$(PTXCONF_MESALIB_DRIVER_XLIB) := 1.5.070500

$(STATEDIR)/mesalib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mesalib)
	@$(call install_fixup, mesalib,PACKAGE,mesalib)
	@$(call install_fixup, mesalib,PRIORITY,optional)
	@$(call install_fixup, mesalib,VERSION,$(MESALIB_VERSION))
	@$(call install_fixup, mesalib,SECTION,base)
	@$(call install_fixup, mesalib,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, mesalib,DEPENDS,)
	@$(call install_fixup, mesalib,DESCRIPTION,missing)

ifdef PTXCONF_MESALIB_DRIVER_DRI

ifdef PTXCONF_MESALIB_DRI_I915
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/i915_dri.so, /usr/lib/dri/i915_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_SWRAST
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/swrast_dri.so, /usr/lib/dri/swrast_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_I810
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/i810_dri.so, /usr/lib/dri/i810_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_I965
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/i965_dri.so, /usr/lib/dri/i965_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_MACH64
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/mach64_dri.so, /usr/lib/dri/mach64_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_MGA
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/mga_dri.so, /usr/lib/dri/mga_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_R128
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/r128_dri.so, /usr/lib/dri/r128_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_R200
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/r200_dri.so, /usr/lib/dri/r200_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_R300
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/r300_dri.so, /usr/lib/dri/r300_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_RADEON
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/radeon_dri.so, /usr/lib/dri/radeon_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_S3V
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/s3v_dri.so, /usr/lib/dri/s3v_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_SAVAGE
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/savage_dri.so, /usr/lib/dri/savage_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_SIS
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/sis_dri.so, /usr/lib/dri/sis_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_TDFX
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/tdfx_dri.so, /usr/lib/dri/tdfx_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_TRIDENT
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/trident_dri.so, /usr/lib/dri/trident_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_UNICHROME
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/unichrome_dri.so, /usr/lib/dri/unichrome_dri.so)
endif
ifdef PTXCONF_MESALIB_DRI_FFB
	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/ffb_dri.so, /usr/lib/dri/ffb_dri.so)
endif

endif

ifndef PTXCONF_MESALIB_DRIVER_OSMESA
	@$(call install_copy, mesalib, 0, 0, 0644, -, \
		 /usr/lib/libGL.so.$(MESALIB_GL_VERSION-y))
	@$(call install_link, mesalib, libGL.so.$(MESALIB_GL_VERSION-y), /usr/lib/libGL.so.1)
	@$(call install_link, mesalib, libGL.so.$(MESALIB_GL_VERSION-y), /usr/lib/libGL.so)
endif

	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/libGLU.so.1.3.070500, /usr/lib/libGLU.so.1.3.070500)
	@$(call install_link, mesalib, libGLU.so.1.3.070500, /usr/lib/libGLU.so.1)
	@$(call install_link, mesalib, libGLU.so.1.3.070500, /usr/lib/libGLU.so)

	@$(call install_copy, mesalib, 0, 0, 0644, $(MESALIB_DIR)/lib/libOSMesa.so.7.5.0, /usr/lib/libOSMesa.so.7.5.0)
	@$(call install_link, mesalib, libOSMesa.so.7.5.0, /usr/lib/libOSMesa.so.7)
	@$(call install_link, mesalib, libOSMesa.so.7.5.0, /usr/lib/libOSMesa.so)

	@$(call install_finish, mesalib)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mesalib_clean:
	rm -rf $(STATEDIR)/mesalib.*
	rm -rf $(PKGDIR)/mesalib_*
	rm -fr $(MESALIB_DIR)


# vim: syntax=make
