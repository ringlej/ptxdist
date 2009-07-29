# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FIGLET) += figlet

#
# Paths and names
#
FIGLET_VERSION		:= 222
FIGLET			:= figlet$(FIGLET_VERSION)
FIGLET_SUFFIX		:= tar.gz
FIGLET_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FIGLET).$(FIGLET_SUFFIX)
FIGLET_SOURCE		:= $(SRCDIR)/$(FIGLET).$(FIGLET_SUFFIX)
FIGLET_DIR		:= $(BUILDDIR)/$(FIGLET)
FIGLET_LICENSE		:= figlet

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FIGLET_SOURCE):
	@$(call targetinfo)
	@$(call get, FIGLET)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FIGLET_PATH	:=  PATH=$(CROSS_PATH)

FIGLET_COMPILE_ENV := $(CROSS_ENV)
FIGLET_MAKEVARS := prefix=/usr

$(STATEDIR)/figlet.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/figlet.targetinstall:
	@$(call targetinfo)

	@$(call install_init, figlet)
	@$(call install_fixup, figlet,PACKAGE,figlet)
	@$(call install_fixup, figlet,PRIORITY,optional)
	@$(call install_fixup, figlet,VERSION,$(FIGLET_VERSION))
	@$(call install_fixup, figlet,SECTION,base)
	@$(call install_fixup, figlet,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, figlet,DEPENDS,)
	@$(call install_fixup, figlet,DESCRIPTION,missing)

	@$(call install_copy, figlet, 0, 0, 0755, -, \
		/usr/bin/figlet)
	@$(call install_copy, figlet, 0, 0, 0644, $(FIGLET_DIR)/fonts/standard.flf, \
		/usr/share/figlet/standard.flf)

	@$(call install_finish, figlet)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

figlet_clean:
	rm -rf $(STATEDIR)/figlet.*
	rm -rf $(PKGDIR)/figlet_*
	rm -rf $(FIGLET_DIR)

# vim: syntax=make
