# -*-makefile-*-
# $Id: template 3345 2005-11-14 17:14:19Z rsc $
#
# Copyright (C) 2005 by Sascha Hauer
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MPLAYER) += mplayer

#
# Paths and names
#
MPLAYER_VERSION	:= 1.0pre7try2
MPLAYER		:= MPlayer-$(MPLAYER_VERSION)
MPLAYER_SUFFIX	:= tar.bz2
MPLAYER_URL	:= http://www.mplayerhq.hu/MPlayer/releases/$(MPLAYER).$(MPLAYER_SUFFIX)
MPLAYER_SOURCE	:= $(SRCDIR)/$(MPLAYER).$(MPLAYER_SUFFIX)
MPLAYER_DIR	:= $(BUILDDIR)/$(MPLAYER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mplayer_get: $(STATEDIR)/mplayer.get

$(STATEDIR)/mplayer.get: $(mplayer_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MPLAYER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MPLAYER)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mplayer_extract: $(STATEDIR)/mplayer.extract

$(STATEDIR)/mplayer.extract: $(mplayer_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MPLAYER_DIR))
	@$(call extract, MPLAYER)
	@$(call patchin, MPLAYER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mplayer_prepare: $(STATEDIR)/mplayer.prepare

MPLAYER_PATH	:= PATH=$(CROSS_PATH)

CFLAGS_BASE	:= -Wl,-rpath-link -Wl,-L$(strip $(SYSROOT))/usr/lib
CFLGAS_EXTRA	:=
ifdef PTXCONF_ARCH_X86
CFLAGS_EXTRA	+= -O2
endif
MPLAYER_ENV 	:= CFLAGS='$(CFLAGS_BASE) $(CFLAGS_EXTRA)'
#
# autoconf
#
MPLAYER_AUTOCONF :=\
	--cc=$(PTXCONF_GNU_TARGET)-gcc \
	--as=$(PTXCONF_GNU_TARGET)-as \
	--host-cc=$(HOSTCC) \
	--target=$(PTXCONF_ARCH_STRING) \
	--disable-mencoder \
	--with-x11incdir=$(SYSROOT)/usr/include \
	--with-x11libdir=$(SYSROOT)/usr/lib \
	--with-extraincdir=$(SYSROOT)/usr/include \
	--with-extralibdir=$(SYSROOT)/usr/lib

ifdef PTXCONF_MPLAYER_V4L2
MPLAYER_AUTOCONF += --enable-tv-v4l2
else
MPLAYER_AUTOCONF += --disable-tv-v4l2
endif

ifdef PTXCONF_MPLAYER_VO_JPEG
MPLAYER_AUTOCONF += --enable-jpeg
else
MPLAYER_AUTOCONF += --disable-jpeg
endif

ifdef PTXCONF_MPLAYER_VO_XV
MPLAYER_AUTOCONF += --enable-xv
else
MPLAYER_AUTOCONF += --disable-xv
endif

ifdef PTXCONF_MPLAYER_VO_X11
MPLAYER_AUTOCONF += --enable-x11
else
MPLAYER_AUTOCONF += --disable-x11
endif

ifdef PTXCONF_MPLAYER_VO_FBDEV
MPLAYER_AUTOCONF += --enable-fbdev
else
MPLAYER_AUTOCONF += --disable-fbdev
endif

$(STATEDIR)/mplayer.prepare: $(mplayer_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MPLAYER_DIR)/config.cache)
	cd $(MPLAYER_DIR) && \
		$(MPLAYER_PATH) $(MPLAYER_ENV) \
		./configure $(MPLAYER_AUTOCONF)
	@echo 
	@echo FIXME: this is necessary with gcc 3.4.4 which runs into OOM with -O4
	@echo
#	sed -ie "s/[ \t]-O4[ \t]/ -O2 /g" $(MPLAYER_DIR)/config.mak
	@echo
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mplayer_compile: $(STATEDIR)/mplayer.compile

$(STATEDIR)/mplayer.compile: $(mplayer_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MPLAYER_DIR) && $(MPLAYER_ENV) $(MPLAYER_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mplayer_install: $(STATEDIR)/mplayer.install

$(STATEDIR)/mplayer.install: $(mplayer_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mplayer_targetinstall: $(STATEDIR)/mplayer.targetinstall

$(STATEDIR)/mplayer.targetinstall: $(mplayer_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, mplayer)
	@$(call install_fixup, mplayer,PACKAGE,mplayer)
	@$(call install_fixup, mplayer,PRIORITY,optional)
	@$(call install_fixup, mplayer,VERSION,$(MPLAYER_VERSION))
	@$(call install_fixup, mplayer,SECTION,base)
	@$(call install_fixup, mplayer,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, mplayer,DEPENDS,)
	@$(call install_fixup, mplayer,DESCRIPTION,missing)

	@$(call install_copy, mplayer, 0, 0, 0755, $(MPLAYER_DIR)/mplayer, /usr/bin/mplayer)

	@$(call install_finish, mplayer)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mplayer_clean:
	rm -rf $(STATEDIR)/mplayer.*
	rm -rf $(IMAGEDIR)/mplayer_*
	rm -rf $(MPLAYER_DIR)

# vim: syntax=make
