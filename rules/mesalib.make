# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME, we only need the source tree, do we still need the package ?


#
# We provide this package
#
PACKAGES-$(PTXCONF_MESALIB) += mesalib

#
# Paths and names
#
MESALIB_VERSION	:= 7.0.1
MESALIB		:= MesaLib-$(MESALIB_VERSION)
MESALIB_SUFFIX	:= tar.bz2
MESALIB_URL	:= $(PTXCONF_SETUP_SFMIRROR)/mesa3d/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_SOURCE	:= $(SRCDIR)/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_DIR	:= $(BUILDDIR)/Mesa-$(MESALIB_VERSION)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mesalib_get: $(STATEDIR)/mesalib.get

$(STATEDIR)/mesalib.get: $(mesalib_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MESALIB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MESALIB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mesalib_extract: $(STATEDIR)/mesalib.extract

$(STATEDIR)/mesalib.extract: $(mesalib_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MESALIB_DIR))
	@$(call extract, MESALIB)
	@$(call patchin, MESALIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mesalib_prepare: $(STATEDIR)/mesalib.prepare

MESALIB_PATH	:=  PATH=$(CROSS_PATH)
MESALIB_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
MESALIB_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/mesalib.prepare: $(mesalib_prepare_deps_default)
	@$(call clean, $(MESALIB_DIR)/config.cache)
	# We only need the sources
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mesalib_compile: $(STATEDIR)/mesalib.compile

$(STATEDIR)/mesalib.compile: $(mesalib_compile_deps_default)
	@$(call targetinfo, $@)
	# we only need the source tree
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mesalib_install: $(STATEDIR)/mesalib.install

$(STATEDIR)/mesalib.install: $(mesalib_install_deps_default)
	@$(call targetinfo, $@)
	# we need the include files 
	cp -a $(MESALIB_DIR)/include/*  $(SYSROOT)/usr/include/
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mesalib_targetinstall: $(STATEDIR)/mesalib.targetinstall

$(STATEDIR)/mesalib.targetinstall: $(mesalib_targetinstall_deps_default)
	@$(call targetinfo, $@)
	# We only need the source tree
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mesalib_clean:
	rm -rf $(STATEDIR)/mesalib.*
	rm -rf $(PKGDIR)/mesalib_*
	rm -rf $(MESALIB_DIR)

# vim: syntax=make
