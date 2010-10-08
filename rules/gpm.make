# -*-makefile-*-
#
# Copyright (C) 2009 by Markus Rathgeb <rathgeb.markus@googlemail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_GPM) += gpm

#
# Paths and names
#
GPM_VERSION	:= 1.20.6
GPM_MD5		:= 6b534da16dc1b28ba828dea89e520f6f
GPM		:= gpm-$(GPM_VERSION)
GPM_SUFFIX	:= tar.bz2
GPM_URL		:= http://www.nico.schottelius.org/software/gpm/archives/$(GPM).$(GPM_SUFFIX)
GPM_SOURCE	:= $(SRCDIR)/$(GPM).$(GPM_SUFFIX)
GPM_DIR		:= $(BUILDDIR)/$(GPM)
GPM_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GPM_SOURCE):
	@$(call targetinfo)
	@$(call get, GPM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GPM_PATH     := PATH=$(CROSS_PATH)
GPM_ENV      := $(CROSS_ENV)

#
# autoconf
#
GPM_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gpm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gpm)
	@$(call install_fixup, gpm,PRIORITY,optional)
	@$(call install_fixup, gpm,SECTION,base)
	@$(call install_fixup, gpm,AUTHOR,"Markus Rathgeb <rathgeb.markus@googlemail.com>")
	@$(call install_fixup, gpm,DESCRIPTION,missing)

	@$(call install_lib, gpm, 0, 0, 0644, libgpm)
	@$(call install_copy, gpm, 0, 0, 0755, -, /usr/sbin/gpm)

	@$(call install_finish, gpm)

	@$(call touch)

# vim: syntax=make
