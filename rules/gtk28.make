# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GTK28) += gtk28

#
# Paths and names
#
GTK28_VERSION	:= 2.8.16
GTK28		:= gtk+-$(GTK28_VERSION)
GTK28_SUFFIX	:= tar.bz2
GTK28_URL	:= ftp://ftp.gtk.org/pub/gtk/v2.8/$(GTK28).$(GTK28_SUFFIX)
GTK28_SOURCE	:= $(SRCDIR)/$(GTK28).$(GTK28_SUFFIX)
GTK28_DIR	:= $(BUILDDIR)/$(GTK28)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gtk28_get: $(STATEDIR)/gtk28.get

$(STATEDIR)/gtk28.get: $(gtk28_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GTK28_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GTK28_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gtk28_extract: $(STATEDIR)/gtk28.extract

$(STATEDIR)/gtk28.extract: $(gtk28_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK28_DIR))
	@$(call extract, $(GTK28_SOURCE))
	@$(call patchin, $(GTK28))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gtk28_prepare: $(STATEDIR)/gtk28.prepare

GTK28_PATH	:= PATH=$(CROSS_PATH)
GTK28_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GTK28_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-explicit-deps=yes

ifndef PTXCONF_GTK28_LIBPNG
GTK28_AUTOCONF += --without-libpng
endif

ifndef PTXCONF_GTK28_LIBTIFF
GTK28_AUTOCONF += --without-libtiff
endif

ifndef PTXCONF_GTK28_LIBJPEG
GTK28_AUTOCONF += --without-libjpeg
endif

ifdef PTXCONF_GTK28_TARGET_X11
GTK28_AUTOCONF += --with-gdktarget=x11
endif

$(STATEDIR)/gtk28.prepare: $(gtk28_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GTK28_DIR)/config.cache)
	cd $(GTK28_DIR) && \
		$(GTK28_PATH) $(GTK28_ENV) \
		./configure $(GTK28_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gtk28_compile: $(STATEDIR)/gtk28.compile

$(STATEDIR)/gtk28.compile: $(gtk28_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GTK28_DIR) && $(GTK28_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gtk28_install: $(STATEDIR)/gtk28.install

$(STATEDIR)/gtk28.install: $(gtk28_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GTK28)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gtk28_targetinstall: $(STATEDIR)/gtk28.targetinstall

$(STATEDIR)/gtk28.targetinstall: $(gtk28_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, gtk28)
	@$(call install_fixup,gtk28,PACKAGE,gtk28)
	@$(call install_fixup,gtk28,PRIORITY,optional)
	@$(call install_fixup,gtk28,VERSION,$(GTK28_VERSION))
	@$(call install_fixup,gtk28,SECTION,base)
	@$(call install_fixup,gtk28,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,gtk28,DEPENDS,)
	@$(call install_fixup,gtk28,DESCRIPTION,missing)

	@$(call install_copy, gtk28, 0, 0, 0755, $(GTK28_DIR)/foobar, /dev/null)

	@$(call install_finish,gtk28)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtk28_clean:
	rm -rf $(STATEDIR)/gtk28.*
	rm -rf $(IMAGEDIR)/gtk28_*
	rm -rf $(GTK28_DIR)

# vim: syntax=make
