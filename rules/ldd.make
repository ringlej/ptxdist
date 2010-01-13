# -*-makefile-*-
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
PACKAGES-$(PTXCONF_LDD) += ldd

# This is the version from the glibc we have stolen from
LDD_VERSION	:= 2.7

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/ldd.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ldd.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ldd.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ldd.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ldd.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ldd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ldd)
	@$(call install_fixup,ldd,PACKAGE,ldd)
	@$(call install_fixup,ldd,PRIORITY,optional)
	@$(call install_fixup,ldd,VERSION,$(LDD_VERSION))
	@$(call install_fixup,ldd,SECTION,base)
	@$(call install_fixup,ldd,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,ldd,DEPENDS,)
	@$(call install_fixup,ldd,DESCRIPTION,missing)

	@$(call install_copy, ldd, 0, 0, 0755, $(PTXDIST_TOPDIR)/generic/usr/bin/ldd, /usr/bin/ldd, n)

	@$(call install_finish,ldd)

	@$(call touch)

# vim: syntax=make
