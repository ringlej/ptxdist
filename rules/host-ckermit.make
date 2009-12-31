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
HOST_CKERMIT_DIR		= $(HOST_BUILDDIR)/$(CKERMIT)
HOST_CKERMIT_MAKE_OPT		:= linuxnc
HOST_CKERMIT_INSTALL_OPT	:= install prefix=

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ckermit.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_CKERMIT_DIR))
	mkdir -p $(HOST_CKERMIT_DIR)
	@$(call extract, CKERMIT, $(HOST_CKERMIT_DIR))
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
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ckermit.install:
	@$(call targetinfo)
	@$(call install, HOST_CKERMIT)
	@ln -sf kermit $(HOST_CKERMIT_PKGDIR)/bin/ckermit
	@$(call touch)

# vim: syntax=make
