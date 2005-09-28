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
ifdef PTXCONF_READLINE
PACKAGES += readline
endif

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

readline_get_deps = $(READLINE_SOURCE)

$(STATEDIR)/readline.get: $(readline_get_deps)
	@$(call targetinfo, $@)
#	@$(call get_patches, $(READLINE))
	$(call touch, $@)

$(READLINE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(READLINE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

readline_extract: $(STATEDIR)/readline.extract

readline_extract_deps = $(STATEDIR)/readline.get

$(STATEDIR)/readline.extract: $(readline_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(READLINE_DIR))
	@$(call extract, $(READLINE_SOURCE))
	@$(call patchin, $(READLINE))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

readline_prepare: $(STATEDIR)/readline.prepare

#
# dependencies
#
readline_prepare_deps = \
	$(STATEDIR)/readline.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/ncurses.install

READLINE_PATH	=  PATH=$(CROSS_PATH)
READLINE_ENV 	=  $(CROSS_ENV)
#READLINE_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#READLINE_ENV	+=

#
# autoconf
#
READLINE_AUTOCONF =  $(CROSS_AUTOCONF)
READLINE_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/readline.prepare: $(readline_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(READLINE_DIR)/config.cache)
	cd $(READLINE_DIR) && \
		$(READLINE_PATH) $(READLINE_ENV) \
		./configure $(READLINE_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

readline_compile: $(STATEDIR)/readline.compile

readline_compile_deps = $(STATEDIR)/readline.prepare

$(STATEDIR)/readline.compile: $(readline_compile_deps)
	@$(call targetinfo, $@)
	cd $(READLINE_DIR) && $(READLINE_ENV) $(READLINE_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

readline_install: $(STATEDIR)/readline.install

$(STATEDIR)/readline.install: $(STATEDIR)/readline.compile
	@$(call targetinfo, $@)
	cd $(READLINE_DIR) && $(READLINE_ENV) $(READLINE_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

readline_targetinstall: $(STATEDIR)/readline.targetinstall

readline_targetinstall_deps = $(STATEDIR)/readline.compile

$(STATEDIR)/readline.targetinstall: $(readline_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,readline)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(READLINE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, $(READLINE_DIR)/shlib/libreadline.so.5.0, /lib/libreadline.so.5.0)
	@$(call install_link, libreadline.so.5.0, /lib/libreadline.so.5)
	@$(call install_link, libreadline.so.5.0, /lib/libreadline.so)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

readline_clean:
	rm -rf $(STATEDIR)/readline.*
	rm -rf $(IMAGEDIR)/readline_*
	rm -rf $(READLINE_DIR)

# vim: syntax=make
