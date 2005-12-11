# -*-makefile-*-
# $Id: apache.make,v 1.5 2005/04/29 09:54:22 michl Exp $
#
# Copyright (C) 2005 by Jiri Nesladek
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_APACHE) += apache

#
# Paths and names
#
APACHE_VERSION		= 1.3.33
APACHE			= apache_$(APACHE_VERSION)
APACHE_SUFFIX		= tar.gz
APACHE_URL		= http://mirror.styx.cz/apache/httpd/$(APACHE).$(APACHE_SUFFIX)
APACHE_PATCH_URL	= file://$(LOCALPATCHDIR)
APACHE_SOURCE		= $(SRCDIR)/$(APACHE).$(APACHE_SUFFIX)
APACHE_DIR		= $(BUILDDIR)/$(APACHE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

apache_get: $(STATEDIR)/apache.get

apache_get_deps = $(APACHE_SOURCE)

$(STATEDIR)/apache.get: $(apache_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(APACHE))
	@$(call touch, $@)

$(APACHE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(APACHE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

apache_extract: $(STATEDIR)/apache.extract

apache_extract_deps = $(STATEDIR)/apache.get

$(STATEDIR)/apache.extract: $(apache_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(APACHE_DIR))
	@$(call extract, $(APACHE_SOURCE))
	@$(call patchin, $(APACHE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

apache_prepare: $(STATEDIR)/apache.prepare

#
# dependencies
#
apache_prepare_deps = \
	$(STATEDIR)/apache.extract \
	$(STATEDIR)/virtual-xchain.install

APACHE_PATH = PATH=$(CROSS_PATH)
APACHE_ENV = \
	$(CROSS_ENV) \
	apr_cv_process_shared_works=yes \
	ac_cv_sizeof_size_t=4 \
	ac_cv_sizeof_ssize_t=4 
#
# autoconf
#	
# FIXME: RSC: add more config options 
#
APACHE_AUTOCONF = \
	--prefix=$(CROSS_LIB_DIR) \
	--sysconfdir=/etc \
	--disable-module=access \
	--disable-module=asis \
	--disable-module=autoindex \
	--disable-module=userdir \
	--disable-module=include \
	--disable-module=log_config \
	--disable-module=negotiation \
	--disable-module=setenvif \
	--disable-module=status \
	--disable-module=env \
	--enable-module=so

$(STATEDIR)/apache.prepare: $(apache_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(APACHE_DIR)/config.cache)
	cd $(APACHE_DIR) && \
		$(APACHE_PATH) $(APACHE_ENV) \
		./configure $(APACHE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

apache_compile: $(STATEDIR)/apache.compile

apache_compile_deps = $(STATEDIR)/apache.prepare \
	$(STATEDIR)/expat.install

$(STATEDIR)/apache.compile: $(apache_compile_deps)
	@$(call targetinfo, $@)
	cd $(APACHE_DIR) && $(APACHE_ENV) $(APACHE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

apache_install: $(STATEDIR)/apache.install

$(STATEDIR)/apache.install: $(STATEDIR)/apache.compile
	@$(call targetinfo, $@)
	@$(call install, APACHE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

apache_targetinstall: $(STATEDIR)/apache.targetinstall

apache_targetinstall_deps = $(STATEDIR)/apache.compile

$(STATEDIR)/apache.targetinstall: $(apache_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,apache)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(APACHE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Jiri Nesladek <nesladek\@2n.cz>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, /usr/lib/apache)
	@$(call install_copy, 0, 0, 0755, $(APACHE_DIR)/src/httpd, /usr/sbin/httpd)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

apache_clean:
	rm -rf $(STATEDIR)/apache.*
	rm -rf $(IMAGEDIR)/apache_*
	rm -rf $(APACHE_DIR)

# vim: syntax=make
