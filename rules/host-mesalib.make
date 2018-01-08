# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MESALIB) += host-mesalib

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MESALIB_CONF_ENV := \
	$(HOST_ENV) \
	ac_cv_prog_PYTHON2=$(PTXDIST_TOPDIR)/bin/python

HOST_MESALIB_BUILD_OOT	:= YES
HOST_MESALIB_CONF_TOOL	:= autoconf
HOST_MESALIB_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-static \
	--disable-shared \
	--disable-debug \
	--disable-mangling \
	--disable-texture-float \
	--disable-asm \
	--disable-selinux \
	--enable-opengl \
	--disable-gles1 \
	--disable-gles2 \
	--disable-dri \
	--disable-gallium-extra-hud \
	--disable-lmsensors \
	--disable-dri3 \
	--disable-glx \
	--disable-osmesa \
	--disable-gallium-osmesa \
	--disable-egl \
	--disable-xa \
	--disable-gbm \
	--disable-nine \
	--disable-xvmc \
	--disable-vdpau \
	--disable-va \
	--disable-omx-bellagio \
	--disable-opencl \
	--disable-opencl-icd \
	--disable-gallium-tests \
	--enable-shared-glapi \
	--disable-glx-read-only-text \
	--disable-driglx-direct \
	--disable-glx-tls \
	--disable-llvm-shared-libs \
	--disable-gallium-llvm \
	--disable-libglvnd \
	--with-gallium-drivers= \
	--with-dri-drivers= \
	--without-vulkan-drivers \
	--with-platforms=

$(STATEDIR)/host-mesalib.install:
	@$(call targetinfo)
	install -D -m755 $(HOST_MESALIB_DIR)-build/src/compiler/glsl_compiler $(HOST_MESALIB_PKGDIR)/bin/mesa/glsl_compiler
	@$(call touch)

# vim: syntax=make
