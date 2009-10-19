# -*-makefile-*-
# $Id$
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XKEYBOARD_CONFIG) += xkeyboard-config

#
# Paths and names
#
XKEYBOARD_CONFIG_VERSION	:= 1.7
XKEYBOARD_CONFIG		:= xkeyboard-config-$(XKEYBOARD_CONFIG_VERSION)
XKEYBOARD_CONFIG_SUFFIX		:= tar.bz2
XKEYBOARD_CONFIG_URL		:= http://xlibs.freedesktop.org/xkbdesc//$(XKEYBOARD_CONFIG).$(XKEYBOARD_CONFIG_SUFFIX)
XKEYBOARD_CONFIG_SOURCE		:= $(SRCDIR)/$(XKEYBOARD_CONFIG).$(XKEYBOARD_CONFIG_SUFFIX)
XKEYBOARD_CONFIG_DIR		:= $(BUILDDIR)/$(XKEYBOARD_CONFIG)
XKEYBOARD_CONFIG_PKGDIR		:= $(PKGDIR)/$(XKEYBOARD_CONFIG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XKEYBOARD_CONFIG_SOURCE):
	@$(call targetinfo)
	@$(call get, XKEYBOARD_CONFIG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XKEYBOARD_CONFIG_PATH	:= PATH=$(CROSS_PATH)
XKEYBOARD_CONFIG_ENV	:= $(CROSS_ENV)

#
# autoconf
#
XKEYBOARD_CONFIG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xkeyboard-config.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  xkeyboard-config)
	@$(call install_fixup, xkeyboard-config,PACKAGE,xkeyboard-config)
	@$(call install_fixup, xkeyboard-config,PRIORITY,optional)
	@$(call install_fixup, xkeyboard-config,VERSION,$(XKEYBOARD_CONFIG_VERSION))
	@$(call install_fixup, xkeyboard-config,SECTION,base)
	@$(call install_fixup, xkeyboard-config,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xkeyboard-config,DEPENDS,)
	@$(call install_fixup, xkeyboard-config,DESCRIPTION,missing)

	@cd $(XKEYBOARD_CONFIG_PKGDIR) &&					\
	for dir in `find .$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb -type d`; do	\
		$(call install_copy, xkeyboard-config, 0, 0, 0755, /$$dir);	\
	done
	@cd $(XKEYBOARD_CONFIG_PKGDIR) &&					\
	for file in `find .$(PTXCONF_XORG_DEFAULT_DATA_DIR)/X11/xkb -type f`; do\
		$(call install_copy, xkeyboard-config, 0, 0, 0644,		\
			$(XKEYBOARD_CONFIG_PKGDIR)/$$file, /$$file);		\
	done

	@$(call install_finish, xkeyboard-config)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xkeyboard-config_clean:
	rm -rf $(STATEDIR)/xkeyboard-config.*
	rm -rf $(PKGDIR)/xkeyboard-config_*
	rm -rf $(XKEYBOARD_CONFIG_DIR)

# vim: syntax=make
