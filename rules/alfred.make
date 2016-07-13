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
PACKAGES-$(PTXCONF_ALFRED) += alfred

#
# Paths and names
#
ALFRED_VERSION	:= 2015.1
ALFRED_MD5	:= fcce70cd8da764ee91c8cd2cbfa14362
ALFRED		:= alfred-$(ALFRED_VERSION)
ALFRED_SUFFIX	:= tar.gz
ALFRED_URL	:= http://downloads.open-mesh.org/batman/stable/sources/alfred/$(ALFRED).$(ALFRED_SUFFIX)
ALFRED_SOURCE	:= $(SRCDIR)/$(ALFRED).$(ALFRED_SUFFIX)
ALFRED_DIR	:= $(BUILDDIR)/$(ALFRED)
ALFRED_LICENSE	:= GPL-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ALFRED_CONF_TOOL	:= NO

ALFRED_MAKE_ENV		:= \
	$(CROSS_ENV)

ALFRED_MAKE_OPT		:= \
	CONFIG_ALFRED_GPSD=n \
	CONFIG_ALFRED_CAPABILITIES=n

ALFRED_INSTALL_OPT	:= \
	$(ALFRED_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/alfred.targetinstall:
	@$(call targetinfo)

	@$(call install_init, alfred)
	@$(call install_fixup, alfred,PRIORITY,optional)
	@$(call install_fixup, alfred,SECTION,base)
	@$(call install_fixup, alfred,AUTHOR,"Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, alfred,DESCRIPTION,missing)

	@$(call install_copy, alfred, 0, 0, 0755, $(ALFRED_DIR)/alfred, /usr/bin/alfred)
	@$(call install_copy, alfred, 0, 0, 0755, $(ALFRED_DIR)/vis/batadv-vis, /usr/bin/batadv-vis)

ifdef PTXCONF_ALFRED_SYSTEMD_SERVICE
	@$(call install_alternative, alfred, 0, 0, 0644, /lib/systemd/system/alfred@.service)
	@$(call install_alternative, alfred, 0, 0, 0644, /lib/systemd/system/batadv-vis@.service)
ifneq ($(PTXCONF_ALFRED_SYSTEMD_SERVICE_ALFRED_INTF),"")
	@$(call install_link, alfred, ../alfred@.service, \
	/lib/systemd/system/multi-user.target.wants/alfred@$(PTXCONF_ALFRED_SYSTEMD_SERVICE_ALFRED_INTF).service)
endif
ifneq ($(PTXCONF_ALFRED_SYSTEMD_SERVICE_BATADVVIS_INTF),"")
	@$(call install_link, alfred, ../batadv-vis@.service, \
	/lib/systemd/system/multi-user.target.wants/batadv-vis@$(PTXCONF_ALFRED_SYSTEMD_SERVICE_BATADVVIS_INTF).service)
endif
endif

	@$(call install_finish, alfred)

	@$(call touch)

# vim: syntax=make
