# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
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
LDD_VERSION	:= 2.3.6
LDD_DIR		:= $(BUILDDIR)/ldd

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ldd_get: $(STATEDIR)/ldd.get

$(STATEDIR)/ldd.get: $(ldd_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ldd_extract: $(STATEDIR)/ldd.extract

$(STATEDIR)/ldd.extract: $(ldd_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ldd.prepare: $(ldd_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ldd_compile: $(STATEDIR)/ldd.compile

$(STATEDIR)/ldd.compile: $(ldd_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ldd_install: $(STATEDIR)/ldd.install

$(STATEDIR)/ldd.install: $(ldd_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ldd_targetinstall: $(STATEDIR)/ldd.targetinstall

$(STATEDIR)/ldd.targetinstall: $(ldd_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, ldd)
	@$(call install_fixup,ldd,PACKAGE,ldd)
	@$(call install_fixup,ldd,PRIORITY,optional)
	@$(call install_fixup,ldd,VERSION,$(LDD_VERSION))
	@$(call install_fixup,ldd,SECTION,base)
	@$(call install_fixup,ldd,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,ldd,DEPENDS,)
	@$(call install_fixup,ldd,DESCRIPTION,missing)

	@$(call install_copy, ldd, 0, 0, 0755, $(PTXDIST_TOPDIR)/generic/bin/ldd, /usr/bin/ldd)

	@$(call install_finish,ldd)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ldd_clean:
	rm -rf $(STATEDIR)/ldd.*
	rm -rf $(IMAGEDIR)/ldd_*
	rm -rf $(LDD_DIR)

# vim: syntax=make
