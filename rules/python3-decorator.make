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
PACKAGES-$(PTXCONF_PYTHON3_DECORATOR) += python3-decorator

#
# Paths and names
#
PYTHON3_DECORATOR_VERSION	:= 4.0.6
PYTHON3_DECORATOR_MD5		:= b17bfa17c294d33022a89de0f61d38fe
PYTHON3_DECORATOR		:= decorator-$(PYTHON3_DECORATOR_VERSION)
PYTHON3_DECORATOR_SUFFIX	:= tar.gz
PYTHON3_DECORATOR_URL		:= https://pypi.python.org/packages/source/d/decorator/$(PYTHON3_DECORATOR).$(PYTHON3_DECORATOR_SUFFIX)#md5=$(PYTHON3_DECORATOR_MD5)
PYTHON3_DECORATOR_SOURCE	:= $(SRCDIR)/$(PYTHON3_DECORATOR).$(PYTHON3_DECORATOR_SUFFIX)
PYTHON3_DECORATOR_DIR		:= $(BUILDDIR)/$(PYTHON3_DECORATOR)
PYTHON3_DECORATOR_LICENSE	:= BSD-2-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_DECORATOR_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-decorator.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-decorator)
	@$(call install_fixup, python3-decorator, PRIORITY, optional)
	@$(call install_fixup, python3-decorator, SECTION, base)
	@$(call install_fixup, python3-decorator, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-decorator, DESCRIPTION, missing)

	@$(call install_copy, python3-decorator, 0, 0, 0644, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/decorator.pyc)

	@$(call install_finish, python3-decorator)

	@$(call touch)

# vim: syntax=make
