# -*-makefile-*-
#
# Copyright (C) 2012 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSEMANAGE) += libsemanage

#
# Paths and names
#
LIBSEMANAGE_VERSION	:= 2.1.9
LIBSEMANAGE_MD5		:= 209e11da5b36c595a796751583f016f8
LIBSEMANAGE		:= libsemanage-$(LIBSEMANAGE_VERSION)
LIBSEMANAGE_SUFFIX	:= tar.gz
LIBSEMANAGE_URL		:= https://raw.githubusercontent.com/wiki/SELinuxProject/selinux/files/releases/20120924/$(LIBSEMANAGE).$(LIBSEMANAGE_SUFFIX)
LIBSEMANAGE_SOURCE	:= $(SRCDIR)/$(LIBSEMANAGE).$(LIBSEMANAGE_SUFFIX)
LIBSEMANAGE_DIR		:= $(BUILDDIR)/$(LIBSEMANAGE)
LIBSEMANAGE_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSEMANAGE_CONF_TOOL := NO
# no := due to CROSS_PYTHON
LIBSEMANAGE_MAKE_ENV = \
	$(CROSS_ENV) \
	CFLAGS="-O2 -Wall -g" \
	PYTHON=$(CROSS_PYTHON)

LIBSEMANAGE_MAKE_OPT := \
	LIBDIR=$(PTXDIST_SYSROOT_TARGET)/usr/lib
LIBSEMANAGE_INSTALL_OPT := \
	install

ifdef PTXCONF_LIBSEMANAGE_PYTHON
LIBSEMANAGE_MAKE_OPT	+= pywrap
LIBSEMANAGE_INSTALL_OPT	+= install-pywrap
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsemanage.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsemanage)
	@$(call install_fixup, libsemanage,PRIORITY,optional)
	@$(call install_fixup, libsemanage,SECTION,base)
	@$(call install_fixup, libsemanage,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, libsemanage,DESCRIPTION,missing)

	@$(call install_lib, libsemanage, 0, 0, 0644, libsemanage)
	@$(call install_alternative, libsemanage, 0, 0, 0644, /etc/selinux/semanage.conf)

ifdef PTXCONF_LIBSEMANAGE_PYTHON
	@$(call install_tree, libsemanage, 0, 0, -, $(PYTHON_SITEPACKAGES))
endif
	@$(call install_finish, libsemanage)

	@$(call touch)

# vim: syntax=make
