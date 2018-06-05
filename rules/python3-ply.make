# -*-makefile-*-
#
# Copyright (C) 2015 by Robin van der Gracht <robin@protonic.nl>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PLY) += python3-ply

#
# Paths and names
#
PYTHON3_PLY_VERSION	:= 3.4
PYTHON3_PLY_MD5		:= ffdc95858819347bf92d7c2acc074894
PYTHON3_PLY		:= ply-$(PYTHON3_PLY_VERSION)
PYTHON3_PLY_SUFFIX	:= tar.gz
PYTHON3_PLY_URL		:= https://pypi.python.org/packages/source/p/ply/$(PYTHON3_PLY).$(PYTHON3_PLY_SUFFIX)
PYTHON3_PLY_SOURCE	:= $(SRCDIR)/$(PYTHON3_PLY).$(PYTHON3_PLY_SUFFIX)
PYTHON3_PLY_DIR		:= $(BUILDDIR)/$(PYTHON3_PLY)
PYTHON3_PLY_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PLY_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-ply.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-ply)
	@$(call install_fixup, python3-ply, PRIORITY, optional)
	@$(call install_fixup, python3-ply, SECTION, base)
	@$(call install_fixup, python3-ply, AUTHOR, "Robin van der Gracht <robin@protonic.nl>")
	@$(call install_fixup, python3-ply, DESCRIPTION, missing)

	@$(call install_glob, python3-ply, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/ply,, *.py)

	@$(call install_finish, python3-ply)

	@$(call touch)

# vim: syntax=make
