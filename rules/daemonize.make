# -*-makefile-*-
# $Id: template 4937 2006-03-01 17:38:11Z rsc $
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DAEMONIZE) += daemonize

#
# Paths and names
#
DAEMONIZE_VERSION	= 1.4
DAEMONIZE		= daemonize-$(DAEMONIZE_VERSION)
DAEMONIZE_SUFFIX	= tar.gz
DAEMONIZE_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(DAEMONIZE).$(DAEMONIZE_SUFFIX)
DAEMONIZE_SOURCE	= $(SRCDIR)/$(DAEMONIZE).$(DAEMONIZE_SUFFIX)
DAEMONIZE_DIR		= $(BUILDDIR)/$(DAEMONIZE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

daemonize_get: $(STATEDIR)/daemonize.get

$(STATEDIR)/daemonize.get: $(daemonize_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DAEMONIZE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DAEMONIZE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

daemonize_extract: $(STATEDIR)/daemonize.extract

$(STATEDIR)/daemonize.extract: $(daemonize_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DAEMONIZE_DIR))
	@$(call extract, DAEMONIZE)
	@$(call patchin, DAEMONIZE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

daemonize_prepare: $(STATEDIR)/daemonize.prepare

DAEMONIZE_PATH	:=  PATH=$(CROSS_PATH)
DAEMONIZE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
DAEMONIZE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/daemonize.prepare: $(daemonize_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DAEMONIZE_DIR)/config.cache)
	cd $(DAEMONIZE_DIR) && \
		$(DAEMONIZE_PATH) $(DAEMONIZE_ENV) \
		./configure $(DAEMONIZE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

daemonize_compile: $(STATEDIR)/daemonize.compile

$(STATEDIR)/daemonize.compile: $(daemonize_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(DAEMONIZE_DIR) && $(DAEMONIZE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

daemonize_install: $(STATEDIR)/daemonize.install

$(STATEDIR)/daemonize.install: $(daemonize_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

daemonize_targetinstall: $(STATEDIR)/daemonize.targetinstall

$(STATEDIR)/daemonize.targetinstall: $(daemonize_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, daemonize)
	@$(call install_fixup,daemonize,PACKAGE,daemonize)
	@$(call install_fixup,daemonize,PRIORITY,optional)
	@$(call install_fixup,daemonize,VERSION,$(DAEMONIZE_VERSION))
	@$(call install_fixup,daemonize,SECTION,base)
	@$(call install_fixup,daemonize,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,daemonize,DEPENDS,)
	@$(call install_fixup,daemonize,DESCRIPTION,missing)

	@$(call install_copy, daemonize, 0, 0, 0755, \
		$(DAEMONIZE_DIR)/daemonize, /usr/sbin/daemonize)

	@$(call install_finish,daemonize)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

daemonize_clean:
	rm -rf $(STATEDIR)/daemonize.*
	rm -rf $(IMAGEDIR)/daemonize_*
	rm -rf $(DAEMONIZE_DIR)

# vim: syntax=make
