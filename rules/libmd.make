# -*-makefile-*-
#
# Copyright (C) 2009 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMD) += libmd

#
# Paths and names
#
LIBMD_VERSION	:= 0.3.1
LIBMD		:= libmd-$(LIBMD_VERSION)
LIBMD_SUFFIX	:= tar.gz
LIBMD_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(LIBMD).$(LIBMD_SUFFIX)
LIBMD_SOURCE	:= $(SRCDIR)/$(LIBMD).$(LIBMD_SUFFIX)
LIBMD_DIR	:= $(BUILDDIR)/$(LIBMD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBMD_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBMD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMD_PATH	:= PATH=$(CROSS_PATH)
LIBMD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBMD_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBMD_STATIC
LIBMD_AUTOCONF += --disable-shared
endif

ifdef PTXCONF_LIBMD_DEBUG
LIBMD_AUTOCONF += --enable-debug
endif

#ifdef PTXCONF_LIBMD_DOC
#LIBMD_AUTOCONF += --enable-doc
#endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmd.targetinstall:
	@$(call targetinfo)

ifndef PTXCONF_LIBMD_STATIC
	@$(call install_init, libmd)
	@$(call install_fixup, libmd,PRIORITY,optional)
	@$(call install_fixup, libmd,SECTION,base)
	@$(call install_fixup, libmd,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, libmd,DESCRIPTION,missing)

	@$(call install_lib, libmd, 0, 0, 0644, libmd)

	@$(call install_finish, libmd)
endif
	@$(call touch)

# vim: syntax=make
