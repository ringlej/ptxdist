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
ORC_VERSION	:= 0.4.16
ORC_MD5		:= e482932e544c847761449b106ecbc483
ORC		:= orc-$(ORC_VERSION)
ORC_SUFFIX	:= tar.gz
ORC_URL		:= http://code.entropywave.com/download/orc/$(ORC).$(ORC_SUFFIX)
ORC_SOURCE	:= $(SRCDIR)/$(ORC).$(ORC_SUFFIX)
ORC_DIR		:= $(BUILDDIR)/$(ORC)
ORC_LICENSE	:= unknown

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
