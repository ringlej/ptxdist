# -*-makefile-*-
#
# Copyright (C) 2017 by Lucas Stach <l.stach@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_MAKO) += python3-mako

#
# Paths and names
#
PYTHON3_MAKO_VERSION	:= 1.0.6
PYTHON3_MAKO_MD5	:= a28e22a339080316b2acc352b9ee631c
PYTHON3_MAKO		:= Mako-$(PYTHON3_MAKO_VERSION)
PYTHON3_MAKO_SUFFIX	:= tar.gz
PYTHON3_MAKO_URL	:= https://pypi.python.org/packages/56/4b/cb75836863a6382199aefb3d3809937e21fa4cb0db15a4f4ba0ecc2e7e8e/$(PYTHON3_MAKO).$(PYTHON3_MAKO_SUFFIX)
PYTHON3_MAKO_SOURCE	:= $(SRCDIR)/$(PYTHON3_MAKO).$(PYTHON3_MAKO_SUFFIX)
PYTHON3_MAKO_DIR	:= $(BUILDDIR)/python3-$(PYTHON3_MAKO)
PYTHON3_MAKO_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_MAKO_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-mako.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-mako)
	@$(call install_fixup, python3-mako,PRIORITY,optional)
	@$(call install_fixup, python3-mako,SECTION,base)
	@$(call install_fixup, python3-mako,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, python3-mako,DESCRIPTION,missing)

	@$(call install_glob, python3-mako, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/mako,, *.py)

	@$(call install_finish, python3-mako)

	@$(call touch)

# vim: syntax=make
