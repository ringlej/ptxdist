# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_AUMIX) += aumix

#
# Paths and names
#
AUMIX_VERSION	:= 2.9.1
AUMIX_MD5	:= 34f28ae1c94fc5298e8bb2688c4b3a20
AUMIX		:= aumix-$(AUMIX_VERSION)
AUMIX_SUFFIX	:= tar.bz2
AUMIX_URL	:= $(call ptx/mirror, SF, aumix/$(AUMIX).$(AUMIX_SUFFIX))
AUMIX_SOURCE	:= $(SRCDIR)/$(AUMIX).$(AUMIX_SUFFIX)
AUMIX_DIR	:= $(BUILDDIR)/$(AUMIX)
AUMIX_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

AUMIX_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_MSGMERGE=:

#
# autoconf
#
AUMIX_CONF_TOOL := autoconf
AUMIX_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-dummy-mixer \
	--without-gtk \
        --without-gpm \
        --without-sysmouse

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/aumix.targetinstall:
	@$(call targetinfo)

	@$(call install_init, aumix)
	@$(call install_fixup, aumix,PRIORITY,optional)
	@$(call install_fixup, aumix,SECTION,base)
	@$(call install_fixup, aumix,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, aumix,DESCRIPTION,missing)

	@$(call install_copy, aumix, 0, 0, 0755, -, /usr/bin/aumix)
	@$(call install_tree, aumix, 0, 0, -, /usr/share/aumix)

	@$(call install_finish, aumix)

	@$(call touch)

# vim: syntax=make
