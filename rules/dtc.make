# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#           (C) 2010 by Carsten Schlote
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
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
# Target-Install
# ----------------------------------------------------------------------------

ptx/dtb = $(notdir $(basename $(strip $(1)))).dtb

# .dtb depends on the .dts and dtc.install for all other dependencies
$(foreach dts, $(call remove_quotes,$(PTXCONF_DTC_OFTREE_DTS)), \
	$(eval $(IMAGEDIR)/$(call ptx/dtb, $(dts)): $(dts)  $(STATEDIR)/dtc.install))

%.dtb:
	@$(call targetinfo)
	@$(PTXCONF_SYSROOT_HOST)/bin/dtc \
		$(call remove_quotes,$(PTXCONF_DTC_EXTRA_ARGS)) \
		-I dts -O dtb -o "$@" "$<"

DTC_DTB = $(foreach dts, $(call remove_quotes,$(PTXCONF_DTC_OFTREE_DTS)), $(IMAGEDIR)/$(call ptx/dtb, $(dts)))

$(STATEDIR)/dtc.targetinstall: $(DTC_DTB)
	@$(call targetinfo)

ifdef PTXCONF_DTC_INSTALL_OFTREE
	@$(call install_init,  dtc)
	@$(call install_fixup, dtc, PRIORITY,optional)
	@$(call install_fixup, dtc, SECTION,base)
	@$(call install_fixup, dtc, AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, dtc, DESCRIPTION, "oftree description for machine $(PTXCONF_PROJECT_VERSION)")

	@$(call install_copy, dtc, 0, 0, 0755, /boot);
	@$(foreach dtb, $(DTC_DTB), \
		$(call install_copy, dtc, 0, 0, 0644, \
		"$(dtb)", "/boot/$(notdir $(dtb))");)

	@$(call install_finish, dtc)
endif
	@$(call touch)

# vim: syntax=make
