# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
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
PACKAGES-$(PTXCONF_SCREEN) += screen

#
# Paths and names
#
SCREEN_VERSION	:= 4.0.2
SCREEN		:= screen-$(SCREEN_VERSION)
SCREEN_SUFFIX	:= tar.gz
SCREEN_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/screen/$(SCREEN).$(SCREEN_SUFFIX)
SCREEN_SOURCE	:= $(SRCDIR)/$(SCREEN).$(SCREEN_SUFFIX)
SCREEN_DIR	:= $(BUILDDIR)/$(SCREEN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

screen_get: $(STATEDIR)/screen.get

$(STATEDIR)/screen.get: $(screen_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SCREEN_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SCREEN)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

screen_extract: $(STATEDIR)/screen.extract

$(STATEDIR)/screen.extract: $(screen_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SCREEN_DIR))
	@$(call extract, SCREEN)
	@$(call patchin, SCREEN)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

screen_prepare: $(STATEDIR)/screen.prepare

SCREEN_PATH	:= PATH=$(CROSS_PATH)
SCREEN_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SCREEN_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--with-sys-screenrc=/etc/screenrc

$(STATEDIR)/screen.prepare: $(screen_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SCREEN_DIR)/config.cache)
	cd $(SCREEN_DIR) && \
		$(SCREEN_PATH) $(SCREEN_ENV) \
		./configure $(SCREEN_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

screen_compile: $(STATEDIR)/screen.compile

$(STATEDIR)/screen.compile: $(screen_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SCREEN_DIR) && $(SCREEN_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

screen_install: $(STATEDIR)/screen.install

$(STATEDIR)/screen.install: $(screen_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, SCREEN)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

screen_targetinstall: $(STATEDIR)/screen.targetinstall

$(STATEDIR)/screen.targetinstall: $(screen_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, screen)
	@$(call install_fixup,screen,PACKAGE,screen)
	@$(call install_fixup,screen,PRIORITY,optional)
	@$(call install_fixup,screen,VERSION,$(SCREEN_VERSION))
	@$(call install_fixup,screen,SECTION,base)
	@$(call install_fixup,screen,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,screen,DEPENDS,)
	@$(call install_fixup,screen,DESCRIPTION,missing)

	@$(call install_copy, screen, 0, 0, 0755, $(SCREEN_DIR)/screen, /usr/bin/screen)

	@if [ -n "$(PTXCONF_SCREEN_CONFIG_FILE)" ]; then \
		$(call install_copy, screen, 0, 0, 0755, $(PTXCONF_SCREEN_CONFIG_FILE), /etc/screenrc, n); \
	fi

	@$(call install_finish,screen)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

screen_clean:
	rm -rf $(STATEDIR)/screen.*
	rm -rf $(IMAGEDIR)/screen_*
	rm -rf $(SCREEN_DIR)

# vim: syntax=make
