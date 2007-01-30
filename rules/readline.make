# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by Sascha Hauer
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
READLINE_VERSION	= 5.0
READLINE		= readline-$(READLINE_VERSION)
READLINE_SUFFIX		= tar.gz
READLINE_URL		= $(PTXCONF_SETUP_GNUMIRROR)/readline/$(READLINE).$(READLINE_SUFFIX)
READLINE_SOURCE		= $(SRCDIR)/$(READLINE).$(READLINE_SUFFIX)
READLINE_DIR		= $(BUILDDIR)/$(READLINE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

readline_get: $(STATEDIR)/readline.get

$(STATEDIR)/readline.get: $(readline_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(READLINE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, READLINE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

readline_extract: $(STATEDIR)/readline.extract

$(STATEDIR)/readline.extract: $(readline_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(READLINE_DIR))
	@$(call extract, READLINE)
	@$(call patchin, READLINE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

readline_prepare: $(STATEDIR)/readline.prepare

READLINE_PATH	  =  PATH=$(CROSS_PATH)
READLINE_ENV 	  =  $(CROSS_ENV)
READLINE_MAKEVARS = DESTDIR=$(SYSROOT)

#
# autoconf
#
READLINE_AUTOCONF := $(CROSS_AUTOCONF_USR) \
		--enable-shared \
		--disable-static\
		--disable-multibyte

ifdef PTXCONF_READLINE_TERMCAP
READLINE_AUTOCONF += --without-curses
endif
ifdef PTXCONF_READLINE_NCURSES
# uses termcap instead of ncurses if both are found!
READLINE_AUTOCONF += --with-curses
endif

$(STATEDIR)/readline.prepare: $(readline_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(READLINE_DIR)/config.cache)
	cd $(READLINE_DIR) && \
		$(READLINE_PATH) $(READLINE_ENV) \
		./configure $(READLINE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

readline_compile: $(STATEDIR)/readline.compile

$(STATEDIR)/readline.compile: $(readline_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(READLINE_DIR) && $(READLINE_ENV) $(READLINE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

readline_install: $(STATEDIR)/readline.install

$(STATEDIR)/readline.install: $(readline_install_deps_default)
	@$(call targetinfo, $@)
	cd $(READLINE_DIR) && \
		$(READLINE_ENV) $(READLINE_PATH) \
		make install \
		$(READLINE_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

readline_targetinstall: $(STATEDIR)/readline.targetinstall

$(STATEDIR)/readline.targetinstall: $(readline_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, readline)
	@$(call install_fixup, readline,PACKAGE,readline)
	@$(call install_fixup, readline,PRIORITY,optional)
	@$(call install_fixup, readline,VERSION,$(READLINE_VERSION))
	@$(call install_fixup, readline,SECTION,base)
	@$(call install_fixup, readline,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, readline,DEPENDS,)
	@$(call install_fixup, readline,DESCRIPTION,missing)

	@$(call install_copy, readline, 0, 0, 0644, $(READLINE_DIR)/shlib/libreadline.so.5.0, /lib/libreadline.so.5.0)
	@$(call install_link, readline, libreadline.so.5.0, /lib/libreadline.so.5)
	@$(call install_link, readline, libreadline.so.5.0, /lib/libreadline.so)

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
