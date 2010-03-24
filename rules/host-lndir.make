# -*-makefile-*-
#
# Copyright (C) 2010 by Jon Ringle
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LNDIR) += host-lndir

#
# Paths and names
#
HOST_LNDIR_VERSION	:= 1.0.1
HOST_LNDIR		:= lndir-$(HOST_LNDIR_VERSION)
HOST_LNDIR_SUFFIX	:= tar.bz2
HOST_LNDIR_URL	:= http://ftp.x.org/pub/individual/util/$(HOST_LNDIR).$(HOST_LNDIR_SUFFIX)
HOST_LNDIR_SOURCE	:= $(SRCDIR)/$(HOST_LNDIR).$(HOST_LNDIR_SUFFIX)
HOST_LNDIR_DIR	:= $(HOST_BUILDDIR)/$(HOST_LNDIR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_LNDIR_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_LNDIR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LNDIR_CONF_TOOL	:= autoconf

# vim: syntax=make
