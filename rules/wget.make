# -*-makefile-*-
# $Id: template 2516 2005-04-25 10:29:55Z rsc $
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
PACKAGES-$(PTXCONF_WGET) += wget

#
# Paths and names
#
WGET_VERSION	= 1.9.1
WGET_PACKET	= wget-$(WGET_VERSION)
WGET_SUFFIX	= tar.gz
WGET_URL	= $(PTXCONF_SETUP_GNUMIRROR)/wget/$(WGET_PACKET).$(WGET_SUFFIX)
WGET_SOURCE	= $(SRCDIR)/$(WGET_PACKET).$(WGET_SUFFIX)
WGET_DIR	= $(BUILDDIR)/$(WGET_PACKET)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

wget_get: $(STATEDIR)/wget.get

$(STATEDIR)/wget.get: $(wget_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(WGET_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, WGET)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

wget_extract: $(STATEDIR)/wget.extract

$(STATEDIR)/wget.extract: $(wget_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(WGET_DIR))
	@$(call extract, WGET)
	@$(call patchin, WGET_PACKET)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

wget_prepare: $(STATEDIR)/wget.prepare

WGET_PATH	=  PATH=$(CROSS_PATH)
WGET_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
WGET_AUTOCONF =  $(CROSS_AUTOCONF_USR)
WGET_AUTOCONF += --without-socks
WGET_AUTOCONF += --without-ssl

$(STATEDIR)/wget.prepare: $(wget_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(WGET_DIR)/config.cache)
	cd $(WGET_DIR) && \
		$(WGET_PATH) $(WGET_ENV) \
		./configure $(WGET_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

wget_compile: $(STATEDIR)/wget.compile

$(STATEDIR)/wget.compile: $(wget_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(WGET_DIR) && $(WGET_ENV) $(WGET_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

wget_install: $(STATEDIR)/wget.install

$(STATEDIR)/wget.install: $(wget_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, WGET)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

wget_targetinstall: $(STATEDIR)/wget.targetinstall

$(STATEDIR)/wget.targetinstall: $(wget_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, wget)
	@$(call install_fixup, wget,PACKAGE,wget)
	@$(call install_fixup, wget,PRIORITY,optional)
	@$(call install_fixup, wget,VERSION,$(WGET_VERSION))
	@$(call install_fixup, wget,SECTION,base)
	@$(call install_fixup, wget,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, wget,DEPENDS,)
	@$(call install_fixup, wget,DESCRIPTION,missing)

	@$(call install_copy, wget, 0, 0, 0755, $(WGET_DIR)/src/wget, /usr/bin/wget)

	@$(call install_finish, wget)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

wget_clean:
	rm -rf $(STATEDIR)/wget.*
	rm -rf $(PKGDIR)/wget_*
	rm -rf $(WGET_DIR)

# vim: syntax=make
