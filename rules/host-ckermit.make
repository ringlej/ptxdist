# -*-makefile-*-
#
# Copyright (C) 2008 by Wolfram Sang
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CKERMIT) += host-ckermit

#
# Paths and names
#
HOST_CKERMIT_DIR	= $(HOST_BUILDDIR)/$(CKERMIT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ckermit.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_CKERMIT_DIR))
	mkdir -p $(HOST_CKERMIT_DIR)
	@$(call extract, CKERMIT, $(HOST_BUILDDIR)/$(CKERMIT))
	@$(call patchin, CKERMIT, $(HOST_CKERMIT_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CKERMIT_PATH	:= PATH=$(HOST_PATH)
HOST_CKERMIT_ENV 	:= $(HOST_ENV)

$(STATEDIR)/host-ckermit.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ckermit.compile:
	@$(call targetinfo)
	cd $(HOST_CKERMIT_DIR) && \
		$(HOST_CKERMIT_PATH) $(MAKE) linuxnc $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ckermit.install:
	@$(call targetinfo)
	cp $(HOST_CKERMIT_DIR)/wermit $(PTXCONF_SYSROOT_HOST)/bin/ckermit
	@$(call touch)

# vim: syntax=make
