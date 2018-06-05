# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
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
PACKAGES-$(PTXCONF_ALSA_LIB) += alsa-lib

#
# Paths and names
#
ALSA_LIB_SUFFIX		:= tar.bz2

ifdef PTXCONF_ALSA_LIB_FULL
ALSA_LIB_VERSION	:= 1.1.4.1
ALSA_LIB_MD5		:= 29fa3e69122d3cf3e8f0e01a0cb1d183
ALSA_LIB		:= alsa-lib-$(ALSA_LIB_VERSION)
ALSA_LIB_URL		:= \
	http://dl.ambiweb.de/mirrors/ftp.alsa-project.org/lib/$(ALSA_LIB).$(ALSA_LIB_SUFFIX) \
	ftp://ftp.alsa-project.org/pub/lib/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
endif

ifdef PTXCONF_ALSA_LIB_LIGHT
ALSA_LIB_VERSION	:= 0.0.17
ALSA_LIB_MD5		:= 81f209f58a3378f5553763b7735e1d58
ALSA_LIB		:= salsa-lib-$(ALSA_LIB_VERSION)
ALSA_LIB_URL		:= ftp://ftp.suse.com/pub/people/tiwai/salsa-lib/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
endif

ALSA_LIB_SOURCE		:= $(SRCDIR)/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
ALSA_LIB_DIR		:= $(BUILDDIR)/$(ALSA_LIB)
ALSA_LIB_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ALSA_LIB_PATH	:= PATH=$(CROSS_PATH)
ALSA_LIB_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
ALSA_LIB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-shared \
	--enable-fast-install \
	--enable-libtool-lock \
	--enable-symbolic-functions \
	--with-debug=no \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_RESMGR)-resmgr \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_READ)-aload \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_MIXER)-mixer \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_PCM)-pcm \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_RAWMIDI)-rawmidi \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_HWDEP)-hwdep \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_SEQ)-seq \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_UCM)-ucm \
	--disable-topology \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_ALISP)-alisp \
	--disable-old-symbols \
	--disable-python \
	--enable-thread-safety \
	--with-versioned \
	--with-tmpdir=/tmp \
	--with-softfloat=$(call ptx/ifdef, PTXCONF_HAS_HARDFLOAT, no, yes) \
	--with-libdl \
	--with-pthread \
	--with-librt \
	--with-alsa-devdir=/dev/snd \
	--with-aload-devdir=/dev

ifdef PTXCONF_ALSA_LIB_PCM
ALSA_LIB_AUTOCONF += --with-pcm-plugins=all
endif

ifdef PTXCONF_ALSA_LIB_LIGHT
ALSA_LIB_AUTOCONF += \
	--enable-everyhing \
	--enable-tlv \
	--enable-timer \
	--enable-conf \
	--enable-async \
	--enable-libasound \
	--enable-rawmidi
endif

# unhandled, yet
# --with-configdir=dir    path where ALSA config files are stored
#  --with-plugindir=dir    path where ALSA plugin files are stored
#  --with-ctl-plugins=<list>
#                          build control plugins (default = all)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/alsa-lib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, alsa-lib)
	@$(call install_fixup, alsa-lib, PRIORITY,optional)
	@$(call install_fixup, alsa-lib, SECTION,base)
	@$(call install_fixup, alsa-lib, AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, alsa-lib, DESCRIPTION,missing)

ifdef PTXCONF_ALSA_LIB_LIGHT
	@$(call install_lib, alsa-lib, 0, 0, 0644, libsalsa)
	@$(call install_link, alsa-lib, libsalsa.so, /usr/lib/libasound.so)
endif

ifdef PTXCONF_ALSA_LIB_FULL
	@$(call install_lib, alsa-lib, 0, 0, 0644, libasound)

	@$(call install_tree, alsa-lib, \
		0, 0, -, /usr/share/alsa/)
endif

ifdef PTXCONF_ALSA_LIB_ASOUND_CONF
	@$(call install_alternative, alsa-lib, 0, 0, 0644, /etc/asound.conf)
endif

	@$(call install_finish, alsa-lib)

	@$(call touch)

# vim: syntax=make
