# -*-makefile-*-
# $Id: template 5709 2006-06-09 13:55:00Z mkl $
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
PACKAGES-$(PTXCONF_LIBICONV) += libiconv

#
# Paths and names
#
LIBICONV_VERSION	:= 1.11
LIBICONV		:= libiconv-$(LIBICONV_VERSION)
LIBICONV_SUFFIX		:= tar.gz
LIBICONV_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/libiconv/$(LIBICONV).$(LIBICONV_SUFFIX)
LIBICONV_SOURCE		:= $(SRCDIR)/$(LIBICONV).$(LIBICONV_SUFFIX)
LIBICONV_DIR		:= $(BUILDDIR)/$(LIBICONV)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libiconv_get: $(STATEDIR)/libiconv.get

$(STATEDIR)/libiconv.get: $(libiconv_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBICONV_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBICONV)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libiconv_extract: $(STATEDIR)/libiconv.extract

$(STATEDIR)/libiconv.extract: $(libiconv_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBICONV_DIR))
	@$(call extract, LIBICONV)
	@$(call patchin, LIBICONV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libiconv_prepare: $(STATEDIR)/libiconv.prepare

LIBICONV_PATH	:=  PATH=$(CROSS_PATH)
LIBICONV_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
LIBICONV_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBICONV_EXTRA_ENCODINGS
	LIBICONV_AUTOCONF += --enable-extra-encodings
endif

$(STATEDIR)/libiconv.prepare: $(libiconv_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBICONV_DIR)/config.cache)
	cd $(LIBICONV_DIR) && \
		$(LIBICONV_PATH) $(LIBICONV_ENV) \
		./configure $(LIBICONV_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libiconv_compile: $(STATEDIR)/libiconv.compile

$(STATEDIR)/libiconv.compile: $(libiconv_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBICONV_DIR) && $(LIBICONV_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libiconv_install: $(STATEDIR)/libiconv.install

$(STATEDIR)/libiconv.install: $(libiconv_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBICONV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libiconv_targetinstall: $(STATEDIR)/libiconv.targetinstall

$(STATEDIR)/libiconv.targetinstall: $(libiconv_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libiconv)
	@$(call install_fixup,libiconv,PACKAGE,libiconv)
	@$(call install_fixup,libiconv,PRIORITY,optional)
	@$(call install_fixup,libiconv,VERSION,$(LIBICONV_VERSION))
	@$(call install_fixup,libiconv,SECTION,base)
	@$(call install_fixup,libiconv,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,libiconv,DEPENDS,)
	@$(call install_fixup,libiconv,DESCRIPTION,missing)

	@$(call install_copy, libiconv, 0, 0, 0644, \
		$(LIBICONV_DIR)/lib/.libs/libiconv.so.2.4.0, \
		/usr/lib/libiconv.so.2.4.0)

	@$(call install_link, libiconv, libiconv.so.2.4.0, /usr/lib/libiconv.so.2)
	@$(call install_link, libiconv, libiconv.so.2.4.0, /usr/lib/libiconv.so)

	@$(call install_finish,libiconv)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libiconv_clean:
	rm -rf $(STATEDIR)/libiconv.*
	rm -rf $(IMAGEDIR)/libiconv_*
	rm -rf $(LIBICONV_DIR)

# vim: syntax=make
