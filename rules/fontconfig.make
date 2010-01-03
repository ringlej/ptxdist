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
FONTCONFIG_VERSION	:= 2.6.0
FONTCONFIG		:= fontconfig-$(FONTCONFIG_VERSION)
FONTCONFIG_SUFFIX	:= tar.gz
FONTCONFIG_URL		:= http://fontconfig.org/release/$(FONTCONFIG).$(FONTCONFIG_SUFFIX)
FONTCONFIG_SOURCE	:= $(SRCDIR)/$(FONTCONFIG).$(FONTCONFIG_SUFFIX)
FONTCONFIG_DIR		:= $(BUILDDIR)/$(FONTCONFIG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FONTCONFIG_SOURCE):
	@$(call targetinfo)
	@$(call get, FONTCONFIG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

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

#
# parallel build is broken: in fc-case/, two header files are generated.
# It *should* work, because the generated files are marked with BUILT_SOURCES,
# so they should be built before any other target. However, we've seen cases
# where the touch happened *after* fc-case.c was compiled -> bang
#
FONTCONFIG_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fontconfig.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fontconfig)
	@$(call install_fixup,fontconfig,PACKAGE,fontconfig)
	@$(call install_fixup,fontconfig,PRIORITY,optional)
	@$(call install_fixup,fontconfig,VERSION,$(FONTCONFIG_VERSION))
	@$(call install_fixup,fontconfig,SECTION,base)
	@$(call install_fixup,fontconfig,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,fontconfig,DEPENDS,)
	@$(call install_fixup,fontconfig,DESCRIPTION,missing)

	@$(call install_copy, fontconfig, 0, 0, 0644, -, \
		/usr/lib/libfontconfig.so.1.3.0)

	@$(call install_link, fontconfig, \
		libfontconfig.so.1.3.0, \
		/usr/lib/libfontconfig.so.1)

	@$(call install_link, fontconfig, \
		libfontconfig.so.1.3.0, \
		/usr/lib/libfontconfig.so)

ifdef PTXCONF_FONTCONFIG_CONFS
	@$(call install_copy, fontconfig, 0, 0, 0644, -, \
		/etc/fonts/fonts.conf,n)

# 	@$(call install_copy, fontconfig, 0, 0, 0644, \
# 		$(FONTCONFIG_DIR)/conf.d/sub-pixel.conf, \
# 		/etc/fonts/conf.d/subpixel.conf,n)

# 	@$(call install_copy, fontconfig, 0, 0, 0644, \
# 		$(FONTCONFIG_DIR)/conf.d/autohint.conf, \
# 		/etc/fonts/conf.d/autohint.conf,n)
endif

ifdef PTXCONF_FONTCONFIG_UTILS
	@$(call install_copy, fontconfig, 0, 0, 0755, -, \
		/usr/bin/fc-cache)

	@$(call install_copy, fontconfig, 0, 0, 0755, -, \
		/usr/bin/fc-list)

	@$(call install_copy, fontconfig, 0, 0, 0755, -, \
		/usr/bin/fc-match)
endif

	@$(call install_finish,fontconfig)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fontconfig_clean:
	rm -rf $(STATEDIR)/fontconfig.*
	rm -rf $(PKGDIR)/fontconfig_*
	rm -rf $(FONTCONFIG_DIR)

# vim: syntax=make
