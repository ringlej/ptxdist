# -*-makefile-*-
# $Id: template-make 7626 2007-11-26 10:27:03Z mkl $
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUCDAEMON) += libucdaemon

#
# Paths and names
#
LIBUCDAEMON_VERSION	:= 0.0.5
LIBUCDAEMON		:= libucdaemon-$(LIBUCDAEMON_VERSION)
LIBUCDAEMON_SUFFIX	:= tar.bz2
LIBUCDAEMON_URL		:= http://www.pengutronix.de/software/libucdaemon/download/$(LIBUCDAEMON).$(LIBUCDAEMON_SUFFIX)
LIBUCDAEMON_SOURCE	:= $(SRCDIR)/$(LIBUCDAEMON).$(LIBUCDAEMON_SUFFIX)
LIBUCDAEMON_DIR		:= $(BUILDDIR)/$(LIBUCDAEMON)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libucdaemon_get: $(STATEDIR)/libucdaemon.get

$(STATEDIR)/libucdaemon.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBUCDAEMON_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBUCDAEMON)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libucdaemon_extract: $(STATEDIR)/libucdaemon.extract

$(STATEDIR)/libucdaemon.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBUCDAEMON_DIR))
	@$(call extract, LIBUCDAEMON)
	@$(call patchin, LIBUCDAEMON)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libucdaemon_prepare: $(STATEDIR)/libucdaemon.prepare

LIBUCDAEMON_PATH	:= PATH=$(CROSS_PATH)
LIBUCDAEMON_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBUCDAEMON_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libucdaemon.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBUCDAEMON_DIR)/config.cache)
	cd $(LIBUCDAEMON_DIR) && \
		$(LIBUCDAEMON_PATH) $(LIBUCDAEMON_ENV) \
		./configure $(LIBUCDAEMON_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libucdaemon_compile: $(STATEDIR)/libucdaemon.compile

$(STATEDIR)/libucdaemon.compile:
	@$(call targetinfo, $@)
	cd $(LIBUCDAEMON_DIR) && $(LIBUCDAEMON_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libucdaemon_install: $(STATEDIR)/libucdaemon.install

$(STATEDIR)/libucdaemon.install:
	@$(call targetinfo, $@)
	@$(call install, LIBUCDAEMON)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libucdaemon_targetinstall: $(STATEDIR)/libucdaemon.targetinstall

$(STATEDIR)/libucdaemon.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, libucdaemon)
	@$(call install_fixup, libucdaemon,PACKAGE,libucdaemon)
	@$(call install_fixup, libucdaemon,PRIORITY,optional)
	@$(call install_fixup, libucdaemon,VERSION,$(LIBUCDAEMON_VERSION))
	@$(call install_fixup, libucdaemon,SECTION,base)
	@$(call install_fixup, libucdaemon,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libucdaemon,DEPENDS,)
	@$(call install_fixup, libucdaemon,DESCRIPTION,missing)

	@$(call install_copy, libucdaemon, 0, 0, 0755, \
		$(LIBUCDAEMON_DIR)/src/.libs/libucdaemon.so.0.0.0, \
		/ub/lib/libucdaemon.so.0.0.0)

	@$(call install_link, libucdaemon, libucdaemon.so.0.0.0, /usr/lib/libucdaemon.so.0)
	@$(call install_link, libucdaemon, libucdaemon.so.0.0.0, /usr/lib/libucdaemon.so)

	@$(call install_finish, libucdaemon)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libucdaemon_clean:
	rm -rf $(STATEDIR)/libucdaemon.*
	rm -rf $(PKGDIR)/libucdaemon_*
	rm -rf $(LIBUCDAEMON_DIR)

# vim: syntax=make
