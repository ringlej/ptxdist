# -*-makefile-*-
#
# Copyright (C) 2003 by BSP
#           (C) 2010,2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GTK_ENGINES) += gtk-engines

#
# Paths and names
#
GTK_ENGINES_VERSION	:= 2.91.1
GTK_ENGINES_MD5		:= 290d2fdb66743066dab92db694dd7b99
GTK_ENGINES		:= gtk-engines-$(GTK_ENGINES_VERSION)
GTK_ENGINES_SUFFIX	:= tar.bz2
GTK_ENGINES_URL		:= http://ftp.gnome.org/pub/GNOME/sources/gtk-engines/2.91/$(GTK_ENGINES).$(GTK_ENGINES_SUFFIX)
GTK_ENGINES_SOURCE	:= $(SRCDIR)/$(GTK_ENGINES).$(GTK_ENGINES_SUFFIX)
GTK_ENGINES_DIR		:= $(BUILDDIR)/$(GTK_ENGINES)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GTK_ENGINES_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-schemas

GTK_ENGINES_ENGINES := \
	clearlooks \
	crux-engine \
	glide \
	hcengine \
	industrial \
	mist \
	redmond95 \
	thinice

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk-engines.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gtk-engines)
	@$(call install_fixup, gtk-engines,PRIORITY,optional)
	@$(call install_fixup, gtk-engines,SECTION,base)
	@$(call install_fixup, gtk-engines,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gtk-engines,DESCRIPTION,missing)

	@$(foreach engine,$(GTK_ENGINES_ENGINES), \
		$(call install_lib, gtk-engines, 0, 0, 0644, \
			gtk-3.0/3.0.0/engines/lib$(engine));)

	@$(call install_tree, gtk-engines, 0, 0, \
		/usr/share/themes)

	@$(call install_finish, gtk-engines)

	@$(call touch)

# vim: syntax=make
