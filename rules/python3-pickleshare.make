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
PACKAGES-$(PTXCONF_PYTHON3_PICKLESHARE) += python3-pickleshare

#
# Paths and names
#
PYTHON3_PICKLESHARE_VERSION	:= 0.6
PYTHON3_PICKLESHARE_MD5		:= 7fadddce8b1b0110c4ef905be795001a
PYTHON3_PICKLESHARE		:= pickleshare-$(PYTHON3_PICKLESHARE_VERSION)
PYTHON3_PICKLESHARE_SUFFIX	:= tar.gz
PYTHON3_PICKLESHARE_URL		:= https://pypi.python.org/packages/source/p/pickleshare/$(PYTHON3_PICKLESHARE).$(PYTHON3_PICKLESHARE_SUFFIX)\#md5=$(PYTHON3_PICKLESHARE_MD5)
PYTHON3_PICKLESHARE_SOURCE	:= $(SRCDIR)/$(PYTHON3_PICKLESHARE).$(PYTHON3_PICKLESHARE_SUFFIX)
PYTHON3_PICKLESHARE_DIR		:= $(BUILDDIR)/$(PYTHON3_PICKLESHARE)
PYTHON3_PICKLESHARE_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PICKLESHARE_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pickleshare.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pickleshare)
	@$(call install_fixup, python3-pickleshare, PRIORITY, optional)
	@$(call install_fixup, python3-pickleshare, SECTION, base)
	@$(call install_fixup, python3-pickleshare, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-pickleshare, DESCRIPTION, missing)

	@$(call install_copy, python3-pickleshare, 0, 0, 0644, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/pickleshare.pyc)

	@$(call install_finish, python3-pickleshare)

	@$(call touch)

# vim: syntax=make
