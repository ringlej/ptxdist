# -*-makefile-*-
#
# Copyright (C) 2009 by Jon Ringle <jon@ringle.org>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# This file contains global macro and environment definitions for klibc
#

# ----------------------------------------------------------------------------
# KLIBC stuff
# ----------------------------------------------------------------------------

KLIBC_PATH := $(CROSS_PATH)

KLIBC_CFLAGS	:= -I$(PTXDIST_SYSROOT_TARGET)/usr/lib/klibc/include
KLIBC_LDFLAGS	:= -L$(PTXDIST_SYSROOT_TARGET)/usr/lib/klibc/lib
KLIBC_ENV_CFLAGS	:= CFLAGS="$(KLIBC_CFLAGS)"
KLIBC_ENV_LDFLAGS	:= LDFLAGS="$(KLIBC_LDFLAGS)"

KLIBC_ENV_CC := CC=klcc
KLIBC_ENV_LD := LD=klcc


KLIBC_ENV_PROGS := \
	$(KLIBC_ENV_CC) \
	$(KLIBC_ENV_LD)

KLIBC_ARCH_ENV := KLIBCARCH=$(PTXCONF_ARCH_STRING)

KLIBC_ENV := \
	$(CROSS_ENV_PROGS) \
	$(KLIBC_ENV_PROGS) \
	$(KLIBC_ARCH_ENV) \
	$(KLIBC_ENV_CFLAGS) \
	$(KLIBC_ENV_LDFLAGS)

KLIBC_AUTOCONF_SYSROOT_ROOT := \
	--prefix=

KLIBC_AUTOCONF_ARCH := $(CROSS_AUTOCONF_ARCH)

KLIBC_AUTOCONF := $(KLIBC_AUTOCONF_SYSROOT_ROOT) $(KLIBC_AUTOCONF_ARCH)

KLIBC_CONTROL := $(STATEDIR)/initramfs_spec

# vim: syntax=make
