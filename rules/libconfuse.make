#
# Copyright (C) 2008 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCONFUSE) += libconfuse

#
# Paths and names
#
LIBCONFUSE_VERSION	:= 2.6
LIBCONFUSE		:= confuse-$(LIBCONFUSE_VERSION)
LIBCONFUSE_SUFFIX	:= tar.gz
LIBCONFUSE_URL		:= http://bzero.se/confuse/$(LIBCONFUSE).$(LIBCONFUSE_SUFFIX)
LIBCONFUSE_SOURCE	:= $(SRCDIR)/$(LIBCONFUSE).$(LIBCONFUSE_SUFFIX)
LIBCONFUSE_DIR		:= $(BUILDDIR)/$(LIBCONFUSE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libconfuse_get: $(STATEDIR)/libconfuse.get

$(STATEDIR)/libconfuse.get: $(libconfuse_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CONFUSE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBCONFUSE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libconfuse_extract: $(STATEDIR)/libconfuse.extract

$(STATEDIR)/libconfuse.extract: $(libconfuse_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBCONFUSE_DIR))
	@$(call extract, LIBCONFUSE)
	@$(call patchin, LIBCONFUSE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libconfuse_prepare: $(STATEDIR)/libconfuse.prepare

LIBCONFUSE_PATH	:= PATH=$(CROSS_PATH)
LIBCONFUSE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBCONFUSE_AUTOCONF := $(CROSS_AUTOCONF_USR) \
		--disable-dependency-tracking \
		--disable-nls

ifdef PTXCONF_LIBCONFUSE_STATIC
LIBCONFUSE_AUTOCONF += --enable-shared=no
endif

$(STATEDIR)/libconfuse.prepare: $(libconfuse_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBCONFUSE_DIR)/config.cache)
	cd $(LIBCONFUSE_DIR) && \
		$(LIBCONFUSE_PATH) $(LIBCONFUSE_ENV) \
		./configure $(LIBCONFUSE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libconfuse_compile: $(STATEDIR)/libconfuse.compile

$(STATEDIR)/libconfuse.compile: $(libconfuse_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBCONFUSE_DIR) && $(LIBCONFUSE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libconfuse_install: $(STATEDIR)/libconfuse.install

$(STATEDIR)/libconfuse.install: $(libconfuse_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBCONFUSE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libconfuse_targetinstall: $(STATEDIR)/libconfuse.targetinstall

$(STATEDIR)/libconfuse.targetinstall: $(libconfuse_targetinstall_deps_default)
	@$(call targetinfo, $@)

ifndef PTXCONF_LIBCONFUSE_STATIC
	@$(call install_init, libconfuse)
	@$(call install_fixup, libconfuse,PACKAGE,libconfuse)
	@$(call install_fixup, libconfuse,PRIORITY,optional)
	@$(call install_fixup, libconfuse,VERSION,$(LIBCONFUSE_VERSION))
	@$(call install_fixup, libconfuse,SECTION,base)
	@$(call install_fixup, libconfuse,AUTHOR,"Juergen Beisert <juergen\@kreuzholzen.de>")
	@$(call install_fixup, libconfuse,DEPENDS,)
	@$(call install_fixup, libconfuse,DESCRIPTION,missing)

	@$(call install_copy, libconfuse, 0, 0, 0755, \
		$(LIBCONFUSE_DIR)/src/.libs/libconfuse.so.0.0.0, \
		/usr/lib/libconfuse.so.0.0.0)
	@$(call install_link, libconfuse, \
		libconfuse.so.0.0.0, \
		/usr/lib/libconfuse.so.0)
	@$(call install_link, libconfuse, \
		libconfuse.so.0.0.0, \
		/usr/lib/libconfuse.so)

	@$(call install_finish, libconfuse)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libconfuse_clean:
	rm -rf $(STATEDIR)/libconfuse.*
	rm -rf $(PKGDIR)/libconfuse_*
	rm -rf $(LIBCONFUSE_DIR)

# vim: syntax=make
