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
PACKAGES-$(PTXCONF_ALSA_LIB) += alsa-lib

#
# Paths and names
#
ALSA_LIB_VERSION	:= 1.0.11
ALSA_LIB		:= alsa-lib-$(ALSA_LIB_VERSION)
ALSA_LIB_SUFFIX		:= tar.bz2
ALSA_LIB_URL		:= ftp://ftp.alsa-project.org/pub/lib/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
ALSA_LIB_SOURCE		:= $(SRCDIR)/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
ALSA_LIB_DIR		:= $(BUILDDIR)/$(ALSA_LIB)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

alsa-lib_get: $(STATEDIR)/alsa-lib.get

$(STATEDIR)/alsa-lib.get: $(alsa-lib_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ALSA_LIB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, ALSA_LIB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

alsa-lib_extract: $(STATEDIR)/alsa-lib.extract

$(STATEDIR)/alsa-lib.extract: $(alsa-lib_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ALSA_LIB_DIR))
	@$(call extract, ALSA_LIB)
	@$(call patchin, ALSA_LIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

alsa-lib_prepare: $(STATEDIR)/alsa-lib.prepare

ALSA_LIB_PATH	:=  PATH=$(CROSS_PATH)
ALSA_LIB_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
ALSA_LIB_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/alsa-lib.prepare: $(alsa-lib_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ALSA_LIB_DIR)/config.cache)
	cd $(ALSA_LIB_DIR) && \
		$(ALSA_LIB_PATH) $(ALSA_LIB_ENV) \
		./configure $(ALSA_LIB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

alsa-lib_compile: $(STATEDIR)/alsa-lib.compile

$(STATEDIR)/alsa-lib.compile: $(alsa-lib_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(ALSA_LIB_DIR) && $(ALSA_LIB_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

alsa-lib_install: $(STATEDIR)/alsa-lib.install

$(STATEDIR)/alsa-lib.install: $(alsa-lib_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, ALSA_LIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

alsa-lib_targetinstall: $(STATEDIR)/alsa-lib.targetinstall

$(STATEDIR)/alsa-lib.targetinstall: $(alsa-lib_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, alsa-lib)
	@$(call install_fixup, alsa-lib, PACKAGE, alsa-lib)
	@$(call install_fixup, alsa-lib, PRIORITY,optional)
	@$(call install_fixup, alsa-lib, VERSION,$(ALSA_LIB_VERSION))
	@$(call install_fixup, alsa-lib, SECTION,base)
	@$(call install_fixup, alsa-lib, AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, alsa-lib, DEPENDS,)
	@$(call install_fixup, alsa-lib, DESCRIPTION,missing)

	@$(call install_copy, alsa-lib, 0, 0, 0755, \
		$(ALSA_LIB_DIR)/src/.libs/libasound.so.2.0.0, \
		/usr/lib/libasound.so.2.0.0 )

	@$(call install_link, alsa-lib, \
		libasound.so.2.0.0, \
		/usr/lib/libasound.so.2)

	@$(call install_link, alsa-lib, \
		libasound.so.2.0.0, \
		/usr/lib/libasound.so)

	@$(call install_copy, alsa-lib, \
		0, 0, 0755, $(ALSA_LIB_DIR)/modules/mixer/simple/.libs/smixer-ac97.so, \
		/lib/alsa-lib/smixer/smixer-ac97.so )

	@$(call install_copy, alsa-lib, \
		0, 0, 0755, $(ALSA_LIB_DIR)/modules/mixer/simple/.libs/smixer-sbase.so, \
		/lib/alsa-lib/smixer/smixer-sbase.so )

	@$(call install_copy, alsa-lib, \
		0, 0, 0755, $(ALSA_LIB_DIR)/modules/mixer/simple/.libs/smixer-hda.so, \
		/lib/alsa-lib/smixer/smixer-hda.so )

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, $(ALSA_LIB_DIR)/src/conf/alsa.conf, \
		/usr/share/alsa/alsa.conf, n)

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, $(ALSA_LIB_DIR)/src/conf/pcm/default.conf, \
		/usr/share/alsa/pcm/default.conf, n)

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, $(ALSA_LIB_DIR)/src/conf/cards/aliases.conf, \
		/usr/share/alsa/cards/aliases.conf, n)

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, $(ALSA_LIB_DIR)/src/conf/pcm/dmix.conf, \
		/usr/share/alsa/pcm/dmix.conf, n)

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, $(ALSA_LIB_DIR)/src/conf/pcm/dsnoop.conf, \
		/usr/share/alsa/pcm/dsnoop.conf, n)	

	@$(call install_finish, alsa-lib)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

alsa-lib_clean:
	rm -rf $(STATEDIR)/alsa-lib.*
	rm -rf $(IMAGEDIR)/alsa-lib_*
	rm -rf $(ALSA_LIB_DIR)

# vim: syntax=make

