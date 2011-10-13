# -*-makefile-*-
#
# Copyright (C) 2007 by Roland Hostettler
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
PACKAGES-$(PTXCONF_FBGRAB) += fbgrab

#
# Paths and names
#
FBGRAB_VERSION	:= 1.0
FBGRAB_MD5	:= 7af4d8774684182ed690d5da82d6d234
FBGRAB		:= fbgrab-$(FBGRAB_VERSION)
FBGRAB_SUFFIX	:= tar.gz
FBGRAB_URL	:= http://hem.bredband.net/gmogmo/fbgrab/$(FBGRAB).$(FBGRAB_SUFFIX)
FBGRAB_SOURCE	:= $(SRCDIR)/$(FBGRAB).$(FBGRAB_SUFFIX)
FBGRAB_DIR	:= $(BUILDDIR)/$(FBGRAB)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------
# overwrite some vars in the makefile

FBGRAB_MAKE_ENV	:= $(CROSS_ENV)
FBGRAB_MAKE_OPT	= \
	$(CROSS_ENV_CC) \
	LDFLAGS='`$(CROSS_ENV) eval PATH=$(CROSS_PATH) $$PKG_CONFIG --libs libpng` $(CROSS_LDFLAGS)'

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fbgrab.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fbgrab)
	@$(call install_fixup, fbgrab,PRIORITY,optional)
	@$(call install_fixup, fbgrab,SECTION,base)
	@$(call install_fixup, fbgrab,AUTHOR,"Roland Hostettler <r.hostettler@gmx.ch>")
	@$(call install_fixup, fbgrab,DESCRIPTION,missing)

	@$(call install_copy, fbgrab, 0, 0, 0755, -, /usr/bin/fbgrab)

	@$(call install_finish, fbgrab)

	@$(call touch)

# vim: syntax=make
