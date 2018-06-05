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
HOST_PACKAGES-$(PTXCONF_HOST_LIBELF) += host-libelf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBELF_CONF_TOOL	:= autoconf
HOST_LIBELF_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-deterministic-archives \
	--disable-thread-safety \
	--disable-debugpred \
	--disable-gprof \
	--disable-gcov \
	--disable-sanitize-undefined \
	--disable-valgrind \
	--disable-tests-rpath \
	--enable-libebl-subdir=elfutils \
	--enable-textrelcheck \
	--enable-symbol-versioning \
	--disable-nls \
	--with-zlib \
	--without-bzlib \
	--without-lzma \
	--without-biarch

ifdef PTXDIST_ICECC
HOST_LIBELF_CFLAGS := -C
endif


# vim: syntax=make
