# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by BSP
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GTK2) += gtk2-engines

#
# Paths and names
#
GTK2-ENGINES_VERSION	= 2.2.0
GTK2-ENGINES		= gtk-engines-$(GTK2-ENGINES_VERSION)
GTK2-ENGINES_SUFFIX	= tar.bz2
GTK2-ENGINES_URL	= http://ftp.gnome.org/pub/GNOME/sources/gtk-engines/2.2/$(GTK2-ENGINES).$(GTK2-ENGINES_SUFFIX)
GTK2-ENGINES_SOURCE	= $(SRCDIR)/$(GTK2-ENGINES).$(GTK2-ENGINES_SUFFIX)
GTK2-ENGINES_DIR	= $(BUILDDIR)/$(GTK2-ENGINES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gtk2-engines_get: $(STATEDIR)/gtk2-engines.get

$(STATEDIR)/gtk2-engines.get: $(gtk2-engines_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GTK2-ENGINES_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GTK2-ENGINES)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gtk2-engines_extract: $(STATEDIR)/gtk2-engines.extract

$(STATEDIR)/gtk2-engines.extract: $(gtk2-engines_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK2-ENGINES_DIR))
	@$(call extract, GTK2-ENGINES)
	@$(call patchin, GTK2-ENGINES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gtk2-engines_prepare: $(STATEDIR)/gtk2-engines.prepare

GTK2-ENGINES_PATH	=  PATH=$(CROSS_PATH)
GTK2-ENGINES_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
GTK2-ENGINES_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/gtk2-engines.prepare: $(gtk2-engines_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK2-ENGINES_DIR)/config.cache)
	cd $(GTK2-ENGINES_DIR) && \
		$(GTK2-ENGINES_PATH) $(GTK2-ENGINES_ENV) \
		./configure $(GTK2-ENGINES_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gtk2-engines_compile: $(STATEDIR)/gtk2-engines.compile

$(STATEDIR)/gtk2-engines.compile: $(gtk2-engines_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GTK2-ENGINES_DIR) && $(GTK2-ENGINES_ENV) $(GTK2-ENGINES_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gtk2-engines_install: $(STATEDIR)/gtk2-engines.install

$(STATEDIR)/gtk2-engines.install: $(gtk2-engines_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GTK2-ENGINES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gtk2-engines_targetinstall: $(STATEDIR)/gtk2-engines.targetinstall

$(STATEDIR)/gtk2-engines.targetinstall: $(gtk2-engines_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, gtk2-engines)
	@$(call install_fixup, gtk2-engines,PACKAGE,gtk2-engines)
	@$(call install_fixup, gtk2-engines,PRIORITY,optional)
	@$(call install_fixup, gtk2-engines,VERSION,$(GTK2-ENGINES_VERSION))
	@$(call install_fixup, gtk2-engines,SECTION,base)
	@$(call install_fixup, gtk2-engines,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gtk2-engines,DEPENDS,)
	@$(call install_fixup, gtk2-engines,DESCRIPTION,missing)

	@$(call install_copy, gtk2-engines, 0, 0, 0644, \
		$(GTK2-ENGINES_DIR)/metal/.libs/libmetal.so, \
		/usr/lib/engines/libmetal.so)
	@$(call install_copy, gtk2-engines, 0, 0, 0644, \
		$(GTK2-ENGINES_DIR)/redmond95/.libs/libredmond95.so, \
		/usr/lib/engines/libredmond95.so)
	@$(call install_copy, gtk2-engines, 0, 0, 0644, \
		$(GTK2-ENGINES_DIR)/pixbuf/.libs/libpixmap.so, \
		/usr/lib/engines/libpixmap.so)

	@$(call install_finish, gtk2-engines)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtk2-engines_clean:
	rm -rf $(STATEDIR)/gtk2-engines.*
	rm -rf $(PKGDIR)/gtk2-engines_*
	rm -rf $(GTK2-ENGINES_DIR)

# vim: syntax=make
