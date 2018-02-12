# -*-makefile-*-
#
# Copyright (C) 2015 by Juergen Borleis <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNDP) += libndp

#
# Paths and names
#
LIBNDP_VERSION	:= 1.6
LIBNDP_MD5	:= 1e54d26bcb4a4110bc3f90c5dd04f1a7
LIBNDP		:= libndp-$(LIBNDP_VERSION)
LIBNDP_SUFFIX	:= tar.gz
LIBNDP_URL	:= http://libndp.org/files/$(LIBNDP).$(LIBNDP_SUFFIX)
LIBNDP_SOURCE	:= $(SRCDIR)/$(LIBNDP).$(LIBNDP_SUFFIX)
LIBNDP_DIR	:= $(BUILDDIR)/$(LIBNDP)
LIBNDP_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBNDP_CONF_TOOL	:= autoconf
LIBNDP_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-logging \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libndp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libndp)
	@$(call install_fixup, libndp,PRIORITY,optional)
	@$(call install_fixup, libndp,SECTION,base)
	@$(call install_fixup, libndp,AUTHOR,"Juergen Borleis <jbe@pengutronix.de>")
	@$(call install_fixup, libndp,DESCRIPTION,"Neighbor Discovery Protocol support")

	@$(call install_lib, libndp, 0, 0, 0644, libndp)
ifdef PTXCONF_LIBNDP_NDPTOOL
	@$(call install_copy, libndp, 0, 0, 0755, -, /usr/bin/ndptool)
endif
	@$(call install_finish, libndp)

	@$(call touch)

# vim: syntax=make
