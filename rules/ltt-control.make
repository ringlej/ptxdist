# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LTT_CONTROL) += ltt-control

#
# Paths and names
#
LTT_CONTROL_VERSION	:= 0.63-03012009
LTT_CONTROL		:= ltt-control-$(LTT_CONTROL_VERSION)
LTT_CONTROL_SUFFIX	:= tar.gz
LTT_CONTROL_URL		:= http://ltt.polymtl.ca/files/lttng/$(LTT_CONTROL).$(LTT_CONTROL_SUFFIX)
LTT_CONTROL_SOURCE	:= $(SRCDIR)/$(LTT_CONTROL).$(LTT_CONTROL_SUFFIX)
LTT_CONTROL_DIR		:= $(BUILDDIR)/$(LTT_CONTROL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LTT_CONTROL_SOURCE):
	@$(call targetinfo)
	@$(call get, LTT_CONTROL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LTT_CONTROL_PATH	:= PATH=$(CROSS_PATH)
LTT_CONTROL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LTT_CONTROL_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltt-control.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltt-control)
	@$(call install_fixup, ltt-control,PACKAGE,ltt-control)
	@$(call install_fixup, ltt-control,PRIORITY,optional)
	@$(call install_fixup, ltt-control,VERSION,$(LTT_CONTROL_VERSION))
	@$(call install_fixup, ltt-control,SECTION,base)
	@$(call install_fixup, ltt-control,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ltt-control,DEPENDS,)
	@$(call install_fixup, ltt-control,DESCRIPTION,missing)

	@$(call install_copy, ltt-control, 0, 0, 0755, -, /usr/bin/lttctl)
	@$(call install_copy, ltt-control, 0, 0, 0755, -, /usr/bin/lttd)

	@$(call install_copy, ltt-control, 0, 0, 0644, -, \
		/usr/lib/liblttctl.so.0.0.0)
	@$(call install_link, ltt-control, liblttctl.so.0.0.0, \
		/usr/lib/liblttctl.so.0)
	@$(call install_link, ltt-control, liblttctl.so.0.0.0, \
		/usr/lib/liblttctl.so)

	@$(call install_finish, ltt-control)

	@$(call touch)

# vim: syntax=make
