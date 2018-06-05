# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ORC) += orc

#
# Paths and names
#
ORC_VERSION	:= 0.4.26
ORC_MD5		:= 8e9bef677bae289d3324d81c337a4507
ORC		:= orc-$(ORC_VERSION)
ORC_SUFFIX	:= tar.xz
ORC_URL		:= http://gstreamer.freedesktop.org/data/src/orc/$(ORC).$(ORC_SUFFIX)
ORC_SOURCE	:= $(SRCDIR)/$(ORC).$(ORC_SUFFIX)
ORC_DIR		:= $(BUILDDIR)/$(ORC)
ORC_LICENSE	:= BSD-2-Clause AND BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
ORC_CONF_TOOL	:= autoconf
ORC_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

# don't install orcc it's for the target and should not be used
$(STATEDIR)/orc.install:
	@$(call targetinfo)
	@$(call world/install, ORC)
	@rm $(ORC_PKGDIR)/usr/bin/orcc
	@$(call touch)
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/orc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, orc)
	@$(call install_fixup, orc,PRIORITY,optional)
	@$(call install_fixup, orc,SECTION,base)
	@$(call install_fixup, orc,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, orc,DESCRIPTION,missing)

	@$(call install_lib, orc, 0, 0, 0644, liborc-0.4)
	@$(call install_lib, orc, 0, 0, 0644, liborc-test-0.4)

	@$(call install_finish, orc)

	@$(call touch)

# vim: syntax=make
