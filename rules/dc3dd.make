# -*-makefile-*-
#
# Copyright (C) 2016 by Thorsten Liepert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_DC3DD) += dc3dd

DC3DD_VERSION		:= 7.2.641
DC3DD_MD5		:= 63987a467310d7b8a5102cb33e1945f4
DC3DD			:= dc3dd-$(DC3DD_VERSION)
DC3DD_SUFFIX		:= tar.xz
DC3DD_URL		:= $(call ptx/mirror, SF, dc3dd/7.2/dc3dd-$(DC3DD_VERSION).$(DC3DD_SUFFIX))
DC3DD_SOURCE		:= $(SRCDIR)/$(DC3DD).$(DC3DD_SUFFIX)
DC3DD_DIR		:= $(BUILDDIR)/$(DC3DD)
DC3DD_LICENSE		:= GPL-3.0-or-later
DC3DD_LICENSE_FILES	:= file://COPYING;md5=d32239bcb673463ab874e80d47fae504

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DC3DD_CONF_ENV	:= \
	$(CROSS_ENV) \
	PERL=

DC3DD_CONF_TOOL	:= autoconf
DC3DD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-dependency-tracking \
	--disable-assert \
	--disable-rpath \
	--disable-hdparm \
	--disable-nls \
	--without-included-regex \
	--with-gnu-ld

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dc3dd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dc3dd)
	@$(call install_fixup, dc3dd,PRIORITY,optional)
	@$(call install_fixup, dc3dd,SECTION,base)
	@$(call install_fixup, dc3dd,AUTHOR,"Thorsten Liepert <thorsten.liepert@diehl.com>")
	@$(call install_fixup, dc3dd,DESCRIPTION,missing)

	@$(call install_copy, dc3dd, 0, 0, 0755, -, /usr/bin/dc3dd)

	@$(call install_finish, dc3dd)

	@$(call touch)

# vim: syntax=make
