# -*-makefile-*-
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WIRELESS) += wireless

#
# Paths and names
#
WIRELESS_VERSION	:= 30
WIRELESS_VERSION_PRE	:= pre9
WIRELESS		:= wireless_tools.$(WIRELESS_VERSION).$(WIRELESS_VERSION_PRE)
WIRELESS_SUFFIX		:= tar.gz
WIRELESS_URL		:= http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/$(WIRELESS).$(WIRELESS_SUFFIX)
WIRELESS_SOURCE		:= $(SRCDIR)/$(WIRELESS).$(WIRELESS_SUFFIX)
WIRELESS_DIR 		:= $(BUILDDIR)/wireless_tools.$(WIRELESS_VERSION)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(WIRELESS_SOURCE):
	@$(call targetinfo)
	@$(call get, WIRELESS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/wireless.prepare:
	@$(call targetinfo)
ifdef PTXCONF_WIRELESS_SHARED
	@$(call disable_sh,$(WIRELESS_DIR)/Makefile,BUILD_STATIC)
else
	@$(call enable_sh, $(WIRELESS_DIR)/Makefile,BUILD_STATIC)
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

WIRELESS_PATH	:= PATH=$(CROSS_PATH)
WIRELESS_ENV 	:= $(CROSS_ENV)

WIRELESS_MAKEVARS := \
	$(CROSS_ENV_CC) \
	PREFIX=/usr

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wireless.install:
	@$(call targetinfo)
	@$(call install, WIRELESS,,install-hdr)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wireless.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wireless)
	@$(call install_fixup, wireless,PACKAGE,wireless)
	@$(call install_fixup, wireless,PRIORITY,optional)
	@$(call install_fixup, wireless,VERSION,$(WIRELESS_VERSION))
	@$(call install_fixup, wireless,SECTION,base)
	@$(call install_fixup, wireless,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, wireless,DEPENDS,)
	@$(call install_fixup, wireless,DESCRIPTION,missing)

	@$(call install_copy, wireless, 0, 0, 0755, -, /usr/sbin/iwconfig)
	@$(call install_copy, wireless, 0, 0, 0755, -, /usr/sbin/iwlist)
	@$(call install_copy, wireless, 0, 0, 0755, -, /usr/sbin/iwpriv)
	@$(call install_copy, wireless, 0, 0, 0755, -, /usr/sbin/iwspy)
	@$(call install_copy, wireless, 0, 0, 0755, -, /usr/sbin/iwgetid)
	@$(call install_copy, wireless, 0, 0, 0755, -, /usr/sbin/iwevent)

ifdef PTXCONF_WIRELESS_SHARED
	@$(call install_copy, wireless, 0, 0, 0644, -, \
		/usr/lib/libiw.so.$(WIRELESS_VERSION))
	@$(call install_link, wireless, libiw.so.$(WIRELESS_VERSION), /usr/lib/libiw.so)
endif

	@$(call install_finish, wireless)

	@$(call touch)
# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

wireless_clean:
	rm -rf $(STATEDIR)/wireless.*
	rm -rf $(PKGDIR)/wireless_*
	rm -rf $(WIRELESS_DIR)

# vim: syntax=make
