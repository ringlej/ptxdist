# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_APACHE2_MOD_PYTHON) += apache2_mod_python

#
# Paths and names
#
APACHE2_MOD_PYTHON_VERSION	:= 3.3.1
APACHE2_MOD_PYTHON_MD5		:= a3b0150176b726bd2833dac3a7837dc5
APACHE2_MOD_PYTHON		:= mod_python-$(APACHE2_MOD_PYTHON_VERSION)
APACHE2_MOD_PYTHON_SUFFIX	:= tgz
APACHE2_MOD_PYTHON_URL		:= http://archive.apache.org/dist/httpd/modpython/$(APACHE2_MOD_PYTHON).$(APACHE2_MOD_PYTHON_SUFFIX)
APACHE2_MOD_PYTHON_SOURCE	:= $(SRCDIR)/$(APACHE2_MOD_PYTHON).$(APACHE2_MOD_PYTHON_SUFFIX)
APACHE2_MOD_PYTHON_DIR		:= $(BUILDDIR)/$(APACHE2_MOD_PYTHON)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

APACHE2_MOD_PYTHON_CONF_ENV := \
	$(CROSS_ENV) \
	LIBEXECDIR=/usr/modules

#
# autoconf
#
APACHE2_MOD_PYTHON_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-apxs=$(SYSROOT)/usr/bin/apxs \
	--with-python=$(PTXCONF_SYSROOT_CROSS)/bin/python

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/apache2_mod_python.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  apache2_mod_python)
	@$(call install_fixup, apache2_mod_python,PRIORITY,optional)
	@$(call install_fixup, apache2_mod_python,SECTION,base)
	@$(call install_fixup, apache2_mod_python,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, apache2_mod_python,DESCRIPTION,missing)

	@$(call install_copy, apache2_mod_python, 0, 0, 0644, -, \
		/usr/modules/mod_python.so)

	@cd $(APACHE2_MOD_PYTHON_PKGDIR) && \
		find usr/lib/python$(PYTHON_MAJORMINOR) \
		-name "*.so" -o -name "*.pyc" | \
		while read file; do \
		$(call install_copy, apache2_mod_python, 0, 0, 644, -, /$${file}); \
	done

	@$(call install_finish, apache2_mod_python)

	@$(call touch)

# vim: syntax=make
