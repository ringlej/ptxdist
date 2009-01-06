# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBLZO) += host-liblzo

#
# Paths and names
#
HOST_LIBLZO_DIR	= $(HOST_BUILDDIR)/$(LIBLZO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-liblzo_get: $(STATEDIR)/host-liblzo.get

$(STATEDIR)/host-liblzo.get: $(STATEDIR)/liblzo.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-liblzo_extract: $(STATEDIR)/host-liblzo.extract

$(STATEDIR)/host-liblzo.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBLZO_DIR))
	@$(call extract, LIBLZO, $(HOST_BUILDDIR))
	@$(call patchin, LIBLZO, $(HOST_LIBLZO_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-liblzo_prepare: $(STATEDIR)/host-liblzo.prepare

HOST_LIBLZO_PATH	:= PATH=$(HOST_PATH)
HOST_LIBLZO_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBLZO_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-liblzo.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBLZO_DIR)/config.cache)
	cd $(HOST_LIBLZO_DIR) && \
		$(HOST_LIBLZO_PATH) $(HOST_LIBLZO_ENV) \
		./configure $(HOST_LIBLZO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-liblzo_compile: $(STATEDIR)/host-liblzo.compile

$(STATEDIR)/host-liblzo.compile:
	@$(call targetinfo, $@)
	cd $(HOST_LIBLZO_DIR) && $(HOST_LIBLZO_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-liblzo_install: $(STATEDIR)/host-liblzo.install

$(STATEDIR)/host-liblzo.install:
	@$(call targetinfo, $@)
	@$(call install, HOST_LIBLZO,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-liblzo_clean:
	rm -rf $(STATEDIR)/host-liblzo.*
	rm -rf $(HOST_LIBLZO_DIR)

# vim: syntax=make
