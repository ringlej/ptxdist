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
NANO_VERSION		:= 2.8.4
NANO_MD5		:= e2a6bfc054d1f535b723f93eb73e5f77
NANO			:= nano-$(NANO_VERSION)
NANO_SUFFIX		:= tar.gz
NANO_URL		:= https://www.nano-editor.org/dist/v$(basename $(NANO_VERSION))/$(NANO).$(NANO_SUFFIX)
NANO_SOURCE		:= $(SRCDIR)/$(NANO).$(NANO_SUFFIX)
NANO_DIR		:= $(BUILDDIR)/$(NANO)
NANO_LICENSE		:= GPL-3.0+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NANO_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_header_magic_h=no \
	ac_cv_lib_magic_magic_open=no

#
# autoconf
#
NANO_CONF_TOOL	:= autoconf
NANO_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-rpath \
	--disable-nls \
	--disable-browser \
	--enable-color \
	--enable-comment \
	--disable-extra \
	--disable-help \
	--enable-histories \
	--enable-justify \
	--disable-libmagic \
	--enable-linenumbers \
	--disable-mouse \
	--enable-multibuffer \
	--enable-nanorc \
	--disable-operatingdir \
	--disable-speller \
	--enable-tabcomp \
	--disable-wordcomp \
	--enable-wrapping \
	--disable-wrapping-as-root \
	--disable-debug \
	--disable-tiny \
	--disable-utf8 \
	--disable-altrcname \
	--without-slang \
	--with-wordbounds

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
