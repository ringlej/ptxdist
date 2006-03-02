# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG <linux-development@auerswald.de>
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WYSTUP) += wystup

#
# Paths and names
#
WYSTUP_VERSION	= 0.0.1
WYSTUP		= wystup-$(WYSTUP_VERSION)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

wystup_targetinstall: $(STATEDIR)/wystup.targetinstall

$(STATEDIR)/wystup.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, wystup)
	@$(call install_fixup,wystup,PACKAGE,wystup)
	@$(call install_fixup,wystup,PRIORITY,optional)
	@$(call install_fixup,wystup,VERSION,$(WYSTUP_VERSION))
	@$(call install_fixup,wystup,SECTION,base)
	@$(call install_fixup,wystup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,wystup,DEPENDS,)
	@$(call install_fixup,wystup,DESCRIPTION,missing)

	@$(call install_copy, wystup, 0, 0, 0755, $(PTXDIST_WORKSPACE)/projectroot/boot/grub/menu.lst, /boot/grub/menu.lst)

	@$(call install_finish,wystup)

	@$(call touch, $@)
