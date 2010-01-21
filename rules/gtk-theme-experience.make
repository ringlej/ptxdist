# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GTK_THEME_EXPERIENCE) += gtk-theme-experience

#
# Paths and names
#
GTK_THEME_EXPERIENCE_VERSION	:= noversion
GTK_THEME_EXPERIENCE		:= GTK2-EXperience
GTK_THEME_EXPERIENCE_SUFFIX	:= tar.gz
GTK_THEME_EXPERIENCE_URL	:= http://ftp.gnome.org/pub/GNOME/teams/art.gnome.org/themes/gtk2/$(GTK_THEME_EXPERIENCE).$(GTK_THEME_EXPERIENCE_SUFFIX)
GTK_THEME_EXPERIENCE_SOURCE	:= $(SRCDIR)/$(GTK_THEME_EXPERIENCE).$(GTK_THEME_EXPERIENCE_SUFFIX)
GTK_THEME_EXPERIENCE_DIR	:= $(BUILDDIR)/$(GTK_THEME_EXPERIENCE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GTK_THEME_EXPERIENCE_SOURCE):
	@$(call targetinfo)
	@$(call get, GTK_THEME_EXPERIENCE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk-theme-experience.extract:
	@$(call targetinfo)
	@$(call clean, $(GTK_THEME_EXPERIENCE_DIR))
	mkdir -p $(GTK_THEME_EXPERIENCE_DIR)
	@$(call extract, GTK_THEME_EXPERIENCE, $(GTK_THEME_EXPERIENCE_DIR))
	mv "$(GTK_THEME_EXPERIENCE_DIR)/eXperience - ice" $(GTK_THEME_EXPERIENCE_DIR)/eXperience-ice
	mv "$(GTK_THEME_EXPERIENCE_DIR)/eXperience - olive" $(GTK_THEME_EXPERIENCE_DIR)/eXperience-olive
	cd $(GTK_THEME_EXPERIENCE_DIR) && find . -name "*~" | xargs rm -fr
	@$(call patchin, GTK_THEME_EXPERIENCE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk-theme-experience.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk-theme-experience.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk-theme-experience.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk-theme-experience.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gtk-theme-experience)
	@$(call install_fixup, gtk-theme-experience,PACKAGE,gtk-theme-experience)
	@$(call install_fixup, gtk-theme-experience,PRIORITY,optional)
	@$(call install_fixup, gtk-theme-experience,VERSION,$(GTK_THEME_EXPERIENCE_VERSION))
	@$(call install_fixup, gtk-theme-experience,SECTION,base)
	@$(call install_fixup, gtk-theme-experience,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gtk-theme-experience,DEPENDS,)
	@$(call install_fixup, gtk-theme-experience,DESCRIPTION,missing)

ifdef PTXCONF_GTK_THEME_EXPERIENCE_PLAIN
	@cd $(GTK_THEME_EXPERIENCE_DIR)/eXperience && \
		for f in `find . -type f | grep -v .svn`; do \
			$(call install_copy, gtk-theme-experience, 0, 0, 0644, \
			$(GTK_THEME_EXPERIENCE_DIR)/eXperience/$$f, \
			/usr/share/themes/eXperience/$$f,n) \
		done
endif


ifdef PTXCONF_GTK_THEME_EXPERIENCE_ICE
	@cd $(GTK_THEME_EXPERIENCE_DIR)/eXperience-ice && \
		for f in `find . -type f | grep -v .svn`; do \
			$(call install_copy, gtk-theme-experience, 0, 0, 0644, \
			$(GTK_THEME_EXPERIENCE_DIR)/eXperience-ice/$$f, \
			/usr/share/themes/eXperience-ice/$$f,n) \
		done
endif

ifdef PTXCONF_GTK_THEME_EXPERIENCE_OLIVE
	@cd $(GTK_THEME_EXPERIENCE_DIR)/eXperience-olive && \
		for f in `find . -type f | grep -v .svn`; do \
			$(call install_copy, gtk-theme-experience, 0, 0, 0644, \
			$(GTK_THEME_EXPERIENCE_DIR)/eXperience-olive/$$f, \
			/usr/share/themes/eXperience-olive/$$f,n) \
		done
endif

ifdef PTXCONF_GTK_DEFAULT_THEME_EXPERIENCE_PLAIN
	@echo "include \"/usr/share/themes/eXperience/gtk-2.0/gtkrc\"" > $(GTK_THEME_EXPERIENCE_DIR)/gtkrc-2.0
	@$(call install_copy, gtk-theme-experience, 0, 0, 0644, \
		$(GTK_THEME_EXPERIENCE_DIR)/gtkrc-2.0, \
		/etc/gtk-2.0/gtkrc,n)
endif
ifdef PTXCONF_GTK_DEFAULT_THEME_EXPERIENCE_ICE
	@echo "include \"/usr/share/themes/eXperience-ice/gtk-2.0/gtkrc\"" > $(GTK_THEME_EXPERIENCE_DIR)/gtkrc-2.0
	@$(call install_copy, gtk-theme-experience, 0, 0, 0644, \
		$(GTK_THEME_EXPERIENCE_DIR)/gtkrc-2.0, \
		/etc/gtk-2.0/gtkrc,n)
endif
ifdef PTXCONF_GTK_DEFAULT_THEME_EXPERIENCE_OLIVE
	@echo "include \"/usr/share/themes/eXperience-olive/gtk-2.0/gtkrc\"" > $(GTK_THEME_EXPERIENCE_DIR)/gtkrc-2.0
	@$(call install_copy, gtk-theme-experience, 0, 0, 0644, \
		$(GTK_THEME_EXPERIENCE_DIR)/gtkrc-2.0, \
		/etc/gtk-2.0/gtkrc,n)
endif

	@$(call install_finish, gtk-theme-experience)

	@$(call touch)

# vim: syntax=make
