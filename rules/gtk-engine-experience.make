# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GTK_ENGINE_EXPERIENCE) += gtk-engine-experience

#
# Paths and names
#
GTK_ENGINE_EXPERIENCE_VERSION	:= 0.10.5
GTK_ENGINE_EXPERIENCE		:= gtk-engine-experience-$(GTK_ENGINE_EXPERIENCE_VERSION)
GTK_ENGINE_EXPERIENCE_SUFFIX	:= tar.bz2
GTK_ENGINE_EXPERIENCE_URL	:= http://benjamin.sipsolutions.net/experience/$(GTK_ENGINE_EXPERIENCE).$(GTK_ENGINE_EXPERIENCE_SUFFIX)
GTK_ENGINE_EXPERIENCE_SOURCE	:= $(SRCDIR)/$(GTK_ENGINE_EXPERIENCE).$(GTK_ENGINE_EXPERIENCE_SUFFIX)
GTK_ENGINE_EXPERIENCE_DIR	:= $(BUILDDIR)/$(GTK_ENGINE_EXPERIENCE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GTK_ENGINE_EXPERIENCE_SOURCE):
	@$(call targetinfo)
	@$(call get, GTK_ENGINE_EXPERIENCE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GTK_ENGINE_EXPERIENCE_PATH	:= PATH=$(CROSS_PATH)
GTK_ENGINE_EXPERIENCE_ENV	:= $(CROSS_ENV)

#
# autoconf
#
GTK_ENGINE_EXPERIENCE_AUTOCONF	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-static

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk-engine-experience.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gtk-engine-experience)
	@$(call install_fixup, gtk-engine-experience,PACKAGE,gtk-engine-experience)
	@$(call install_fixup, gtk-engine-experience,PRIORITY,optional)
	@$(call install_fixup, gtk-engine-experience,VERSION,$(GTK_ENGINE_EXPERIENCE_VERSION))
	@$(call install_fixup, gtk-engine-experience,SECTION,base)
	@$(call install_fixup, gtk-engine-experience,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gtk-engine-experience,DEPENDS,)
	@$(call install_fixup, gtk-engine-experience,DESCRIPTION,missing)

	@$(call install_copy, gtk-engine-experience, 0, 0, 0644, \
		$(GTK_ENGINE_EXPERIENCE_PKGDIR)/usr/lib/gtk-2.0/2.10.0/engines/libexperience.so, \
		/usr/lib/gtk-2.0/engines/libexperience.so)

	@$(call install_finish, gtk-engine-experience)

	@$(call touch)

# vim: syntax=make
