# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LMBENCH) += lmbench

#
# Paths and names
#
LMBENCH_VERSION	:= 3.0-a9
LMBENCH_MD5	:= b3351a3294db66a72e2864a199d37cbf
LMBENCH		:= lmbench-$(LMBENCH_VERSION)
LMBENCH_SUFFIX	:= tgz
LMBENCH_URL	:= $(call ptx/mirror, SF, lmbench/$(LMBENCH).$(LMBENCH_SUFFIX))
LMBENCH_SOURCE	:= $(SRCDIR)/$(LMBENCH).$(LMBENCH_SUFFIX)
LMBENCH_DIR	:= $(BUILDDIR)/$(LMBENCH)
LMBENCH_LICENSE	:= GPL-2.0-only with exceptions
LMBENCH_LICENSE_FILES := \
	file://COPYING;md5=8ca43cbc842c2336e835926c2166c28b \
	file://COPYING-2;md5=8e9aee2ccc75d61d107e43794a25cdf9

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LMBENCH_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lmbench.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lmbench)
	@$(call install_fixup, lmbench,PRIORITY,optional)
	@$(call install_fixup, lmbench,SECTION,base)
	@$(call install_fixup, lmbench,AUTHOR,"Robert Schwebel")
	@$(call install_fixup, lmbench,DESCRIPTION,missing)

	for file in \
		/usr/bin/par_mem \
		/usr/bin/lat_tcp \
		/usr/bin/par_ops \
		/usr/bin/lat_mmap \
		/usr/bin/hello \
		/usr/bin/bw_unix \
		/usr/bin/lat_syscall \
		/usr/bin/lat_sem \
		/usr/bin/lat_fs \
		/usr/bin/loop_o \
		/usr/bin/lat_fcntl \
		/usr/bin/lat_unix \
		/usr/bin/bw_tcp \
		/usr/bin/lat_rpc \
		/usr/bin/lat_unix_connect \
		/usr/bin/bw_file_rd \
		/usr/bin/disk \
		/usr/bin/lat_mem_rd \
		/usr/bin/lat_select \
		/usr/bin/lat_connect \
		/usr/bin/lat_fifo \
		/usr/bin/line \
		/usr/bin/timing_o \
		/usr/bin/lat_ctx \
		/usr/bin/bw_mem \
		/usr/bin/lat_sig \
		/usr/bin/lat_pipe \
		/usr/bin/lat_pagefault \
		/usr/bin/lmhttp \
		/usr/bin/tlb \
		/usr/bin/bw_pipe \
		/usr/bin/mhz \
		/usr/bin/lat_http \
		/usr/bin/msleep \
		/usr/bin/lat_ops \
		/usr/bin/lat_udp \
		/usr/bin/stream \
		/usr/bin/enough \
		/usr/bin/flushdisk \
		/usr/bin/lmdd \
		/usr/bin/lat_proc \
		/usr/bin/bw_mmap_rd \
		/usr/bin/memsize \
	; do \
		$(call install_copy, lmbench, 0, 0, 0755, -, $$file); \
	done

	@$(call install_lib, lmbench, 0, 0, 0644, liblmbench)

	@$(call install_finish, lmbench)

	@$(call touch)

# vim: syntax=make
