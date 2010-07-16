# -*-makefile-*-
#
# Copyright (C) 2007-2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_VICE) += vice

#
# Paths and names
#
VICE_VERSION	:= 1.22
VICE		:= vice-$(VICE_VERSION)
VICE_SUFFIX	:= tar.gz
VICE_URL	:= http://www.viceteam.org/online/$(VICE).$(VICE_SUFFIX)
VICE_SOURCE	:= $(SRCDIR)/$(VICE).$(VICE_SUFFIX)
VICE_DIR	:= $(BUILDDIR)/$(VICE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(VICE_SOURCE):
	@$(call targetinfo)
	@$(call get, VICE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VICE_PATH	:= PATH=$(CROSS_PATH)
VICE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
VICE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	\
	--with-sdl \
	--disable-gnomeui \
	--disable-nls \
	--disable-realdevice \
	--disable-ffmpeg \
	--disable-ethernet \
	--disable-ipv6 \
	--disable-parsid \
	--disable-bundle \
	\
	--without-readline \
	--without-arts \
	--without-esd \
	--with-alsa \
	--without-oss \
	--with-resid \
	--without-png \
	--without-zlib \
	--without-picasso96 \
	--without-cocoa	\
	\
	--enable-fullscreen \
	--without-xaw3d \
	--without-x

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/vice.targetinstall:
	@$(call targetinfo)

	@$(call install_init, vice)
	@$(call install_fixup, vice,PRIORITY,optional)
	@$(call install_fixup, vice,SECTION,base)
	@$(call install_fixup, vice,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, vice,DESCRIPTION,missing)

#	@$(call install_copy, vice, 0, 0, 0755, $(VICE_DIR)/foobar, /dev/null)

	@$(call install_finish, vice)

	@$(call touch)

# vim: syntax=make
