# -*-makefile-*-
# $Id: kernel-uc.make,v 1.3 2003/10/28 11:12:24 mkl Exp $
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
# ifdef PTXCONF_KERNEL_UC
# KERNEL_PATCHES += kernel-uc
# endif

#
# Paths and names
#
KERNEL_UC_VERSION	= $(call get_option, \
	s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)_\(uc[0-9]\).*/\1.\2.\3-\4/, uc)
KERNEL_UC		= uClinux-$(KERNEL_UC_VERSION)
KERNEL_UC_SUFFIX	= diff.gz
KERNEL_UC_URL		= http://www.uclinux.org/pub/uClinux/uClinux-2.4.x/$(KERNEL_UC).$(KERNEL_UC_SUFFIX)
KERNEL_UC_SOURCE	= $(SRCDIR)/$(KERNEL_UC).$(KERNEL_UC_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-uc_get: $(STATEDIR)/kernel-uc.get

kernel-uc_get_deps = \
	$(KERNEL_UC_SOURCE)

$(STATEDIR)/kernel-uc.get: $(kernel-uc_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL_UC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL_UC_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-uc_install: $(STATEDIR)/kernel-uc.install

$(STATEDIR)/kernel-uc.install: $(STATEDIR)/kernel-uc.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_UC_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-uc_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make
