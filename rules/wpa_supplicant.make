# -*-makefile-*-
#
# Copyright (C) 2009 by Markus Rathgeb <rathgeb.markus@googlemail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WPA_SUPPLICANT) += wpa_supplicant

#
# Paths and names
#
WPA_SUPPLICANT_NAME	:= wpa_supplicant
WPA_SUPPLICANT_VERSION	:= 0.6.9
WPA_SUPPLICANT		:= $(WPA_SUPPLICANT_NAME)-$(WPA_SUPPLICANT_VERSION)
WPA_SUPPLICANT_SUFFIX		:= tar.gz
WPA_SUPPLICANT_URL		:= http://hostap.epitest.fi/releases/$(WPA_SUPPLICANT).$(WPA_SUPPLICANT_SUFFIX)
WPA_SUPPLICANT_SOURCE		:= $(SRCDIR)/$(WPA_SUPPLICANT).$(WPA_SUPPLICANT_SUFFIX)
WPA_SUPPLICANT_DIR		:= $(BUILDDIR)/$(WPA_SUPPLICANT)/$(WPA_SUPPLICANT_NAME)
WPA_SUPPLICANT_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(WPA_SUPPLICANT_SOURCE):
	@$(call targetinfo)
	@$(call get, WPA_SUPPLICANT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WPA_SUPPLICANT_PATH	:= PATH=$(CROSS_PATH)
WPA_SUPPLICANT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
WPA_SUPPLICANT_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/wpa_supplicant.prepare:
	@$(call targetinfo)

	cd $(WPA_SUPPLICANT_DIR) && \
		$(WPA_SUPPLICANT_PATH) $(WPA_SUPPLICANT_ENV)
	  @rm -f $(WPA_SUPPLICANT_DIR)/.config
	  @echo "CC=$(CROSS_CC)" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CFLAGS += -I$(SYSROOT)/include" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CFLAGS += -I$(SYSROOT)/usr/include" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "LDFLAGS += -L$(SYSROOT)/lib" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "LDFLAGS += -L$(SYSROOT)/usr/lib" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_BACKEND=file" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_CTRL_IFACE=y" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_EAP_GTC=y" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_EAP_LEAP=y" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_EAP_MD5=y" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_EAP_MSCHAPV2=y" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_EAP_OTP=y" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_EAP_PEAP=y" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_EAP_TLS=y" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_EAP_TTLS=y" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_IEEE8021X_EAPOL=y" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_PEERKEY=y" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_PKCS12=y" >> $(WPA_SUPPLICANT_DIR)/.config && \
	  echo "CONFIG_SMARTCARD=y" >> $(WPA_SUPPLICANT_DIR)/.config
	  @grep -e PTXCONF_WPA_SUPPLICANT_ $(PTXDIST_PTXCONFIG) | \
		sed -e 's/PTXCONF_WPA_SUPPLICANT_/CONFIG_/g' >> $(WPA_SUPPLICANT_DIR)/.config

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wpa_supplicant.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  wpa_supplicant)
	@$(call install_fixup, wpa_supplicant,PACKAGE,wpa-supplicant)
	@$(call install_fixup, wpa_supplicant,PRIORITY,optional)
	@$(call install_fixup, wpa_supplicant,VERSION,$(WPA_SUPPLICANT_VERSION))
	@$(call install_fixup, wpa_supplicant,SECTION,base)
	@$(call install_fixup, wpa_supplicant,AUTHOR,"Markus Rathgeb <rathgeb.markus@googlemail.com>")
	@$(call install_fixup, wpa_supplicant,DEPENDS,)
	@$(call install_fixup, wpa_supplicant,DESCRIPTION,missing)

	@$(call install_copy, wpa_supplicant, 0, 0, 0755, $(WPA_SUPPLICANT_DIR)/wpa_supplicant, /usr/sbin/wpa_supplicant)
	@$(call install_copy, wpa_supplicant, 0, 0, 0755, $(WPA_SUPPLICANT_DIR)/wpa_cli, /usr/bin/wpa_cli)

	@$(call install_finish, wpa_supplicant)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

wpa_supplicant_clean:
	rm -rf $(STATEDIR)/wpa_supplicant.*
	rm -rf $(PKGDIR)/wpa_supplicant_*
	rm -rf $(BUILDDIR)/$(WPA_SUPPLICANT)

# vim: syntax=make
