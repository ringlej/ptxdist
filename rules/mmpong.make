# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MMPONG) += mmpong

#
# Paths and names
#
MMPONG_VERSION	:= 0.9
MMPONG		:= mmpong-$(MMPONG_VERSION)
MMPONG_SUFFIX	:= tar.gz
MMPONG_URL	:= http://www.mmpong.net/trac/downloads/$(MMPONG).$(MMPONG_SUFFIX)
MMPONG_SOURCE	:= $(SRCDIR)/$(MMPONG).$(MMPONG_SUFFIX)
MMPONG_DIR	:= $(BUILDDIR)/$(MMPONG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MMPONG_SOURCE):
	@$(call targetinfo)
	@$(call get, MMPONG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MMPONG_CONF_TOOL := cmake

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mmpong.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mmpong)
	@$(call install_fixup, mmpong,PACKAGE,mmpong)
	@$(call install_fixup, mmpong,PRIORITY,optional)
	@$(call install_fixup, mmpong,VERSION,$(MMPONG_VERSION))
	@$(call install_fixup, mmpong,SECTION,base)
	@$(call install_fixup, mmpong,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, mmpong,DEPENDS,)
	@$(call install_fixup, mmpong,DESCRIPTION,missing)

	@$(call install_copy, mmpong, 0, 0, 0644, -, /usr/lib/libmmpong.so.0.9)
	@$(call install_link, mmpong, libmmpong.so.0.9, /usr/lib/libmmpong.so)

ifdef PTXCONF_MMPONG_CACA
	@$(call install_copy, mmpong, 0, 0, 0755, -, /usr/games/mmpong-caca)
endif

ifdef PTXCONF_MMPONG_SERVER
	@$(call install_copy, mmpong, 0, 0, 0755, -, /usr/games/mmpongd)
endif

	@$(call install_finish, mmpong)

	@$(call touch)

# vim: syntax=make
