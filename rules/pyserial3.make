# -*-makefile-*-
#
# Copyright (C) 2011 by Juergen Beisert <jbe@pengutronix.de>
# Copyright (C) 2015 by Bernhard Walle <bernhard@bwalle.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYSERIAL3) += pyserial3

#
# Paths and names
#
PYSERIAL3_VERSION	:= 3.4
PYSERIAL3_MD5		:= fc00727ed9cf3a31b7a296a4d42f6afc
PYSERIAL3		:= v$(PYSERIAL3_VERSION)
PYSERIAL3_SUFFIX	:= tar.gz
PYSERIAL3_URL		:= https://github.com/pyserial/pyserial/archive/v$(PYSERIAL3_VERSION).$(PYSERIAL3_SUFFIX)
PYSERIAL3_SOURCE	:= $(SRCDIR)/$(PYSERIAL3).$(PYSERIAL3_SUFFIX)
PYSERIAL3_DIR		:= $(BUILDDIR)/$(PYSERIAL3)
PYSERIAL3_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/pyserial3.extract:
	@$(call targetinfo)
	@$(call clean, $(PYSERIAL3_DIR))
	@$(call extract, PYSERIAL3)
	@$(call patchin, PYSERIAL3)
	@(cd $(PYSERIAL3_DIR) ; \
		find . -name '*.py' -exec sed -i \
		's@#! \?/usr/bin/env python@#!/usr/bin/env python3@g' {} \;)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYSERIAL3_CONF_TOOL	:= python3
PYSERIAL3_MAKE_OPT	= build -e "/usr/bin/python$(PYTHON3_MAJORMINOR)"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pyserial3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pyserial3)
	@$(call install_fixup, pyserial3,PRIORITY,optional)
	@$(call install_fixup, pyserial3,SECTION,base)
	@$(call install_fixup, pyserial3,AUTHOR,"Bernhard Walle <bernhard@bwalle.de>")
	@$(call install_fixup, pyserial3,DESCRIPTION, "Serial Communication for Python")

	@$(call install_copy, pyserial3, 0, 0, 0755, $(PYTHON3_SITEPACKAGES))
	@$(call install_copy, pyserial3, 0, 0, 0755, $(PYTHON3_SITEPACKAGES)/serial)
	@$(call install_copy, pyserial3, 0, 0, 0755, $(PYTHON3_SITEPACKAGES)/serial/tools)
	@$(call install_copy, pyserial3, 0, 0, 0755, $(PYTHON3_SITEPACKAGES)/serial/urlhandler)

	@for file in $(shell cd $(PYSERIAL3_PKGDIR) && find . -name "*.pyc"); \
	do \
		$(call install_copy, pyserial3, 0, 0, 0644, -, /$$file); \
	done

ifdef PTXCONF_PYSERIAL3_MINITERM
	$(call install_copy, pyserial3, 0, 0, 0755, \
		$(PYSERIAL3_PKGDIR)/usr/bin/miniterm.py, /usr/bin/miniterm3.py)
endif

	@$(call install_finish, pyserial3)

	@$(call touch)

# vim: syntax=make
