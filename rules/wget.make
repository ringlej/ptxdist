# -*-makefile-*-
#
# Copyright (C) 2005-2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WGET) += wget

#
# Paths and names
#
WGET_VERSION	:= 1.11.4
WGET_MD5	:= 69e8a7296c0e12c53bd9ffd786462e87
WGET		:= wget-$(WGET_VERSION)
WGET_SUFFIX	:= tar.gz
WGET_URL	:= $(call ptx/mirror, GNU, wget/$(WGET).$(WGET_SUFFIX))
WGET_SOURCE	:= $(SRCDIR)/$(WGET).$(WGET_SUFFIX)
WGET_DIR	:= $(BUILDDIR)/$(WGET)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(WGET_SOURCE):
	@$(call targetinfo)
	@$(call get, WGET)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WGET_PATH	:= PATH=$(CROSS_PATH)
WGET_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
WGET_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	--without-socks \
	--without-ssl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wget.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wget)
	@$(call install_fixup, wget,PRIORITY,optional)
	@$(call install_fixup, wget,SECTION,base)
	@$(call install_fixup, wget,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, wget,DESCRIPTION,missing)

	@$(call install_copy, wget, 0, 0, 0755, -, /usr/bin/wget)

	@$(call install_finish, wget)

	@$(call touch)

# vim: syntax=make
