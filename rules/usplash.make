# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
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
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_USPLASH) += usplash

#
# Paths and names
#
USPLASH_VERSION	:= 0.5.21
USPLASH		:= usplash_$(USPLASH_VERSION)
USPLASH_SUFFIX	:= tar.gz
USPLASH_URL	:= http://archive.ubuntu.com/ubuntu/pool/main/u/usplash/$(USPLASH).$(USPLASH_SUFFIX)
USPLASH_SOURCE	:= $(SRCDIR)/$(USPLASH).$(USPLASH_SUFFIX)
USPLASH_DIR	:= $(BUILDDIR)/$(USPLASH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(USPLASH_SOURCE):
	@$(call targetinfo)
	@$(call get, USPLASH)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/usplash.extract:
	@$(call targetinfo)
	@$(call clean, $(USPLASH_DIR))
	@$(call extract, USPLASH)
	mv $(BUILDDIR)/usplash $(USPLASH_DIR)
	@$(call patchin, USPLASH)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

USPLASH_PATH	:= PATH=$(CROSS_PATH)
USPLASH_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
USPLASH_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-svga-backend \
	--disable-convert-tools

$(STATEDIR)/usplash.prepare:
	@$(call targetinfo)
	@$(call clean, $(USPLASH_DIR)/config.cache)
	cd $(USPLASH_DIR) && \
		$(USPLASH_PATH) $(USPLASH_ENV) \
		sh ./configure $(USPLASH_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/usplash.compile:
	@$(call targetinfo)
	cd $(USPLASH_DIR) && \
		$(USPLASH_ENV) $(USPLASH_PATH) \
		$(MAKE) \
		$(PARALLELMFLAGS_BROKEN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/usplash.targetinstall:
	@$(call targetinfo)

	@$(call install_init, usplash)
	@$(call install_fixup, usplash,PACKAGE,usplash)
	@$(call install_fixup, usplash,PRIORITY,optional)
	@$(call install_fixup, usplash,VERSION,$(USPLASH_VERSION))
	@$(call install_fixup, usplash,SECTION,base)
	@$(call install_fixup, usplash,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, usplash,DEPENDS,)
	@$(call install_fixup, usplash,DESCRIPTION,missing)

	@$(call install_copy, usplash, 0, 0, 0755, $(USPLASH_DIR)/usplash, /sbin/usplash)
	@$(call install_copy, usplash, 0, 0, 0755, $(USPLASH_DIR)/usplash_write, /sbin/usplash_write)
	@$(call install_copy, usplash, 0, 0, 0755, $(USPLASH_DIR)/usplash_down, /sbin/usplash_down)
	@$(call install_copy, usplash, 0, 0, 0755, $(USPLASH_DIR)/update-usplash-theme, /sbin/update-usplash-theme)
	@$(call install_copy, usplash, 0, 0, 0644, $(USPLASH_DIR)/.libs/libusplash.so.0, /lib/libusplash.so.0)
	@$(call install_link, usplash, libusplash.so.0, /lib/libusplash.so)

	@$(call install_finish, usplash)

	@$(call touch)

# vim: syntax=make
