# -*-makefile-*-
# $Id: kernel-ltt.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
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
ifdef PTXCONF_KERNEL_LTT
PATCHES			+= kernel-ltt
endif

#
# Paths and names
#
KERNEL-LTT_VERSION	= $(call get_option, \
	s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)_\(rmk[0-9]\)_\(pxa[0-9]\)_\(mtd[0-9]*\)_\(ptx[0-9]\)_\(ltt[0-9]\).*/\1.\2.\3-\4-\5-\7-\8/, ltt)
KERNEL-LTT		= linux-$(KERNEL-LTT_VERSION)
KERNEL-LTT_SUFFIX	= diff
KERNEL-LTT_URL		= http://www.pengutronix.de/software/ltt/$(KERNEL-LTT).$(KERNEL-LTT_SUFFIX)
KERNEL-LTT_SOURCE	= $(SRCDIR)/$(KERNEL-LTT).$(KERNEL-LTT_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-ltt_get: $(STATEDIR)/kernel-ltt.get

kernel-ltt_get_deps = \
	$(KERNEL-LTT_SOURCE)

$(STATEDIR)/kernel-ltt.get: $(kernel-ltt_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL-LTT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL-LTT_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-ltt_install: $(STATEDIR)/kernel-ltt.install

$(STATEDIR)/kernel-ltt.install: $(STATEDIR)/kernel-ltt.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL-LTT_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-ltt_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make
