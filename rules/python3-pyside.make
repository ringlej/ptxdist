# -*-makefile-*-
#
# Copyright (C) 2016 by Robin van der Gracht <robin@protonic.nl>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PYSIDE) += python3-pyside

#
# Paths and names
#
PYTHON3_PYSIDE_VERSION	:= 4.8+1.2.2
PYTHON3_PYSIDE_MD5	:= 1969c2ff90eefaa4b200d234059d2287
PYTHON3_PYSIDE		:= pyside-qt$(PYTHON3_PYSIDE_VERSION)
PYTHON3_PYSIDE_SUFFIX	:= tar.bz2
PYTHON3_PYSIDE_URL	:= http://download.qt-project.org/official_releases/pyside/$(PYTHON3_PYSIDE).$(PYTHON3_PYSIDE_SUFFIX)
PYTHON3_PYSIDE_SOURCE	:= $(SRCDIR)/$(PYTHON3_PYSIDE).$(PYTHON3_PYSIDE_SUFFIX)
PYTHON3_PYSIDE_DIR	:= $(BUILDDIR)/$(PYTHON3_PYSIDE)
PYTHON3_PYSIDE_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
PYTHON3_PYSIDE_CONF_TOOL	:= cmake
PYTHON3_PYSIDE_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DUSE_PYTHON3:BOOL=ON

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pyside.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pyside)
	@$(call install_fixup, python3-pyside, PRIORITY, optional)
	@$(call install_fixup, python3-pyside, SECTION, base)
	@$(call install_fixup, python3-pyside, AUTHOR, "Robin van der Gracht <robin@protonic.nl>")
	@$(call install_fixup, python3-pyside, DESCRIPTION, missing)

	@$(call install_lib, python3-pyside, 0, 0, 0644, \
		libpyside.cpython-*)
	@$(call install_tree, python3-pyside, 0, 0, -,\
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/PySide)

	@$(call install_finish, python3-pyside)

	@$(call touch)

# vim: syntax=make
