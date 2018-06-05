# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_GI) += python3-gi

#
# Paths and names
#
PYTHON3_GI_VERSION	:= 3.18.2
PYTHON3_GI_MD5		:= 0a956f3e785e23b0f136832f2e57a862
PYTHON3_GI		:= pygobject-$(PYTHON3_GI_VERSION)
PYTHON3_GI_SUFFIX	:= tar.xz
PYTHON3_GI_URL		:= http://ftp.gnome.org/pub/GNOME/sources/pygobject/$(basename $(PYTHON3_GI_VERSION))/$(PYTHON3_GI).$(PYTHON3_GI_SUFFIX)
PYTHON3_GI_SOURCE	:= $(SRCDIR)/$(PYTHON3_GI).$(PYTHON3_GI_SUFFIX)
PYTHON3_GI_DIR		:= $(BUILDDIR)/$(PYTHON3_GI)
PYTHON3_GI_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
PYTHON3_GI_CONF_TOOL	:= autoconf
PYTHON3_GI_CONF_OPT	 = \
	$(CROSS_AUTOCONF_USR) \
	--disable-cairo \
	--disable-iso-c \
	--disable-code-coverage \
	--with-python=$(CROSS_PYTHON3)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-gi.install:
	@$(call targetinfo)
	@$(call world/install, PYTHON3_GI)
	@$(call world/env, PYTHON3_GI) ptxd_make_world_install_python_cleanup
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-gi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-gi)
	@$(call install_fixup, python3-gi,PRIORITY,optional)
	@$(call install_fixup, python3-gi,SECTION,base)
	@$(call install_fixup, python3-gi,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-gi,DESCRIPTION,missing)

	@$(call install_glob, python3-gi, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/gi,, *.py *.la)

	@$(call install_finish, python3-gi)

	@$(call touch)

# vim: syntax=make
