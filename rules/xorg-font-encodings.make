# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_ENCODINGS) += xorg-font-encodings

#
# Paths and names
#
XORG_FONT_ENCODINGS_VERSION	:= 1.0.0
XORG_FONT_ENCODINGS		:= encodings-X11R7.0-$(XORG_FONT_ENCODINGS_VERSION)
XORG_FONT_ENCODINGS_SUFFIX	:= tar.bz2
XORG_FONT_ENCODINGS_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.0/src/font//$(XORG_FONT_ENCODINGS).$(XORG_FONT_ENCODINGS_SUFFIX)
XORG_FONT_ENCODINGS_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ENCODINGS).$(XORG_FONT_ENCODINGS_SUFFIX)
XORG_FONT_ENCODINGS_DIR		:= $(BUILDDIR)/$(XORG_FONT_ENCODINGS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-encodings_get: $(STATEDIR)/xorg-font-encodings.get

$(STATEDIR)/xorg-font-encodings.get: $(xorg-font-encodings_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_ENCODINGS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_ENCODINGS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-encodings_extract: $(STATEDIR)/xorg-font-encodings.extract

$(STATEDIR)/xorg-font-encodings.extract: $(xorg-font-encodings_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_ENCODINGS_DIR))
	@$(call extract, XORG_FONT_ENCODINGS)
	@$(call patchin, XORG_FONT_ENCODINGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-encodings_prepare: $(STATEDIR)/xorg-font-encodings.prepare

XORG_FONT_ENCODINGS_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_ENCODINGS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_ENCODINGS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-font-encodings.prepare: $(xorg-font-encodings_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_ENCODINGS_DIR)/config.cache)
	cd $(XORG_FONT_ENCODINGS_DIR) && \
		$(XORG_FONT_ENCODINGS_PATH) $(XORG_FONT_ENCODINGS_ENV) \
		./configure $(XORG_FONT_ENCODINGS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-encodings_compile: $(STATEDIR)/xorg-font-encodings.compile

$(STATEDIR)/xorg-font-encodings.compile: $(xorg-font-encodings_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_ENCODINGS_DIR) && $(XORG_FONT_ENCODINGS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-encodings_install: $(STATEDIR)/xorg-font-encodings.install

$(STATEDIR)/xorg-font-encodings.install: $(xorg-font-encodings_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_FONT_ENCODINGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-encodings_targetinstall: $(STATEDIR)/xorg-font-encodings.targetinstall

$(STATEDIR)/xorg-font-encodings.targetinstall: $(xorg-font-encodings_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-font-encodings)
	@$(call install_fixup, xorg-font-encodings,PACKAGE,xorg-font-encodings)
	@$(call install_fixup, xorg-font-encodings,PRIORITY,optional)
	@$(call install_fixup, xorg-font-encodings,VERSION,$(XORG_FONT_ENCODINGS_VERSION))
	@$(call install_fixup, xorg-font-encodings,SECTION,base)
	@$(call install_fixup, xorg-font-encodings,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-font-encodings,DEPENDS,)
	@$(call install_fixup, xorg-font-encodings,DESCRIPTION,missing)

	@cd $(XORG_FONT_ENCODINGS_DIR); \
	for file in *.enc.gz; do	\
		$(call install_copy, xorg-font-encodings, 0, 0, 0644, $$file, $(XORG_FONTDIR)/encodings/$$file, n); \
	done

	@$(call install_copy, xorg-font-encodings, 0, 0, 0644, $(XORG_FONT_ENCODINGS_DIR)/encodings.dir, $(XORG_FONTDIR)/encodings/encodings.dir, n)

	@$(call install_finish, xorg-font-encodings)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-encodings_clean:
	rm -rf $(STATEDIR)/xorg-font-encodings.*
	rm -rf $(IMAGEDIR)/xorg-font-encodings_*
	rm -rf $(XORG_FONT_ENCODINGS_DIR)

# vim: syntax=make
