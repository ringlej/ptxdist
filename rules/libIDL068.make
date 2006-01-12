# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: RSC: is this a hosttool? 

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBIDL068) += libidl068

#
# Paths and names
#
LIBIDL068_VERSION	= 0.6.8
LIBIDL068		= libIDL-$(LIBIDL068_VERSION)
LIBIDL068_SUFFIX	= tar.gz
LIBIDL068_URL		= http://ftp.mozilla.org/pub/mozilla/libraries/source/$(LIBIDL068).$(LIBIDL068_SUFFIX)
LIBIDL068_SOURCE	= $(SRCDIR)/$(LIBIDL068).$(LIBIDL068_SUFFIX)
LIBIDL068_DIR		= $(BUILDDIR)/$(LIBIDL068)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libidl068_get: $(STATEDIR)/libidl068.get

libidl068_get_deps	=  $(LIBIDL068_SOURCE)

$(STATEDIR)/libidl068.get: $(libidl068_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBIDL068_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBIDL068_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libidl068_extract: $(STATEDIR)/libidl068.extract

libidl068_extract_deps	=  $(STATEDIR)/libidl068.get

$(STATEDIR)/libidl068.extract: $(libidl068_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBIDL068_DIR))
	@$(call extract, $(LIBIDL068_SOURCE))
	@$(call patchin, $(LIBIDL068))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libidl068_prepare: $(STATEDIR)/libidl068.prepare

#
# dependencies
#
libidl068_prepare_deps =  \
	$(STATEDIR)/libidl068.extract \
	$(STATEDIR)/virtual-xchain.install

LIBIDL068_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
LIBIDL068_ENV 	=  $(CROSS_ENV)
LIBIDL068_ENV	+= PKG_CONFIG_PATH=../$(GLIB22):../$(PANGO12):../$(ATK124):../$(LIBIDL068):../$(FREETYPE214):../$(FONTCONFIG22)
#LIBIDL068_ENV	+= libIDL_cv_long_long_format=ll

#
# autoconf
#
LIBIDL068_AUTOCONF	=  $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBIDL068_FOO
LIBIDL068_AUTOCONF	+= --enable-foo
endif

$(STATEDIR)/libidl068.prepare: $(libidl068_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBIDL068_BUILDDIR))
	cd $(LIBIDL068_DIR) && \
		$(LIBIDL068_PATH) $(LIBIDL068_ENV) \
		./configure $(LIBIDL068_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libidl068_compile: $(STATEDIR)/libidl068.compile

libidl068_compile_deps =  $(STATEDIR)/libidl068.prepare

$(STATEDIR)/libidl068.compile: $(libidl068_compile_deps_default)
	@$(call targetinfo, $@)

	$(LIBIDL068_PATH) $(LIBIDL068_ENV) make -C $(LIBIDL068_DIR)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libidl068_install: $(STATEDIR)/libidl068.install

$(STATEDIR)/libidl068.install: $(STATEDIR)/libidl068.compile
	@$(call targetinfo, $@)
	@$(call install, LIBIDL068)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libidl068_targetinstall: $(STATEDIR)/libidl068.targetinstall

libidl068_targetinstall_deps	=  $(STATEDIR)/libidl068.compile

$(STATEDIR)/libidl068.targetinstall: $(libidl068_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libidl068_clean:
	rm -rf $(STATEDIR)/libidl068.*
	rm -rf $(LIBIDL068_DIR)

# vim: syntax=make
