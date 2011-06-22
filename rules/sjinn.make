# -*-makefile-*-
#
# Copyright (C) 2007 by Tom St
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SJINN) += sjinn

#
# Paths and names
#
SJINN_VERSION	:= 1.01
SJINN_MD5	:= b38969d4a614b660919090ba0c8d5c7d
SJINN		:= sjinn-$(SJINN_VERSION)
SJINN_SUFFIX	:= tar.gz
SJINN_URL	:= http://downloads.sourceforge.net/sjinn/$(SJINN).$(SJINN_SUFFIX)
SJINN_SOURCE	:= $(SRCDIR)/$(SJINN).$(SJINN_SUFFIX)
SJINN_DIR	:= $(BUILDDIR)/$(SJINN)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SJINN_CONF_TOOL	:= NO

SJINN_MAKE_OPT := \
	CC=$(CROSS_CC) \
	prefix=/usr

SJINN_INSTALL_OPT := \
	install \
	prefix=$(SJINN_PKGDIR)/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sjinn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sjinn)
	@$(call install_fixup, sjinn,PRIORITY,optional)
	@$(call install_fixup, sjinn,SECTION,base)
	@$(call install_fixup, sjinn,AUTHOR,"Tom St")
	@$(call install_fixup, sjinn,DESCRIPTION,missing)

	@$(call install_copy, sjinn, 0, 0, 0755, -, /usr/bin/rs232)

	@$(call install_finish, sjinn)

	@$(call touch)

# vim: syntax=make
