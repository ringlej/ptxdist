# -*-makefile-*-
#
# Copyright (C) 2003 by BSP
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
PACKAGES-$(PTXCONF_GTK2_ENGINES) += gtk2-engines

#
# Paths and names
#
GTK2_ENGINES_VERSION	:= 2.2.0
GTK2_ENGINES		:= gtk-engines-$(GTK2_ENGINES_VERSION)
GTK2_ENGINES_SUFFIX	:= tar.bz2
GTK2_ENGINES_URL	:= http://ftp.gnome.org/pub/GNOME/sources/gtk-engines/2.2/$(GTK2_ENGINES).$(GTK2_ENGINES_SUFFIX)
GTK2_ENGINES_SOURCE	:= $(SRCDIR)/$(GTK2_ENGINES).$(GTK2_ENGINES_SUFFIX)
GTK2_ENGINES_DIR	:= $(BUILDDIR)/$(GTK2_ENGINES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GTK2_ENGINES_SOURCE):
	@$(call targetinfo)
	@$(call get, GTK2_ENGINES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GTK2_ENGINES_PATH	:= PATH=$(CROSS_PATH)
GTK2_ENGINES_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GTK2_ENGINES_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk2-engines.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gtk2-engines)
	@$(call install_fixup, gtk2-engines,PACKAGE,gtk2-engines)
	@$(call install_fixup, gtk2-engines,PRIORITY,optional)
	@$(call install_fixup, gtk2-engines,VERSION,$(GTK2_ENGINES_VERSION))
	@$(call install_fixup, gtk2-engines,SECTION,base)
	@$(call install_fixup, gtk2-engines,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gtk2-engines,DEPENDS,)
	@$(call install_fixup, gtk2-engines,DESCRIPTION,missing)

	@$(call install_copy, gtk2-engines, 0, 0, 0644, -, \
		/usr/lib/gtk-2.0/2.10.0/engines/libmetal.so)
	@$(call install_copy, gtk2-engines, 0, 0, 0644, -, \
		/usr/lib/gtk-2.0/2.10.0/engines/libredmond95.so)
	@$(call install_copy, gtk2-engines, 0, 0, 0644, -, \
		/usr/lib/gtk-2.0/2.10.0/engines/libpixmap.so)

	@$(call install_finish, gtk2-engines)

	@$(call touch)

# vim: syntax=make
