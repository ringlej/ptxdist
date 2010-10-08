# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
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
PACKAGES-$(PTXCONF_NICKEL) += nickel

#
# Paths and names
#
NICKEL_VERSION	:= 1.1.0
NICKEL_MD5	:= 5bcbf33d1457e6587c46ac3b0526523c
NICKEL		:= nickel-$(NICKEL_VERSION)
NICKEL_SUFFIX	:= tar.gz
NICKEL_URL	:= http://downloads.sourceforge.net/chaoslizard/$(NICKEL).$(NICKEL_SUFFIX)
NICKEL_SOURCE	:= $(SRCDIR)/$(NICKEL).$(NICKEL_SUFFIX)
NICKEL_DIR	:= $(BUILDDIR)/$(NICKEL)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

NICKEL_SUBDIR	:= src

NICKEL_MAKE_OPT := CC=$(CROSS_CC) LD=$(CROSS_CC)
NICKEL_INSTALL_OPT := prefix=/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nickel.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nickel)
	@$(call install_fixup, nickel,PRIORITY,optional)
	@$(call install_fixup, nickel,SECTION,base)
	@$(call install_fixup, nickel,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, nickel,DESCRIPTION,missing)

	@$(call install_lib, nickel, 0, 0, 0644, libnickel)

	@$(call install_finish, nickel)
	@$(call touch)

# vim: syntax=make
