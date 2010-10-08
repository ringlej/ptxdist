# -*-makefile-*-
#
# Copyright (C) 2009 by Jan Weitzel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_ACPID) += acpid

#
# Paths and names
#
ACPID_VERSION		:= 2.0.8
ACPID_MD5		:= 7e5ede75e37ccaaf75536bc44cf214fc
ACPID_LICENSE		:= GPLv2
ACPID			:= acpid-$(ACPID_VERSION)
ACPID_SUFFIX		:= tar.gz
ACPID_URL		:= http://www.tedfelix.com/linux/$(ACPID).$(ACPID_SUFFIX)
ACPID_SOURCE		:= $(SRCDIR)/$(ACPID).$(ACPID_SUFFIX)
ACPID_DIR		:= $(BUILDDIR)/$(ACPID)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ACPID_CONF_TOOL		:= NO
ACPID_MAKE_ENV		:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/acpid.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  acpid)
	@$(call install_fixup, acpid,PRIORITY,optional)
	@$(call install_fixup, acpid,SECTION,base)
	@$(call install_fixup, acpid,AUTHOR,"Jan Weitzel <j.weitzel@phytec.de>, Juergen Kilb <j.kilb@phytec.de>")
	@$(call install_fixup, acpid,DESCRIPTION,missing)

	@$(call install_copy, acpid, 0, 0, 0755, -, /usr/sbin/acpid)
	@$(call install_copy, acpid, 0, 0, 0755, -, /usr/bin/acpi_listen)

ifdef PTXCONF_ACPID_POWEROFF
	@$(call install_alternative, acpid, 0, 0, 0755, /etc/acpi/events/power_button)
endif

ifdef PTXCONF_ACPID_STARTSCRIPT
	@$(call install_alternative, acpid, 0, 0, 0755, /etc/init.d/acpid)

ifneq ($(call remove_quotes,$(PTXCONF_ACPID_BBINIT_LINK)),)
	@$(call install_link, acpid, \
		../init.d/acpid, \
		/etc/rc.d/$(PTXCONF_ACPID_BBINIT_LINK))
endif
endif

	@$(call install_finish, acpid)

	@$(call touch)

# vim: syntax=make
