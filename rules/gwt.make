# -*-makefile-*-
#
# Copyright (C) 2007 by Luotao Fu <l.fu@pengutronix.de>
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
PACKAGES-$(PTXCONF_GWT) += gwt

#
# Paths and names
#
GWT_VERSION	:= 1.0.1
GWT		:= gwt-$(GWT_VERSION)
GWT_SUFFIX	:= tar.bz2
GWT_URL		:= http://www.pengutronix.de/software/gwt/download/$(GWT).$(GWT_SUFFIX)
GWT_SOURCE	:= $(SRCDIR)/$(GWT).$(GWT_SUFFIX)
GWT_DIR		:= $(BUILDDIR)/$(GWT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GWT_SOURCE):
	@$(call targetinfo)
	@$(call get, GWT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GWT_PATH	:= PATH=$(CROSS_PATH)
GWT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GWT_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_GWT_GWTMM
GWT_AUTOCONF += --enable-gtkmm-bindings
else
GWT_AUTOCONF += --disable-gtkmm-bindings
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gwt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gwt)
	@$(call install_fixup, gwt,PRIORITY,optional)
	@$(call install_fixup, gwt,SECTION,base)
	@$(call install_fixup, gwt,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gwt,DESCRIPTION,missing)

	@$(call install_copy, gwt, 0, 0, 0644, -, /usr/lib/libgwt.so.1.0.0)
	@$(call install_link, gwt, libgwt.so.1.0.0, /usr/lib/libgwt.so.1)
	@$(call install_link, gwt, libgwt.so.1.0.0, /usr/lib/libgwt.so)

ifdef PTXCONF_GWT_GWTMM
	@$(call install_copy, gwt, 0, 0, 0644, -, /usr/lib/libgwtmm.so.1.0.0)
	@$(call install_link, gwt, libgwtmm.so.1.0.0, /usr/lib/libgwtmm.so.1)
	@$(call install_link, gwt, libgwtmm.so.1.0.0, /usr/lib/libgwtmm.so)
endif

	@$(call install_finish, gwt)

	@$(call touch)

# vim: syntax=make
