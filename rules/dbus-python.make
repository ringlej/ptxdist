# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DBUS_PYTHON) += dbus-python

#
# Paths and names
#
DBUS_PYTHON_VERSION	:= 0.84.0
DBUS_PYTHON_MD5		:= fe69a2613e824463e74f10913708c88a
DBUS_PYTHON		:= dbus-python-$(DBUS_PYTHON_VERSION)
DBUS_PYTHON_SUFFIX	:= tar.gz
DBUS_PYTHON_URL		:= http://dbus.freedesktop.org/releases/dbus-python/$(DBUS_PYTHON).$(DBUS_PYTHON_SUFFIX)
DBUS_PYTHON_SOURCE	:= $(SRCDIR)/$(DBUS_PYTHON).$(DBUS_PYTHON_SUFFIX)
DBUS_PYTHON_DIR		:= $(BUILDDIR)/$(DBUS_PYTHON)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DBUS_PYTHON_PATH	:= PATH=$(CROSS_PATH)
DBUS_PYTHON_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DBUS_PYTHON_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-html-docs \
	--disable-api-docs

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dbus-python.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dbus-python)
	@$(call install_fixup, dbus-python,PRIORITY,optional)
	@$(call install_fixup, dbus-python,SECTION,base)
	@$(call install_fixup, dbus-python,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dbus-python,DESCRIPTION,missing)

	@cd "$(DBUS_PYTHON_PKGDIR)"; \
		find ./usr/lib/python$(PYTHON_MAJORMINOR) \
		\( -name "*.so" -o -name "*.pyc" \) | \
		while read file; do \
		$(call install_copy, dbus-python, 0, 0, 0644, -, $${file##.}); \
	done

	@$(call install_finish, dbus-python)

	@$(call touch)

# vim: syntax=make
