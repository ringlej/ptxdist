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
HOST_PACKAGES-$(PTXCONF_HOST_LIBXCB) += host-libxcb

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBXCB_ENV	:= \
	$(HOST_ENV) \
	ac_cv_prog_BUILD_DOCS=no \
	ac_cv_lib_Xdmcp_XdmcpWrap=no

#
# autoconf
#
HOST_LIBXCB_CONF_TOOL	:= autoconf
HOST_LIBXCB_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-static \
	--disable-selective-werror \
	--disable-strict-compilation \
	--disable-devel-docs \
	--enable-composite \
	--enable-damage \
	--enable-dpms \
	--enable-dri2 \
	--enable-dri3 \
	--enable-ge \
	--enable-glx \
	--enable-present \
	--enable-randr \
	--enable-record \
	--enable-render \
	--enable-resource \
	--enable-screensaver \
	--enable-shape \
	--enable-shm \
	--enable-sync \
	--enable-xevie \
	--enable-xfixes \
	--enable-xfree86-dri \
	--enable-xinerama \
	--enable-xinput \
	--enable-xkb \
	--enable-xprint \
	--disable-selinux \
	--enable-xtest \
	--enable-xv \
	--enable-xvmc \
	--without-doxygen \
	--without-launchd

# vim: syntax=make
