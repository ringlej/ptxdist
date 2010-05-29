# -*-makefile-*-
#
# Copyright (C) 2010 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SMARTMONTOOLS) += smartmontools

#
# Paths and names
#
SMARTMONTOOLS_VERSION	:= 5.39
SMARTMONTOOLS		:= smartmontools-$(SMARTMONTOOLS_VERSION)
SMARTMONTOOLS_SUFFIX	:= tar.gz
SMARTMONTOOLS_URL	:= $(PTXCONF_SETUP_SFMIRROR)/smartmontools/$(SMARTMONTOOLS).$(SMARTMONTOOLS_SUFFIX)
SMARTMONTOOLS_SOURCE	:= $(SRCDIR)/$(SMARTMONTOOLS).$(SMARTMONTOOLS_SUFFIX)
SMARTMONTOOLS_DIR	:= $(BUILDDIR)/$(SMARTMONTOOLS)
SMARTMONTOOLS_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SMARTMONTOOLS_SOURCE):
	@$(call targetinfo)
	@$(call get, SMARTMONTOOLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SMARTMONTOOLS_CONF_TOOL	:= autoconf
SMARTMONTOOLS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-sample

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/smartmontools.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  smartmontools)
	@$(call install_fixup, smartmontools,PACKAGE,smartmontools)
	@$(call install_fixup, smartmontools,PRIORITY,optional)
	@$(call install_fixup, smartmontools,VERSION,$(SMARTMONTOOLS_VERSION))
	@$(call install_fixup, smartmontools,SECTION,base)
	@$(call install_fixup, smartmontools,AUTHOR,"Bart vdr. Meulen <bartvdrmeulen@gmail.com>")
	@$(call install_fixup, smartmontools,DEPENDS,)
	@$(call install_fixup, smartmontools,DESCRIPTION,missing)

ifdef PTXCONF_SMARTMONTOOLS_SMARTCTL
	@$(call install_copy, smartmontools, 0, 0, 0755, -, /usr/sbin/smartctl)
endif
ifdef PTXCONF_SMARTMONTOOLS_SMARTD
	@$(call install_copy, smartmontools, 0, 0, 0755, -, /usr/sbin/smartd)
endif
ifdef PTXCONF_SMARTMONTOOLS_SMARTD_CONFIG
	@$(call install_alternative, smartmontools, 0, 0, 0644, /etc/smartd.conf)
endif
ifdef PTXCONF_SMARTMONTOOLS_SMARTD_INITD
	@$(call install_alternative, smartmontools, 0, 0, 0755, /etc/init.d/smartd)
endif

	@$(call install_finish, smartmontools)

	@$(call touch)


# vim: syntax=make
