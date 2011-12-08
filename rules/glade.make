# -*-makefile-*-
#
# Copyright (C) 2007, 2009 by Marc Kleine-Buddde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLADE) += glade

#
# Paths and names
#
GLADE_VERSION	:= 3.10.2
GLADE_MD5	:= ca6cc56c3de0b46488ae422d93a36d79
GLADE		:= glade-$(GLADE_VERSION)
GLADE_SUFFIX	:= tar.bz2
GLADE_URL	:= http://ftp.gnome.org/pub/GNOME/sources/glade/3.10/$(GLADE).$(GLADE_SUFFIX)
GLADE_SOURCE	:= $(SRCDIR)/$(GLADE).$(GLADE_SUFFIX)
GLADE_DIR	:= $(BUILDDIR)/$(GLADE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GLADE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-introspection \
	--disable-scrollkeeper \
	--disable-python

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glade.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glade)
	@$(call install_fixup, glade,PRIORITY,optional)
	@$(call install_fixup, glade,SECTION,base)
	@$(call install_fixup, glade,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, glade,DESCRIPTION,missing)

	@$(call install_copy, glade, 0, 0, 0755, -, /usr/bin/glade)
	@$(call install_lib, glade, 0, 0, 0644, libgladeui-2)
	@$(call install_tree, glade, 0, 0, -, /usr/share/glade)

	@$(call install_finish, glade)

	@$(call touch)

# vim: syntax=make
