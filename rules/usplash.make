# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_USPLASH) += usplash

#
# Paths and names
#
USPLASH_VERSION	:= 0.5.49
USPLASH_MD5	:= 6b1fd6c109456f47cbad1b1ccaa2bf53
USPLASH		:= usplash_$(USPLASH_VERSION)
USPLASH_SUFFIX	:= tar.gz
USPLASH_URL	:= http://archive.ubuntu.com/ubuntu/pool/main/u/usplash/$(USPLASH).$(USPLASH_SUFFIX)
USPLASH_SOURCE	:= $(SRCDIR)/$(USPLASH).$(USPLASH_SUFFIX)
USPLASH_DIR	:= $(BUILDDIR)/$(USPLASH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
USPLASH_CONF_TOOL	:= autoconf
USPLASH_CONF_OPT	:= \
	$(CROSS_AUTOCONF_ROOT) \
	--enable-svga-backend \
	--disable-convert-tools

$(STATEDIR)/usplash.prepare:
	@$(call targetinfo)
	@chmod +x $(USPLASH_DIR)/configure
	@$(call world/prepare, USPLASH)
	@$(call touch)

USPLASH_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/usplash.targetinstall:
	@$(call targetinfo)

	@$(call install_init, usplash)
	@$(call install_fixup, usplash,PRIORITY,optional)
	@$(call install_fixup, usplash,SECTION,base)
	@$(call install_fixup, usplash,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, usplash,DESCRIPTION,missing)

	@$(call install_copy, usplash, 0, 0, 0755, -, /sbin/usplash)
	@$(call install_copy, usplash, 0, 0, 0755, -, /sbin/usplash_write)
	@$(call install_copy, usplash, 0, 0, 0755, -, /sbin/usplash_down)
	@$(call install_copy, usplash, 0, 0, 0755, -, /sbin/update-usplash-theme)
	@$(call install_copy, usplash, 0, 0, 0644, -, /lib/libusplash.so.0)
	@$(call install_link, usplash, libusplash.so.0, /lib/libusplash.so)

	@$(call install_finish, usplash)

	@$(call touch)

# vim: syntax=make
