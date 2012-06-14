# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBDBUS_CXX) += libdbus-cxx

#
# Paths and names
#
LIBDBUS_CXX_VERSION	:= r9139
LIBDBUS_CXX_MD5		:=
LIBDBUS_CXX		:= libdbus-c++-$(LIBDBUS_CXX_VERSION)
LIBDBUS_CXX_SUFFIX	:= tar.gz
LIBDBUS_CXX_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(LIBDBUS_CXX).$(LIBDBUS_CXX_SUFFIX)
LIBDBUS_CXX_SOURCE	:= $(SRCDIR)/$(LIBDBUS_CXX).$(LIBDBUS_CXX_SUFFIX)
LIBDBUS_CXX_DIR		:= $(BUILDDIR)/$(LIBDBUS_CXX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBDBUS_CXX_PATH := \
	PATH=$(CROSS_PATH)

LIBDBUS_CXX_ENV	:= \
	$(CROSS_ENV) \
	CXX_FOR_BUILD=$(HOSTCXX)

#
# autoconf
#
LIBDBUS_CXX_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--with-build-libdbus-cxx=$(HOST_LIBDBUS_CXX_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libdbus-cxx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libdbus-cxx)
	@$(call install_fixup, libdbus-cxx,PRIORITY,optional)
	@$(call install_fixup, libdbus-cxx,SECTION,base)
	@$(call install_fixup, libdbus-cxx,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libdbus-cxx,DESCRIPTION,missing)

	@$(call install_lib, libdbus-cxx, 0, 0, 0755, libdbus-c++-1)

	@$(call install_finish, libdbus-cxx)

	@$(call touch)

# vim: syntax=make
