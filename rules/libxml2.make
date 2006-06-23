# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBXML2) += libxml2

#
# Paths and names
#
LIBXML2_VERSION	:= 2.6.23
LIBXML2		:= libxml2-$(LIBXML2_VERSION)
LIBXML2_SUFFIX	:= tar.gz
LIBXML2_URL	:= ftp://xmlsoft.org/libxml2/$(LIBXML2).$(LIBXML2_SUFFIX)
LIBXML2_SOURCE	:= $(SRCDIR)/$(LIBXML2).$(LIBXML2_SUFFIX)
LIBXML2_DIR	:= $(BUILDDIR)/$(LIBXML2)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libxml2_get: $(STATEDIR)/libxml2.get

$(STATEDIR)/libxml2.get: $(libxml2_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBXML2_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBXML2)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libxml2_extract: $(STATEDIR)/libxml2.extract

$(STATEDIR)/libxml2.extract: $(libxml2_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBXML2_DIR))
	@$(call extract, LIBXML2)
	@$(call patchin, LIBXML2)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libxml2_prepare: $(STATEDIR)/libxml2.prepare

#
# dependencies
#
LIBXML2_PATH	:= PATH=$(CROSS_PATH)

#
# autoconf
#
LIBXML2_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBXML2_C14N
LIBXML2_AUTOCONF += --with-c14n
else
LIBXML2_AUTOCONF += --without-c14n
endif

ifdef PTXCONF_LIBXML2_CATALOG
LIBXML2_AUTOCONF += --with-catalog
else
LIBXML2_AUTOCONF += --without-catalog
endif

ifdef PTXCONF_LIBXML2_DEBUG
LIBXML2_AUTOCONF += --with-debug
else
LIBXML2_AUTOCONF += --without-debug
endif

ifdef PTXCONF_LIBXML2_DOCBOOK
LIBXML2_AUTOCONF += --with-docbook
else
LIBXML2_AUTOCONF += --without-docbook
endif

ifdef PTXCONF_LIBXML2_FEXCEPTIONS
LIBXML2_AUTOCONF += --with-fexceptions
else
LIBXML2_AUTOCONF += --without-fexceptions
endif

ifdef PTXCONF_LIBXML2_FTP
LIBXML2_AUTOCONF += --with-ftp
else
LIBXML2_AUTOCONF += --without-ftp
endif

ifdef PTXCONF_LIBXML2_HISTORY
LIBXML2_AUTOCONF += --with-history
else
LIBXML2_AUTOCONF += --without-history
endif

ifdef PTXCONF_LIBXML2_HTML
LIBXML2_AUTOCONF += --with-html
else
LIBXML2_AUTOCONF += --without-html
endif

ifdef PTXCONF_LIBXML2_HTTP
LIBXML2_AUTOCONF += --with-http
else
LIBXML2_AUTOCONF += --without-http
endif

ifdef PTXCONF_LIBXML2_ICONV
LIBXML2_AUTOCONF += --with-iconv
else
LIBXML2_AUTOCONF += --without-iconv
endif

ifdef PTXCONF_LIBXML2_ISO8859X
LIBXML2_AUTOCONF += --with-iso8859x
else
LIBXML2_AUTOCONF += --without-iso8859x
endif

ifdef PTXCONF_LIBXML2_LEGACY
LIBXML2_AUTOCONF += --with-legacy
else
LIBXML2_AUTOCONF += --without-legacy
endif

ifdef PTXCONF_LIBXML2_MEM_DEBUG
LIBXML2_AUTOCONF += --with-mem-debug
else
LIBXML2_AUTOCONF += --without-mem-debug
endif

ifdef PTXCONF_LIBXML2_MINIMUM
LIBXML2_AUTOCONF += --with-minimum
else
LIBXML2_AUTOCONF += --without-minimum
endif

ifdef PTXCONF_LIBXML2_OUTPUT
LIBXML2_AUTOCONF += --with-output
else
LIBXML2_AUTOCONF += --without-output
endif

ifdef PTXCONF_LIBXML2_PATTERN
LIBXML2_AUTOCONF += --with-pattern
else
LIBXML2_AUTOCONF += --without-pattern
endif

ifdef PTXCONF_LIBXML2_PUSH
LIBXML2_AUTOCONF += --with-push
else
LIBXML2_AUTOCONF += --without-push
endif

ifdef PTXCONF_LIBXML2_PYTHON
LIBXML2_AUTOCONF += --with-python
else
LIBXML2_AUTOCONF += --without-python
endif

ifdef PTXCONF_LIBXML2_READER
LIBXML2_AUTOCONF += --with-reader
else
LIBXML2_AUTOCONF += --without-reader
endif

