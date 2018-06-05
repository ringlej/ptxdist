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
LIBOOP_VERSION	:= 1.0.1
LIBOOP_MD5	:= f2b3dff17355fd9a6e2229caca8993f0
LIBOOP		:= liboop-$(LIBOOP_VERSION)
LIBOOP_SUFFIX	:= tar.gz
LIBOOP_URL	:= http://ftp.lysator.liu.se/pub/liboop/$(LIBOOP).$(LIBOOP_SUFFIX)
LIBOOP_SOURCE	:= $(SRCDIR)/$(LIBOOP).$(LIBOOP_SUFFIX)
LIBOOP_DIR	:= $(BUILDDIR)/$(LIBOOP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

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
