# -*-makefile-*-
# $Id: template 2922 2005-07-11 19:17:53Z rsc $
#
# Copyright (C) 2005 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DIFFUTILS) += diffutils

#
# Paths and names
#
DIFFUTILS_VERSION	= 2.8.1
DIFFUTILS		= diffutils-$(DIFFUTILS_VERSION)
DIFFUTILS_SUFFIX	= tar.gz
DIFFUTILS_URL		= http://ftp.gnu.org/pub/gnu/diffutils/$(DIFFUTILS).$(DIFFUTILS_SUFFIX)
DIFFUTILS_SOURCE	= $(SRCDIR)/$(DIFFUTILS).$(DIFFUTILS_SUFFIX)
DIFFUTILS_DIR		= $(BUILDDIR)/$(DIFFUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

diffutils_get: $(STATEDIR)/diffutils.get

$(STATEDIR)/diffutils.get: $(diffutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DIFFUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DIFFUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

diffutils_extract: $(STATEDIR)/diffutils.extract

$(STATEDIR)/diffutils.extract: $(diffutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DIFFUTILS_DIR))
	@$(call extract, DIFFUTILS)
	@$(call patchin, DIFFUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

diffutils_prepare: $(STATEDIR)/diffutils.prepare

DIFFUTILS_PATH	=  PATH=$(CROSS_PATH)
DIFFUTILS_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
DIFFUTILS_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/diffutils.prepare: $(diffutils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DIFFUTILS_DIR)/config.cache)
	cd $(DIFFUTILS_DIR) && \
		$(DIFFUTILS_PATH) $(DIFFUTILS_ENV) \
		./configure $(DIFFUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

diffutils_compile: $(STATEDIR)/diffutils.compile

$(STATEDIR)/diffutils.compile: $(diffutils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(DIFFUTILS_DIR) && $(DIFFUTILS_ENV) $(DIFFUTILS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

diffutils_install: $(STATEDIR)/diffutils.install

$(STATEDIR)/diffutils.install: $(diffutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, DIFFUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

diffutils_targetinstall: $(STATEDIR)/diffutils.targetinstall

$(STATEDIR)/diffutils.targetinstall: $(diffutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, diffutils)
	@$(call install_fixup, diffutils,PACKAGE,diffutils)
	@$(call install_fixup, diffutils,PRIORITY,optional)
	@$(call install_fixup, diffutils,VERSION,$(DIFFUTILS_VERSION))
	@$(call install_fixup, diffutils,SECTION,base)
	@$(call install_fixup, diffutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, diffutils,DEPENDS,)
	@$(call install_fixup, diffutils,DESCRIPTION,missing)

ifdef PTXCONF_DIFFUTILS_DIFF
	@$(call install_copy, diffutils, 0, 0, 0755, $(DIFFUTILS_DIR)/src/diff, /usr/bin/diff)
endif
ifdef PTXCONF_DIFFUTILS_DIFF3
	@$(call install_copy, diffutils, 0, 0, 0755, $(DIFFUTILS_DIR)/src/diff3, /usr/bin/diff3)
endif
ifdef PTXCONF_DIFFUTILS_SDIFF
	@$(call install_copy, diffutils, 0, 0, 0755, $(DIFFUTILS_DIR)/src/diff, /usr/bin/sdiff)
endif
ifdef PTXCONF_DIFFUTILS_CMP
	@$(call install_copy, diffutils, 0, 0, 0755, $(DIFFUTILS_DIR)/src/cmp, /usr/bin/cmp)
endif

	@$(call install_finish, diffutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

diffutils_clean:
	rm -rf $(STATEDIR)/diffutils.*
	rm -rf $(PKGDIR)/diffutils_*
	rm -rf $(DIFFUTILS_DIR)

# vim: syntax=make
