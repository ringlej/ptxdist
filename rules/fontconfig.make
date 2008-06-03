# -*-makefile-*-
# $Id: template 4761 2006-02-24 17:35:57Z sha $
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FONTCONFIG) += fontconfig

#
# Paths and names
#
FONTCONFIG_VERSION	:= 2.5.91
FONTCONFIG		:= fontconfig-$(FONTCONFIG_VERSION)
FONTCONFIG_SUFFIX	:= tar.gz
FONTCONFIG_URL		:= http://fontconfig.org/release/$(FONTCONFIG).$(FONTCONFIG_SUFFIX)
FONTCONFIG_SOURCE	:= $(SRCDIR)/$(FONTCONFIG).$(FONTCONFIG_SUFFIX)
FONTCONFIG_DIR		:= $(BUILDDIR)/$(FONTCONFIG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

fontconfig_get: $(STATEDIR)/fontconfig.get

$(STATEDIR)/fontconfig.get: $(fontconfig_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FONTCONFIG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, FONTCONFIG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fontconfig_extract: $(STATEDIR)/fontconfig.extract

$(STATEDIR)/fontconfig.extract: $(fontconfig_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FONTCONFIG_DIR))
	@$(call extract, FONTCONFIG)
	@$(call patchin, FONTCONFIG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

fontconfig_prepare: $(STATEDIR)/fontconfig.prepare

FONTCONFIG_PATH	:=  PATH=$(CROSS_PATH)
FONTCONFIG_ENV 	:=  \
	$(CROSS_ENV) \
	ac_cv_prog_HASDOCBOOK=no

#
# autoconf
#
FONTCONFIG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	--with-cache-dir=/var/cache/fontconfig \
	--with-default-fonts=$(XORG_FONTDIR) \
	--with-arch=$(PTXCONF_ARCH_STRING)

$(STATEDIR)/fontconfig.prepare: $(fontconfig_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FONTCONFIG_DIR)/config.cache)
	cd $(FONTCONFIG_DIR) && \
		$(FONTCONFIG_PATH) $(FONTCONFIG_ENV) \
		./configure $(FONTCONFIG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

fontconfig_compile: $(STATEDIR)/fontconfig.compile

$(STATEDIR)/fontconfig.compile: $(fontconfig_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FONTCONFIG_DIR) && $(FONTCONFIG_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fontconfig_install: $(STATEDIR)/fontconfig.install

$(STATEDIR)/fontconfig.install: $(fontconfig_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, FONTCONFIG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fontconfig_targetinstall: $(STATEDIR)/fontconfig.targetinstall

$(STATEDIR)/fontconfig.targetinstall: $(fontconfig_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, fontconfig)
	@$(call install_fixup,fontconfig,PACKAGE,fontconfig)
	@$(call install_fixup,fontconfig,PRIORITY,optional)
	@$(call install_fixup,fontconfig,VERSION,$(FONTCONFIG_VERSION))
	@$(call install_fixup,fontconfig,SECTION,base)
	@$(call install_fixup,fontconfig,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,fontconfig,DEPENDS,)
	@$(call install_fixup,fontconfig,DESCRIPTION,missing)

	@$(call install_copy, fontconfig, 0, 0, 0644, \
		$(FONTCONFIG_DIR)/src/.libs/libfontconfig.so.1.3.0, \
		/usr/lib/libfontconfig.so.1.3.0)

	@$(call install_link, fontconfig, \
		libfontconfig.so.1.3.0, \
		/usr/lib/libfontconfig.so.1)

	@$(call install_link, fontconfig, \
		libfontconfig.so.1.3.0, \
		/usr/lib/libfontconfig.so)

ifdef PTXCONF_FONTCONFIG_CONFS
	@$(call install_copy, fontconfig, 0, 0, 0644, \
		$(FONTCONFIG_DIR)/fonts.conf, \
		/etc/fonts/fonts.conf,n)

# 	@$(call install_copy, fontconfig, 0, 0, 0644, \
# 		$(FONTCONFIG_DIR)/conf.d/sub-pixel.conf, \
# 		/etc/fonts/conf.d/subpixel.conf,n)

# 	@$(call install_copy, fontconfig, 0, 0, 0644, \
# 		$(FONTCONFIG_DIR)/conf.d/autohint.conf, \
# 		/etc/fonts/conf.d/autohint.conf,n)
endif

ifdef PTXCONF_FONTCONFIG_UTILS
	@$(call install_copy, fontconfig, 0, 0, 0755, \
		$(FONTCONFIG_DIR)/fc-cache/.libs/fc-cache, \
		/usr/bin/fc-cache)

	@$(call install_copy, fontconfig, 0, 0, 0755, \
		$(FONTCONFIG_DIR)/fc-list/.libs/fc-list, \
		/usr/bin/fc-list)

	@$(call install_copy, fontconfig, 0, 0, 0755, \
		$(FONTCONFIG_DIR)/fc-match/.libs/fc-match, \
		/usr/bin/fc-match)
endif

	@$(call install_finish,fontconfig)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fontconfig_clean:
	rm -rf $(STATEDIR)/fontconfig.*
	rm -rf $(PKGDIR)/fontconfig_*
	rm -rf $(FONTCONFIG_DIR)

# vim: syntax=make
