# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-kernel-mtd_get: $(STATEDIR)/xchain-kernel-mtd.get

xchain-kernel-mtd_get_deps = \
	$(STATEDIR)/kernel-mtd.get

$(STATEDIR)/xchain-kernel-mtd.get: $(xchain-kernel-mtd_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-kernel-mtd_install: $(STATEDIR)/xchain-kernel-mtd.install

$(STATEDIR)/xchain-kernel-mtd.install: $(STATEDIR)/xchain-kernel-mtd.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_MTD_SOURCE), $(XCHAIN_KERNEL_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kernel-mtd_clean:
	rm -rf $(STATEDIR)/xchain-kernel*

# vim: syntax=make
