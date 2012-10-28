# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NANO) += nano

#
# Paths and names
#
NANO_VERSION		:= 2.3.1
NANO_MD5		:= af09f8828744b0ea0808d6c19a2b4bfd
NANO			:= nano-$(NANO_VERSION)
NANO_SUFFIX		:= tar.gz
NANO_URL		:= http://www.nano-editor.org/dist/v2.3/$(NANO).$(NANO_SUFFIX)
NANO_SOURCE		:= $(SRCDIR)/$(NANO).$(NANO_SUFFIX)
NANO_DIR		:= $(BUILDDIR)/$(NANO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NAN_CONF_TOOL	:= autoconf
NANO_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-rpath \
	--disable-nls \
	--disable-debug \
	--disable-tiny \
	--disable-extra \
	--disable-browser \
	--disable-help \
	--enable-justify \
	--disable-mouse \
	--disable-operatingdir \
	--disable-speller \
	--enable-tabcomp \
	--enable-wrapping \
	--enable-color \
	--enable-multibuffer \
	--disable-nanorc \
	--disable-utf8 \
	--disable-glibtest

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nano.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nano)
	@$(call install_fixup, nano,PRIORITY,optional)
	@$(call install_fixup, nano,SECTION,base)
	@$(call install_fixup, nano,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, nano,DESCRIPTION,missing)

	@$(call install_copy, nano, 0, 0, 0755, -, /usr/bin/nano)
	@$(call install_finish, nano)

	@$(call touch)

# vim: syntax=make
