# -*-makefile-*-
#
# Copyright (C) 2017 by David Jander <david@protonic.nl>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PYALSAAUDIO) += python3-pyalsaaudio

#
# Paths and names
#
PYTHON3_PYALSAAUDIO_VERSION	:= 0.8.4
PYTHON3_PYALSAAUDIO_MD5		:= b46f69561bc85fc52e698b2440ca251e
PYTHON3_PYALSAAUDIO		:= python3-pyalsaaudio-$(PYTHON3_PYALSAAUDIO_VERSION)
PYTHON3_PYALSAAUDIO_SUFFIX	:= tar.gz
PYTHON3_PYALSAAUDIO_URL		:= https://pypi.python.org/packages/52/b6/44871791929d9d7e11325af0b7be711388dfeeab17147988f044a41a6d83/pyalsaaudio-$(PYTHON3_PYALSAAUDIO_VERSION).$(PYTHON3_PYALSAAUDIO_SUFFIX)
PYTHON3_PYALSAAUDIO_SOURCE	:= $(SRCDIR)/$(PYTHON3_PYALSAAUDIO).$(PYTHON3_PYALSAAUDIO_SUFFIX)
PYTHON3_PYALSAAUDIO_DIR		:= $(BUILDDIR)/$(PYTHON3_PYALSAAUDIO)
PYTHON3_PYALSAAUDIO_LICENSE	:= PSF

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYALSAAUDIO_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pyalsaaudio.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pyalsaaudio)
	@$(call install_fixup, python3-pyalsaaudio, PRIORITY, optional)
	@$(call install_fixup, python3-pyalsaaudio, SECTION, base)
	@$(call install_fixup, python3-pyalsaaudio, AUTHOR, "David Jander <david@protonic.nl>")
	@$(call install_fixup, python3-pyalsaaudio, DESCRIPTION, missing)

	@$(call install_glob, python3-pyalsaaudio, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages,*/alsaaudio*.so)

	@$(call install_finish, python3-pyalsaaudio)

	@$(call touch)

# vim: syntax=make
