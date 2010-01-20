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
LMBENCH		:= lmbench-$(LMBENCH_VERSION)
LMBENCH_SUFFIX	:= tgz
LMBENCH_URL	:= $(PTXCONF_SETUP_SFMIRROR)/lmbench/$(LMBENCH).$(LMBENCH_SUFFIX)
LMBENCH_SOURCE	:= $(SRCDIR)/$(LMBENCH).$(LMBENCH_SUFFIX)
LMBENCH_DIR	:= $(BUILDDIR)/$(LMBENCH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LMBENCH_SOURCE):
	@$(call targetinfo)
	@$(call get, LMBENCH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LMBENCH_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug

$(STATEDIR)/lmbench.prepare:
	@$(call targetinfo)
	@$(call clean, $(LMBENCH_DIR)/config.cache)
	chmod +x $(LMBENCH_DIR)/configure
	cd $(LMBENCH_DIR) && \
		$(LMBENCH_PATH) $(LMBENCH_ENV) \
		./configure $(LMBENCH_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lmbench.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lmbench)
	@$(call install_fixup, lmbench,PACKAGE,lmbench)
	@$(call install_fixup, lmbench,PRIORITY,optional)
	@$(call install_fixup, lmbench,VERSION,$(LMBENCH_VERSION))
	@$(call install_fixup, lmbench,SECTION,base)
	@$(call install_fixup, lmbench,AUTHOR,"Robert Schwebel")
	@$(call install_fixup, lmbench,DEPENDS,)
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

	@$(call install_copy, lmbench, 0, 0, 0644, -, /usr/lib/liblmbench.so.0.0.0)
	@$(call install_link, lmbench, liblmbench.so.0.0.0, /usr/lib/liblmbench.so.0)
	@$(call install_link, lmbench, liblmbench.so.0.0.0, /usr/lib/liblmbench.so)

	@$(call install_finish, lmbench)

	@$(call touch)

# vim: syntax=make
