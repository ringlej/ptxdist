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
MESALIB_VERSION	:= 7.0.3
MESALIB		:= MesaLib-$(MESALIB_VERSION)
MESALIB_SUFFIX	:= tar.bz2
MESALIB_URL	:= $(PTXCONF_SETUP_SFMIRROR)/mesa3d/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_SOURCE	:= $(SRCDIR)/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_DIR	:= $(BUILDDIR)/Mesa-$(MESALIB_VERSION)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MESALIB_SOURCE):
	@$(call targetinfo)
	@$(call get, MESALIB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/mesalib.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/mesalib.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mesalib.install:
	@$(call targetinfo)
	cp -a $(MESALIB_DIR)/include/*  $(SYSROOT)/usr/include/
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mesalib.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mesalib_clean:
	rm -rf $(STATEDIR)/mesalib.*
	rm -rf $(PKGDIR)/mesalib_*
	rm -rf $(MESALIB_DIR)

# vim: syntax=make
