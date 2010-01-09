# -*-makefile-*-
#
# Copyright (C) 2007 by Guillaume Gourat <guillaume.forum@free.fr>
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
PACKAGES-$(PTXCONF_LIBCGI) += libcgi

#
# Paths and names
#
LIBCGI_VERSION	:= 1.0
LIBCGI		:= libcgi-$(LIBCGI_VERSION)
LIBCGI_SUFFIX	:= tar.gz
LIBCGI_URL	:= $(PTXCONF_SETUP_SFMIRROR)/libcgi/$(LIBCGI).$(LIBCGI_SUFFIX)
LIBCGI_SOURCE	:= $(SRCDIR)/$(LIBCGI).$(LIBCGI_SUFFIX)
LIBCGI_DIR	:= $(BUILDDIR)/$(LIBCGI)
LIBCGI_LICENSE	:= LGPLv2.1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBCGI_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBCGI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCGI_PATH	:= PATH=$(CROSS_PATH)
LIBCGI_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBCGI_AUTOCONF := $(CROSS_AUTOCONF_USR)

LIBCGI_MAKEVARS	:= $(CROSS_ENV_CC) $(CROSS_ENV_AR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcgi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcgi)
	@$(call install_fixup, libcgi,PACKAGE,libcgi)
	@$(call install_fixup, libcgi,PRIORITY,optional)
	@$(call install_fixup, libcgi,VERSION,$(LIBCGI_VERSION))
	@$(call install_fixup, libcgi,SECTION,base)
	@$(call install_fixup, libcgi,AUTHOR,"Guillaume GOURAT <guillaume.gourat@nexvision.fr>")
	@$(call install_fixup, libcgi,DEPENDS,)
	@$(call install_fixup, libcgi,DESCRIPTION,missing)

	@$(call install_copy, libcgi, 0, 0, 0644, -, /usr/lib/libcgi.so)

	@$(call install_finish, libcgi)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libcgi_clean:
	rm -rf $(STATEDIR)/libcgi.*
	rm -rf $(PKGDIR)/libcgi_*
	rm -rf $(LIBCGI_DIR)

# vim: syntax=make
