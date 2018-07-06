# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_NSPR) += host-nspr

HOST_NSPR_SUBDIR	:= nspr

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_NSPR_CONF_TOOL	:= autoconf
# Note: the default is 32bit even on 64bit systems
HOST_NSPR_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-optimize=-O2 \
	--disable-debug \
	--disable-debug-symbols \
	--enable-64bit \
	--disable-mdupdate \
	--disable-cplus \
	--disable-strip \
	--disable-wrap-malloc \
	--without-mozilla \
	--with-thumb=toolchain-default \
	--with-thumb-interwork=toolchain-default \
	--with-arch=toolchain-default \
	--with-fpu=toolchain-default \
	--with-float-abi=toolchain-default \
	--with-soft-float=toolchain-default

# vim: syntax=make
