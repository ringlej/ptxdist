# -*-makefile-*-
# $Id$
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
HOST_PACKAGES-$(PTXCONF_HOST-PELTS) += host-pelts

#
# Paths and names
#
HOST-PELTS_VERSION	= 1.0.0
HOST-PELTS		= pelts-$(HOST-PELTS_VERSION)
HOST-PELTS_SUFFIX	= tar.gz
HOST-PELTS_URL		= http://www.pengutronix.de/software/pelts/download/v1.0/$(HOST-PELTS).$(HOST-PELTS_SUFFIX)
HOST-PELTS_SOURCE	= $(SRCDIR)/$(HOST-PELTS).$(HOST-PELTS_SUFFIX)
HOST-PELTS_DIR		= $(HOST_BUILDDIR)/$(HOST-PELTS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-pelts_get: $(STATEDIR)/host-pelts.get

$(STATEDIR)/host-pelts.get: $(host-pelts_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST-PELTS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST-PELTS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-pelts_extract: $(STATEDIR)/host-pelts.extract

$(STATEDIR)/host-pelts.extract: $(host-pelts_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST-PELTS_DIR))
	@$(call extract, HOST-PELTS, $(HOST_BUILDDIR))
	@$(call patchin, $(HOST-PELTS), $(HOST-PELTS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-pelts_prepare: $(STATEDIR)/host-pelts.prepare

HOST-PELTS_PATH	=  PATH=$(HOST_PATH)
HOST-PELTS_ENV 	=  $(HOSTCC_ENV)

#
# autoconf
#
HOST-PELTS_AUTOCONF =  $(HOST_AUTOCONF)

$(STATEDIR)/host-pelts.prepare: $(host-pelts_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST-PELTS_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-pelts_compile: $(STATEDIR)/host-pelts.compile

$(STATEDIR)/host-pelts.compile: $(host-pelts_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-pelts_install: $(STATEDIR)/host-pelts.install

$(STATEDIR)/host-pelts.install: $(host-pelts_install_deps_default)
	@$(call targetinfo, $@)
	# first install the test library
	rm -fr $(PTXCONF_PREFIX)/lib/pelts-*
	cp -a $(HOST-PELTS_DIR) $(PTXCONF_PREFIX)/lib/
	@echo
	@echo "Looking up tests in pelts library:"
	@echo
	@if [ -d "$(PTXDIST_WORKSPACE)/testsuite" ]; then \
		for tool in `find $(PTXCONF_PREFIX)/lib/$(HOST-PELTS)/testsuite -maxdepth 1 -mindepth 1 -type d`; do \
			if [ ! -e "$(PTXDIST_WORKSPACE)/testsuite/`basename $$tool`" ]; then \
				echo "`basename $$tool`"; \
				ln -sf $$tool $(PTXDIST_WORKSPACE)/testsuite/; \
			else \
				echo "`basename $$tool` (omitted)"; \
			fi; \
		done; \
	fi
	@echo
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-pelts_clean:
	rm -rf $(STATEDIR)/host-pelts.*
	rm -rf $(HOST-PELTS_DIR)
	find $(PTXDIST_WORKSPACE)/testsuite -type l | xargs rm -fr

# vim: syntax=make
