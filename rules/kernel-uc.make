# -*-makefile-*-
# $Id: kernel-uc.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
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
ifdef PTXCONF_KERNEL_UC
PATCHES			+= kernel-uc
endif

#
# Paths and names
#
KERNEL-UC_VERSION	= $(call get_option, \
	s/^PTXCONF_KERNEL_\([0-9]\)_\([0-9]\)_\([0-9]*\)_\(uc[0-9]\).*/\1.\2.\3-\4/, uc)
KERNEL-UC		= uClinux-$(KERNEL-UC_VERSION)
KERNEL-UC_SUFFIX	= diff.gz
KERNEL-UC_URL		= http://www.uclinux.org/pub/uClinux/uClinux-2.4.x/$(KERNEL-UC).$(KERNEL-UC_SUFFIX)
KERNEL-UC_SOURCE	= $(SRCDIR)/$(KERNEL-UC).$(KERNEL-UC_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-uc_get: $(STATEDIR)/kernel-uc.get

kernel-uc_get_deps = \
	$(KERNEL-UC_SOURCE)

$(STATEDIR)/kernel-uc.get: $(kernel-uc_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL-UC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL-UC_URL))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-uc_install: $(STATEDIR)/kernel-uc.install

$(STATEDIR)/kernel-uc.install: $(STATEDIR)/kernel-uc.get
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL-UC_SOURCE), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-uc_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make
