# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JSON_C) += json-c

#
# Paths and names
#
JSON_C_VERSION		:= 0.10
JSON_C_MD5		:= a4edc79410eb894f08d7d52ca9f88732
JSON_C			:= json-c-$(JSON_C_VERSION)
JSON_C_SUFFIX		:= tar.gz
JSON_C_URL		:= https://s3.amazonaws.com/json-c_releases/releases/$(JSON_C).$(JSON_C_SUFFIX)
JSON_C_SOURCE		:= $(SRCDIR)/$(JSON_C).$(JSON_C_SUFFIX)
JSON_C_DIR		:= $(BUILDDIR)/$(JSON_C)
JSON_C_LICENSE		:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

JSON_C_PATH	:= PATH=$(CROSS_PATH)
JSON_C_ENV	:= $(CROSS_ENV)

#
# autoconf
#
JSON_C_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/json-c.targetinstall:
	@$(call targetinfo)

	@$(call install_init, json-c)
	@$(call install_fixup, json-c,PRIORITY,optional)
	@$(call install_fixup, json-c,SECTION,base)
	@$(call install_fixup, json-c,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, json-c,DESCRIPTION,missing)

	@$(call install_lib, json-c, 0, 0, 0644, libjson)

	@$(call install_finish, json-c)

	@$(call touch)

# vim: ft=make noet
