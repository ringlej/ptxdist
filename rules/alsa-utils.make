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
ALSA_UTILS_VERSION	:= 1.0.11
ALSA_UTILS		:= alsa-utils-$(ALSA_UTILS_VERSION)
ALSA_UTILS_SUFFIX	:= tar.bz2
ALSA_UTILS_URL		:= ftp://ftp.alsa-project.org/pub/utils/$(ALSA_UTILS).$(ALSA_UTILS_SUFFIX)
ALSA_UTILS_SOURCE	:= $(SRCDIR)/$(ALSA_UTILS).$(ALSA_UTILS_SUFFIX)
ALSA_UTILS_DIR		:= $(BUILDDIR)/$(ALSA_UTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

alsa-utils_get: $(STATEDIR)/alsa-utils.get

$(STATEDIR)/alsa-utils.get: $(alsa-utils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ALSA_UTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, ALSA_UTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

alsa-utils_extract: $(STATEDIR)/alsa-utils.extract

$(STATEDIR)/alsa-utils.extract: $(alsa-utils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ALSA_UTILS_DIR))
	@$(call extract, ALSA_UTILS)
	@$(call patchin, ALSA_UTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

alsa-utils_prepare: $(STATEDIR)/alsa-utils.prepare

ALSA_UTILS_PATH	:=  PATH=$(CROSS_PATH)
ALSA_UTILS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
ALSA_UTILS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/alsa-utils.prepare: $(alsa-utils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ALSA_UTILS_DIR)/config.cache)
	cd $(ALSA_UTILS_DIR) && \
		$(ALSA_UTILS_PATH) $(ALSA_UTILS_ENV) \
		./configure $(ALSA_UTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

alsa-utils_compile: $(STATEDIR)/alsa-utils.compile

$(STATEDIR)/alsa-utils.compile: $(alsa-utils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(ALSA_UTILS_DIR) && $(ALSA_UTILS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

alsa-utils_install: $(STATEDIR)/alsa-utils.install

$(STATEDIR)/alsa-utils.install: $(alsa-utils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

alsa-utils_targetinstall: $(STATEDIR)/alsa-utils.targetinstall

$(STATEDIR)/alsa-utils.targetinstall: $(alsa-utils_targetinstall_deps_default)
	@$(call targetinfo, $@)

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

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

alsa-utils_clean:
	rm -rf $(STATEDIR)/alsa-utils.*
	rm -rf $(IMAGEDIR)/alsa-utils_*
	rm -rf $(ALSA_UTILS_DIR)

# vim: syntax=make

