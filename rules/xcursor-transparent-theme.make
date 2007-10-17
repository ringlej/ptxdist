# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XCURSOR_TRANSPARENT_THEME) += xcursor-transparent-theme

#
# Paths and names
#
XCURSOR_TRANSPARENT_THEME_VERSION	:= 0.1.1
XCURSOR_TRANSPARENT_THEME		:= xcursor-transparent-theme-$(XCURSOR_TRANSPARENT_THEME_VERSION)
XCURSOR_TRANSPARENT_THEME_SUFFIX	:= tar.gz
XCURSOR_TRANSPARENT_THEME_URL		:= http://matchbox-project.org/sources/utils/$(XCURSOR_TRANSPARENT_THEME).$(XCURSOR_TRANSPARENT_THEME_SUFFIX)
XCURSOR_TRANSPARENT_THEME_SOURCE	:= $(SRCDIR)/$(XCURSOR_TRANSPARENT_THEME).$(XCURSOR_TRANSPARENT_THEME_SUFFIX)
XCURSOR_TRANSPARENT_THEME_DIR		:= $(BUILDDIR)/$(XCURSOR_TRANSPARENT_THEME)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xcursor-transparent-theme_get: $(STATEDIR)/xcursor-transparent-theme.get

$(STATEDIR)/xcursor-transparent-theme.get: $(xcursor-transparent-theme_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XCURSOR_TRANSPARENT_THEME_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XCURSOR_TRANSPARENT_THEME)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xcursor-transparent-theme_extract: $(STATEDIR)/xcursor-transparent-theme.extract

$(STATEDIR)/xcursor-transparent-theme.extract: $(xcursor-transparent-theme_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XCURSOR_TRANSPARENT_THEME_DIR))
	@$(call extract, XCURSOR_TRANSPARENT_THEME)
	@$(call patchin, XCURSOR_TRANSPARENT_THEME)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xcursor-transparent-theme_prepare: $(STATEDIR)/xcursor-transparent-theme.prepare

XCURSOR_TRANSPARENT_THEME_PATH	:= PATH=$(CROSS_PATH)
XCURSOR_TRANSPARENT_THEME_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XCURSOR_TRANSPARENT_THEME_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xcursor-transparent-theme.prepare: $(xcursor-transparent-theme_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XCURSOR_TRANSPARENT_THEME_DIR)/config.cache)
	cd $(XCURSOR_TRANSPARENT_THEME_DIR) && \
		$(XCURSOR_TRANSPARENT_THEME_PATH) $(XCURSOR_TRANSPARENT_THEME_ENV) \
		./configure $(XCURSOR_TRANSPARENT_THEME_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xcursor-transparent-theme_compile: $(STATEDIR)/xcursor-transparent-theme.compile

$(STATEDIR)/xcursor-transparent-theme.compile: $(xcursor-transparent-theme_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XCURSOR_TRANSPARENT_THEME_DIR) && $(XCURSOR_TRANSPARENT_THEME_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xcursor-transparent-theme_install: $(STATEDIR)/xcursor-transparent-theme.install

$(STATEDIR)/xcursor-transparent-theme.install: $(xcursor-transparent-theme_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XCURSOR_TRANSPARENT_THEME)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xcursor-transparent-theme_targetinstall: $(STATEDIR)/xcursor-transparent-theme.targetinstall

$(STATEDIR)/xcursor-transparent-theme.targetinstall: $(xcursor-transparent-theme_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xcursor-transparent-theme)
	@$(call install_fixup, xcursor-transparent-theme,PACKAGE,xcursor-transparent-theme)
	@$(call install_fixup, xcursor-transparent-theme,PRIORITY,optional)
	@$(call install_fixup, xcursor-transparent-theme,VERSION,$(XCURSOR_TRANSPARENT_THEME_VERSION))
	@$(call install_fixup, xcursor-transparent-theme,SECTION,base)
	@$(call install_fixup, xcursor-transparent-theme,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xcursor-transparent-theme,DEPENDS,)
	@$(call install_fixup, xcursor-transparent-theme,DESCRIPTION,missing)

	if test -e $(XCURSOR_TRANSPARENT_THEME_DIR)/ptx_install; then	\
		rm -rf $(XCURSOR_TRANSPARENT_THEME_DIR)/ptx_install;	\
	fi

	cd $(XCURSOR_TRANSPARENT_THEME_DIR) && $(MAKE) install DESTDIR=$(XCURSOR_TRANSPARENT_THEME_DIR)/ptx_install

	cd $(XCURSOR_TRANSPARENT_THEME_DIR)/ptx_install;						\
	find . -type l | while read link; do								\
		target=$$(readlink $$link);								\
		target=$${target#$(XCURSOR_TRANSPARENT_THEME_DIR)/ptx_install};				\
		$(call install_link, xcursor-transparent-theme, $$target, $${link#.});			\
	done;												\
	find . -type f | while read file; do								\
		$(call install_copy, xcursor-transparent-theme, 0, 0, 0644, $$file, $${file#.}, n);	\
	done

	@$(call install_finish, xcursor-transparent-theme)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xcursor-transparent-theme_clean:
	rm -rf $(STATEDIR)/xcursor-transparent-theme.*
	rm -rf $(IMAGEDIR)/xcursor-transparent-theme_*
	rm -rf $(XCURSOR_TRANSPARENT_THEME_DIR)

# vim: syntax=make
