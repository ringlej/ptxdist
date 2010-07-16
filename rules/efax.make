# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel <r.schwebel@pengutronix.de>
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
PACKAGES-$(PTXCONF_EFAX) += efax

#
# Paths and names
#
EFAX_VERSION	:= 0.9
EFAX		:= efax-$(EFAX_VERSION)
EFAX_SUFFIX	:= tar.gz
EFAX_URL	:= ftp://ftp.metalab.unc.edu/pub/Linux/apps/serialcomm/fax/$(EFAX).$(EFAX_SUFFIX)
EFAX_SOURCE	:= $(SRCDIR)/$(EFAX).$(EFAX_SUFFIX)
EFAX_DIR	:= $(BUILDDIR)/$(EFAX)
EFAX_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(EFAX_SOURCE):
	@$(call targetinfo)
	@$(call get, EFAX)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

EFAX_PATH	:= PATH=$(CROSS_PATH)
EFAX_MAKE_ENV	:= $(CROSS_ENV)
EFAX_MAKE_OPT	:= CC=$(CROSS_CC)

EFAX_INSTALL_OPT := \
	BINDIR=$(EFAX_PKGDIR)/usr/bin \
	MANDIR=$(EFAX_PKGDIR)/usr/man \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/efax.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  efax)
	@$(call install_fixup, efax,PRIORITY,optional)
	@$(call install_fixup, efax,SECTION,base)
	@$(call install_fixup, efax,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, efax,DESCRIPTION,missing)

	@$(call install_copy, efax, 0, 0, 0755, -, /usr/bin/efax)
	@$(call install_copy, efax, 0, 0, 0755, -, /usr/bin/efix)

	@$(call install_finish, efax)

	@$(call touch)

# vim: syntax=make
