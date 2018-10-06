# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SHARED_GDB_MD5		:= $(call remove_quotes,$(PTXCONF_GDB_MD5))

ifdef PTXCONF_GDB_TOOLCHAIN_VERSION
TOOLCHAIN_CONFIG	:= $(PTXDIST_PLATFORMDIR)/selected_toolchain/ptxconfig
ifneq ($(wildcard $(TOOLCHAIN_CONFIG)),)
SHARED_GDB_VERSION	:= $(call remove_quotes,$(shell ptxd_get_kconfig $(TOOLCHAIN_CONFIG) PTXCONF_CROSS_GDB_VERSION))
ifeq ($(SHARED_GDB_MD5),)
SHARED_GDB_MD5		:= $(call remove_quotes,$(shell ptxd_get_kconfig $(TOOLCHAIN_CONFIG) PTXCONF_CROSS_GDB_MD5))
endif
else
SHARED_GDB_VERSION	:= $(shell $(PTXCONF_COMPILER_PREFIX)gdb -v | sed -e 's/.* //;q')
endif
else
SHARED_GDB_VERSION	:= $(call remove_quotes,$(PTXCONF_GDB_VERSION))
endif

# vim: syntax=make
