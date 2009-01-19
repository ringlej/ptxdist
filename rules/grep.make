# -*-makefile-*-
# $Id: template-make 8785 2008-08-26 07:48:06Z wsa $
#
# Copyright (C) 2008 by Luotao Fu <l.fu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GREP) += grep

#
# Paths and names
#
GREP_VERSION	:= 2.5.3
GREP		:= grep-$(GREP_VERSION)
GREP_SUFFIX	:= tar.bz2
GREP_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/grep/$(GREP).$(GREP_SUFFIX)
GREP_SOURCE	:= $(SRCDIR)/$(GREP).$(GREP_SUFFIX)
GREP_DIR	:= $(BUILDDIR)/$(GREP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GREP_SOURCE):
	@$(call targetinfo)
	@$(call get, GREP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/grep.extract:
	@$(call targetinfo)
	@$(call clean, $(GREP_DIR))
	@$(call extract, GREP)
	@$(call patchin, GREP)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GREP_PATH	:= PATH=$(CROSS_PATH)
GREP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GREP_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_GREP_PCRE
GREP_AUTOCONF += --enable-perl-regexp
else
GREP_AUTOCONF += --disable-perl-regexp
endif

$(STATEDIR)/grep.prepare:
	@$(call targetinfo)
	@$(call clean, $(GREP_DIR)/config.cache)
	cd $(GREP_DIR) && \
		$(GREP_PATH) $(GREP_ENV) \
		./configure $(GREP_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/grep.compile:
	@$(call targetinfo)
	cd $(GREP_DIR) && $(GREP_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/grep.install:
	@$(call targetinfo)
	@$(call install, GREP)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/grep.targetinstall:
	@$(call targetinfo)

	@$(call install_init, grep)
	@$(call install_fixup, grep,PACKAGE,grep)
	@$(call install_fixup, grep,PRIORITY,optional)
	@$(call install_fixup, grep,VERSION,$(GREP_VERSION))
	@$(call install_fixup, grep,SECTION,base)
	@$(call install_fixup, grep,AUTHOR,"Luotao Fu <l.fu\@pengutronix.de>")
	@$(call install_fixup, grep,DEPENDS,)
	@$(call install_fixup, grep,DESCRIPTION,missing)

	@$(call install_copy, grep, 0, 0, 0755, $(GREP_DIR)/src/grep, /bin/grep)

	@$(call install_finish, grep)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

grep_clean:
	rm -rf $(STATEDIR)/grep.*
	rm -rf $(PKGDIR)/grep_*
	rm -rf $(GREP_DIR)

# vim: syntax=make
