# -*-makefile-*-
# $Id: template-make 7759 2008-02-12 21:05:07Z mkl $
#
# Copyright (C) 2004 by Sascha Hauer
#               2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_READLINE) += readline

#
# Paths and names
#
READLINE_VERSION	:= 5.2
READLINE		:= readline-$(READLINE_VERSION)
READLINE_SUFFIX		:= tar.gz
READLINE_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/readline/$(READLINE).$(READLINE_SUFFIX)
READLINE_SOURCE		:= $(SRCDIR)/$(READLINE).$(READLINE_SUFFIX)
READLINE_DIR		:= $(BUILDDIR)/$(READLINE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/readline.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(READLINE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, READLINE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/readline.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(READLINE_DIR))
	@$(call extract, READLINE)
	@$(call patchin, READLINE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

READLINE_PATH	:= PATH=$(CROSS_PATH)
READLINE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
READLINE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static\
	--disable-multibyte

ifdef PTXCONF_READLINE_TERMCAP
READLINE_AUTOCONF += --without-curses
endif
ifdef PTXCONF_READLINE_NCURSES
READLINE_AUTOCONF += --with-curses
endif

$(STATEDIR)/readline.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(READLINE_DIR)/config.cache)
	cd $(READLINE_DIR) && \
		$(READLINE_PATH) $(READLINE_ENV) \
		./configure $(READLINE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/readline.compile:
	@$(call targetinfo, $@)
	cd $(READLINE_DIR) && $(READLINE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/readline.install:
	@$(call targetinfo, $@)
	@$(call install, READLINE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/readline.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, readline)
	@$(call install_fixup, readline,PACKAGE,readline)
	@$(call install_fixup, readline,PRIORITY,optional)
	@$(call install_fixup, readline,VERSION,$(READLINE_VERSION))
	@$(call install_fixup, readline,SECTION,base)
	@$(call install_fixup, readline,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, readline,DEPENDS,)
	@$(call install_fixup, readline,DESCRIPTION,missing)

	@$(call install_copy, readline, 0, 0, 0644, $(READLINE_DIR)/shlib/libreadline.so.5.2, /lib/libreadline.so.5.2)
	@$(call install_link, readline, libreadline.so.5.2, /lib/libreadline.so.5)
	@$(call install_link, readline, libreadline.so.5.2, /lib/libreadline.so)

	@$(call install_finish, readline)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

readline_clean:
	rm -rf $(STATEDIR)/readline.*
	rm -rf $(IMAGEDIR)/readline_*
	rm -rf $(READLINE_DIR)

# vim: syntax=make
