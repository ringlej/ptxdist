# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ALSA_UTILS) += alsa-utils

#
# Paths and names
#
ALSA_UTILS_VERSION	:= 1.0.16
ALSA_UTILS		:= alsa-utils-$(ALSA_UTILS_VERSION)
ALSA_UTILS_SUFFIX	:= tar.bz2
ALSA_UTILS_URL		:= ftp://ftp.alsa-project.org/pub/utils/$(ALSA_UTILS).$(ALSA_UTILS_SUFFIX)
ALSA_UTILS_SOURCE	:= $(SRCDIR)/$(ALSA_UTILS).$(ALSA_UTILS_SUFFIX)
ALSA_UTILS_DIR		:= $(BUILDDIR)/$(ALSA_UTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ALSA_UTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, ALSA_UTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ALSA_UTILS_PATH	:=  PATH=$(CROSS_PATH)
ALSA_UTILS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
ALSA_UTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \

# switches that should be controlled
# --disable-nls
# --disable-alsamixer
# --disable-alsatest

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/alsa-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, alsa-utils)
	@$(call install_fixup, alsa-utils, PACKAGE, alsa-utils)
	@$(call install_fixup, alsa-utils, PRIORITY, optional)
	@$(call install_fixup, alsa-utils, VERSION, $(ALSA_UTILS_VERSION))
	@$(call install_fixup, alsa-utils, SECTION, base)
	@$(call install_fixup, alsa-utils, AUTHOR, "Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, alsa-utils, DEPENDS,)
	@$(call install_fixup, alsa-utils, DESCRIPTION, missing)

	@$(call install_copy, alsa-utils, 0, 0, 0755, $(ALSA_UTILS_DIR)/alsactl/alsactl, /usr/sbin/alsactl)
	@$(call install_copy, alsa-utils, 0, 0, 0755, $(ALSA_UTILS_DIR)/alsamixer/alsamixer, /usr/bin/alsamixer)
	@$(call install_copy, alsa-utils, 0, 0, 0755, $(ALSA_UTILS_DIR)/amidi/amidi, /usr/bin/amidi)
	@$(call install_copy, alsa-utils, 0, 0, 0755, $(ALSA_UTILS_DIR)/amixer/amixer, /usr/bin/amixer)
	@$(call install_copy, alsa-utils, 0, 0, 0755, $(ALSA_UTILS_DIR)/aplay/aplay, /usr/bin/aplay)
# link arecord aplay
	@$(call install_link, alsa-utils, aplay, /usr/bin/arecord)

	@$(call install_copy, alsa-utils, 0, 0, 0755, $(ALSA_UTILS_DIR)/iecset/iecset, /usr/bin/iecset)
	@$(call install_copy, alsa-utils, 0, 0, 0755, $(ALSA_UTILS_DIR)/seq/aconnect/aconnect, /usr/bin/aconnect)
	@$(call install_copy, alsa-utils, 0, 0, 0755, $(ALSA_UTILS_DIR)/seq/aplaymidi/aplaymidi, /usr/bin/aplaymidi)
	@$(call install_copy, alsa-utils, 0, 0, 0755, $(ALSA_UTILS_DIR)/seq/aplaymidi/arecordmidi, /usr/bin/arecordmidi)
	@$(call install_copy, alsa-utils, 0, 0, 0755, $(ALSA_UTILS_DIR)/seq/aseqdump/aseqdump, /usr/bin/aseqdump)
	@$(call install_copy, alsa-utils, 0, 0, 0755, $(ALSA_UTILS_DIR)/seq/aseqnet/aseqnet, /usr/bin/aseqnet)

	@$(call install_finish, alsa-utils)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

alsa-utils_clean:
	rm -rf $(STATEDIR)/alsa-utils.*
	rm -rf $(IMAGEDIR)/alsa-utils_*
	rm -rf $(ALSA_UTILS_DIR)

# vim: syntax=make

