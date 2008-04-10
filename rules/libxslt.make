# -*-makefile-*-
# $Id: template 2878 2005-07-03 17:54:38Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBXSLT) += libxslt

#
# Paths and names
#
LIBXSLT_VERSION	= 1.1.15
LIBXSLT		= libxslt-$(LIBXSLT_VERSION)
LIBXSLT_SUFFIX	= tar.gz
LIBXSLT_URL	= ftp://xmlsoft.org/libxslt/$(LIBXSLT).$(LIBXSLT_SUFFIX)
LIBXSLT_SOURCE	= $(SRCDIR)/$(LIBXSLT).$(LIBXSLT_SUFFIX)
LIBXSLT_DIR	= $(BUILDDIR)/$(LIBXSLT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libxslt_get: $(STATEDIR)/libxslt.get

$(STATEDIR)/libxslt.get: $(libxslt_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBXSLT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBXSLT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libxslt_extract: $(STATEDIR)/libxslt.extract

$(STATEDIR)/libxslt.extract: $(libxslt_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBXSLT_DIR))
	@$(call extract, LIBXSLT)
	@$(call patchin, LIBXSLT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libxslt_prepare: $(STATEDIR)/libxslt.prepare

LIBXSLT_PATH	=  PATH=$(CROSS_PATH)
LIBXSLT_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LIBXSLT_AUTOCONF =  $(CROSS_AUTOCONF_USR)
LIBXSLT_AUTOCONF += --with-libxml-libs-prefix=$(SYSROOT)/usr/lib
LIBXSLT_AUTOCONF += --with-libxml-include-prefix=$(SYSROOT)/usr/include
LIBXSLT_AUTOCONF += --without-python

ifdef PTXCONF_LIBXSLT_CRYPTO
	LIBXSLT_AUTOCONF += --with-crypto
else
	LIBXSLT_AUTOCONF += --without-crypto
endif


ifdef PTXCONF_LIBXSLT_PLUGINS
	LIBXSLT_AUTOCONF += --with-plugins
else
	LIBXSLT_AUTOCONF += --without-plugins
endif


ifdef PTXCONF_LIBXSLT_DEBUG
	LIBXSLT_AUTOCONF += --with-debug
	LIBXSLT_AUTOCONF += --with-debugger
else
	LIBXSLT_AUTOCONF += --without-debug
	LIBXSLT_AUTOCONF += --without-debugger
endif


$(STATEDIR)/libxslt.prepare: $(libxslt_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBXSLT_DIR)/config.cache)
	cd $(LIBXSLT_DIR) && \
		$(LIBXSLT_PATH) $(LIBXSLT_ENV) \
		./configure $(LIBXSLT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libxslt_compile: $(STATEDIR)/libxslt.compile

$(STATEDIR)/libxslt.compile: $(libxslt_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBXSLT_DIR) && $(LIBXSLT_ENV) $(LIBXSLT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libxslt_install: $(STATEDIR)/libxslt.install

$(STATEDIR)/libxslt.install: $(libxslt_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBXSLT)

	# FIXME: this probably has to be fixed upstream!
	# libxslt installs xslt-config to wrong path.
	install $(LIBXSLT_DIR)/xslt-config $(PTXCONF_SYSROOT_CROSS)/bin/

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libxslt_targetinstall: $(STATEDIR)/libxslt.targetinstall

$(STATEDIR)/libxslt.targetinstall: $(libxslt_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libxslt)
	@$(call install_fixup, libxslt,PACKAGE,libxslt)
	@$(call install_fixup, libxslt,PRIORITY,optional)
	@$(call install_fixup, libxslt,VERSION,$(LIBXSLT_VERSION))
	@$(call install_fixup, libxslt,SECTION,base)
	@$(call install_fixup, libxslt,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libxslt,DEPENDS,)
	@$(call install_fixup, libxslt,DESCRIPTION,missing)

ifdef PTXCONF_LIBXSLT_LIBXSLT
	@$(call install_copy, libxslt, 0, 0, 0644, \
		$(LIBXSLT_DIR)/libxslt/.libs/libxslt.so.1.1.15, \
		/usr/lib/libxslt.so.1.1.15)
	@$(call install_link, libxslt, libxslt.so.1.1.15, /usr/lib/libxslt.so.1)
	@$(call install_link, libxslt, libxslt.so.1.1.15, /usr/lib/libxslt.so)
endif

ifdef PTXCONF_LIBXSLT_LIBEXSLT
	@$(call install_copy, libxslt, 0, 0, 0644, \
		$(LIBXSLT_DIR)/libexslt/.libs/libexslt.so.0.8.12, \
		/usr/lib/libexslt.so.0.8.12)
	@$(call install_link, libxslt, libexslt.so.0.8.12, /usr/lib/libexslt.so.0)
	@$(call install_link, libxslt, libexslt.so.0.8.12, /usr/lib/libexslt.so)
endif

ifdef PTXCONF_LIBXSLT_XSLTPROC
	@$(call install_copy, libxslt, 0, 0, 0755, \
		$(LIBXSLT_DIR)/xsltproc/.libs/xsltproc, \
		/usr/bin/xsltproc)
endif

	@$(call install_finish, libxslt)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libxslt_clean:
	rm -rf $(STATEDIR)/libxslt.*
	rm -rf $(IMAGEDIR)/libxslt_*
	rm -rf $(LIBXSLT_DIR)

# vim: syntax=make
