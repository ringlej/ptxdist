# -*-makefile-*-
#
# Copyright (C) 2006 by Juergen Beisert
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FINDUTILS) += findutils

#
# Paths and names
#
FINDUTILS_VERSION	:= 4.2.23
FINDUTILS		:= findutils-$(FINDUTILS_VERSION)
FINDUTILS_SUFFIX	:= tar.gz
FINDUTILS_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/findutils/$(FINDUTILS).$(FINDUTILS_SUFFIX)
FINDUTILS_SOURCE	:= $(SRCDIR)/$(FINDUTILS).$(FINDUTILS_SUFFIX)
FINDUTILS_DIR		:= $(BUILDDIR)/$(FINDUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FINDUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, FINDUTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FINDUTILS_PATH	:= PATH=$(CROSS_PATH)
FINDUTILS_ENV 	:= $(CROSS_ENV)
#
# where to place the database at runtime
#
FINDUTILS_DBASE_PATH := /var/lib/locate
#
# autoconf
#
FINDUTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--libexecdir=/usr/bin \
	--localstatedir=$(FINDUTILS_DBASE_PATH) \
	--disable-debug \
	--disable-nls

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/findutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init,findutils)
	@$(call install_fixup,findutils,PACKAGE,findutils)
	@$(call install_fixup,findutils,PRIORITY,optional)
	@$(call install_fixup,findutils,VERSION,$(FINDUTILS_VERSION))
	@$(call install_fixup,findutils,SECTION,base)
	@$(call install_fixup,findutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,findutils,DEPENDS,)
	@$(call install_fixup,findutils,DESCRIPTION,missing)

ifdef PTXCONF_FINDUTILS_FIND
	@$(call install_copy,findutils, 0, 0, 0755, -, /usr/bin/find)
endif
ifdef PTXCONF_FINDUTILS_XARGS
	@$(call install_copy,findutils, 0, 0, 0755, -, /usr/bin/xargs)
endif
ifdef PTXCONF_FINDUTILS_DATABASE
	@$(call install_copy,findutils, 0, 0, 0755, -, /usr/bin/locate)
	@$(call install_copy,findutils, 0, 0, 0755, -, /usr/bin/updatedb,n)
	@$(call install_copy,findutils, 0, 0, 0755, -, /usr/bin/bigram)
	@$(call install_copy,findutils, 0, 0, 0755, -, /usr/bin/code)
	@$(call install_copy,findutils, 0, 0, 0755, -, /usr/bin/frcode)
	@$(call install_copy,findutils, 0, 0, 0755, $(FINDUTILS_DBASE_PATH))
endif
	@$(call install_finish,findutils)

	@$(call touch)

# vim: syntax=make
