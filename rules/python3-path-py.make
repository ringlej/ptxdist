# -*-makefile-*-
#
# Copyright (C) 2016 by Florian Scherf <f.scherf@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PATH_PY) += python3-path-py

#
# Paths and names
#
PYTHON3_PATH_PY_VERSION	:= 8.1.2
PYTHON3_PATH_PY_MD5	:= 31d07ac861284f8148a9041064852371
PYTHON3_PATH_PY		:= path.py-$(PYTHON3_PATH_PY_VERSION)
PYTHON3_PATH_PY_SUFFIX	:= tar.gz
PYTHON3_PATH_PY_URL	:= https://pypi.python.org/packages/source/p/path.py/$(PYTHON3_PATH_PY).$(PYTHON3_PATH_PY_SUFFIX)\#md5=$(PYTHON3_PATH_PY_MD5)
PYTHON3_PATH_PY_SOURCE	:= $(SRCDIR)/$(PYTHON3_PATH_PY).$(PYTHON3_PATH_PY_SUFFIX)
PYTHON3_PATH_PY_DIR	:= $(BUILDDIR)/$(PYTHON3_PATH_PY)
PYTHON3_PATH_PY_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PATH_PY_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-path-py.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-path-py)
	@$(call install_fixup, python3-path-py, PRIORITY, optional)
	@$(call install_fixup, python3-path-py, SECTION, base)
	@$(call install_fixup, python3-path-py, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-path-py, DESCRIPTION, missing)

	@$(call install_copy, python3-path-py, 0, 0, 0644, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/path.pyc)

	@$(call install_finish, python3-path-py)

	@$(call touch)

# vim: syntax=make
