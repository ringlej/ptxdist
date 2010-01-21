# -*-makefile-*-
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

$(XCURSOR_TRANSPARENT_THEME_SOURCE):
	@$(call targetinfo)
	@$(call get, XCURSOR_TRANSPARENT_THEME)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XCURSOR_TRANSPARENT_THEME_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xcursor-transparent-theme.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xcursor-transparent-theme)
	@$(call install_fixup, xcursor-transparent-theme,PACKAGE,xcursor-transparent-theme)
	@$(call install_fixup, xcursor-transparent-theme,PRIORITY,optional)
	@$(call install_fixup, xcursor-transparent-theme,VERSION,$(XCURSOR_TRANSPARENT_THEME_VERSION))
	@$(call install_fixup, xcursor-transparent-theme,SECTION,base)
	@$(call install_fixup, xcursor-transparent-theme,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xcursor-transparent-theme,DEPENDS,)
	@$(call install_fixup, xcursor-transparent-theme,DESCRIPTION,missing)

	cd $(XCURSOR_TRANSPARENT_THEME_PKGDIR);				\
	find . -type l | while read link; do				\
		target=$$(readlink $$link);				\
		target=$${target#$$(cd $$(dirname $$link); pwd)/};	\
		$(call install_link, xcursor-transparent-theme,		\
			$$target, $${link#.});				\
	done;								\
	find . -type f | while read file; do				\
		$(call install_copy, xcursor-transparent-theme, 0, 0,	\
			0644, -, $${file#.}, n);			\
	done

	@$(call install_finish, xcursor-transparent-theme)

	@$(call touch)

# vim: syntax=make
