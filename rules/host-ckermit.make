# -*-makefile-*-
# $Id$
#
# Copyright (C) 2008 by Robert Schwebel
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
HOST_CKERMIT_VERSION	:= 211
HOST_CKERMIT		:= cku$(HOST_CKERMIT_VERSION)
HOST_CKERMIT_SUFFIX	:= tar.gz
# Upstream host does connect but not respond to commands :( (ftp://kermit.columbia.edu/kermit/archives/)
HOST_CKERMIT_URL	:= ftp://ftp.tu-clausthal.de/pub/linux/gentoo/distfiles/$(HOST_CKERMIT).$(HOST_CKERMIT_SUFFIX)
HOST_CKERMIT_SOURCE	:= $(SRCDIR)/$(HOST_CKERMIT).$(HOST_CKERMIT_SUFFIX)
HOST_CKERMIT_DIR	:= $(HOST_BUILDDIR)/$(HOST_CKERMIT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_CKERMIT_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_CKERMIT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ckermit.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_CKERMIT_DIR))
	mkdir -p $(HOST_CKERMIT_DIR)
	@$(call extract, HOST_CKERMIT, $(HOST_BUILDDIR)/$(HOST_CKERMIT))
	@$(call patchin, HOST_CKERMIT, $(HOST_CKERMIT_DIR))
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

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-ckermit_clean:
	rm -rf $(STATEDIR)/host-ckermit.*
	rm -rf $(HOST_CKERMIT_DIR)

# vim: syntax=make
