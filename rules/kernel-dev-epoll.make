# -*-makefile-*-
# $Id: kernel-dev-epoll.make,v 1.1 2003/10/31 22:48:51 mkl Exp $
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
ifdef PTXCONF_KERNEL_DEV-EPOLL
KERNEL_PATCHES += kernel-dev-epoll
endif

#
# Paths and names
#
KERNEL_DEV-EPOLL_VERSION	= 2.4.18-0.32
KERNEL_DEV-EPOLL		= ep_patch-$(KERNEL_DEV-EPOLL_VERSION)
KERNEL_DEV-EPOLL_SUFFIX		= diff
KERNEL_DEV-EPOLL_URL		= http://www.xmailserver.org/linux-patches/$(KERNEL_DEV-EPOLL).$(KERNEL_DEV-EPOLL_SUFFIX)
KERNEL_DEV-EPOLL_SOURCE		= $(SRCDIR)/$(KERNEL_DEV-EPOLL).$(KERNEL_DEV-EPOLL_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-dev-epoll_get: $(STATEDIR)/kernel-dev-epoll.get

kernel-dev-epoll_get_deps = \
	$(KERNEL_DEV-EPOLL_SOURCE)

$(STATEDIR)/kernel-dev-epoll.get: $(kernel-dev-epoll_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL_DEV-EPOLL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL_DEV-EPOLL_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-dev-epoll_install: $(STATEDIR)/kernel-dev-epoll.install

$(STATEDIR)/kernel-dev-epoll.install: $(STATEDIR)/kernel-dev-epoll.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_DEV-EPOLL_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-dev-epoll_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make