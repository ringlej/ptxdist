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
DTC_LICENSE := ignore

DTC_OFTREE_DTS_PATH := $(call remove_quotes,$(PTXCONF_DTC_OFTREE_DTS_PATH))

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ptx/dtb = $(notdir $(basename $(strip $(1)))).dtb
ptx/dts = $(call ptx/in-path,DTC_OFTREE_DTS_PATH,$(strip $(1)))

ifdef PTXCONF_DTC_OFTREE_DTS
# Note: this must match the magic in ptxd_make_dts_dtb
DTC_OFTREE_DTS := $(foreach dts, $(call remove_quotes,$(PTXCONF_DTC_OFTREE_DTS)), \
	$(if $(filter /%,$(dts)),$(dts),$(call ptx/dts,$(dts))))
endif

dts/env = \
	$(call ptx/env) \
	dts_path=$(PTXCONF_DTC_OFTREE_DTS_PATH) \
	dts_dtb="$(strip $(1))" \
	dts_dts="$(strip $(2))" \
	dts_kernel_dir="$(KERNEL_DIR)" \
	dts_kernel_arch="$(GENERIC_KERNEL_ARCH)"

%.dtb: $(STATEDIR)/dtc.install
	@$(call targetinfo)
	@$(call dts/env, $@, $(DTB_DTS)) ptxd_make_dts_dtb
	@$(call finish)

DTC_DTB = $(foreach dts, $(call remove_quotes,$(PTXCONF_DTC_OFTREE_DTS)), $(IMAGEDIR)/$(call ptx/dtb, $(dts)))

# make sure "ptxdist targetinstall kernel" generates a new device trees
$(STATEDIR)/kernel.targetinstall.post: $(DTC_DTB)

$(STATEDIR)/dtc.targetinstall: $(DTC_DTB)
	@$(call targetinfo)

ifdef PTXCONF_DTC_INSTALL_OFTREE
	@$(call install_init,  dtc)
	@$(call install_fixup, dtc, PRIORITY,optional)
	@$(call install_fixup, dtc, SECTION,base)
	@$(call install_fixup, dtc, AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, dtc, DESCRIPTION, "oftree description for machine $(PTXCONF_PLATFORM)")

	@$(call install_copy, dtc, 0, 0, 0755, /boot);
	@$(foreach dtb, $(DTC_DTB), \
		$(call install_copy, dtc, 0, 0, 0644, \
		"$(dtb)", "/boot/$(notdir $(dtb))")$(ptx/nl))

	@$(call install_finish, dtc)
endif
	@$(call touch)

# vim: syntax=make
