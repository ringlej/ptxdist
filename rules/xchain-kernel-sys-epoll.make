# -*-makefile-*-
# $Id: xchain-kernel-sys-epoll.make,v 1.1 2003/10/31 22:48:51 mkl Exp $
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
ifdef PTXCONF_KERNEL_SYS-EPOLL
XCHAIN_KERNEL_PATCHES += xchain-kernel-sys-epoll
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-kernel-sys-epoll_get: $(STATEDIR)/xchain-kernel-sys-epoll.get

xchain-kernel-sys-epoll_get_deps = \
	$(STATEDIR)/kernel-sys-epoll.get

$(STATEDIR)/xchain-kernel-sys-epoll.get: $(xchain-kernel-sys-epoll_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-kernel-sys-epoll_install: $(STATEDIR)/xchain-kernel-sys-epoll.install

$(STATEDIR)/xchain-kernel-sys-epoll.install: $(STATEDIR)/xchain-kernel-sys-epoll.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_SYS-EPOLL_SOURCE), $(XCHAIN_KERNEL_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kernel-sys-epoll_clean:
	rm -rf $(STATEDIR)/xchain-kernel*

# vim: syntax=make
