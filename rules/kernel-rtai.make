# -*-makefile-*-
# $Id: kernel-rtai.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
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
ifdef PTXCONF_RTAI
KERNEL_PATCHES		+= rtai
endif

#
# Paths and names
#
KERNEL_RTAI_PATCH	= $(KERNEL_RTAI_DIR)/patches/patch-$(KERNEL_VERSION)-$(RTAI_TECH)
KERNEL_RTAI_SOURCE	= $(RTAI_SOURCE)
KERNEL_RTAI		= $(RTAI)
KERNEL_RTAI_DIR		= $(PATCHES_BUILDDIR)/$(KERNEL_RTAI)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel-rtai_get: $(STATEDIR)/kernel-rtai.get

$(STATEDIR)/kernel-rtai.get: $(KERNEL_RTAI_SOURCE)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

kernel-rtai_extract: $(STATEDIR)/kernel-rtai.extract

$(STATEDIR)/kernel-rtai.extract: $(STATEDIR)/kernel-rtai.get
	@$(call targetinfo, $@)
	@$(call clean, $(KERNEL_RTAI_DIR))
	@$(call extract, $(KERNEL_RTAI_SOURCE), $(PATCHES_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel-rtai_install: $(STATEDIR)/kernel-rtai.install

$(STATEDIR)/kernel-rtai.install: $(STATEDIR)/kernel-rtai.extract
	@$(call targetinfo, $@)
	@$(call patch_apply, $(KERNEL_RTAI_PATCH), $(KERNEL_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel-rtai_clean:
	rm -rf $(STATEDIR)/kernel*

# vim: syntax=make
