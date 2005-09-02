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
ifdef PTXCONF_APACHE2
PACKAGES += apache2
endif

#
# Paths and names
#
APACHE2_VERSION	= 2.0.54
APACHE2		= httpd-$(APACHE2_VERSION)
APACHE2_SUFFIX	= tar.bz2
APACHE2_URL	= http://ftp.plusline.de/ftp.apache.org/httpd/$(APACHE2).$(APACHE2_SUFFIX)
APACHE2_SOURCE	= $(SRCDIR)/$(APACHE2).$(APACHE2_SUFFIX)
APACHE2_DIR	= $(BUILDDIR)/$(APACHE2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

apache2_get: $(STATEDIR)/apache2.get

apache2_get_deps = $(APACHE2_SOURCE)

$(STATEDIR)/apache2.get: $(apache2_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(APACHE2))
	touch $@

$(APACHE2_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(APACHE2_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

apache2_extract: $(STATEDIR)/apache2.extract

apache2_extract_deps = $(STATEDIR)/apache2.get

$(STATEDIR)/apache2.extract: $(apache2_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(APACHE2_DIR))
	@$(call extract, $(APACHE2_SOURCE))
	@$(call patchin, $(APACHE2))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

apache2_prepare: $(STATEDIR)/apache2.prepare

#
# dependencies
#
apache2_prepare_deps = \
	$(STATEDIR)/apache2.extract \
	$(STATEDIR)/virtual-xchain.install

APACHE2_PATH	=  PATH=$(CROSS_PATH)
APACHE2_ENV 	=  $(CROSS_ENV)
APACHE2_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

# FIXME: find a real patch for these (fix configure script)
# APACHE2_ENV	+= SHELL="ac_cv_sizeof_ssize_t=4 ac_cv_sizeof_size_t=4 apr_cv_process_shared_works=yes ac_cv_func_setpgrp_void=yes /bin/sh"
APACHE2_ENV	+= ac_cv_sizeof_ssize_t=4
APACHE2_ENV	+= ac_cv_sizeof_size_t=4
APACHE2_ENV	+= apr_cv_process_shared_works=yes
APACHE2_ENV	+= ac_cv_func_setpgrp_void=yes

#
# autoconf
#
APACHE2_AUTOCONF =  $(CROSS_AUTOCONF)
APACHE2_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/apache2.prepare: $(apache2_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(APACHE2_DIR)/config.cache)
	cd $(APACHE2_DIR) && \
		$(APACHE2_PATH) $(APACHE2_ENV) \
		./configure $(APACHE2_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

apache2_compile: $(STATEDIR)/apache2.compile

apache2_compile_deps = \
	$(STATEDIR)/apache2.prepare \
	$(STATEDIR)/host-apache2.compile \
	$(STATEDIR)/expat.install

$(STATEDIR)/apache2.compile: $(apache2_compile_deps)
	@$(call targetinfo, $@)

	# Tweak, tweak...
	cp $(HOST_APACHE2_DIR)/srclib/apr-util/uri/gen_uri_delims $(APACHE2_DIR)/srclib/apr-util/uri/gen_uri_delims
	cp $(HOST_APACHE2_DIR)/srclib/pcre/dftables $(APACHE2_DIR)/srclib/pcre/dftables
	cp $(HOST_APACHE2_DIR)/server/gen_test_char $(APACHE2_DIR)/server/gen_test_char

	cd $(APACHE2_DIR) && $(APACHE2_ENV) $(APACHE2_PATH) make

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

apache2_install: $(STATEDIR)/apache2.install

$(STATEDIR)/apache2.install: $(STATEDIR)/apache2.compile
	@$(call targetinfo, $@)
	cd $(APACHE2_DIR) && $(APACHE2_ENV) $(APACHE2_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

apache2_targetinstall: $(STATEDIR)/apache2.targetinstall

apache2_targetinstall_deps = $(STATEDIR)/apache2.compile

$(STATEDIR)/apache2.targetinstall: $(apache2_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,apache2)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(APACHE2_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(APACHE2_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

apache2_clean:
	rm -rf $(STATEDIR)/apache2.*
	rm -rf $(IMAGEDIR)/apache2_*
	rm -rf $(APACHE2_DIR)

# vim: syntax=make
