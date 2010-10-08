# -*-makefile-*-
#
# Copyright (C) 2010 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DIALOG) += dialog

#
# Paths and names
#
DIALOG_VERSION	:= 1.1-20100428
DIALOG_MD5	:= 519c0a0cbac28ddb992111ec2c3f82aa
DIALOG		:= dialog-$(DIALOG_VERSION)
DIALOG_SUFFIX	:= tgz
DIALOG_URL	:= ftp://invisible-island.net/dialog/$(DIALOG).$(DIALOG_SUFFIX)
DIALOG_SOURCE	:= $(SRCDIR)/$(DIALOG).$(DIALOG_SUFFIX)
DIALOG_DIR	:= $(BUILDDIR)/$(DIALOG)
DIALOG_LICENSE	:= LGPLv2.1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DIALOG_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dialog.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  dialog)
	@$(call install_fixup, dialog,PRIORITY,optional)
	@$(call install_fixup, dialog,SECTION,base)
	@$(call install_fixup, dialog,AUTHOR,"Bart vdr. Meulen <bartvdrmeulen@gmail.com>")
	@$(call install_fixup, dialog,DESCRIPTION,missing)

	@$(call install_copy, dialog, 0, 0, 0755, -, /usr/bin/dialog)

	@$(call install_finish, dialog)

	@$(call touch)

# vim: syntax=make
