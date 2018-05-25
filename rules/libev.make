# -*-makefile-*-
#
# Copyright (C) 2018 by Guillermo Rodriguez <guille.rodriguez@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBEV) += libev

#
# Paths and names
#
LIBEV_VERSION	:= 4.24
LIBEV_MD5	:= 94459a5a22db041dec6f98424d6efe54
LIBEV		:= libev-$(LIBEV_VERSION)
LIBEV_SUFFIX	:= tar.gz
LIBEV_URL	:= http://dist.schmorp.de/libev/Attic/$(LIBEV).$(LIBEV_SUFFIX)
LIBEV_SOURCE	:= $(SRCDIR)/$(LIBEV).$(LIBEV_SUFFIX)
LIBEV_DIR	:= $(BUILDDIR)/$(LIBEV)
LIBEV_LICENSE	:= GPLv2+, BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBEV_CONF_TOOL	:= autoconf
LIBEV_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libev)
	@$(call install_fixup, libev, PRIORITY, optional)
	@$(call install_fixup, libev, SECTION, base)
	@$(call install_fixup, libev, AUTHOR, "Guillermo Rodriguez <guille.rodriguez@gmail.com>")
	@$(call install_fixup, libev, DESCRIPTION, missing)

	@$(call install_lib, libev, 0, 0, 0644, libev)

	@$(call install_finish, libev)

	@$(call touch)

# vim: syntax=make
