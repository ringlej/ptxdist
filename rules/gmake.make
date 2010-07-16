# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GMAKE) += gmake

#
# Paths and names
#
GMAKE_VERSION	:= 3.81
GMAKE		:= make-$(GMAKE_VERSION)
GMAKE_SUFFIX	:= tar.bz2
GMAKE_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/make/$(GMAKE).$(GMAKE_SUFFIX)
GMAKE_SOURCE	:= $(SRCDIR)/$(GMAKE).$(GMAKE_SUFFIX)
GMAKE_DIR	:= $(BUILDDIR)/$(GMAKE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GMAKE_SOURCE):
	@$(call targetinfo)
	@$(call get, GMAKE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GMAKE_PATH	:= PATH=$(CROSS_PATH)
GMAKE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GMAKE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath \
	--without-libintl-prefix

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gmake.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gmake)
	@$(call install_fixup, gmake,PRIORITY,optional)
	@$(call install_fixup, gmake,SECTION,base)
	@$(call install_fixup, gmake,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gmake,DESCRIPTION,missing)

	@$(call install_copy, gmake, 0, 0, 0755, -, /usr/bin/make)

	@$(call install_finish, gmake)

	@$(call touch)

# vim: syntax=make
