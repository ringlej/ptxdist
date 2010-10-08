# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger
#               2004-2009 by the ptxdist project
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
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
LIBXML2_VERSION	:= 2.7.7
LIBXML2_MD5	:= 9abc9959823ca9ff904f1fbcf21df066
LIBXML2		:= libxml2-$(LIBXML2_VERSION)
LIBXML2_SUFFIX	:= tar.gz
LIBXML2_SOURCE	:= $(SRCDIR)/$(LIBXML2).$(LIBXML2_SUFFIX)
LIBXML2_DIR	:= $(BUILDDIR)/$(LIBXML2)
LIBXML2_LICENSE	:= MIT

LIBXML2_URL := \
	ftp://xmlsoft.org/libxml2/$(LIBXML2).$(LIBXML2_SUFFIX) \
	ftp://xmlsoft.org/libxml2/old/$(LIBXML2).$(LIBXML2_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBXML2_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBXML2)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBXML2_PATH	:= PATH=$(CROSS_PATH)
LIBXML2_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBXML2_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	--oldincludedir=$(SYSROOT)/usr/include

ifdef PTXCONF_ICONV
# --with-iconv=yes -> does the right thing for libc-iconv
LIBXML2_AUTOCONF += --with-iconv=yes
else
LIBXML2_AUTOCONF += --with-iconv=no
endif

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
LIBXML2_AUTOCONF += --with-python=$(SYSROOT)/usr
else
LIBXML2_AUTOCONF += --with-python=no
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

ifdef PTXCONF_LIBXML2_SCHEMATRON
LIBXML2_AUTOCONF += --with-schematron
else
LIBXML2_AUTOCONF += --without-schematron
endif

ifdef PTXCONF_LIBXML2_THREADS
LIBXML2_AUTOCONF += --with-threads
else
LIBXML2_AUTOCONF += --without-threads
endif

ifdef PTXCONF_LIBXML2_THREADS_ALLOC
LIBXML2_AUTOCONF += --with-thread-alloc
else
LIBXML2_AUTOCONF += --without-thread-alloc
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

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libxml2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libxml2)
	@$(call install_fixup, libxml2,PRIORITY,optional)
	@$(call install_fixup, libxml2,SECTION,base)
	@$(call install_fixup, libxml2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libxml2,DESCRIPTION,missing)

	@$(call install_lib, libxml2, 0, 0, 0644, libxml2)

	@$(call install_finish, libxml2)

	@$(call touch)

# vim: syntax=make
