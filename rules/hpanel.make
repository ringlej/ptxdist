# -*-makefile-*-
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
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
PACKAGES-$(PTXCONF_HPANEL) += hpanel

#
# Paths and names
#
HPANEL_VERSION	:= 0.3.2
HPANEL		:= hpanel-$(HPANEL_VERSION)
HPANEL_SUFFIX	:= tar.gz
HPANEL_URL	:= http://www.phrat.de/$(HPANEL).$(HPANEL_SUFFIX)
HPANEL_SOURCE	:= $(SRCDIR)/$(HPANEL).$(HPANEL_SUFFIX)
HPANEL_DIR	:= $(BUILDDIR)/$(HPANEL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HPANEL_SOURCE):
	@$(call targetinfo)
	@$(call get, HPANEL)

# hpanel has a very broken configure script. Don't use it!
HPANEL_CONF_TOOL := NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HPANEL_PATH	:= PATH=$(CROSS_PATH)
HPANEL_MAKE_ENV	:= $(CROSS_ENV)
# the archive contains the target binary. Remove it with the 'clean' target.
HPANEL_MAKE_OPT	:= clean hpanel
HPANEL_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hpanel.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hpanel)
	@$(call install_fixup,hpanel,PACKAGE,hpanel)
	@$(call install_fixup,hpanel,PRIORITY,optional)
	@$(call install_fixup,hpanel,VERSION,$(HPANEL_VERSION))
	@$(call install_fixup,hpanel,SECTION,base)
	@$(call install_fixup,hpanel,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,hpanel,DEPENDS,)
	@$(call install_fixup,hpanel,DESCRIPTION,missing)

	@$(call install_copy, hpanel, 0, 0, 0755, -, /usr/bin/hpanel)

	@$(call install_finish,hpanel)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hpanel_clean:
	rm -rf $(STATEDIR)/hpanel.*
	rm -rf $(PKGDIR)/hpanel_*
	rm -rf $(HPANEL_DIR)

# vim: syntax=make
