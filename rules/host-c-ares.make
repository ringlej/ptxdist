# -*-makefile-*-
#
# Copyright (C) 2018 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_C_ARES) += host-c-ares

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_C_ARES_CONF_TOOL	:= autoconf
HOST_C_ARES_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-debug \
	--enable-optimize \
	--enable-warnings \
	--disable-werror \
	--disable-curldebug \
	--enable-symbol-hiding \
	--disable-expose-statics \
	--disable-code-coverage \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-libgcc \
	--enable-nonblocking \
	--disable-tests \
	--with-random=/dev/urandom

# vim: syntax=make
