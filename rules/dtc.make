# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#           (C) 2010 by Carsten Schlote
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DTC) += dtc

DTC_VERSION := 1.0.0

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/dtc.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/dtc.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/dtc.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/dtc.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dtc.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dtc.targetinstall:
	@$(call targetinfo)
	$(PTXCONF_SYSROOT_HOST)/bin/dtc \
		$(call remove_quotes,$(PTXCONF_DTC_EXTRA_ARGS)) \
		-I dts -O dtb -o $(IMAGEDIR)/oftree \
		$(PTXCONF_DTC_OFTREE_DTS)

ifdef PTXCONF_DTC_INSTALL_OFTREE
	@$(call install_init,  dtc)
	@$(call install_fixup, dtc, PRIORITY,optional)
	@$(call install_fixup, dtc, SECTION,base)
	@$(call install_fixup, dtc, AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, dtc, DESCRIPTION, "oftree description for machine $(PTXCONF_PROJECT_VERSION)")

	@$(call install_copy, dtc, 0, 0, 0755, /boot);
	@$(call install_copy, dtc, 0, 0, 0644, $(IMAGEDIR)/oftree, /boot/oftree);

	@$(call install_finish, dtc)
endif
	@$(call touch)

# vim: syntax=make
