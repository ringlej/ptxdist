# -*-makefile-*-
#
# Copyright (C) 2008 by Juergen Beisert <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPCIACCESS) += libpciaccess

#
# Paths and names
#
LIBPCIACCESS_VERSION	:= 0.10.3
LIBPCIACCESS		:= libpciaccess-$(LIBPCIACCESS_VERSION)
LIBPCIACCESS_SUFFIX	:= tar.bz2
LIBPCIACCESS_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(LIBPCIACCESS).$(LIBPCIACCESS_SUFFIX)
LIBPCIACCESS_SOURCE	:= $(SRCDIR)/$(LIBPCIACCESS).$(LIBPCIACCESS_SUFFIX)
LIBPCIACCESS_DIR	:= $(BUILDDIR)/$(LIBPCIACCESS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libpciaccess_get: $(STATEDIR)/libpciaccess.get

$(STATEDIR)/libpciaccess.get: $(libpciaccess_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBPCIACCESS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBPCIACCESS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libpciaccess_extract: $(STATEDIR)/libpciaccess.extract

$(STATEDIR)/libpciaccess.extract: $(libpciaccess_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPCIACCESS_DIR))
	@$(call extract, LIBPCIACCESS)
	@$(call patchin, LIBPCIACCESS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libpciaccess_prepare: $(STATEDIR)/libpciaccess.prepare

LIBPCIACCESS_PATH	:= PATH=$(CROSS_PATH)
LIBPCIACCESS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBPCIACCESS_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

ifdef PTXCONF_LIBPCIACCESS_STATIC
LIBPCIACCESS_AUTOCONF += --enable-shared=no
endif

ifdef PTXCONF_LIBPCIACCESS_MTRR
LIBPCIACCESS_ENV += ac_cv_file__usr_include_asm_mtrr_h=yes
else
LIBPCIACCESS_ENV += ac_cv_file__usr_include_asm_mtrr_h=no
endif

$(STATEDIR)/libpciaccess.prepare: $(libpciaccess_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPCIACCESS_DIR)/config.cache)
	cd $(LIBPCIACCESS_DIR) && \
		$(LIBPCIACCESS_PATH) $(LIBPCIACCESS_ENV) \
		./configure $(LIBPCIACCESS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libpciaccess_compile: $(STATEDIR)/libpciaccess.compile

$(STATEDIR)/libpciaccess.compile: $(libpciaccess_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBPCIACCESS_DIR) && $(LIBPCIACCESS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libpciaccess_install: $(STATEDIR)/libpciaccess.install

$(STATEDIR)/libpciaccess.install: $(libpciaccess_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBPCIACCESS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libpciaccess_targetinstall: $(STATEDIR)/libpciaccess.targetinstall

$(STATEDIR)/libpciaccess.targetinstall: $(libpciaccess_targetinstall_deps_default)
	@$(call targetinfo, $@)

ifndef PTXCONF_LIBPCIACCESS_STATIC
# only shared libraries are to be installed on the target
	@$(call install_init, libpciaccess)
	@$(call install_fixup, libpciaccess,PACKAGE,libpciaccess)
	@$(call install_fixup, libpciaccess,PRIORITY,optional)
	@$(call install_fixup, libpciaccess,VERSION,$(LIBPCIACCESS_VERSION))
	@$(call install_fixup, libpciaccess,SECTION,base)
	@$(call install_fixup, libpciaccess,AUTHOR,"Juergen Beisert <j.beisert\@pengutronix.de>")
	@$(call install_fixup, libpciaccess,DEPENDS,)
	@$(call install_fixup, libpciaccess,DESCRIPTION,missing)

	@$(call install_copy, libpciaccess, 0, 0, 0644, \
		$(LIBPCIACCESS_DIR)/src/.libs/libpciaccess.so.0.10.2, \
		/usr/lib/libpciaccess.so.0.10.2)
	@$(call install_link, libpciaccess, libpciaccess.so.0.10.2, \
		/usr/lib/libpciaccess.so.0)
	@$(call install_link, libpciaccess, libpciaccess.so.0.10.2, \
		/usr/lib/libpciaccess.so)

	@$(call install_finish, libpciaccess)
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libpciaccess_clean:
	rm -rf $(STATEDIR)/libpciaccess.*
	rm -rf $(PKGDIR)/libpciaccess_*
	rm -rf $(LIBPCIACCESS_DIR)

# vim: syntax=make
