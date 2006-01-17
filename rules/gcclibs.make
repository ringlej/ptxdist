# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#                       Marc Kleine-Budde <kleine-budde@gmx.de>
#               2005 by Marc Kleine-Budde <mkl@pengutronix.de>, Pengutronix
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GCCLIBS_GCC_S) += gcclibs

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gcclibs_get: $(STATEDIR)/gcclibs.get

$(STATEDIR)/gcclibs.get: $(gcclibs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gcclibs_extract: $(STATEDIR)/gcclibs.extract

$(STATEDIR)/gcclibs.extract: $(gcclibs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gcclibs_prepare: $(STATEDIR)/gcclibs.prepare

$(STATEDIR)/gcclibs.prepare: $(gcclibs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gcclibs_compile: $(STATEDIR)/gcclibs.compile

$(STATEDIR)/gcclibs.compile: $(gcclibs_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gcclibs_install: $(STATEDIR)/gcclibs.install

$(STATEDIR)/gcclibs.install: $(gcclibs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gcclibs_targetinstall: $(STATEDIR)/gcclibs.targetinstall

$(STATEDIR)/gcclibs.targetinstall: $(gcclibs_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,gcclibs)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(shell $(CROSS_CC) -dumpversion))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_GCCLIBS_CXX
	@$(call install_copy_toolchain_lib, libstdc++.so, /usr/lib)
endif

ifdef PTXCONF_GCCLIBS_GCC_S
	@$(call install_copy_toolchain_lib, libgcc_s.so, /lib)
endif

ifdef PTXCONF_GCCLIBS_GCC_S_NOF
	@$(call install_copy_toolchain_lib, libgcc_s_nof.so, /lib)
endif

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gcclibs_clean:
	rm -rf $(STATEDIR)/gcclibs.*

# vim: syntax=make