ifdef PTXCONF_LIBXML2_REGEXPS
LIBXML2_AUTOCONF += --with-regexps
else
LIBXML2_AUTOCONF += --without-regexps
endif

ifdef PTXCONF_LIBXML2_RUN_DEBUG
LIBXML2_AUTOCONF += --with-run-debug
else
LIBXML2_AUTOCONF += --without-run-debug
endif

ifdef PTXCONF_LIBXML2_SAX1
LIBXML2_AUTOCONF += --with-sax1
else
LIBXML2_AUTOCONF += --without-sax1
endif

ifdef PTXCONF_LIBXML2_SCHEMAS
LIBXML2_AUTOCONF += --with-schemas
else
LIBXML2_AUTOCONF += --without-schemas
endif

ifdef PTXCONF_LIBXML2_THREADS
LIBXML2_AUTOCONF += --with-threads
else
LIBXML2_AUTOCONF += --without-threads
endif

ifdef PTXCONF_LIBXML2_THREADS_ALLOC
LIBXML2_AUTOCONF += --with-threads-alloc
else
LIBXML2_AUTOCONF += --without-threads-alloc
endif

ifdef PTXCONF_LIBXML2_DOM
LIBXML2_AUTOCONF += --with-tree
else
LIBXML2_AUTOCONF += --without-tree
endif

ifdef PTXCONF_LIBXML2_DTD
LIBXML2_AUTOCONF += --with-valid
else
LIBXML2_AUTOCONF += --without-valid
endif

ifdef PTXCONF_LIBXML2_WRITER
LIBXML2_AUTOCONF += --with-writer
else
LIBXML2_AUTOCONF += --without-writer
endif

ifdef PTXCONF_LIBXML2_XINCLUDE
LIBXML2_AUTOCONF += --with-xinclude
else
LIBXML2_AUTOCONF += --without-xinclude
endif

ifdef PTXCONF_LIBXML2_XPATH
LIBXML2_AUTOCONF += --with-xpath
else
LIBXML2_AUTOCONF += --without-xpath
endif

ifdef PTXCONF_LIBXML2_XPTR
LIBXML2_AUTOCONF += --with-xptr
else
LIBXML2_AUTOCONF += --without-xptr
endif

ifdef PTXCONF_LIBXML2_MODULES
LIBXML2_AUTOCONF += --with-modules
else
LIBXML2_AUTOCONF += --without-modules
endif

ifdef PTXCONF_LIBXML2_ZLIB
LIBXML2_AUTOCONF += --with-zlib=$(SYSROOT)/usr
else
LIBXML2_AUTOCONF += --without-zlib
endif

$(STATEDIR)/libxml2.prepare: $(libxml2_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBXML2_DIR)/config.cache)
	cd $(LIBXML2_DIR) && \
		$(LIBXML2_PATH) $(LIBXML2_ENV) \
		./configure $(LIBXML2_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libxml2_compile: $(STATEDIR)/libxml2.compile

$(STATEDIR)/libxml2.compile: $(libxml2_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBXML2_DIR) && $(LIBXML2_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libxml2_install: $(STATEDIR)/libxml2.install

$(STATEDIR)/libxml2.install: $(libxml2_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBXML2)
	install -D $(LIBXML2_DIR)/xml2-config $(PTXCONF_PREFIX)/bin/xml2-config
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libxml2_targetinstall: $(STATEDIR)/libxml2.targetinstall

$(STATEDIR)/libxml2.targetinstall: $(libxml2_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libxml2)
	@$(call install_fixup, libxml2,PACKAGE,libxml2)
	@$(call install_fixup, libxml2,PRIORITY,optional)
	@$(call install_fixup, libxml2,VERSION,$(LIBXML2_VERSION))
	@$(call install_fixup, libxml2,SECTION,base)
	@$(call install_fixup, libxml2,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libxml2,DEPENDS,)
	@$(call install_fixup, libxml2,DESCRIPTION,missing)

	@$(call install_copy, libxml2, 0, 0, 0644, \
		$(LIBXML2_DIR)/.libs/libxml2.so.2.6.23, \
		/usr/lib/libxml2.so.2.6.23)
	@$(call install_link, libxml2, libxml2.so.2.6.23,  /usr/lib/libxml2.so.2)
	@$(call install_link, libxml2, libxml2.so.2.6.23, /usr/lib/libxml2.so)

	@$(call install_finish, libxml2)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libxml2_clean:
	rm -rf $(STATEDIR)/libxml2.*
	rm -rf $(IMAGEDIR)/libxml2_*
	rm -rf $(LIBXML2_DIR)

# vim: syntax=make
