# -*-makefile-*-
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONTS) += xorg-fonts

#
# Paths and names
#
XORG_FONTS_VERSION	:= 1.0.0
XORG_FONTS		:= xorg-fonts-$(XORG_FONTS_VERSION)
XORG_FONTS_DIR		:= $(BUILDDIR)/$(XORG_FONTS)
XORG_FONTS_DIR_INSTALL	:= $(XORG_FONTS_DIR)-install

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-fonts.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONTS_PATH	:=  PATH=$(HOST_PATH)

$(STATEDIR)/xorg-fonts.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-fonts.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-fonts.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-fonts.targetinstall:
	@$(call targetinfo)

	@if test -e $(XORG_FONTS_DIR_INSTALL); then \
		rm -rf $(XORG_FONTS_DIR_INSTALL); \
	fi
	@mkdir -p $(XORG_FONTS_DIR_INSTALL)

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install-post
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-fonts.targetinstall.post:
	@$(call targetinfo)

	@$(XORG_FONTS_PATH); \
	find $(XORG_FONTS_DIR_INSTALL) -mindepth 1 -type d | while read dir; do \
		echo $$dir;\
		case "$${dir}" in \
			*/[Ee]ncodings)	\
					if test -d "$${dir}/large"; then \
						elarge="-e ./large"; \
					fi; \
					pushd $${dir} > /dev/null; \
					mkfontscale -b -s -l -n -r -p $(XORG_FONTDIR)/encodings -e . $${elarge} $${dir}; \
					popd > /dev/null ;; \
			*/[Ss]peedo)	mkfontdir $${dir} ;; \
			*)		mkfontscale $${dir}; \
					mkfontdir $${dir} ;; \
		esac; \
	done

# FIXME: add fc-cache?

	@$(call install_init, xorg-fonts)
	@$(call install_fixup, xorg-fonts,PACKAGE,xorg-fonts)
	@$(call install_fixup, xorg-fonts,PRIORITY,optional)
	@$(call install_fixup, xorg-fonts,VERSION,$(XORG_FONTS_VERSION))
	@$(call install_fixup, xorg-fonts,SECTION,base)
	@$(call install_fixup, xorg-fonts,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-fonts,DEPENDS,)
	@$(call install_fixup, xorg-fonts,DESCRIPTION,missing)

	@cd $(XORG_FONTS_DIR_INSTALL); \
	find . -type f | while read file; do \
		$(call install_copy, xorg-fonts, 0, 0, 0644, \
			$(XORG_FONTS_DIR_INSTALL)/$$file, \
			$(XORG_FONTDIR)/$$file, n); \
	done

	@$(call install_finish, xorg-fonts)

	@$(call touch)

# vim: syntax=make
