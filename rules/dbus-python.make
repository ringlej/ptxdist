# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
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
DBUS_PYTHON_VERSION	:= 0.83.0
DBUS_PYTHON		:= dbus-python-$(DBUS_PYTHON_VERSION)
DBUS_PYTHON_SUFFIX	:= tar.gz
DBUS_PYTHON_URL		:= http://dbus.freedesktop.org/releases/dbus-python/$(DBUS_PYTHON).$(DBUS_PYTHON_SUFFIX)
DBUS_PYTHON_SOURCE	:= $(SRCDIR)/$(DBUS_PYTHON).$(DBUS_PYTHON_SUFFIX)
DBUS_PYTHON_DIR		:= $(BUILDDIR)/$(DBUS_PYTHON)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DBUS_PYTHON_SOURCE):
	@$(call targetinfo)
	@$(call get, DBUS_PYTHON)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/dbus-python.extract:
	@$(call targetinfo)
	@$(call clean, $(DBUS_PYTHON_DIR))
	@$(call extract, DBUS_PYTHON)
	@$(call patchin, DBUS_PYTHON)
	# touch autoconf files in correct order
	cd $(DBUS_PYTHON_DIR); \
	touch aclocal.m4; \
	find . -name "Makefile.in" | xargs touch; \
	touch config.h.in
	@$(call touch)

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
	--disable-api-docs \
	--with-python-includes=$(SYSROOT)/usr/include

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dbus-python.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dbus-python)
	@$(call install_fixup, dbus-python,PACKAGE,dbus-python)
	@$(call install_fixup, dbus-python,PRIORITY,optional)
	@$(call install_fixup, dbus-python,VERSION,$(DBUS_PYTHON_VERSION))
	@$(call install_fixup, dbus-python,SECTION,base)
	@$(call install_fixup, dbus-python,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dbus-python,DEPENDS,)
	@$(call install_fixup, dbus-python,DESCRIPTION,missing)


	for i in \
		/usr/lib/python2.4/site-packages/dbus_bindings.pyc \
		/usr/lib/python2.4/site-packages/dbus/bus.pyc \
		/usr/lib/python2.4/site-packages/dbus/connection.pyc \
		/usr/lib/python2.4/site-packages/dbus/dbus_bindings.pyc \
		/usr/lib/python2.4/site-packages/dbus/_dbus.pyc \
		/usr/lib/python2.4/site-packages/dbus/decorators.pyc \
		/usr/lib/python2.4/site-packages/dbus/exceptions.pyc \
		/usr/lib/python2.4/site-packages/dbus/_expat_introspect_parser.pyc \
		/usr/lib/python2.4/site-packages/dbus/glib.pyc \
		/usr/lib/python2.4/site-packages/dbus/gobject_service.pyc \
		/usr/lib/python2.4/site-packages/dbus/__init__.pyc \
		/usr/lib/python2.4/site-packages/dbus/lowlevel.pyc \
		/usr/lib/python2.4/site-packages/dbus/mainloop/glib.pyc \
		/usr/lib/python2.4/site-packages/dbus/mainloop/__init__.pyc \
		/usr/lib/python2.4/site-packages/dbus/proxies.pyc \
		/usr/lib/python2.4/site-packages/dbus/server.pyc \
		/usr/lib/python2.4/site-packages/dbus/service.pyc \
		/usr/lib/python2.4/site-packages/dbus/types.pyc \
		/usr/lib/python2.4/site-packages/dbus/_version.pyc \
	; do \
		$(call install_copy, dbus-python, 0, 0, 0644, -, $$i); \
	done

	$(call install_copy, dbus-python, 0, 0, 0644, -, \
		/usr/lib/python2.4/site-packages/_dbus_bindings.so)

	$(call install_copy, dbus-python, 0, 0, 0644, -, \
		/usr/lib/python2.4/site-packages/_dbus_glib_bindings.so)

	@$(call install_finish, dbus-python)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dbus-python_clean:
	rm -rf $(STATEDIR)/dbus-python.*
	rm -rf $(PKGDIR)/dbus-python_*
	rm -rf $(DBUS_PYTHON_DIR)

# vim: syntax=make
