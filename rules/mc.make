# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MC) += mc

#
# Paths and names
#
MC_VERSION	:= 4.6.1
MC		:= mc-$(MC_VERSION)
MC_SUFFIX	:= tar.gz
MC_URL		:= http://www.ibiblio.org/pub/Linux/utils/file/managers/mc/$(MC).$(MC_SUFFIX)
MC_SOURCE	:= $(SRCDIR)/$(MC).$(MC_SUFFIX)
MC_DIR		:= $(BUILDDIR)/$(MC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mc_get: $(STATEDIR)/mc.get

$(STATEDIR)/mc.get: $(mc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mc_extract: $(STATEDIR)/mc.extract

$(STATEDIR)/mc.extract: $(mc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MC_DIR))
	@$(call extract, MC)
	@$(call patchin, MC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mc_prepare: $(STATEDIR)/mc.prepare

MC_PATH	:=  PATH=$(CROSS_PATH)
MC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
MC_AUTOCONF := $(CROSS_AUTOCONF_USR) \
		--with-x=no \
		--without-gpm-mouse \
		--disable-dependency-tracking

ifdef PTXCONF_MC_USES_NCURSES
MC_AUTOCONF += --with-screen=ncurses
endif

ifdef PTXCONF_MC_USES_SLANG
MC_AUTOCONF += --with-screen=slang
endif

$(STATEDIR)/mc.prepare: $(mc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MC_DIR)/config.cache)
	cd $(MC_DIR) && \
		$(MC_PATH) $(MC_ENV) \
		./configure $(MC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mc_compile: $(STATEDIR)/mc.compile

$(STATEDIR)/mc.compile: $(mc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MC_DIR) && $(MC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mc_install: $(STATEDIR)/mc.install

$(STATEDIR)/mc.install: $(mc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mc_targetinstall: $(STATEDIR)/mc.targetinstall

$(STATEDIR)/mc.targetinstall: $(mc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, mc)
	@$(call install_fixup,mc,PACKAGE,mc)
	@$(call install_fixup,mc,PRIORITY,optional)
	@$(call install_fixup,mc,VERSION,$(MC_VERSION))
	@$(call install_fixup,mc,SECTION,base)
	@$(call install_fixup,mc,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,mc,DEPENDS,)
	@$(call install_fixup,mc,DESCRIPTION,missing)

	@$(call install_copy, mc, 0, 0, 0755, $(MC_DIR)/src/mc, /usr/bin/mc)

	@$(call install_finish,mc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mc_clean:
	rm -rf $(STATEDIR)/mc.*
	rm -rf $(PKGDIR)/mc_*
	rm -rf $(MC_DIR)

# vim: syntax=make
