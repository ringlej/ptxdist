# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POWERTOP) += powertop

#
# Paths and names
#
POWERTOP_VERSION	:= 1.11
POWERTOP		:= powertop-$(POWERTOP_VERSION)
POWERTOP_SUFFIX		:= tar.gz
POWERTOP_URL		:= http://www.lesswatts.org/projects/powertop/download/$(POWERTOP).$(POWERTOP_SUFFIX)
POWERTOP_SOURCE		:= $(SRCDIR)/$(POWERTOP).$(POWERTOP_SUFFIX)
POWERTOP_DIR		:= $(BUILDDIR)/$(POWERTOP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(POWERTOP_SOURCE):
	@$(call targetinfo)
	@$(call get, POWERTOP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POWERTOP_PATH	:= PATH=$(CROSS_PATH)

POWERTOP_COMPILE_ENV 	:= $(CROSS_ENV)
POWERTOP_MAKEVARS	:= BINDIR=/usr/sbin

$(STATEDIR)/powertop.prepare:
	@$(call targetinfo)
ifdef PTXCONF_NCURSES_WIDE_CHAR
	sed -i -e "s/-lncurses[^ ]*/-lncursesw/g" "$(POWERTOP_DIR)/Makefile"
else
	sed -i -e "s/-lncurses[^ ]*/-lncurses/g" "$(POWERTOP_DIR)/Makefile"
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/powertop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, powertop)
	@$(call install_fixup, powertop,PRIORITY,optional)
	@$(call install_fixup, powertop,SECTION,base)
	@$(call install_fixup, powertop,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, powertop,DESCRIPTION,missing)

	@$(call install_copy, powertop, 0, 0, 0755, -, /usr/sbin/powertop)

	@$(call install_finish, powertop)

	@$(call touch)

# vim: syntax=make
