# -*-makefile-*-
#
# Copyright (C) 2007 by Lars Munch <lars@segv.dk>
#               2010 by Ryan Raasch <ryan.raasch@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_LIBMXML) += libmxml

#
# Paths and names
#
LIBMXML_VERSION	:= 2.6
LIBMXML		:= mxml-$(LIBMXML_VERSION)
LIBMXML_SUFFIX	:= tar.gz
LIBMXML_URL	:= http://ftp.easysw.com/pub/mxml/$(LIBMXML_VERSION)/$(LIBMXML).$(LIBMXML_SUFFIX)
LIBMXML_SOURCE	:= $(SRCDIR)/$(LIBMXML).$(LIBMXML_SUFFIX)
LIBMXML_DIR	:= $(BUILDDIR)/mxml-$(LIBMXML_VERSION)
LIBMXML_LICENSE	:= LGPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMXML_CONF_TOOL := autoconf
LIBMXML_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared

# build static lib, too. make install will fail otherwise
LIBMXML_MAKE_OPT := \
	all \
	libmxml.a

LIBMXML_INSTALL_OPT := \
	install \
	DSTROOT=$(LIBMXML_PKGDIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmxml.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmxml)
	@$(call install_fixup, libmxml,PRIORITY,optional)
	@$(call install_fixup, libmxml,SECTION,base)
	@$(call install_fixup, libmxml,AUTHOR,"Ryan Raasch <ryan.raasch@gmail.com>")
	@$(call install_fixup, libmxml,DESCRIPTION,missing)

	@$(call install_lib, libmxml, 0, 0, 0644, libmxml)

	@$(call install_finish, libmxml)

	@$(call touch)

# vim: syntax=make
