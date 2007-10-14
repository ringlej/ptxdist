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
PACKAGES-$(PTXCONF_LIBIDL_2) += libidl-2

#
# Paths and names
#
LIBIDL_2_VERSION	= 0.8.3
LIBIDL_2		= libIDL-$(LIBIDL_2_VERSION)
LIBIDL_2_SUFFIX		= tar.gz
LIBIDL_2_URL		= http://ftp.gnome.org/pub/GNOME/sources/libIDL/0.8/$(LIBIDL_2).$(LIBIDL_2_SUFFIX)
LIBIDL_2_SOURCE		= $(SRCDIR)/$(LIBIDL_2).$(LIBIDL_2_SUFFIX)
LIBIDL_2_DIR		= $(BUILDDIR)/$(LIBIDL_2)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libidl-2_get: $(STATEDIR)/libidl-2.get

$(STATEDIR)/libidl-2.get: $(libidl-2_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBIDL_2_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBIDL_2)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libidl-2_extract: $(STATEDIR)/libidl-2.extract

$(STATEDIR)/libidl-2.extract: $(libidl-2_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBIDL_2_DIR))
	@$(call extract, LIBIDL_2)
	@$(call patchin, LIBIDL_2)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libidl-2_prepare: $(STATEDIR)/libidl-2.prepare

LIBIDL_2_PATH	=  PATH=$(SYSROOT)/bin:$(CROSS_PATH)
LIBIDL_2_ENV 	= \
	$(CROSS_ENV) \
	libIDL_cv_long_long_format=ll

#
# autoconf
#
LIBIDL_2_AUTOCONF	=  $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBIDL_2_FOO
LIBIDL_2_AUTOCONF	+= --enable-foo
endif

$(STATEDIR)/libidl-2.prepare: $(libidl-2_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBIDL_2_BUILDDIR))
	cd $(LIBIDL_2_DIR) && \
		$(LIBIDL_2_PATH) $(LIBIDL_2_ENV) \
		./configure $(LIBIDL_2_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libidl-2_compile: $(STATEDIR)/libidl-2.compile

$(STATEDIR)/libidl-2.compile: $(libidl-2_compile_deps_default)
	@$(call targetinfo, $@)

	cd $(LIBIDL_2_DIR) && $(LIBIDL_2_PATH) $(LIBIDL_2_ENV) make

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libidl-2_install: $(STATEDIR)/libidl-2.install

$(STATEDIR)/libidl-2.install: $(libidl-2_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBIDL_2)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libidl-2_targetinstall: $(STATEDIR)/libidl-2.targetinstall

$(STATEDIR)/libidl-2.targetinstall: $(libidl-2_targetinstall_deps_default)
	@$(call targetinfo, $@)
	# FIXME: nothing to do? 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libidl-2_clean:
	rm -rf $(STATEDIR)/libidl-2.*
	rm -rf $(LIBIDL_2_DIR)

# vim: syntax=make
