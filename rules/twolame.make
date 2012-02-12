# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TWOLAME) += twolame

#
# Paths and names
#
TWOLAME_VERSION	:= 0.3.13
TWOLAME_MD5	:= 4113d8aa80194459b45b83d4dbde8ddb
TWOLAME		:= twolame-$(TWOLAME_VERSION)
TWOLAME_SUFFIX	:= tar.gz
TWOLAME_URL	:= $(call ptx/mirror, SF, twolame/$(TWOLAME).$(TWOLAME_SUFFIX))
TWOLAME_SOURCE	:= $(SRCDIR)/$(TWOLAME).$(TWOLAME_SUFFIX)
TWOLAME_DIR	:= $(BUILDDIR)/$(TWOLAME)
TWOLAME_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
TWOLAME_CONF_TOOL	:= autoconf
TWOLAME_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/twolame.targetinstall:
	@$(call targetinfo)

	@$(call install_init, twolame)
	@$(call install_fixup, twolame,PRIORITY,optional)
	@$(call install_fixup, twolame,SECTION,base)
	@$(call install_fixup, twolame,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, twolame,DESCRIPTION,missing)

	@$(call install_lib, twolame, 0, 0, 0644, libtwolame)

	@$(call install_finish, twolame)

	@$(call touch)

# vim: syntax=make
