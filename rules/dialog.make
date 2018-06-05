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
DIALOG_VERSION	:= 1.3-20171209
DIALOG_MD5	:= f66f28beca900b54f5fc90fdcce93508
DIALOG		:= dialog-$(DIALOG_VERSION)
DIALOG_SUFFIX	:= tgz
DIALOG_URL	:= ftp://ftp.invisible-island.net/dialog/$(DIALOG).$(DIALOG_SUFFIX)
DIALOG_SOURCE	:= $(SRCDIR)/$(DIALOG).$(DIALOG_SUFFIX)
DIALOG_DIR	:= $(BUILDDIR)/$(DIALOG)
DIALOG_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DIALOG_CONF_TOOL	:= autoconf
DIALOG_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-echo \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls \
	--disable-trace \
	--disable-rpath \
	--with-ncurses \
	--without-Xaw3d \
	--without-Xaw3dxft \
	--without-neXtaw \
	--without-XawPlus \
	--without-x \
	--enable-extras \
	--enable-rc-file \
	--enable-Xdialog \
	--enable-Xdialog2 \
	--enable-whiptail \
	--enable-form \
	--enable-gauge \
	--enable-tailbox \
	--enable-mixedform \
	--enable-mixedgauge \
	--enable-widec \
	--disable-rpath-hack

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
