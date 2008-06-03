# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#                            Pengutronix <info@pengutronix.de>, Germany
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

$(STATEDIR)/gettext.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GETTEXT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GETTEXT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/gettext.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(GETTEXT_DIR))
	@$(call extract, GETTEXT)
	@$(call patchin, GETTEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

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

$(STATEDIR)/gettext.compile:
	@$(call targetinfo, $@)
	cd $(GETTEXT_DIR) && $(GETTEXT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gettext.install:
	@$(call targetinfo, $@)
	@$(call install, GETTEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

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

	@$(call install_copy, gettext, 0, 0, 0755, $(GETTEXT_DIR)/gettext-tools/src/xgettext, /usr/bin/xgettext)
	@$(call install_copy, gettext, 0, 0, 0755, $(GETTEXT_DIR)/gettext-runtime/src/gettext, /usr/bin/gettext)

	@$(call install_copy, gettext, 0, 0, 0644, \
		$(GETTEXT_DIR)/gettext-tools/gnulib-lib/.libs/libgettextlib-0.16.1.so, \
		/usr/lib/libgettextlib-0.16.1.so)

	@$(call install_copy, gettext, 0, 0, 0644, \
		$(GETTEXT_DIR)/gettext-runtime/libasprintf/.libs/libasprintf.so.0.0.0, \
		/usr/lib/libasprintf.so.0.0.0)

	@$(call install_copy, gettext, 0, 0, 0644, \
		$(GETTEXT_DIR)/gettext-tools/libgettextpo/.libs/libgettextpo.so.0.3.0, \
		/usr/lib/libgettextpo.so.0.3.0)

	@$(call install_copy, gettext, 0, 0, 0644, \
		$(GETTEXT_DIR)/gettext-tools/src/.libs/libgettextsrc-0.16.1.so, \
		/usr/lib/libgettextsrc-0.16.1.so)

	@$(call install_finish, gettext)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gettext_clean:
	rm -rf $(STATEDIR)/gettext.*
	rm -rf $(PKGDIR)/gettext_*
	rm -rf $(GETTEXT_DIR)

# vim: syntax=make
