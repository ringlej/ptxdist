# -*-makefile-*-
# $Id: template 2922 2005-07-11 19:17:53Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
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
APACHE2_MOD_PYTHON_VERSION	:= 3.2.8
APACHE2_MOD_PYTHON		:= mod_python-$(APACHE2_MOD_PYTHON_VERSION)
APACHE2_MOD_PYTHON_SUFFIX	:= tgz
APACHE2_MOD_PYTHON_URL		:= http://apache.easy-webs.de/httpd/modpython/$(APACHE2_MOD_PYTHON).$(APACHE2_MOD_PYTHON_SUFFIX)
APACHE2_MOD_PYTHON_SOURCE	:= $(SRCDIR)/$(APACHE2_MOD_PYTHON).$(APACHE2_MOD_PYTHON_SUFFIX)
APACHE2_MOD_PYTHON_DIR		:= $(BUILDDIR)/$(APACHE2_MOD_PYTHON)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

apache2_mod_python_get: $(STATEDIR)/apache2_mod_python.get

$(STATEDIR)/apache2_mod_python.get: $(apache2_mod_python_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(APACHE2_MOD_PYTHON_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, APACHE2_MOD_PYTHON)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

apache2_mod_python_extract: $(STATEDIR)/apache2_mod_python.extract

$(STATEDIR)/apache2_mod_python.extract: $(apache2_mod_python_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(APACHE2_MOD_PYTHON_DIR))
	@$(call extract, APACHE2_MOD_PYTHON)
	@$(call patchin, APACHE2_MOD_PYTHON)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

apache2_mod_python_prepare: $(STATEDIR)/apache2_mod_python.prepare

APACHE2_MOD_PYTHON_PATH	:=  PATH=$(CROSS_PATH)
APACHE2_MOD_PYTHON_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
APACHE2_MOD_PYTHON_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--with-apxs=$(SYSROOT)/usr/bin/apxs \
	--with-python=$(PTXCONF_SYSROOT_HOST)/bin/python

$(STATEDIR)/apache2_mod_python.prepare: $(apache2_mod_python_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(APACHE2_MOD_PYTHON_DIR)/config.cache)
	cd $(APACHE2_MOD_PYTHON_DIR) && \
		$(APACHE2_MOD_PYTHON_PATH) $(APACHE2_MOD_PYTHON_ENV) \
		./configure $(APACHE2_MOD_PYTHON_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

apache2_mod_python_compile: $(STATEDIR)/apache2_mod_python.compile

$(STATEDIR)/apache2_mod_python.compile: $(apache2_mod_python_compile_deps_default)
	@$(call targetinfo, $@)

	cd $(APACHE2_MOD_PYTHON_DIR) && $(APACHE2_MOD_PYTHON_PATH) $(MAKE)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

apache2_mod_python_install: $(STATEDIR)/apache2_mod_python.install

$(STATEDIR)/apache2_mod_python.install: $(apache2_mod_python_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

apache2_mod_python_targetinstall: $(STATEDIR)/apache2_mod_python.targetinstall

$(STATEDIR)/apache2_mod_python.targetinstall: $(apache2_mod_python_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,  apache2_mod_python)
	@$(call install_fixup, apache2_mod_python,PACKAGE,apache2-mod-python)
	@$(call install_fixup, apache2_mod_python,PRIORITY,optional)
	@$(call install_fixup, apache2_mod_python,VERSION,$(APACHE2_MOD_PYTHON_VERSION))
	@$(call install_fixup, apache2_mod_python,SECTION,base)
	@$(call install_fixup, apache2_mod_python,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, apache2_mod_python,DEPENDS,)
	@$(call install_fixup, apache2_mod_python,DESCRIPTION,missing)

	@$(call install_copy,  apache2_mod_python, 0, 0, 0644, \
		$(APACHE2_MOD_PYTHON_DIR)/src/.libs/mod_python.so, \
		/usr/share/apache2/libexec/mod_python.so)

	@$(call install_copy,  apache2_mod_python, 0, 0, 0755, \
		/usr/lib/python2.4/mod_python)

	cd $(APACHE2_MOD_PYTHON_DIR)/lib/python/mod_python && \
	for i in *; do \
		$(call install_copy, apache2_mod_python, 0, 0, 0644, $$i, /usr/lib/python2.4/mod_python/$$i,n); \
	done

	@$(call install_finish, apache2_mod_python)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

apache2_mod_python_clean:
	rm -rf $(STATEDIR)/apache2_mod_python.*
	rm -rf $(IMAGEDIR)/apache2_mod_python_*
	rm -rf $(APACHE2_MOD_PYTHON_DIR)

# vim: syntax=make
