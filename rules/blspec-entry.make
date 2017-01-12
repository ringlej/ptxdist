# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_ENTRY) += blspec-entry

BLSPEC_ENTRY_VERSION	:= $(KERNEL_VERSION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

BLSPEC_ENTRY_TITLE	:= PTXdist - $(call remove_quotes,$(PTXCONF_PROJECT_VENDOR)-$(PTXCONF_PROJECT))
ifdef PTXCONF_BLSPEC_ENTRY_DEVICETREE
BLSPEC_ENTRY_NAMES	= $(basename $(notdir $(DTC_DTB)))
blspec/title		= $(BLSPEC_ENTRY_TITLE) $(strip $(1))
blspec/devicetree	= devicetree\t/boot/$(strip $(1)).dtb
else
BLSPEC_ENTRY_NAMES	= default
blspec/title		= $(BLSPEC_ENTRY_TITLE)
blspec/devicetree	=
endif
BLSPEC_ENTRY_LICENSE	= ignore

$(STATEDIR)/blspec-entry.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-entry)
	@$(call install_fixup,blspec-entry,PRIORITY,optional)
	@$(call install_fixup,blspec-entry,SECTION,base)
	@$(call install_fixup,blspec-entry,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup,blspec-entry,DESCRIPTION,missing)

	@$(foreach name, $(BLSPEC_ENTRY_NAMES), \
		$(call install_alternative, blspec-entry, 0, 0, 0644, \
			/loader/entries/default.conf,n,/loader/entries/$(name).conf)$(ptx/nl) \
		$(call install_replace, blspec-entry, /loader/entries/$(name).conf, \
			@TITLE@,'$(call blspec/title,$(name))')$(ptx/nl) \
		$(call install_replace, blspec-entry, /loader/entries/$(name).conf, \
			@VERSION@,'$(BLSPEC_ENTRY_VERSION)')$(ptx/nl) \
		$(call install_replace, blspec-entry, /loader/entries/$(name).conf, \
			@CMDLINE@,$(PTXCONF_BLSPEC_ENTRY_CMDLINE))$(ptx/nl) \
		$(call install_replace, blspec-entry, /loader/entries/$(name).conf, \
			@KERNEL@,'/boot/$(KERNEL_IMAGE)')$(ptx/nl) \
		$(call install_replace, blspec-entry, /loader/entries/$(name).conf, \
			@DEVICETREE@,'$(call blspec/devicetree,$(name))')$(ptx/nl))

	@$(call install_finish,blspec-entry)

	@$(call touch)

# vim: syntax=make
