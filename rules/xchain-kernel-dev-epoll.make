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
# ifdef PTXCONF_KERNEL_DEV-EPOLL
# XCHAIN_KERNEL_PATCHES += xchain-kernel-dev-epoll
# endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-kernel-dev-epoll_get: $(STATEDIR)/xchain-kernel-dev-epoll.get

xchain-kernel-dev-epoll_get_deps = \
	$(STATEDIR)/kernel-dev-epoll.get

$(STATEDIR)/xchain-kernel-dev-epoll.get: $(xchain-kernel-dev-epoll_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-kernel-dev-epoll_install: $(STATEDIR)/xchain-kernel-dev-epoll.install

$(STATEDIR)/xchain-kernel-dev-epoll.install: $(STATEDIR)/xchain-kernel-dev-epoll.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_DEV-EPOLL_SOURCE), $(XCHAIN_KERNEL_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kernel-dev-epoll_clean:
	rm -rf $(STATEDIR)/xchain-kernel*

# vim: syntax=make
