# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Ixia Corporation, by Milan Bobde
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
# ifdef PTXCONF_KERNEL_SYS-EPOLL
# KERNEL_PATCHES += kernel-sys-epoll
# endif

#
# Paths and names
#
ifeq ($(KERNEL_VERSION),2.4.20)
KERNEL_SYS-EPOLL_VERSION	= 2.4.20-0.61
KERNEL_SYS-EPOLL		= sys_epoll-$(KERNEL_SYS-EPOLL_VERSION)
endif

ifeq ($(KERNEL_VERSION),2.4.21)
KERNEL_SYS-EPOLL_VERSION	= 2.4.21-0.18
KERNEL_SYS-EPOLL		= epoll-lt-$(KERNEL_SYS-EPOLL_VERSION)
endif

KERNEL_SYS-EPOLL_SUFFIX		= diff
KERNEL_SYS-EPOLL_URL		= http://www.xmailserver.org/linux-patches/$(KERNEL_SYS-EPOLL).$(KERNEL_SYS-EPOLL_SUFFIX)
KERNEL_SYS-EPOLL_SOURCE		= $(SRCDIR)/$(KERNEL_SYS-EPOLL).$(KERNEL_SYS-EPOLL_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-sys-epoll_get: $(STATEDIR)/kernel-sys-epoll.get

kernel-sys-epoll_get_deps = \
	$(KERNEL_SYS-EPOLL_SOURCE)

$(STATEDIR)/kernel-sys-epoll.get: $(kernel-sys-epoll_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL_SYS-EPOLL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL_SYS-EPOLL_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-sys-epoll_install: $(STATEDIR)/kernel-sys-epoll.install

$(STATEDIR)/kernel-sys-epoll.install: $(STATEDIR)/kernel-sys-epoll.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_SYS-EPOLL_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-sys-epoll_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make
