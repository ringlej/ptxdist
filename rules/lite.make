# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Denis Oliver Kropp
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LITE) += lite

#
# Paths and names
#
LITE_VERSION	:= 0.8.6
LITE		:= LiTE-$(LITE_VERSION)
LITE_SUFFIX		:= tar.gz
LITE_URL		:= http://www.directfb.org/downloads/Libs/$(LITE).$(LITE_SUFFIX)
LITE_SOURCE		:= $(SRCDIR)/$(LITE).$(LITE_SUFFIX)
LITE_DIR		:= $(BUILDDIR)/$(LITE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

lite_get: $(STATEDIR)/lite.get

$(STATEDIR)/lite.get: $(lite_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LITE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LITE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

lite_extract: $(STATEDIR)/lite.extract

$(STATEDIR)/lite.extract: $(lite_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LITE_DIR))
	@$(call extract, LITE)
	@$(call patchin, LITE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

lite_prepare: $(STATEDIR)/lite.prepare

LITE_PATH	:= PATH=$(CROSS_PATH)
LITE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LITE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/lite.prepare: $(lite_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LITE_DIR)/config.cache)
	cd $(LITE_DIR) && \
		$(LITE_PATH) $(LITE_ENV) \
		./configure $(LITE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

lite_compile: $(STATEDIR)/lite.compile

$(STATEDIR)/lite.compile: $(lite_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LITE_DIR) && $(LITE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

lite_install: $(STATEDIR)/lite.install

$(STATEDIR)/lite.install: $(lite_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LITE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

lite_targetinstall: $(STATEDIR)/lite.targetinstall

$(STATEDIR)/lite.targetinstall: $(lite_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, lite)
	@$(call install_fixup, lite,PACKAGE,lite)
	@$(call install_fixup, lite,PRIORITY,optional)
	@$(call install_fixup, lite,VERSION,$(LITE_VERSION))
	@$(call install_fixup, lite,SECTION,base)
	@$(call install_fixup, lite,AUTHOR,"Denis Oliver Kropp <dok\@directfb.org>")
	@$(call install_fixup, lite,DEPENDS,directfb)
	@$(call install_fixup, lite,DESCRIPTION,missing)

	@$(call install_copy, lite, 0, 0, 0755, \
		$(LITE_DIR)/lite/.libs/liblite.so.3.0.1, \
		/usr/lib/liblite.so.3.0.1)

	@$(call install_link, lite, liblite.so.3.0.1, /usr/lib/liblite.so.3)

	@$(call install_copy, lite, 0, 0, 0644, \
		$(LITE_DIR)/data/cursor.png, \
		/usr/share/LiTE/cursor.png)

	@$(call install_copy, lite, 0, 0, 0644, \
		$(LITE_DIR)/data/links.png, \
		/usr/share/LiTE/links.png)

	@$(call install_copy, lite, 0, 0, 0644, \
		$(LITE_DIR)/data/obenlinks.png, \
		/usr/share/LiTE/obenlinks.png)

	@$(call install_copy, lite, 0, 0, 0644, \
		$(LITE_DIR)/data/oben.png, \
		/usr/share/LiTE/oben.png)

	@$(call install_copy, lite, 0, 0, 0644, \
		$(LITE_DIR)/data/obenrechts.png, \
		/usr/share/LiTE/obenrechts.png)

	@$(call install_copy, lite, 0, 0, 0644, \
		$(LITE_DIR)/data/rechts.png, \
		/usr/share/LiTE/rechts.png)

	@$(call install_copy, lite, 0, 0, 0644, \
		$(LITE_DIR)/data/untenlinks.png, \
		/usr/share/LiTE/untenlinks.png)

	@$(call install_copy, lite, 0, 0, 0644, \
		$(LITE_DIR)/data/unten.png, \
		/usr/share/LiTE/unten.png)

	@$(call install_copy, lite, 0, 0, 0644, \
		$(LITE_DIR)/data/untenrechts.png, \
		/usr/share/LiTE/untenrechts.png)

	@$(call install_copy, lite, 0, 0, 0755, \
		$(LITE_DIR)/examples/.libs/simple, \
		/usr/bin/lite_simple)

	@$(call install_copy, lite, 0, 0, 0755, \
		$(LITE_DIR)/examples/.libs/slider, \
		/usr/bin/lite_slider)

	@$(call install_copy, lite, 0, 0, 0755, \
		$(LITE_DIR)/examples/.libs/msgbox, \
		/usr/bin/lite_msgbox)

	@$(call install_copy, lite, 0, 0, 0755, \
		$(LITE_DIR)/examples/.libs/bench, \
		/usr/bin/lite_bench)

	@$(call install_copy, lite, 0, 0, 0755, \
		$(LITE_DIR)/examples/.libs/dfbspy, \
		/usr/bin/dfbspy)

	@$(call install_finish, lite)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lite_clean:
	rm -rf $(STATEDIR)/lite.*
	rm -rf $(IMAGEDIR)/lite_*
	rm -rf $(LITE_DIR)

# vim: syntax=make
