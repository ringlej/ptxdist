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
	--disable-pwr8 \
	--disable-debug \
	--disable-profile \
	--disable-sanitize \
	--disable-asm \
	--disable-selinux \
	--disable-llvm-shared-libs \
	--disable-libunwind \
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
	--disable-omx-tizonia \
	--disable-omx-bellagio \
	--disable-va \
	--disable-opencl \
	--disable-opencl-icd \
	--disable-gallium-tests \
	--disable-libglvnd \
	--disable-mangling \
	--enable-shared-glapi \
	--disable-driglx-direct \
	--disable-glx-tls \
	--disable-llvm-shared-libs \
	--disable-glx-read-only-text \
	--disable-xlib-lease \
	--disable-llvm \
	--disable-valgrind \
	--with-gallium-drivers= \
	--with-dri-drivers= \
	--without-vulkan-drivers \
	--with-platforms=

$(STATEDIR)/host-mesalib.install:
	@$(call targetinfo)
	install -D -m755 $(HOST_MESALIB_DIR)-build/src/compiler/glsl_compiler $(HOST_MESALIB_PKGDIR)/bin/mesa/glsl_compiler
	@$(call touch)

# vim: syntax=make
