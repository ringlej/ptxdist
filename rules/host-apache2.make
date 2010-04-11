# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_APACHE2) += host-apache2

#
# Paths and names
#
HOST_APACHE2		= $(APACHE2)
HOST_APACHE2_DIR	= $(HOST_BUILDDIR)/$(HOST_APACHE2)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_APACHE2_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_APACHE2_AUTOCONF := $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-apache2.compile:
	@$(call targetinfo)
	cd $(HOST_APACHE2_DIR)/srclib/apr-util/uri && $(HOST_APACHE2_ENV) $(MAKE)
	cd $(HOST_APACHE2_DIR)/srclib/pcre && $(HOST_APACHE2_ENV) $(MAKE) dftables
	cd $(HOST_APACHE2_DIR)/server && $(HOST_APACHE2_ENV) $(MAKE) gen_test_char
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-apache2.install:
	@$(call targetinfo)
	install -D -m 755 "$(HOST_APACHE2_DIR)/srclib/apr-util/uri/gen_uri_delims" \
		"$(HOST_APACHE2_PKGDIR)/bin/apache2/gen_uri_delims"
	install -D -m 755 "$(HOST_APACHE2_DIR)/srclib/pcre/dftables" \
		"$(HOST_APACHE2_PKGDIR)/bin/apache2/dftables"
	install -D -m 755 "$(HOST_APACHE2_DIR)/server/gen_test_char" \
		"$(HOST_APACHE2_PKGDIR)/bin/apache2/gen_test_char"
	@$(call touch)

# vim: syntax=make
