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

#
# We provide this package
#
ifdef PTXCONF_LIBIDL-2
PACKAGES += libidl-2
endif

#
# Paths and names
#
LIBIDL-2_VERSION	= 0.8.3
LIBIDL-2		= libIDL-$(LIBIDL-2_VERSION)
LIBIDL-2_SUFFIX		= tar.gz
LIBIDL-2_URL		= http://ftp.gnome.org/pub/GNOME/sources/libIDL/0.8/$(LIBIDL-2).$(LIBIDL-2_SUFFIX)
LIBIDL-2_SOURCE		= $(SRCDIR)/$(LIBIDL-2).$(LIBIDL-2_SUFFIX)
LIBIDL-2_DIR		= $(BUILDDIR)/$(LIBIDL-2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libidl-2_get: $(STATEDIR)/libidl-2.get

libidl-2_get_deps	=  $(LIBIDL-2_SOURCE)

$(STATEDIR)/libidl-2.get: $(libidl-2_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(LIBIDL-2_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBIDL-2_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libidl-2_extract: $(STATEDIR)/libidl-2.extract

libidl-2_extract_deps	=  $(STATEDIR)/libidl-2.get

$(STATEDIR)/libidl-2.extract: $(libidl-2_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBIDL-2_DIR))
	@$(call extract, $(LIBIDL-2_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libidl-2_prepare: $(STATEDIR)/libidl-2.prepare

#
# dependencies
#
libidl-2_prepare_deps =  \
	$(STATEDIR)/libidl-2.extract \
	$(STATEDIR)/virtual-xchain.install

LIBIDL-2_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
LIBIDL-2_ENV 	=  $(CROSS_ENV)
LIBIDL-2_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/
LIBIDL-2_ENV	+= libIDL_cv_long_long_format=ll

#
# autoconf
#
LIBIDL-2_AUTOCONF	=  $(CROSS_AUTOCONF)
LIBIDL-2_AUTOCONF	+= --prefix=/$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)

ifdef PTXCONF_LIBIDL-2_FOO
LIBIDL-2_AUTOCONF	+= --enable-foo
endif

$(STATEDIR)/libidl-2.prepare: $(libidl-2_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBIDL-2_BUILDDIR))
	cd $(LIBIDL-2_DIR) && \
		$(LIBIDL-2_PATH) $(LIBIDL-2_ENV) \
		./configure $(LIBIDL-2_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libidl-2_compile: $(STATEDIR)/libidl-2.compile

libidl-2_compile_deps =  $(STATEDIR)/libidl-2.prepare

$(STATEDIR)/libidl-2.compile: $(libidl-2_compile_deps)
	@$(call targetinfo, $@)

	cd $(LIBIDL-2_DIR) && $(LIBIDL-2_PATH) $(LIBIDL-2_ENV) make

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libidl-2_install: $(STATEDIR)/libidl-2.install

$(STATEDIR)/libidl-2.install: $(STATEDIR)/libidl-2.compile
	@$(call targetinfo, $@)

	cd $(LIBIDL-2_DIR) && $(LIBIDL-2_PATH) $(LIBIDL-2_ENV) make install

	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libidl-2_targetinstall: $(STATEDIR)/libidl-2.targetinstall

libidl-2_targetinstall_deps	=  $(STATEDIR)/libidl-2.compile

$(STATEDIR)/libidl-2.targetinstall: $(libidl-2_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libidl-2_clean:
	rm -rf $(STATEDIR)/libidl-2.*
	rm -rf $(LIBIDL-2_DIR)

# vim: syntax=make
