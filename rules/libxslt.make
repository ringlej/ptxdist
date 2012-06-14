# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
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
PACKAGES-$(PTXCONF_LIBXSLT) += libxslt

#
# Paths and names
#
LIBXSLT_VERSION	:= 1.1.26
LIBXSLT_MD5	:= e61d0364a30146aaa3001296f853b2b9
LIBXSLT		:= libxslt-$(LIBXSLT_VERSION)
LIBXSLT_SUFFIX	:= tar.gz
LIBXSLT_SOURCE	:= $(SRCDIR)/$(LIBXSLT).$(LIBXSLT_SUFFIX)
LIBXSLT_DIR	:= $(BUILDDIR)/$(LIBXSLT)
LIBXSLT_LICENSE	:= MIT

LIBXSLT_URL	:= \
	ftp://xmlsoft.org/libxslt/$(LIBXSLT).$(LIBXSLT_SUFFIX) \
	ftp://xmlsoft.org/libxslt/old/$(LIBXSLT).$(LIBXSLT_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBXSLT_PATH	:= PATH=$(CROSS_PATH)
LIBXSLT_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBXSLT_AUTOCONF := \
	 $(CROSS_AUTOCONF_USR) \
	--without-python

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
LIBXSLT_AUTOCONF += \
	--with-debug \
	--with-debugger
else
LIBXSLT_AUTOCONF += \
	--without-debug \
	--without-debugger
endif


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libxslt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libxslt)
	@$(call install_fixup, libxslt,PRIORITY,optional)
	@$(call install_fixup, libxslt,SECTION,base)
	@$(call install_fixup, libxslt,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libxslt,DESCRIPTION,missing)

ifdef PTXCONF_LIBXSLT_LIBXSLT
	@$(call install_lib, libxslt, 0, 0, 0644, libxslt)
endif
ifdef PTXCONF_LIBXSLT_LIBEXSLT
	@$(call install_lib, libxslt, 0, 0, 0644, libexslt)
endif
ifdef PTXCONF_LIBXSLT_XSLTPROC
	@$(call install_copy, libxslt, 0, 0, 0755, -, /usr/bin/xsltproc)
endif
	@$(call install_finish, libxslt)

	@$(call touch)

# vim: syntax=make
