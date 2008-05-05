# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2008 by Brandon Fosdick <bfosdick@dash.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_INOTIFY_TOOLS) += inotify-tools

#
# Paths and names
#
INOTIFY_TOOLS_VERSION	:= 3.13
INOTIFY_TOOLS		:= inotify-tools-$(INOTIFY_TOOLS_VERSION)
INOTIFY_TOOLS_SUFFIX	:= tar.gz
INOTIFY_TOOLS_URL	:= $(PTXCONF_SETUP_SFMIRROR)/inotify-tools//$(INOTIFY_TOOLS).$(INOTIFY_TOOLS_SUFFIX)
INOTIFY_TOOLS_SOURCE	:= $(SRCDIR)/$(INOTIFY_TOOLS).$(INOTIFY_TOOLS_SUFFIX)
INOTIFY_TOOLS_DIR	:= $(BUILDDIR)/$(INOTIFY_TOOLS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

inotify-tools_get: $(STATEDIR)/inotify-tools.get

$(STATEDIR)/inotify-tools.get: $(inotify-tools_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(INOTIFY_TOOLS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, INOTIFY_TOOLS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

inotify-tools_extract: $(STATEDIR)/inotify-tools.extract

$(STATEDIR)/inotify-tools.extract: $(inotify-tools_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(INOTIFY_TOOLS_DIR))
	@$(call extract, INOTIFY_TOOLS)
	@$(call patchin, INOTIFY_TOOLS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

inotify-tools_prepare: $(STATEDIR)/inotify-tools.prepare

INOTIFY_TOOLS_PATH	:= PATH=$(CROSS_PATH)
INOTIFY_TOOLS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
INOTIFY_TOOLS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/inotify-tools.prepare: $(inotify-tools_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(INOTIFY_TOOLS_DIR)/config.cache)
	cd $(INOTIFY_TOOLS_DIR) && \
		$(INOTIFY_TOOLS_PATH) $(INOTIFY_TOOLS_ENV) \
		./configure $(INOTIFY_TOOLS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

inotify-tools_compile: $(STATEDIR)/inotify-tools.compile

$(STATEDIR)/inotify-tools.compile: $(inotify-tools_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(INOTIFY_TOOLS_DIR) && $(INOTIFY_TOOLS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

inotify-tools_install: $(STATEDIR)/inotify-tools.install

$(STATEDIR)/inotify-tools.install: $(inotify-tools_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, INOTIFY_TOOLS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

inotify-tools_targetinstall: $(STATEDIR)/inotify-tools.targetinstall

$(STATEDIR)/inotify-tools.targetinstall: $(inotify-tools_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, inotify-tools)
	@$(call install_fixup,inotify-tools,PACKAGE,inotify-tools)
	@$(call install_fixup,inotify-tools,PRIORITY,optional)
	@$(call install_fixup,inotify-tools,VERSION,$(INOTIFY_TOOLS_VERSION))
	@$(call install_fixup,inotify-tools,SECTION,base)
	@$(call install_fixup,inotify-tools,AUTHOR,"Brandon Fosdick <bfosdick\@dash.net>")
	@$(call install_fixup,inotify-tools,DEPENDS,)
	@$(call install_fixup,inotify-tools,DESCRIPTION,missing)

	@$(call install_copy, inotify-tools, 0, 0, 0755, \
		$(INOTIFY_TOOLS_DIR)/src/.libs/inotifywait, \
		/usr/bin/inotifywait)

	@$(call install_copy, inotify-tools, 0, 0, 0755, \
		$(INOTIFY_TOOLS_DIR)/src/.libs/inotifywatch, \
		/usr/bin/inotifywait)

	@$(call install_copy, inotify-tools, 0, 0, 0755, \
		$(INOTIFY_TOOLS_DIR)/libinotifytools/src/.libs/libinotifytools.so.0.4.1, \
		/usr/lib/libinotifytools.so.0.4.1)

	@$(call install_link, inotify-tools, \
		/usr/lib/libinotifytools.so.0.4.1, \
		/usr/lib/libinotifytools.so.0)

	@$(call install_link, inotify-tools, \
		/usr/lib/libinotifytools.so.0.4.1, \
		/usr/lib/libinotifytools.so)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

inotify-tools_clean:
	rm -rf $(STATEDIR)/inotify-tools.*
	rm -rf $(IMAGEDIR)/inotify-tools_*
	rm -rf $(INOTIFY_TOOLS_DIR)

