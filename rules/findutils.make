# -*-makefile-*-
# $Id: template 4453 2006-01-29 13:28:16Z rsc $
#
# Copyright (C) 2006 by Juergen Beisert
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FINDUTILS) += findutils

#
# Paths and names
#
FINDUTILS_VERSION	:= 4.2.23
FINDUTILS		:= findutils-$(FINDUTILS_VERSION)
FINDUTILS_SUFFIX	:= tar.gz
FINDUTILS_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/findutils/$(FINDUTILS).$(FINDUTILS_SUFFIX)
FINDUTILS_SOURCE	:= $(SRCDIR)/$(FINDUTILS).$(FINDUTILS_SUFFIX)
FINDUTILS_DIR		:= $(BUILDDIR)/$(FINDUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

findutils_get: $(STATEDIR)/findutils.get

$(STATEDIR)/findutils.get: $(findutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FINDUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, FINDUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

findutils_extract: $(STATEDIR)/findutils.extract

$(STATEDIR)/findutils.extract: $(findutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FINDUTILS_DIR))
	@$(call extract, FINDUTILS)
	@$(call patchin, FINDUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

findutils_prepare: $(STATEDIR)/findutils.prepare

FINDUTILS_PATH	:= PATH=$(CROSS_PATH)
FINDUTILS_ENV 	:= $(CROSS_ENV)
#
# where to place the database at runtime
#
FINDUTILS_DBASE_PATH := /var/lib/locate
#
# autoconf
#
FINDUTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--libexecdir=/usr/bin \
	--localstatedir=$(FINDUTILS_DBASE_PATH) \
	--disable-debug \
	--disable-nls

$(STATEDIR)/findutils.prepare: $(findutils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FINDUTILS_DIR)/config.cache)
	cd $(FINDUTILS_DIR) && \
		$(FINDUTILS_PATH) $(FINDUTILS_ENV) \
		./configure $(FINDUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

findutils_compile: $(STATEDIR)/findutils.compile

$(STATEDIR)/findutils.compile: $(findutils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FINDUTILS_DIR) && $(FINDUTILS_ENV) $(FINDUTILS_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

findutils_install: $(STATEDIR)/findutils.install

$(STATEDIR)/findutils.install: $(findutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

findutils_targetinstall: $(STATEDIR)/findutils.targetinstall

$(STATEDIR)/findutils.targetinstall: $(findutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,findutils)
	@$(call install_fixup,findutils,PACKAGE,findutils)
	@$(call install_fixup,findutils,PRIORITY,optional)
	@$(call install_fixup,findutils,VERSION,$(FINDUTILS_VERSION))
	@$(call install_fixup,findutils,SECTION,base)
	@$(call install_fixup,findutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,findutils,DEPENDS,)
	@$(call install_fixup,findutils,DESCRIPTION,missing)

ifdef PTXCONF_FINDUTILS_FIND
	@$(call install_copy,findutils, 0, 0, 0755, $(FINDUTILS_DIR)/find/find, /usr/bin/find)
endif
ifdef PTXCONF_FINDUTILS_XARGS
	@$(call install_copy,findutils, 0, 0, 0755, $(FINDUTILS_DIR)/xargs/xargs, /usr/bin/xargs)
endif
ifdef PTXCONF_FINDUTILS_DATABASE
	@$(call install_copy,findutils, 0, 0, 0755, $(FINDUTILS_DIR)/locate/locate, /usr/bin/locate)
	@$(call install_copy,findutils, 0, 0, 0755, $(FINDUTILS_DIR)/locate/updatedb, /usr/bin/updatedb,n)
	@$(call install_copy,findutils, 0, 0, 0755, $(FINDUTILS_DIR)/locate/bigram, /usr/bin/bigram)
	@$(call install_copy,findutils, 0, 0, 0755, $(FINDUTILS_DIR)/locate/code, /usr/bin/code)
	@$(call install_copy,findutils, 0, 0, 0755, $(FINDUTILS_DIR)/locate/frcode, /usr/bin/frcode)
	@$(call install_copy,findutils, 0, 0, 0755, $(FINDUTILS_DBASE_PATH))
endif
	@$(call install_finish,findutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

findutils_clean:
	rm -rf $(STATEDIR)/findutils.*
	rm -rf $(PKGDIR)/findutils_*
	rm -rf $(FINDUTILS_DIR)

# vim: syntax=make
