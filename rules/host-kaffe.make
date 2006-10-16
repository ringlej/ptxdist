# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#

#
HOST_PACKAGES-$(PTXCONF_HOST_KAFFE) += host-kaffe

#
# Paths and names
#
HOST_KAFFE		= $(KAFFE)
HOST_KAFFE_DIR		= $(HOST_BUILDDIR)/$(HOST_KAFFE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-kaffe_get: $(STATEDIR)/host-kaffe.get

#
# We are depending on the same packet than target's kaffe
#
$(STATEDIR)/host-kaffe.get: $(STATEDIR)/kaffe.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-kaffe_extract: $(STATEDIR)/host-kaffe.extract

$(STATEDIR)/host-kaffe.extract: $(host-kaffe_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_KAFFE_DIR))
	@$(call extract, KAFFE, $(HOST_BUILDDIR))
	@$(call patchin, KAFFE, $(HOST_KAFFE_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-kaffe_prepare: $(STATEDIR)/host-kaffe.prepare

HOST_KAFFE_PATH	:= PATH=$(HOST_PATH)
HOST_KAFFE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_KAFFE_AUTOCONF	:= $(HOST_AUTOCONF) \
	--without-esd \
	--without-alsa \
	--without-sound \
	--disable-alsa \
	--disable-gtk-peer \
	--disable-esd \
	--disable-dssi \
	--disable-nls \
	--disable-largefile \
	--disable-dependency-tracking

ifdef PTXCONF_KAFFE_JAVAC_ECJ
HOST_KAFFE_AUTOCONF += --with-ecj
endif

ifdef PTXCONF_KAFFE_JAVAC_JIKES
HOST_KAFFE_AUTOCONF += --with-jikes
endif

$(STATEDIR)/host-kaffe.prepare: $(host-kaffe_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_KAFFE_DIR)/config.cache)
	cd $(HOST_KAFFE_DIR) && \
		$(HOST_KAFFE_PATH) $(HOST_KAFFE_ENV) \
		./configure $(HOST_KAFFE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-kaffe_compile: $(STATEDIR)/host-kaffe.compile


$(STATEDIR)/host-kaffe.compile: $(host-kaffe_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_KAFFE_DIR) && $(HOST_KAFFE_ENV) $(HOST_KAFFE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-kaffe_install: $(STATEDIR)/host-kaffe.install

$(STATEDIR)/host-kaffe.install: $(host-kaffe_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_KAFFE,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-kaffe_clean:
	rm -rf $(STATEDIR)/host-kaffe.*
	rm -rf $(HOST_KAFFE_DIR)

# vim: syntax=make
