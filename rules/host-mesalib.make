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

HOST_MESALIB_DIR	= $(HOST_BUILDDIR)/Mesa-$(MESALIB_VERSION)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MESALIB_CONF_ENV := \
	$(HOST_ENV) \
	ac_cv_prog_PYTHON2=$(PTXDIST_TOPDIR)/bin/python

HOST_MESALIB_CONF_TOOL	:= autoconf
HOST_MESALIB_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-static \
	--enable-shared \
	--disable-debug \
	--disable-mangling \
	--disable-texture-float \
	--disable-asm \
	--disable-selinux \
	--enable-opengl \
	--disable-gles1 \
	--disable-gles2 \
	--disable-openvg \
	--disable-dri \
	--disable-glx \
	--disable-osmesa \
	--disable-gallium-osmesa \
	--disable-egl \
	--disable-xorg \
	--disable-xa \
	--disable-gbm \
	--disable-xvmc \
	--disable-vdpau \
	--disable-opencl \
	--disable-xlib-glx \
	--disable-gallium-egl \
	--disable-gallium-gbm \
	--disable-r600-llvm-compiler \
	--disable-gallium-tests \
	--disable-shared-glapi \
	--disable-driglx-direct \
	--disable-glx-tls \
	--disable-gallium-llvm \
	--with-gallium-drivers= \
	--with-dri-drivers= \
	--without-expat

$(STATEDIR)/host-mesalib.install:
	@$(call targetinfo)
	install -D -m755 $(HOST_MESALIB_DIR)/src/glsl/builtin_compiler/builtin_compiler $(HOST_MESALIB_PKGDIR)/bin/mesa/builtin_compiler
	@$(call touch)

# vim: syntax=make
