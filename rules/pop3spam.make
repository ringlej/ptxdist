# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POP3SPAM) += pop3spam

#
# Paths and names
#
POP3SPAM_VERSION	= 0.9
POP3SPAM		= pop3spam-$(POP3SPAM_VERSION)
POP3SPAM_SUFFIX		= tar.bz2
POP3SPAM_URL		= $(PTXCONF_SETUP_SFMIRROR)/pop3spam/$(POP3SPAM).$(POP3SPAM_SUFFIX)
POP3SPAM_SOURCE		= $(SRCDIR)/$(POP3SPAM).$(POP3SPAM_SUFFIX)
POP3SPAM_DIR		= $(BUILDDIR)/$(POP3SPAM)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pop3spam_get: $(STATEDIR)/pop3spam.get

$(STATEDIR)/pop3spam.get: $(pop3spam_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(POP3SPAM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(POP3SPAM_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pop3spam_extract: $(STATEDIR)/pop3spam.extract

$(STATEDIR)/pop3spam.extract: $(pop3spam_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(POP3SPAM_DIR))
	@$(call extract, $(POP3SPAM_SOURCE))
	@$(call patchin, $(POP3SPAM))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pop3spam_prepare: $(STATEDIR)/pop3spam.prepare

POP3SPAM_PATH	=  PATH=$(CROSS_PATH)
POP3SPAM_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
POP3SPAM_AUTOCONF = $(CROSS_AUTOCONF_USR)

$(STATEDIR)/pop3spam.prepare: $(pop3spam_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(POP3SPAM_DIR)/config.cache)
	cd $(POP3SPAM_DIR) && \
		$(POP3SPAM_PATH) $(POP3SPAM_ENV) \
		./configure $(POP3SPAM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pop3spam_compile: $(STATEDIR)/pop3spam.compile

pop3spam_compile_deps = $(STATEDIR)/pop3spam.prepare

$(STATEDIR)/pop3spam.compile: $(pop3spam_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(POP3SPAM_DIR) && $(POP3SPAM_ENV) $(POP3SPAM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pop3spam_install: $(STATEDIR)/pop3spam.install

$(STATEDIR)/pop3spam.install: $(pop3spam_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, POP3SPAM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pop3spam_targetinstall: $(STATEDIR)/pop3spam.targetinstall

pop3spam_targetinstall_deps =  $(STATEDIR)/pop3spam.compile
pop3spam_targetinstall_deps += $(STATEDIR)/pcre.targetinstall

$(STATEDIR)/pop3spam.targetinstall: $(pop3spam_targetinstall_deps_default)
	@$(call targetinfo, $@)
	
	@$(call install_init, pop3spam)
	@$(call install_fixup, pop3spam,PACKAGE,pop3spam)
	@$(call install_fixup, pop3spam,PRIORITY,optional)
	@$(call install_fixup, pop3spam,VERSION,$(POP3SPAM_VERSION))
	@$(call install_fixup, pop3spam,SECTION,base)
	@$(call install_fixup, pop3spam,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, pop3spam,DEPENDS,)
	@$(call install_fixup, pop3spam,DESCRIPTION,missing)
	
	@$(call install_copy, pop3spam, 0, 0, 0555, $(POP3SPAM_DIR)/src/pop3spam, /usr/bin/pop3spam)

	@$(call install_finish, pop3spam)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pop3spam_clean:
	rm -rf $(STATEDIR)/pop3spam.*
	rm -rf $(IMAGEDIR)/pop3spam_*
	rm -rf $(POP3SPAM_DIR)

# vim: syntax=make
