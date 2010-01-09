# -*-makefile-*-
#
# Copyright (C) 2005 by Christian Gagneraud <chgans@gna.org>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RAWREC) += rawrec

#
# Paths and names
#
RAWREC_VERSION		:= 0.9.98
RAWREC			:= rawrec-$(RAWREC_VERSION)
RAWREC_SUFFIX		:= tar.gz
RAWREC_URL		:= $(PTXCONF_SETUP_SFMIRROR)/rawrec/$(RAWREC).$(RAWREC_SUFFIX)
RAWREC_SOURCE		:= $(SRCDIR)/$(RAWREC).$(RAWREC_SUFFIX)
RAWREC_DIR		:= $(BUILDDIR)/$(RAWREC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(RAWREC_SOURCE):
	@$(call targetinfo)
	@$(call get, RAWREC)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

RAWREC_PATH	:= PATH=$(CROSS_PATH)
RAWREC_MAKE_ENV	:= $(CROSS_ENV)
RAWREC_MAKE_OPT	:= CC=$(CROSS_CC)
RAWREC_SUBDIR	:= src

RAWREC_INSTALL_OPT	:= EXE_DIR=$(RAWREC_PKGDIR)/usr/bin bin_install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rawrec.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rawrec)
	@$(call install_fixup, rawrec,PACKAGE,rawrec)
	@$(call install_fixup, rawrec,PRIORITY,optional)
	@$(call install_fixup, rawrec,VERSION,$(RAWREC_VERSION))
	@$(call install_fixup, rawrec,SECTION,base)
	@$(call install_fixup, rawrec,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, rawrec,DEPENDS,)
	@$(call install_fixup, rawrec,DESCRIPTION,missing)

	@$(call install_copy, rawrec, 0, 0, 0755, -, /usr/bin/rawrec)
	@$(call install_link, rawrec, rawrec, /usr/bin/rawplay)

	@$(call install_finish, rawrec)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rawrec_clean:
	rm -rf $(STATEDIR)/rawrec.*
	rm -rf $(PKGDIR)/rawrec_*
	rm -rf $(RAWREC_DIR)

# vim: syntax=make
