# -*-makefile-*-
# $Id: kernel-ltt.make,v 1.4 2003/10/28 11:12:24 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
# ifdef PTXCONF_KERNEL_LTT
# KERNEL_PATCHES += kernel-ltt
# endif

#
# Paths and names
#
KERNEL_LTT_VERSION	= $(call get_option, \
	s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)_\(rmk[0-9]\)_\(pxa[0-9]\)_\(mtd[0-9]*\)_\(ptx[0-9]*\)_\(ltt[0-9]\).*/\1.\2.\3-\4-\5-\7-\8/, ltt)
KERNEL_LTT		= linux-$(KERNEL_LTT_VERSION)
KERNEL_LTT_SUFFIX	= diff
KERNEL_LTT_URL		= http://www.pengutronix.de/software/ltt/$(KERNEL_LTT).$(KERNEL_LTT_SUFFIX)
KERNEL_LTT_SOURCE	= $(SRCDIR)/$(KERNEL_LTT).$(KERNEL_LTT_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-ltt_get: $(STATEDIR)/kernel-ltt.get

kernel-ltt_get_deps = \
	$(KERNEL_LTT_SOURCE)

$(STATEDIR)/kernel-ltt.get: $(kernel-ltt_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL_LTT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL_LTT_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-ltt_install: $(STATEDIR)/kernel-ltt.install

$(STATEDIR)/kernel-ltt.install: $(STATEDIR)/kernel-ltt.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_LTT_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-ltt_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make
