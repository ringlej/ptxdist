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
ifdef PTXCONF_GCCLIBS_GCC_S
PACKAGES += gcclibs
endif


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gcclibs_get: $(STATEDIR)/gcclibs.get

$(STATEDIR)/gcclibs.get:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gcclibs_extract: $(STATEDIR)/gcclibs.extract

gcclibs_extract_deps = $(STATEDIR)/gcclibs.get

$(STATEDIR)/gcclibs.extract: $(gcclibs_extract_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gcclibs_prepare: $(STATEDIR)/gcclibs.prepare

gcclibs_prepare_deps = $(STATEDIR)/gcclibs.extract

$(STATEDIR)/gcclibs.prepare: $(gcclibs_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gcclibs_compile: $(STATEDIR)/gcclibs.compile

gcclibs_compile_deps = $(STATEDIR)/gcclibs.prepare

$(STATEDIR)/gcclibs.compile: $(gcclibs_compile_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gcclibs_install: $(STATEDIR)/gcclibs.install

$(STATEDIR)/gcclibs.install: $(STATEDIR)/gcclibs.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gcclibs_targetinstall: $(STATEDIR)/gcclibs.targetinstall

gcclibs_targetinstall_deps = $(STATEDIR)/gcclibs.compile

$(STATEDIR)/gcclibs.targetinstall: $(gcclibs_targetinstall_deps)
	@$(call targetinfo, $@)
ifdef PTXCONF_GCCLIBS_CXX
	@$(call copy_toolchain_lib_root, libstdc++.so, /usr/lib)
endif

ifdef PTXCONF_GCCLIBS_GCC_S
	@$(call copy_toolchain_lib_root, libgcc_s.so, /lib)
endif

ifdef PTXCONF_GCCLIBS_GCC_S_NOF
	@$(call copy_toolchain_lib_root, libgcc_s_nof.so, /lib)
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gcclibs_clean:
	rm -rf $(STATEDIR)/gcclibs.*

# vim: syntax=make
