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
PACKAGES-$(PTXCONF_PYTHON3_SIX) += python3-six

#
# Paths and names
#
PYTHON3_SIX_VERSION	:= 1.10.0
PYTHON3_SIX_MD5		:= 34eed507548117b2ab523ab14b2f8b55
PYTHON3_SIX		:= six-$(PYTHON3_SIX_VERSION)
PYTHON3_SIX_SUFFIX	:= tar.gz
PYTHON3_SIX_URL		:= https://pypi.python.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/$(PYTHON3_SIX).$(PYTHON3_SIX_SUFFIX)
PYTHON3_SIX_SOURCE	:= $(SRCDIR)/$(PYTHON3_SIX).$(PYTHON3_SIX_SUFFIX)
PYTHON3_SIX_DIR		:= $(BUILDDIR)/python3-$(PYTHON3_SIX)
PYTHON3_SIX_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_SIX_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-six.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-six)
	@$(call install_fixup, python3-six,PRIORITY,optional)
	@$(call install_fixup, python3-six,SECTION,base)
	@$(call install_fixup, python3-six,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, python3-six,DESCRIPTION,missing)

	@$(call install_glob, python3-six, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages,, *.py)

	@$(call install_finish, python3-six)

	@$(call touch)

# vim: syntax=make
