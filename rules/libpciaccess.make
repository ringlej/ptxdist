# -*-makefile-*-
#
# Copyright (C) 2008 by Juergen Beisert <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPCIACCESS) += libpciaccess

#
# Paths and names
#
LIBPCIACCESS_VERSION	:= 0.11.0
LIBPCIACCESS		:= libpciaccess-$(LIBPCIACCESS_VERSION)
LIBPCIACCESS_SUFFIX	:= tar.bz2
LIBPCIACCESS_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(LIBPCIACCESS).$(LIBPCIACCESS_SUFFIX)
LIBPCIACCESS_SOURCE	:= $(SRCDIR)/$(LIBPCIACCESS).$(LIBPCIACCESS_SUFFIX)
LIBPCIACCESS_DIR	:= $(BUILDDIR)/$(LIBPCIACCESS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBPCIACCESS_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBPCIACCESS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPCIACCESS_PATH	:= PATH=$(CROSS_PATH)
LIBPCIACCESS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBPCIACCESS_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBPCIACCESS_STATIC
LIBPCIACCESS_AUTOCONF += --enable-shared=no
endif

ifdef PTXCONF_LIBPCIACCESS_MTRR
LIBPCIACCESS_ENV += ac_cv_file__usr_include_asm_mtrr_h=yes
else
LIBPCIACCESS_ENV += ac_cv_file__usr_include_asm_mtrr_h=no
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpciaccess.targetinstall:
	@$(call targetinfo)

ifndef PTXCONF_LIBPCIACCESS_STATIC
# only shared libraries are to be installed on the target
	@$(call install_init, libpciaccess)
	@$(call install_fixup, libpciaccess,PRIORITY,optional)
	@$(call install_fixup, libpciaccess,SECTION,base)
	@$(call install_fixup, libpciaccess,AUTHOR,"Juergen Beisert <j.beisert@pengutronix.de>")
	@$(call install_fixup, libpciaccess,DESCRIPTION,missing)

	@$(call install_copy, libpciaccess, 0, 0, 0644, -, \
		/usr/lib/libpciaccess.so.0.10.8)
	@$(call install_link, libpciaccess, libpciaccess.so.0.10.8, \
		/usr/lib/libpciaccess.so.0)
	@$(call install_link, libpciaccess, libpciaccess.so.0.10.8, \
		/usr/lib/libpciaccess.so)

	@$(call install_finish, libpciaccess)
endif

	@$(call touch)

# vim: syntax=make
