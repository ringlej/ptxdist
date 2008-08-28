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
ALSA_LIB_SUFFIX		:= tar.bz2

ifdef PTXCONF_ALSA_LIB_FULL
ALSA_LIB_VERSION	:= 1.0.16
ALSA_LIB		:= alsa-lib-$(ALSA_LIB_VERSION)
ALSA_LIB_URL		:= ftp://ftp.alsa-project.org/pub/lib/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
endif

ifdef PTXCONF_ALSA_LIB_LIGHT
ALSA_LIB_VERSION	:= 0.0.17
ALSA_LIB		:= salsa-lib-$(ALSA_LIB_VERSION)
ALSA_LIB_URL		:= ftp://ftp.suse.com/pub/people/tiwai/salsa-lib/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
endif

ALSA_LIB_SOURCE		:= $(SRCDIR)/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
ALSA_LIB_DIR		:= $(BUILDDIR)/$(ALSA_LIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ALSA_LIB_SOURCE):
	@$(call targetinfo)
	@$(call get, ALSA_LIB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

alsa-lib_prepare: $(STATEDIR)/alsa-lib.prepare

ALSA_LIB_PATH	:=  PATH=$(CROSS_PATH)
ALSA_LIB_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
ALSA_LIB_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--disable-python \
	--with-debug=no

ifdef PTXCONF_ALSA_LIB_STATIC
ALSA_LIB_AUTOCONF += --enable-static --disable-shared
else
ALSA_LIB_AUTOCONF += --enable-static
endif

ifdef PTXCONF_ALSA_LIB_RESMGR
ALSA_LIB_AUTOCONF += --enable-resmgr
endif

ifndef PTXCONF_ALSA_LIB_READ
ALSA_LIB_AUTOCONF += --disable-aload
endif

ifndef PTXCONF_ALSA_LIB_MIXER
ALSA_LIB_AUTOCONF += --disable-mixer
endif

ifndef PTXCONF_ALSA_LIB_PCM
ALSA_LIB_AUTOCONF += --disable-pcm
endif

ifndef PTXCONF_ALSA_LIB_RAWMIDI
ALSA_LIB_AUTOCONF += --disable-rawmidi
endif

ifndef PTXCONF_ALSA_LIB_HWDEP
ALSA_LIB_AUTOCONF += --disable-hwdep
else
ALSA_LIB_AUTOCONF += --enable-hwdep
endif

ifndef PTXCONF_ALSA_LIB_SEQ
ALSA_LIB_AUTOCONF += --disable-seq
else
ALSA_LIB_AUTOCONF += --enable-seq
endif

ifndef PTXCONF_ALSA_LIB_INSTR
ALSA_LIB_AUTOCONF += --disable-instr
endif

ifdef PTXCONF_ALSA_LIB_LIGHT
ALSA_LIB_AUTOCONF += --enable-everyhing \
	--enable-tlv \
	--enable-timer \
	--enable-conf \
	--enable-async \
	--enable-libasound \
	--enable-rawmidi
endif

# unhandled, yet
# --with-softfloat
# --with-alsa-devdir=dir
# --with-aload-devdir=dir
# --with-pcm-plugins=<list>


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/alsa-lib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, alsa-lib)
	@$(call install_fixup, alsa-lib, PACKAGE, alsa-lib)
	@$(call install_fixup, alsa-lib, PRIORITY,optional)
	@$(call install_fixup, alsa-lib, VERSION,$(ALSA_LIB_VERSION))
	@$(call install_fixup, alsa-lib, SECTION,base)
	@$(call install_fixup, alsa-lib, AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, alsa-lib, DEPENDS,)
	@$(call install_fixup, alsa-lib, DESCRIPTION,missing)

ifdef PTXCONF_ALSA_LIB_LIGHT
	@$(call install_copy, alsa-lib, 0, 0, 0644, \
		$(ALSA_LIB_DIR)/src/.libs/libsalsa.so.0.0.1, \
		/usr/lib/libsalsa.so.0.0.1 )

	@$(call install_link, alsa-lib, \
		libsalsa.so.0.0.1, \
		/usr/lib/libsalsa.so.0)

	@$(call install_link, alsa-lib, \
		libsalsa.so.0.0.1, \
		/usr/lib/libsalsa.so)

	@$(call install_link, alsa-lib, \
		libsalsa.so, \
		/usr/lib/libasound.so)
endif
ifdef PTXCONF_ALSA_LIB_FULL
	@$(call install_copy, alsa-lib, 0, 0, 0644, \
		$(ALSA_LIB_DIR)/src/.libs/libasound.so.2.0.0, \
		/usr/lib/libasound.so.2.0.0 )

	@$(call install_link, alsa-lib, \
		libasound.so.2.0.0, \
		/usr/lib/libasound.so.2)

	@$(call install_link, alsa-lib, \
		libasound.so.2.0.0, \
		/usr/lib/libasound.so)

ifdef PTXCONF_ALSA_LIB_MIXER
	@$(call install_copy, alsa-lib, \
		0, 0, 0644, $(ALSA_LIB_DIR)/modules/mixer/simple/.libs/smixer-ac97.so, \
		/lib/alsa-lib/smixer/smixer-ac97.so )
endif

ifdef PTXCONF_ALSA_LIB_MIXER
	@$(call install_copy, alsa-lib, \
		0, 0, 0644, $(ALSA_LIB_DIR)/modules/mixer/simple/.libs/smixer-sbase.so, \
		/lib/alsa-lib/smixer/smixer-sbase.so )

	@$(call install_copy, alsa-lib, \
		0, 0, 0644, $(ALSA_LIB_DIR)/modules/mixer/simple/.libs/smixer-hda.so, \
		/lib/alsa-lib/smixer/smixer-hda.so )
endif

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
endif

	@$(call install_finish, alsa-lib)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

alsa-lib_clean:
	rm -rf $(STATEDIR)/alsa-lib.*
	rm -rf $(PKGDIR)/alsa-lib_*
	rm -rf $(ALSA_LIB_DIR)

# vim: syntax=make

