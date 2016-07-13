# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBRSVG) += librsvg

#
# Paths and names
#
LIBRSVG_VERSION	:= 2.26.3
LIBRSVG_MD5	:= 8df68c2c02cdf2a96a92b43bf737bf9c
LIBRSVG		:= librsvg-$(LIBRSVG_VERSION)
LIBRSVG_SUFFIX	:= tar.bz2
LIBRSVG_URL	:= http://ftp.gnome.org/pub/GNOME/sources/librsvg/2.26/$(LIBRSVG).$(LIBRSVG_SUFFIX)
LIBRSVG_SOURCE	:= $(SRCDIR)/$(LIBRSVG).$(LIBRSVG_SUFFIX)
LIBRSVG_DIR	:= $(BUILDDIR)/$(LIBRSVG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBRSVG_PATH	:= PATH=$(CROSS_PATH)
LIBRSVG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBRSVG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-theme  \
	--$(call ptx/endis, PTXCONF_LIBRSVG_PIXBUF_LOADER)-pixbuf-loader \
	--disable-gtk-doc \
	--disable-tools \
	--$(call ptx/wwo, PTXCONF_LIBRSVG_SVGZ)-svgz \
	--$(call ptx/wwo, PTXCONF_LIBRSVG_CROCO)-croco \
	--without-x

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/librsvg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, librsvg)
	@$(call install_fixup, librsvg,PRIORITY,optional)
	@$(call install_fixup, librsvg,SECTION,base)
	@$(call install_fixup, librsvg,AUTHOR,"Erwin Rol")
	@$(call install_fixup, librsvg,DESCRIPTION,missing)

	@$(call install_lib, librsvg, 0, 0, 0644, librsvg-2)

	@$(call install_finish, librsvg)

	@$(call touch)

# vim: syntax=make
