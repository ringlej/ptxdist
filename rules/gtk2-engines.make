# -*-makefile-*-
# $Id: gtk2-engines.make,v 1.1 2004/03/31 16:23:29 robert Exp $
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
ifdef PTXCONF_GTK2-ENGINES
PACKAGES += gtk2-engines
endif

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

gtk2-engines_get_deps = $(GTK2-ENGINES_SOURCE)

$(STATEDIR)/gtk2-engines.get: $(gtk2-engines_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(GTK2-ENGINES_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GTK2-ENGINES_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gtk2-engines_extract: $(STATEDIR)/gtk2-engines.extract

gtk2-engines_extract_deps = $(STATEDIR)/gtk2-engines.get

$(STATEDIR)/gtk2-engines.extract: $(gtk2-engines_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK2-ENGINES_DIR))
	@$(call extract, $(GTK2-ENGINES_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gtk2-engines_prepare: $(STATEDIR)/gtk2-engines.prepare

#
# dependencies
#
gtk2-engines_prepare_deps = \
	$(STATEDIR)/gtk2-engines.extract \
	$(STATEDIR)/virtual-xchain.install

GTK2-ENGINES_PATH	=  PATH=$(CROSS_PATH)
GTK2-ENGINES_ENV 	=  $(CROSS_ENV)
GTK2-ENGINES_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#GTK2-ENGINES_ENV	+=

#
# autoconf
#
GTK2-ENGINES_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/gtk2-engines.prepare: $(gtk2-engines_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK2-ENGINES_DIR)/config.cache)
	cd $(GTK2-ENGINES_DIR) && \
		$(GTK2-ENGINES_PATH) $(GTK2-ENGINES_ENV) \
		./configure $(GTK2-ENGINES_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gtk2-engines_compile: $(STATEDIR)/gtk2-engines.compile

gtk2-engines_compile_deps = $(STATEDIR)/gtk2-engines.prepare

$(STATEDIR)/gtk2-engines.compile: $(gtk2-engines_compile_deps)
	@$(call targetinfo, $@)
	cd $(GTK2-ENGINES_DIR) && $(GTK2-ENGINES_ENV) $(GTK2-ENGINES_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gtk2-engines_install: $(STATEDIR)/gtk2-engines.install

$(STATEDIR)/gtk2-engines.install: $(STATEDIR)/gtk2-engines.compile
	@$(call targetinfo, $@)
	cd $(GTK2-ENGINES_DIR) && $(GTK2-ENGINES_ENV) $(GTK2-ENGINES_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gtk2-engines_targetinstall: $(STATEDIR)/gtk2-engines.targetinstall

gtk2-engines_targetinstall_deps = $(STATEDIR)/gtk2-engines.compile

$(STATEDIR)/gtk2-engines.targetinstall: $(gtk2-engines_targetinstall_deps)
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/usr/lib/engines
	cp -d $(GTK2-ENGINES_DIR)/metal/.libs/libmetal.so $(ROOTDIR)/usr/lib/engines/
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/usr/lib/engines/libmetal.so
	cp -d $(GTK2-ENGINES_DIR)/redmond95/.libs/libredmond95.so $(ROOTDIR)/usr/lib/engines/
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/usr/lib/engines/libredmond95.so
	cp -d $(GTK2-ENGINES_DIR)/pixbuf/.libs/libpixmap.so $(ROOTDIR)/usr/lib/engines/
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/usr/lib/engines/libpixmap.so
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtk2-engines_clean:
	rm -rf $(STATEDIR)/gtk2-engines.*
	rm -rf $(GTK2-ENGINES_DIR)

# vim: syntax=make
