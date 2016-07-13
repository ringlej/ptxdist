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
PACKAGES-$(PTXCONF_PYTHON3_TRAITLETS) += python3-traitlets

#
# Paths and names
#
PYTHON3_TRAITLETS_VERSION	:= 4.1.0
PYTHON3_TRAITLETS_MD5		:= 2ebf5e11a19f82f25395b4a793097080
PYTHON3_TRAITLETS		:= traitlets-$(PYTHON3_TRAITLETS_VERSION)
PYTHON3_TRAITLETS_SUFFIX	:= tar.gz
PYTHON3_TRAITLETS_URL		:= https://pypi.python.org/packages/source/t/traitlets/$(PYTHON3_TRAITLETS).$(PYTHON3_TRAITLETS_SUFFIX)\#md5=$(PYTHON3_TRAITLETS_MD5)
PYTHON3_TRAITLETS_SOURCE	:= $(SRCDIR)/$(PYTHON3_TRAITLETS).$(PYTHON3_TRAITLETS_SUFFIX)
PYTHON3_TRAITLETS_DIR		:= $(BUILDDIR)/$(PYTHON3_TRAITLETS)
PYTHON3_TRAITLETS_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
PYTHON3_TRAITLETS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-traitlets.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-traitlets)
	@$(call install_fixup, python3-traitlets, PRIORITY, optional)
	@$(call install_fixup, python3-traitlets, SECTION, base)
	@$(call install_fixup, python3-traitlets, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-traitlets, DESCRIPTION, missing)

	@$(call install_glob, python3-traitlets, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/traitlets,, *.py)

	@$(call install_finish, python3-traitlets)

	@$(call touch)

# vim: syntax=make
