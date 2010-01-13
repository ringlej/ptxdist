# -*-makefile-*-
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

#
# We are depending on the same packet than target's kaffe
#
$(STATEDIR)/host-kaffe.get: $(STATEDIR)/kaffe.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-kaffe.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_KAFFE_DIR))
	@$(call extract, KAFFE, $(HOST_BUILDDIR))
	@$(call patchin, KAFFE, $(HOST_KAFFE_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

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

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------


$(STATEDIR)/host-kaffe.compile:
	@$(call targetinfo)
	cd $(HOST_KAFFE_DIR) && $(HOST_KAFFE_ENV) $(HOST_KAFFE_PATH) make
	@$(call touch)

# vim: syntax=make
