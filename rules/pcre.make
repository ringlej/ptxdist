# -*-makefile-*-
#
# $Id:$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PCRE) += pcre

#
# Paths and names
#
PCRE_VERSION	= 5.0
PCRE		= pcre-$(PCRE_VERSION)
PCRE_SUFFIX	= tar.gz
PCRE_URL	= $(PTXCONF_SETUP_SFMIRROR)/pcre/$(PCRE).$(PCRE_SUFFIX)
PCRE_SOURCE	= $(SRCDIR)/$(PCRE).$(PCRE_SUFFIX)
PCRE_DIR	= $(BUILDDIR)/$(PCRE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pcre_get: $(STATEDIR)/pcre.get

$(STATEDIR)/pcre.get: $(pcre_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PCRE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PCRE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pcre_extract: $(STATEDIR)/pcre.extract

$(STATEDIR)/pcre.extract: $(pcre_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PCRE_DIR))
	@$(call extract, PCRE)
	@$(call patchin, PCRE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pcre_prepare: $(STATEDIR)/pcre.prepare

PCRE_PATH	=  PATH=$(CROSS_PATH)
PCRE_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
PCRE_AUTOCONF = $(CROSS_AUTOCONF_USR)

$(STATEDIR)/pcre.prepare: $(pcre_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PCRE_DIR)/config.cache)
	cd $(PCRE_DIR) && \
		$(PCRE_PATH) $(PCRE_ENV) \
		./configure $(PCRE_AUTOCONF)

	# Hack: libtool wants --tag=C when linking host side tools
	perl -i -p -e 's/LINK_FOR_BUILD = \$$\(LIBTOOL\)/LINK_FOR_BUILD = \$$\(LIBTOOL\) --tag=C/g' $(PCRE_DIR)/Makefile	

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pcre_compile: $(STATEDIR)/pcre.compile

$(STATEDIR)/pcre.compile: $(pcre_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PCRE_DIR) && $(PCRE_ENV) $(PCRE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pcre_install: $(STATEDIR)/pcre.install

$(STATEDIR)/pcre.install: $(pcre_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, PCRE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pcre_targetinstall: $(STATEDIR)/pcre.targetinstall

$(STATEDIR)/pcre.targetinstall: $(pcre_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, pcre)
	@$(call install_fixup, pcre,PACKAGE,pcre)
	@$(call install_fixup, pcre,PRIORITY,optional)
	@$(call install_fixup, pcre,VERSION,$(PCRE_VERSION))
	@$(call install_fixup, pcre,SECTION,base)
	@$(call install_fixup, pcre,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, pcre,DEPENDS,)
	@$(call install_fixup, pcre,DESCRIPTION,missing)

	@$(call install_copy, pcre, 0, 0, 0644, $(PCRE_DIR)/.libs/libpcre.so.0.0.1, /usr/lib/libpcre.so.0.0.1)
	@$(call install_link, pcre, /usr/lib/libpcre.so.0.0.1, /usr/lib/libpcre.so.0) 
	@$(call install_link, pcre, /usr/lib/libpcre.so.0.0.1, /usr/lib/libpcre.so) 
	@$(call install_copy, pcre, 0, 0, 0644, $(PCRE_DIR)/.libs/libpcreposix.so.0.0.0, /usr/lib/libpcreposix.so.0.0.0)
	@$(call install_link, pcre, /usr/lib/libpcreposix.so.0.0.0, /usr/lib/libpcreposix.so.0) 
	@$(call install_link, pcre, /usr/lib/libpcreposix.so.0.0.0, /usr/lib/libpcreposix.so) 

	@$(call install_finish, pcre)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pcre_clean:
	rm -rf $(STATEDIR)/pcre.*
	rm -rf $(IMAGEDIR)/pcre_*
	rm -rf $(PCRE_DIR)

# vim: syntax=make
