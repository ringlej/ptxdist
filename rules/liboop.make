# -*-makefile-*-
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBOOP) += liboop

#
# Paths and names
#
LIBOOP_VERSION	:= 1.0
LIBOOP_MD5	:= 88fc8decf99fd75d2af40e0a005fa0d3
LIBOOP		:= liboop-$(LIBOOP_VERSION)
LIBOOP_SUFFIX	:= tar.bz2
LIBOOP_URL	:= http://download.ofb.net/liboop/$(LIBOOP).$(LIBOOP_SUFFIX)
LIBOOP_SOURCE	:= $(SRCDIR)/$(LIBOOP).$(LIBOOP_SUFFIX)
LIBOOP_DIR	:= $(BUILDDIR)/$(LIBOOP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBOOP_PATH	:= PATH=$(CROSS_PATH)
LIBOOP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBOOP_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--enable-static \
	--without-adns \
	--without-readline \
	--without-glib \
	--without-tcl \
	--without-libwww

LIBOOP_MAKE_PAR := NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/liboop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, liboop)
	@$(call install_fixup, liboop,PRIORITY,optional)
	@$(call install_fixup, liboop,SECTION,base)
	@$(call install_fixup, liboop,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, liboop,DESCRIPTION,missing)

	@$(call install_lib, liboop, 0, 0, 0644, liboop)

	@$(call install_finish, liboop)

	@$(call touch)

# vim: syntax=make
