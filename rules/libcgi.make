# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Guillaume Gourat <guillaume.forum@free.fr>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCGI) += libcgi

#
# Paths and names
#
LIBCGI_VERSION	:= 1.0
LIBCGI		:= libcgi-$(LIBCGI_VERSION)
LIBCGI_SUFFIX	:= tar.gz
LIBCGI_URL	:= $(PTXCONF_SETUP_SFMIRROR)/libcgi/$(LIBCGI).$(LIBCGI_SUFFIX)
LIBCGI_SOURCE	:= $(SRCDIR)/$(LIBCGI).$(LIBCGI_SUFFIX)
LIBCGI_DIR	:= $(BUILDDIR)/$(LIBCGI)
LIBCGI_LICENSE	:= LGPLv2.1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libcgi_get: $(STATEDIR)/libcgi.get

$(STATEDIR)/libcgi.get: $(libcgi_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBCGI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBCGI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libcgi_extract: $(STATEDIR)/libcgi.extract

$(STATEDIR)/libcgi.extract: $(libcgi_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBCGI_DIR))
	@$(call extract, LIBCGI)
	@$(call patchin, LIBCGI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libcgi_prepare: $(STATEDIR)/libcgi.prepare

LIBCGI_PATH	:= PATH=$(CROSS_PATH)
LIBCGI_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBCGI_AUTOCONF := $(CROSS_AUTOCONF_USR)

LIBCGI_MAKEVARS	:= $(CROSS_ENV_CC) $(CROSS_ENV_AR)

$(STATEDIR)/libcgi.prepare: $(libcgi_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBCGI_DIR)/config.cache)
	cd $(LIBCGI_DIR) && \
		$(LIBCGI_PATH) $(LIBCGI_ENV) \
		./configure $(LIBCGI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libcgi_compile: $(STATEDIR)/libcgi.compile

$(STATEDIR)/libcgi.compile: $(libcgi_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBCGI_DIR) && $(LIBCGI_PATH) $(MAKE) $(LIBCGI_MAKEVARS) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libcgi_install: $(STATEDIR)/libcgi.install

$(STATEDIR)/libcgi.install: $(libcgi_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBCGI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libcgi_targetinstall: $(STATEDIR)/libcgi.targetinstall

$(STATEDIR)/libcgi.targetinstall: $(libcgi_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libcgi)
	@$(call install_fixup, libcgi,PACKAGE,libcgi)
	@$(call install_fixup, libcgi,PRIORITY,optional)
	@$(call install_fixup, libcgi,VERSION,$(LIBCGI_VERSION))
	@$(call install_fixup, libcgi,SECTION,base)
	@$(call install_fixup, libcgi,AUTHOR,"Guillaume GOURAT <guillaume.gourat\@nexvision.fr>")
	@$(call install_fixup, libcgi,DEPENDS,)
	@$(call install_fixup, libcgi,DESCRIPTION,missing)

	@$(call install_copy, libcgi, 0, 0, 0644, $(LIBCGI_DIR)/src/libcgi.so, /usr/lib/libcgi.so, y)

	@$(call install_finish, libcgi)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libcgi_clean:
	rm -rf $(STATEDIR)/libcgi.*
	rm -rf $(PKGDIR)/libcgi_*
	rm -rf $(LIBCGI_DIR)

# vim: syntax=make
