# -*-makefile-*-
# $Id: template 2878 2005-07-03 17:54:38Z rsc $
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
PACKAGES-$(PTXCONF_XMLSTARLET) += xmlstarlet

#
# Paths and names
#
XMLSTARLET_VERSION	= 1.0.1
XMLSTARLET		= xmlstarlet-$(XMLSTARLET_VERSION)
XMLSTARLET_SUFFIX	= tar.gz
XMLSTARLET_URL		= $(PTXCONF_SETUP_SFMIRROR)/xmlstar/$(XMLSTARLET).$(XMLSTARLET_SUFFIX)
XMLSTARLET_SOURCE	= $(SRCDIR)/$(XMLSTARLET).$(XMLSTARLET_SUFFIX)
XMLSTARLET_DIR		= $(BUILDDIR)/$(XMLSTARLET)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xmlstarlet_get: $(STATEDIR)/xmlstarlet.get

$(STATEDIR)/xmlstarlet.get: $(xmlstarlet_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XMLSTARLET_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XMLSTARLET)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xmlstarlet_extract: $(STATEDIR)/xmlstarlet.extract

$(STATEDIR)/xmlstarlet.extract: $(xmlstarlet_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XMLSTARLET_DIR))
	@$(call extract, XMLSTARLET)
	@$(call patchin, XMLSTARLET)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xmlstarlet_prepare: $(STATEDIR)/xmlstarlet.prepare

XMLSTARLET_PATH	=  PATH=$(CROSS_PATH)
XMLSTARLET_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
XMLSTARLET_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--with-libxml-prefix=$(SYSROOT)/usr \
	--with-libxslt-prefix=$(SYSROOT)/usr \
	--with-libiconv-prefix=$(SYSROOT)/usr

$(STATEDIR)/xmlstarlet.prepare: $(xmlstarlet_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XMLSTARLET_DIR)/config.cache)
	cd $(XMLSTARLET_DIR) && \
		$(XMLSTARLET_PATH) $(XMLSTARLET_ENV) \
		./configure $(XMLSTARLET_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xmlstarlet_compile: $(STATEDIR)/xmlstarlet.compile

$(STATEDIR)/xmlstarlet.compile: $(xmlstarlet_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XMLSTARLET_DIR) && $(XMLSTARLET_ENV) $(XMLSTARLET_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xmlstarlet_install: $(STATEDIR)/xmlstarlet.install

$(STATEDIR)/xmlstarlet.install: $(xmlstarlet_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XMLSTARLET)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xmlstarlet_targetinstall: $(STATEDIR)/xmlstarlet.targetinstall

$(STATEDIR)/xmlstarlet.targetinstall: $(xmlstarlet_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xmlstarlet)
	@$(call install_fixup, xmlstarlet,PACKAGE,xmlstarlet)
	@$(call install_fixup, xmlstarlet,PRIORITY,optional)
	@$(call install_fixup, xmlstarlet,VERSION,$(XMLSTARLET_VERSION))
	@$(call install_fixup, xmlstarlet,SECTION,base)
	@$(call install_fixup, xmlstarlet,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xmlstarlet,DEPENDS,)
	@$(call install_fixup, xmlstarlet,DESCRIPTION,missing)

	@$(call install_copy, xmlstarlet, 0, 0, 0755, $(XMLSTARLET_DIR)/src/xml, /usr/bin/xmlstarlet)

	@$(call install_finish, xmlstarlet)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xmlstarlet_clean:
	rm -rf $(STATEDIR)/xmlstarlet.*
	rm -rf $(PKGDIR)/xmlstarlet_*
	rm -rf $(XMLSTARLET_DIR)

# vim: syntax=make
