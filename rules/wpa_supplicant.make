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
WPA_SUPPLICANT_SUFFIX	:= tar.gz
WPA_SUPPLICANT_URL	:= http://hostap.epitest.fi/releases/$(WPA_SUPPLICANT).$(WPA_SUPPLICANT_SUFFIX)
WPA_SUPPLICANT_SOURCE	:= $(SRCDIR)/$(WPA_SUPPLICANT).$(WPA_SUPPLICANT_SUFFIX)
WPA_SUPPLICANT_DIR	:= $(BUILDDIR)/$(WPA_SUPPLICANT)
WPA_SUPPLICANT_SUBDIR	:= $(WPA_SUPPLICANT_NAME)
WPA_SUPPLICANT_CONFIG	:= $(BUILDDIR)/$(WPA_SUPPLICANT)/$(WPA_SUPPLICANT_SUBDIR)/.config
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
WPA_SUPPLICANT_ENV 	:= \
	$(CROSS_ENV) \
	LIBDIR=/lib \
	BINDIR=/sbin

#
# autoconf
#
WPA_SUPPLICANT_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/wpa_supplicant.prepare:
	@$(call targetinfo)

	@echo "CC=$(CROSS_CC)"				>  $(WPA_SUPPLICANT_CONFIG) && \
	echo "CFLAGS += -I$(PTXDIST_SYSROOT_TARGET)/include"		>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CFLAGS += -I$(PTXDIST_SYSROOT_TARGET)/usr/include"	>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "LDFLAGS += -L$(PTXDIST_SYSROOT_TARGET)/lib"		>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "LDFLAGS += -L$(PTXDIST_SYSROOT_TARGET)/usr/lib"		>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_BACKEND=file"			>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_CTRL_IFACE=y"			>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_EAP_GTC=y"				>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_EAP_LEAP=y"			>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_EAP_MD5=y"				>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_EAP_MSCHAPV2=y"			>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_EAP_OTP=y"				>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_EAP_PEAP=y"			>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_EAP_TLS=y"				>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_EAP_TTLS=y"			>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_IEEE8021X_EAPOL=y"			>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_PEERKEY=y"				>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_PKCS12=y"				>> $(WPA_SUPPLICANT_CONFIG) && \
	echo "CONFIG_SMARTCARD=y"			>> $(WPA_SUPPLICANT_CONFIG)

	@grep -e PTXCONF_WPA_SUPPLICANT_ $(PTXDIST_PTXCONFIG) | \
		sed -e 's/PTXCONF_WPA_SUPPLICANT_/CONFIG_/g' >> $(WPA_SUPPLICANT_CONFIG)

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wpa_supplicant.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  wpa_supplicant)
	@$(call install_fixup, wpa_supplicant,PRIORITY,optional)
	@$(call install_fixup, wpa_supplicant,SECTION,base)
	@$(call install_fixup, wpa_supplicant,AUTHOR,"Markus Rathgeb <rathgeb.markus@googlemail.com>")
	@$(call install_fixup, wpa_supplicant,DESCRIPTION,missing)

	@$(call install_copy, wpa_supplicant, 0, 0, 0755, -, \
		/sbin/wpa_supplicant)
	@$(call install_copy, wpa_supplicant, 0, 0, 0755, -, \
		/sbin/wpa_cli)

	@$(call install_finish, wpa_supplicant)

	@$(call touch)

# vim: syntax=make
