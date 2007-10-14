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

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGD) += libgd

#
# Paths and names
#
LIBGD_VERSION	= 2.0.15
LIBGD		= gd-$(LIBGD_VERSION)
LIBGD_SUFFIX	= tar.gz
LIBGD_URL	= http://www.boutell.com/gd/http/$(LIBGD).$(LIBGD_SUFFIX)
LIBGD_SOURCE	= $(SRCDIR)/$(LIBGD).$(LIBGD_SUFFIX)
LIBGD_DIR	= $(BUILDDIR)/$(LIBGD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libgd_get: $(STATEDIR)/libgd.get

$(STATEDIR)/libgd.get: $(libgd_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBGD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBGD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libgd_extract: $(STATEDIR)/libgd.extract

$(STATEDIR)/libgd.extract: $(libgd_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGD_DIR))
	@$(call extract, LIBGD)
	@$(call patchin, LIBGD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libgd_prepare: $(STATEDIR)/libgd.prepare

LIBGD_PATH	=  PATH=$(SYSROOT)/bin:$(CROSS_PATH)
LIBGD_ENV 	=  $(CROSS_ENV)


#
# autoconf
#
LIBGD_AUTOCONF  =  $(CROSS_AUTOCONF_USR)

#LIBGD_AUTOCONF	+= 

$(STATEDIR)/libgd.prepare: $(libgd_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGD_BUILDDIR))
	cd $(LIBGD_DIR) && \
		$(LIBGD_PATH) $(LIBGD_ENV) \
		./configure $(LIBGD_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libgd_compile: $(STATEDIR)/libgd.compile

$(STATEDIR)/libgd.compile: $(libgd_compile_deps_default)
	@$(call targetinfo, $@)
	$(LIBGD_PATH) $(LIBGD_ENV) make -C $(LIBGD_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libgd_install: $(STATEDIR)/libgd.install

$(STATEDIR)/libgd.install: $(libgd_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME: is this a hosttool? 
	@$(call install, LIBGD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libgd_targetinstall: $(STATEDIR)/libgd.targetinstall

$(STATEDIR)/libgd.targetinstall: $(libgd_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libgd_clean:
	rm -rf $(STATEDIR)/libgd.*
	rm -rf $(LIBGD_DIR)

# vim: syntax=make
