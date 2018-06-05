# -*-makefile-*-
#
# Copyright (C) 2014 by Markus Pargmann <mpa@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBOPING) += liboping

#
# Paths and names
#
LIBOPING_VERSION	:= 1.9.0
LIBOPING_MD5		:= 28d085b95d1ca1acd541fc2606d5e02d
LIBOPING		:= liboping-$(LIBOPING_VERSION)
LIBOPING_SUFFIX		:= tar.gz
LIBOPING_URL		:= http://verplant.org/liboping/files/$(LIBOPING).$(LIBOPING_SUFFIX)
LIBOPING_SOURCE		:= $(SRCDIR)/$(LIBOPING).$(LIBOPING_SUFFIX)
LIBOPING_DIR		:= $(BUILDDIR)/$(LIBOPING)
LIBOPING_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBOPING_CONF_TOOL	:= autoconf
LIBOPING_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--disable-debug \
	--without-perl-bindings

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/liboping.targetinstall:
	@$(call targetinfo)

	@$(call install_init, liboping)
	@$(call install_fixup, liboping,PRIORITY,optional)
	@$(call install_fixup, liboping,SECTION,base)
	@$(call install_fixup, liboping,AUTHOR,"Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, liboping,DESCRIPTION,missing)

	@$(call install_lib, liboping, 0, 0, 0644, liboping)

	@$(call install_finish, liboping)

	@$(call touch)

# vim: syntax=make
