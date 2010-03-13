# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBEZV24) += libezv24

#
# Paths and names
#
LIBEZV24_VERSION	:= 0.1.1-ptx2
LIBEZV24		:= libezv24-$(LIBEZV24_VERSION)
LIBEZV24_SUFFIX		:= tar.bz2
LIBEZV24_URL		:= http://www.pengutronix.de/software/misc/download/$(LIBEZV24).$(LIBEZV24_SUFFIX)
LIBEZV24_SOURCE		:= $(SRCDIR)/$(LIBEZV24).$(LIBEZV24_SUFFIX)
LIBEZV24_DIR		:= $(BUILDDIR)/$(LIBEZV24)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBEZV24_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBEZV24)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBEZV24_PATH	:= PATH=$(CROSS_PATH)
LIBEZV24_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBEZV24_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libezv24.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libezv24)
	@$(call install_fixup,libezv24,PACKAGE,libezv24)
	@$(call install_fixup,libezv24,PRIORITY,optional)
	@$(call install_fixup,libezv24,VERSION,$(LIBEZV24_VERSION))
	@$(call install_fixup,libezv24,SECTION,base)
	@$(call install_fixup,libezv24,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,libezv24,DEPENDS,)
	@$(call install_fixup,libezv24,DESCRIPTION,missing)

	@$(call install_copy, libezv24, 0, 0, 0644, -, \
		/usr/lib/libezV24.so.0.0.0)

	@$(call install_link, libezv24, \
		libezV24.so.0.0.0, /usr/lib/libezV24.so.0)

	@$(call install_link, libezv24, \
		libezV24.so.0.0.0, /usr/lib/libezV24.so)

	@$(call install_finish,libezv24)

	@$(call touch)

# vim: syntax=make
