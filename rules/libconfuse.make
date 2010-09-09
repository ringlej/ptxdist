# -*-makefile-*-
#
# Copyright (C) 2008 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCONFUSE) += libconfuse

#
# Paths and names
#
LIBCONFUSE_VERSION	:= 2.6
LIBCONFUSE		:= confuse-$(LIBCONFUSE_VERSION)
LIBCONFUSE_SUFFIX	:= tar.gz
LIBCONFUSE_URL		:= http://bzero.se/confuse/$(LIBCONFUSE).$(LIBCONFUSE_SUFFIX)
LIBCONFUSE_SOURCE	:= $(SRCDIR)/$(LIBCONFUSE).$(LIBCONFUSE_SUFFIX)
LIBCONFUSE_DIR		:= $(BUILDDIR)/$(LIBCONFUSE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBCONFUSE_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBCONFUSE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCONFUSE_PATH	:= PATH=$(CROSS_PATH)
LIBCONFUSE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBCONFUSE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls

ifdef PTXCONF_LIBCONFUSE_STATIC
LIBCONFUSE_AUTOCONF += --enable-shared=no
else
LIBCONFUSE_AUTOCONF += --enable-shared
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libconfuse.targetinstall:
	@$(call targetinfo)

ifndef PTXCONF_LIBCONFUSE_STATIC
	@$(call install_init, libconfuse)
	@$(call install_fixup, libconfuse,PRIORITY,optional)
	@$(call install_fixup, libconfuse,SECTION,base)
	@$(call install_fixup, libconfuse,AUTHOR,"Juergen Beisert <juergen@kreuzholzen.de>")
	@$(call install_fixup, libconfuse,DESCRIPTION,missing)

	@$(call install_lib, libconfuse, 0, 0, 0644, libconfuse)

	@$(call install_finish, libconfuse)
endif
	@$(call touch)

# vim: syntax=make
