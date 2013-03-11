# -*-makefile-*-
#
# Copyright (C) 2013 by Philipp Zabel <p.zabel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MTDEV) += mtdev

#
# Paths and names
#
MTDEV_VERSION	:= 1.1.3
MTDEV_MD5	:= 8a236569ad3dd79eaeed45f1935359be
MTDEV		:= mtdev-$(MTDEV_VERSION)
MTDEV_SUFFIX	:= tar.bz2
MTDEV_URL	:= http://bitmath.org/code/mtdev/$(MTDEV).$(MTDEV_SUFFIX)
MTDEV_SOURCE	:= $(SRCDIR)/$(MTDEV).$(MTDEV_SUFFIX)
MTDEV_DIR	:= $(BUILDDIR)/$(MTDEV)
MTDEV_LICENSE	:= MIT/X11

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
MTDEV_CONF_TOOL	:= autoconf
MTDEV_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mtdev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mtdev)
	@$(call install_fixup, mtdev,PRIORITY,optional)
	@$(call install_fixup, mtdev,SECTION,base)
	@$(call install_fixup, mtdev,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, mtdev,DESCRIPTION,multitouch protocol translation library)

	@$(call install_lib, mtdev, 0, 0, 0644, libmtdev)

	@$(call install_finish, mtdev)

	@$(call touch)

# vim: syntax=make
