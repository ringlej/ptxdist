# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger <b.spranger@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: does nothing on targetinstall? 

#
# We provide this package
#
PACKAGES-$(PTXCONF_POPT) += popt

#
# Paths and names
#
POPT_VERSION	:= 1.7
POPT		:= popt-$(POPT_VERSION)
POPT_SUFFIX	:= tar.gz
POPT_URL	:= ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.1.x/$(POPT).$(POPT_SUFFIX)
POPT_SOURCE	:= $(SRCDIR)/$(POPT).$(POPT_SUFFIX)
POPT_DIR	:= $(BUILDDIR)/$(POPT)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

popt_get: $(STATEDIR)/popt.get

$(STATEDIR)/popt.get: $(popt_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(POPT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(POPT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

popt_extract: $(STATEDIR)/popt.extract

$(STATEDIR)/popt.extract: $(popt_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(POPT_DIR))
	@$(call extract, $(POPT_SOURCE))
	@$(call patchin, $(POPT))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

popt_prepare: $(STATEDIR)/popt.prepare

POPT_PATH	=  PATH=$(CROSS_PATH)
POPT_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
#POPT_AUTOCONF = \
#	--build=$(GNU_HOST) \
#	--host=$(PTXCONF_GNU_TARGET)

POPT_AUTOCONF = $(CROSS_AUTOCONF_USR)

$(STATEDIR)/popt.prepare: $(popt_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(POP_DIR)/config.cache)
	cd $(POPT_DIR) && \
		$(POPT_PATH) $(POPT_ENV) \
		./configure $(POPT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

popt_compile: $(STATEDIR)/popt.compile

$(STATEDIR)/popt.compile: $(popt_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(POPT_DIR) && $(POPT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

popt_install: $(STATEDIR)/popt.install

$(STATEDIR)/popt.install: $(popt_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, POPT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

popt_targetinstall: $(STATEDIR)/popt.targetinstall

$(STATEDIR)/popt.targetinstall: $(popt_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

popt_clean:
	rm -rf $(STATEDIR)/popt.*
	rm -rf $(IMAGEDIR)/popt_*
	rm -rf $(POPT_DIR)

# vim: syntax=make
