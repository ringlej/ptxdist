# -*-makefile-*-
#
# Copyright (C) 2016 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBFASTJSON) += libfastjson

#
# Paths and names
#
LIBFASTJSON_VERSION	:= 0.99.8
LIBFASTJSON_MD5		:= 730713ad1d851def7ac8898f751bbfdd
LIBFASTJSON		:= libfastjson-$(LIBFASTJSON_VERSION)
LIBFASTJSON_SUFFIX	:= tar.gz
LIBFASTJSON_URL		:= https://codeload.github.com/rsyslog/libfastjson/$(LIBFASTJSON_SUFFIX)/v$(LIBFASTJSON_VERSION)
LIBFASTJSON_SOURCE	:= $(SRCDIR)/$(LIBFASTJSON).$(LIBFASTJSON_SUFFIX)
LIBFASTJSON_DIR		:= $(BUILDDIR)/$(LIBFASTJSON)
LIBFASTJSON_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBFASTJSON_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libfastjson.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libfastjson)
	@$(call install_fixup, libfastjson, PRIORITY, optional)
	@$(call install_fixup, libfastjson, SECTION, base)
	@$(call install_fixup, libfastjson, AUTHOR, "Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, libfastjson, DESCRIPTION, missing)

	@$(call install_lib, libfastjson, 0, 0, 0644, libfastjson)

	@$(call install_finish, libfastjson)

	@$(call touch)

# vim: syntax=make
