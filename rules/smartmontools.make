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
SMARTMONTOOLS_VERSION	:= 6.6
SMARTMONTOOLS_MD5	:= 9ae2c6e7131cd2813edcc65cbe5f223f
SMARTMONTOOLS		:= smartmontools-$(SMARTMONTOOLS_VERSION)
SMARTMONTOOLS_SUFFIX	:= tar.gz
SMARTMONTOOLS_URL	:= $(call ptx/mirror, SF, smartmontools/$(SMARTMONTOOLS).$(SMARTMONTOOLS_SUFFIX))
SMARTMONTOOLS_SOURCE	:= $(SRCDIR)/$(SMARTMONTOOLS).$(SMARTMONTOOLS_SUFFIX)
SMARTMONTOOLS_DIR	:= $(BUILDDIR)/$(SMARTMONTOOLS)
SMARTMONTOOLS_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SMARTMONTOOLS_CONF_TOOL	:= autoconf
SMARTMONTOOLS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-sample \
	--with-systemdsystemunitdir=/usr/lib/systemd/system \
	--without-update-smart-drivedb \
	--without-gnupg \
	--without-selinux \
	--without-libcap-ng \
	--without-nvme-devicescan

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/smartmontools.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  smartmontools)
	@$(call install_fixup, smartmontools,PRIORITY,optional)
	@$(call install_fixup, smartmontools,SECTION,base)
	@$(call install_fixup, smartmontools,AUTHOR,"Bart vdr. Meulen <bartvdrmeulen@gmail.com>")
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

ifneq ($(call remove_quotes,$(PTXCONF_SMARTMONTOOLS_BBINIT_LINK)),)
	@$(call install_link, smartmontools, \
		../init.d/smartd, \
		/etc/rc.d/$(PTXCONF_SMARTMONTOOLS_BBINIT_LINK))
endif
endif
ifdef PTXCONF_SMARTMONTOOLS_SYSTEMD_UNIT
	@$(call install_copy, smartmontools, 0, 0, 0644, -, \
		/usr/lib/systemd/system/smartd.service)
	@$(call install_link, smartmontools, ../smartd.service, \
		/usr/lib/systemd/system/multi-user.target.wants/smartd.service)
endif

	@$(call install_finish, smartmontools)

	@$(call touch)


# vim: syntax=make
