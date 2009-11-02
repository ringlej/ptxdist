# -*-makefile-*-
# $Id: template-make 7626 2007-11-26 10:27:03Z mkl $
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ATTR) += attr

#
# Paths and names
#
ATTR_VERSION	:= 2.4.44
ATTR		:= attr-$(ATTR_VERSION)
ATTR_SUFFIX	:= tar.gz
ATTR_SOURCE	:= $(SRCDIR)/$(ATTR).src.$(ATTR_SUFFIX)
ATTR_DIR	:= $(BUILDDIR)/$(ATTR)

ATTR_URL	:= \
	ftp://oss.sgi.com/projects/xfs/cmd_tars/$(ATTR).src.$(ATTR_SUFFIX) \
	ftp://oss.sgi.com/projects/xfs/previous/cmd_tars/$(ATTR).src.$(ATTR_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ATTR_SOURCE):
	@$(call targetinfo)
	@$(call get, ATTR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ATTR_PATH	:= PATH=$(CROSS_PATH)
ATTR_ENV 	:= \
	$(CROSS_ENV) \
	LIBTOOL=$(PTXCONF_SYSROOT_CROSS)/bin/libtool

#
# autoconf
#
ATTR_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_ATTR_GETTEXT
ATTR_AUTOCONF += --enable-gettext
else
ATTR_AUTOCONF += --disable-gettext
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/attr.targetinstall:
	@$(call targetinfo)

	@$(call install_init, attr)
	@$(call install_fixup, attr,PACKAGE,attr)
	@$(call install_fixup, attr,PRIORITY,optional)
	@$(call install_fixup, attr,VERSION,$(ATTR_VERSION))
	@$(call install_fixup, attr,SECTION,base)
	@$(call install_fixup, attr,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, attr,DEPENDS,)
	@$(call install_fixup, attr,DESCRIPTION,missing)

	@$(call install_copy, attr, 0, 0, 0755, $(ATTR_DIR)/attr/attr, /usr/bin/attr)
	@$(call install_copy, attr, 0, 0, 0755, $(ATTR_DIR)/setfattr/setfattr, /usr/bin/setfattr)
	@$(call install_copy, attr, 0, 0, 0755, $(ATTR_DIR)/getfattr/getfattr, /usr/bin/getfattr)

	@$(call install_finish, attr)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

attr_clean:
	rm -rf $(STATEDIR)/attr.*
	rm -rf $(PKGDIR)/attr_*
	rm -rf $(ATTR_DIR)

# vim: syntax=make
