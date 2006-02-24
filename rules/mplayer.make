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
MPLAYER_VERSION	= 1.0pre7try2
MPLAYER		= MPlayer-$(MPLAYER_VERSION)
MPLAYER_SUFFIX	= tar.bz2
MPLAYER_URL	= http://ftp5.mplayerhq.hu/mplayer/releases/$(MPLAYER).$(MPLAYER_SUFFIX)
MPLAYER_SOURCE	= $(SRCDIR)/$(MPLAYER).$(MPLAYER_SUFFIX)
MPLAYER_DIR	= $(BUILDDIR)/$(MPLAYER)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mplayer_get: $(STATEDIR)/mplayer.get

$(STATEDIR)/mplayer.get: $(mplayer_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MPLAYER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MPLAYER_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mplayer_extract: $(STATEDIR)/mplayer.extract

$(STATEDIR)/mplayer.extract: $(mplayer_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MPLAYER_DIR))
	@$(call extract, $(MPLAYER_SOURCE))
	@$(call patchin, $(MPLAYER))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mplayer_prepare: $(STATEDIR)/mplayer.prepare

MPLAYER_PATH	=  PATH=$(CROSS_PATH)
MPLAYER_ENV 	=  $(CROSS_ENV)
MPLAYER_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
#MPLAYER_AUTOCONF = $(CROSS_AUTOCONF_USR)

MPLAYER_AUTOCONF =  --cc=$(PTXCONF_GNU_TARGET)-gcc
MPLAYER_AUTOCONF += --as=$(PTXCONF_GNU_TARGET)-as
MPLAYER_AUTOCONF += --host-cc=$(HOSTCC)
MPLAYER_AUTOCONF += --target=$(PTXCONF_ARCH)
MPLAYER_AUTOCONF += --disable-mencoder
MPLAYER_AUTOCONF += --enable-fbdev

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
	cd $(MPLAYER_DIR) && $(MPLAYER_ENV) $(MPLAYER_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mplayer_install: $(STATEDIR)/mplayer.install

$(STATEDIR)/mplayer.install: $(mplayer_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, MPLAYER)
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
