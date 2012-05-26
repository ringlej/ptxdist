# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GTK_DOC) += host-gtk-doc

#
# Paths and names
#
HOST_GTK_DOC_VERSION	:= 1.13
HOST_GTK_DOC_MD5	:= 27940d6cd5c9dcda8fc003043d8c299a
HOST_GTK_DOC		:= gtk-doc-$(HOST_GTK_DOC_VERSION)
HOST_GTK_DOC_SUFFIX	:= tar.bz2
HOST_GTK_DOC_URL	:= http://ftp.gnome.org/pub/GNOME/sources/gtk-doc/$(HOST_GTK_DOC_VERSION)/$(HOST_GTK_DOC).$(HOST_GTK_DOC_SUFFIX)
HOST_GTK_DOC_SOURCE	:= $(SRCDIR)/$(HOST_GTK_DOC).$(HOST_GTK_DOC_SUFFIX)
HOST_GTK_DOC_DIR	:= $(HOST_BUILDDIR)/$(HOST_GTK_DOC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_GTK_DOC_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_GTK_DOC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/host-gtk-doc.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-gtk-doc.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-gtk-doc.install:
	@$(call targetinfo)
	install -D "$(HOST_GTK_DOC_DIR)/gtk-doc.m4" "$(PTXDIST_SYSROOT_HOST)/share/aclocal"
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_GTK_DOC_CONF_TOOL	:= autoconf

# vim: syntax=make
