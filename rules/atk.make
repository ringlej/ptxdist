# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2006 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
#                         Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ATK) += atk

#
# Paths and names
#
ATK_VERSION	:= 1.28.0
ATK		:= atk-$(ATK_VERSION)
ATK_SUFFIX	:= tar.bz2
ATK_URL		:= http://ftp.gnome.org/pub/gnome/sources/atk/1.28/$(ATK).$(ATK_SUFFIX)
ATK_SOURCE	:= $(SRCDIR)/$(ATK).$(ATK_SUFFIX)
ATK_DIR		:= $(BUILDDIR)/$(ATK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

atk_get: $(STATEDIR)/atk.get

$(STATEDIR)/atk.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ATK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, ATK)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

atk_extract: $(STATEDIR)/atk.extract

$(STATEDIR)/atk.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(ATK_DIR))
	@$(call extract, ATK)
	@$(call patchin, ATK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

atk_prepare: $(STATEDIR)/atk.prepare

ATK_PATH	:= PATH=$(CROSS_PATH)
ATK_ENV		:= $(CROSS_ENV)

#
# autoconf
#
ATK_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static \
	--disable-glibtest

$(STATEDIR)/atk.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(ATK_DIR)/config.cache)
	cd $(ATK_DIR) && \
		$(ATK_PATH) $(ATK_ENV) \
		./configure $(ATK_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

atk_compile: $(STATEDIR)/atk.compile

$(STATEDIR)/atk.compile:
	@$(call targetinfo, $@)
	cd $(ATK_DIR) && $(ATK_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

atk_install: $(STATEDIR)/atk.install

$(STATEDIR)/atk.install:
	@$(call targetinfo, $@)
	@$(call install, ATK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

atk_targetinstall: $(STATEDIR)/atk.targetinstall

$(STATEDIR)/atk.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, atk)
	@$(call install_fixup,atk,PACKAGE,atk)
	@$(call install_fixup,atk,PRIORITY,optional)
	@$(call install_fixup,atk,VERSION,$(ATK_VERSION))
	@$(call install_fixup,atk,SECTION,base)
	@$(call install_fixup,atk,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,atk,DEPENDS,)
	@$(call install_fixup,atk,DESCRIPTION,missing)

	@$(call install_copy, atk, 0, 0, 0644, -, \
		/usr/lib/libatk-1.0.so.0.2809.1)
	@$(call install_link, atk, libatk-1.0.so.0.2809.1, /usr/lib/libatk-1.0.so.0)
	@$(call install_link, atk, libatk-1.0.so.0.2809.1, /usr/lib/libatk-1.0.so)

	@$(call install_finish,atk)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

atk_clean:
	rm -rf $(STATEDIR)/atk.*
	rm -rf $(PKGDIR)/atk_*
	rm -rf $(ATK_DIR)

# vim: syntax=make
