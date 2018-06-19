# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FRIBIDI) += fribidi

#
# Paths and names
#
FRIBIDI_VERSION	:= 1.0.4
FRIBIDI_MD5	:= 00d058ac76e6c0f46a6671a63d31cf67
FRIBIDI		:= fribidi-$(FRIBIDI_VERSION)
FRIBIDI_SUFFIX	:= tar.bz2
FRIBIDI_URL	:= https://github.com/fribidi/fribidi/releases/download/v$(FRIBIDI_VERSION)/$(FRIBIDI).$(FRIBIDI_SUFFIX)
FRIBIDI_SOURCE	:= $(SRCDIR)/$(FRIBIDI).$(FRIBIDI_SUFFIX)
FRIBIDI_DIR	:= $(BUILDDIR)/$(FRIBIDI)
FRIBIDI_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FRIBIDI_CONF_TOOL	:= autoconf
FRIBIDI_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--disable-deprecated

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fribidi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fribidi)
	@$(call install_fixup, fribidi,PRIORITY,optional)
	@$(call install_fixup, fribidi,SECTION,base)
	@$(call install_fixup, fribidi,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, fribidi,DESCRIPTION,missing)

	@$(call install_lib, fribidi, 0, 0, 0644, libfribidi)

	@$(call install_finish, fribidi)

	@$(call touch)

# vim: syntax=make
