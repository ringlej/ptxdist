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
PYSERIAL3_VERSION	:= 2.7
PYSERIAL3_MD5		:= 794506184df83ef2290de0d18803dd11
PYSERIAL3		:= pyserial3-$(PYSERIAL3_VERSION)
PYSERIAL3_SUFFIX	:= tar.gz
PYSERIAL3_URL		:= http://pypi.python.org/packages/source/p/pyserial/pyserial-$(PYSERIAL3_VERSION).$(PYSERIAL3_SUFFIX)
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

PYSERIAL3_PATH		:= PATH=$(CROSS_PATH)
PYSERIAL3_CONF_TOOL	:= NO
PYSERIAL3_MAKE_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/pyserial3.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pyserial3.install:
	@$(call targetinfo)
	@cd $(PYSERIAL3_DIR) && \
		$(PYSERIAL3_PATH) $(PYSERIAL3_MAKE_ENV) \
		python3 setup.py install --root=$(PYSERIAL3_PKGDIR) --prefix=/usr
	@$(call touch)

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

# note: the setup.py also installs the miniterm.py script, but with a really
# broken path to the python interpreter. As a workaround we use the plain script
# from the build directory instead
ifdef PTXCONF_PYSERIAL3_MINITERM
	$(call install_copy, pyserial3, 0, 0, 0755, \
		$(PYSERIAL3_DIR)/build/lib/serial/tools/miniterm.py, /usr/bin/miniterm3.py)
endif

	@$(call install_finish, pyserial3)

	@$(call touch)

# vim: syntax=make
