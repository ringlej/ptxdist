# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#               Pengutronix <info@pengutronix.de>, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GETTEXT) += gettext

#
# Paths and names
#
GETTEXT_VERSION	:= 0.16.1
GETTEXT		:= gettext-$(GETTEXT_VERSION)
GETTEXT_SUFFIX	:= tar.gz
GETTEXT_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/gettext/$(GETTEXT).$(GETTEXT_SUFFIX)
GETTEXT_SOURCE	:= $(SRCDIR)/$(GETTEXT).$(GETTEXT_SUFFIX)
GETTEXT_DIR	:= $(BUILDDIR)/$(GETTEXT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gettext_get: $(STATEDIR)/gettext.get

$(STATEDIR)/gettext.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GETTEXT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GETTEXT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gettext_extract: $(STATEDIR)/gettext.extract

$(STATEDIR)/gettext.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(GETTEXT_DIR))
	@$(call extract, GETTEXT)
	@$(call patchin, GETTEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gettext_prepare: $(STATEDIR)/gettext.prepare

GETTEXT_PATH	:= PATH=$(CROSS_PATH)
GETTEXT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GETTEXT_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-java \
	--disable-native-java \
	--disable-csharp


$(STATEDIR)/gettext.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(GETTEXT_DIR)/config.cache)
	cd $(GETTEXT_DIR) && \
		$(GETTEXT_PATH) $(GETTEXT_ENV) \
		./configure $(GETTEXT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gettext_compile: $(STATEDIR)/gettext.compile

$(STATEDIR)/gettext.compile:
	@$(call targetinfo, $@)
	cd $(GETTEXT_DIR) && $(GETTEXT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gettext_install: $(STATEDIR)/gettext.install

$(STATEDIR)/gettext.install:
	@$(call targetinfo, $@)
	@$(call install, GETTEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gettext_targetinstall: $(STATEDIR)/gettext.targetinstall

$(STATEDIR)/gettext.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, gettext)
	@$(call install_fixup, gettext,PACKAGE,gettext)
	@$(call install_fixup, gettext,PRIORITY,optional)
	@$(call install_fixup, gettext,VERSION,$(GETTEXT_VERSION))
	@$(call install_fixup, gettext,SECTION,base)
	@$(call install_fixup, gettext,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gettext,DEPENDS,)
	@$(call install_fixup, gettext,DESCRIPTION,missing)

	@$(call install_copy, gettext, 0, 0, 0755, $(GETTEXT_DIR)/foobar, /dev/null)

	@$(call install_finish, gettext)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gettext_clean:
	rm -rf $(STATEDIR)/gettext.*
	rm -rf $(IMAGEDIR)/gettext_*
	rm -rf $(GETTEXT_DIR)

# vim: syntax=make
