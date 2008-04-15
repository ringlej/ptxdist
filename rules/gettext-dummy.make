# -*-makefile-*-
# $Id: template-make 8008 2008-04-15 07:39:46Z mkl $
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
PACKAGES-$(PTXCONF_GETTEXT_DUMMY) += gettext-dummy

#
# Paths and names
#
GETTEXT_DUMMY_VERSION	:= 1.0.1
GETTEXT_DUMMY		:= gettext-dummy-$(GETTEXT_DUMMY_VERSION)
GETTEXT_DUMMY_SUFFIX	:= tar.bz2
GETTEXT_DUMMY_URL	:= http://www.pengutronix.de/software/gettext-dummy/download/$(GETTEXT_DUMMY).$(GETTEXT_DUMMY_SUFFIX)
GETTEXT_DUMMY_SOURCE	:= $(SRCDIR)/$(GETTEXT_DUMMY).$(GETTEXT_DUMMY_SUFFIX)
GETTEXT_DUMMY_DIR	:= $(BUILDDIR)/$(GETTEXT_DUMMY)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/gettext-dummy.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GETTEXT_DUMMY_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GETTEXT_DUMMY)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/gettext-dummy.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(GETTEXT_DUMMY_DIR))
	@$(call extract, GETTEXT_DUMMY)
	@$(call patchin, GETTEXT_DUMMY)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GETTEXT_DUMMY_PATH	:= PATH=$(CROSS_PATH)
GETTEXT_DUMMY_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GETTEXT_DUMMY_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/gettext-dummy.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(GETTEXT_DUMMY_DIR)/config.cache)
	cd $(GETTEXT_DUMMY_DIR) && \
		$(GETTEXT_DUMMY_PATH) $(GETTEXT_DUMMY_ENV) \
		./configure $(GETTEXT_DUMMY_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/gettext-dummy.compile:
	@$(call targetinfo, $@)
	cd $(GETTEXT_DUMMY_DIR) && $(GETTEXT_DUMMY_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gettext-dummy.install:
	@$(call targetinfo, $@)
	@$(call install, GETTEXT_DUMMY)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gettext-dummy.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, gettext-dummy)
	@$(call install_fixup, gettext-dummy,PACKAGE,gettext-dummy)
	@$(call install_fixup, gettext-dummy,PRIORITY,optional)
	@$(call install_fixup, gettext-dummy,VERSION,$(GETTEXT_DUMMY_VERSION))
	@$(call install_fixup, gettext-dummy,SECTION,base)
	@$(call install_fixup, gettext-dummy,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gettext-dummy,DEPENDS,)
	@$(call install_fixup, gettext-dummy,DESCRIPTION,missing)

	@$(call install_copy, gettext-dummy, 0, 0, 0644, \
		$(GETTEXT_DUMMY_DIR)/.libs/libintl.so.0.0.0, \
		/usr/lib/libpv.so.0.0.0)

	@$(call install_link, gettext-dummy, libintl.so.0.0.0, /usr/lib/libintl.so.0)
	@$(call install_link, gettext-dummy, libintl.so.0.0.0, /usr/lib/libintl.so)

	@$(call install_finish, gettext-dummy)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gettext-dummy_clean:
	rm -rf $(STATEDIR)/gettext-dummy.*
	rm -rf $(IMAGEDIR)/gettext-dummy_*
	rm -rf $(GETTEXT_DUMMY_DIR)

# vim: syntax=make
