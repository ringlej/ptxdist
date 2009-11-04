# -*-makefile-*-
#
# Copyright (C) 2003, 2009 by Marc Kleine-Budde <kleine-budde@gmx.de>
#           (C) 2008 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

KERNEL_VERSION		:= $(call remove_quotes,$(PTXCONF_KERNEL_VERSION))
_version_temp		:= $(subst ., ,$(KERNEL_VERSION))
KERNEL_VERSION_MAJOR	:= $(word 1,$(_version_temp))
KERNEL_VERSION_MINOR	:= $(word 2,$(_version_temp))
_version_temp		:=

KERNEL_HEADERS_DIR	:= $(PTXDIST_SYSROOT_TARGET)/kernel-headers
KERNEL_HEADERS_INCLUDE_DIR := $(KERNEL_HEADERS_DIR)/include

# vim: syntax=make
