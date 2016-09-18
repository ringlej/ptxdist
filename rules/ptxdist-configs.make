# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PTXDIST_CONFIGS) += ptxdist-configs

PTXDIST_CONFIGS_VERSION	:= $(PTXDIST_VERSION_FULL)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ptxdist-configs.targetinstall: \
	$(PTXDIST_PTXCONFIG) \
	$(PTXDIST_PLATFORMCONFIG)

ifneq ($(wildcard $(PTXDIST_COLLECTIONCONFIG)),)
$(STATEDIR)/ptxdist-configs.targetinstall: \
	$(PTXDIST_COLLECTIONCONFIG)
endif

ifdef PTXCONF_KERNEL
$(STATEDIR)/ptxdist-configs.targetinstall: $(STATEDIR)/kernel.prepare
endif
ifdef PTXCONF_BAREBOX
$(STATEDIR)/ptxdist-configs.targetinstall: $(STATEDIR)/barebox.prepare
endif

$(STATEDIR)/ptxdist-configs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ptxdist-configs)
	@$(call install_fixup,ptxdist-configs,PRIORITY,optional)
	@$(call install_fixup,ptxdist-configs,SECTION,base)
	@$(call install_fixup,ptxdist-configs,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup,ptxdist-configs,DESCRIPTION,missing)

	@$(call install_copy, ptxdist-configs, 0, 0, 0644, \
		$(PTXDIST_PTXCONFIG), /usr/share/ptxdist/ptxconfig)
	@$(call install_copy, ptxdist-configs, 0, 0, 0644, \
		$(PTXDIST_PLATFORMCONFIG), /usr/share/ptxdist/platformconfig)
ifneq ($(wildcard $(PTXDIST_COLLECTIONCONFIG)),)
	@$(call install_copy, ptxdist-configs, 0, 0, 0644, \
		$(PTXDIST_COLLECTIONCONFIG), /usr/share/ptxdist/collectionconfig)
endif
ifdef PTXCONF_KERNEL
	@$(call install_copy, ptxdist-configs, 0, 0, 0644, \
		$(KERNEL_CONFIG), /usr/share/ptxdist/kernelconfig)
endif
ifdef PTXCONF_BAREBOX
	@$(call install_copy, ptxdist-configs, 0, 0, 0644, \
		$(BAREBOX_CONFIG), /usr/share/ptxdist/bareboxconfig)
endif

	@$(call install_finish,ptxdist-configs)

	@$(call touch)

# vim: syntax=make
