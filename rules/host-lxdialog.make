# -*-makefile-*-
# $Id$
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
HOST_PACKAGES-$(PTXCONF_HOST_LXDIALOG) += host-lxdialog

#
# Paths and names
#
HOST_LXDIALOG_VERSION	= 2.5.something# FIXME: should be updated
HOST_LXDIALOG		= lxdialog-$(HOST_LXDIALOG_VERSION)
HOST_LXDIALOG_DIR	= $(PTXDIST_WORKSPACE)/scripts/lxdialog

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-lxdialog_get: $(STATEDIR)/host-lxdialog.get

$(STATEDIR)/host-lxdialog.get:
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-lxdialog_extract: $(STATEDIR)/host-lxdialog.extract

host-lxdialog_extract_deps = $(STATEDIR)/host-lxdialog.get

$(STATEDIR)/host-lxdialog.extract: $(host-lxdialog_extract_deps)
	@$(call targetinfo, $@)

	# we may be in an out-of-tree workspace...
	if [ ! -d "$(HOST_LXDIALOG_DIR)" ]; then \
		mkdir -p $(PTXDIST_WORKSPACE)/scripts; \
		cp -a $(PTXDIST_TOPDIR)/scripts/lxdialog $(HOST_LXDIALOG_DIR); \
		touch $(HOST_LXDIALOG_DIR)/.ptxdistoutoftree; \
	fi
	rm -f $(HOST_LXDIALOG_DIR)/Makefile
	cp -a \
		$(PTXDIST_TOPDIR)/scripts/ptx-modifications/Makefile.lxdialog.ptx \
		$(HOST_LXDIALOG_DIR)/Makefile

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-lxdialog_prepare: $(STATEDIR)/host-lxdialog.prepare

#
# dependencies
#
host-lxdialog_prepare_deps = $(STATEDIR)/host-lxdialog.extract

HOST_LXDIALOG_PATH	=  PATH=$(HOST_PATH)
HOST_LXDIALOG_ENV 	=  $(HOSTCC_ENV)

$(STATEDIR)/host-lxdialog.prepare: $(host-lxdialog_prepare_deps)
	@$(call targetinfo, $@, n)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-lxdialog_compile: $(STATEDIR)/host-lxdialog.compile

host-lxdialog_compile_deps = $(STATEDIR)/host-lxdialog.prepare

$(STATEDIR)/host-lxdialog.compile: $(host-lxdialog_compile_deps)
	@$(call targetinfo, $@, n)
	cd $(HOST_LXDIALOG_DIR) && $(HOST_LXDIALOG_ENV) $(HOST_LXDIALOG_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-lxdialog_install: $(STATEDIR)/host-lxdialog.install

host-lxdialog_install_deps = $(STATEDIR)/host-lxdialog.compile

$(STATEDIR)/host-lxdialog.install: $(host-lxdialog_install_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-lxdialog_clean:
	rm -rf $(STATEDIR)/host-lxdialog.*
	rm -rf $(HOST_LXDIALOG_DIR)

# vim: syntax=make
