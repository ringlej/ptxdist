# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GPGME) += gpgme

#
# Paths and names
#
GPGME_VERSION	:= 1.11.1
GPGME_MD5	:= 129c46fb85a7ffa41e43345e48aee884
GPGME		:= gpgme-$(GPGME_VERSION)
GPGME_SUFFIX	:= tar.bz2
GPGME_URL	:= https://www.gnupg.org/ftp/gcrypt/gpgme/$(GPGME).$(GPGME_SUFFIX)
GPGME_SOURCE	:= $(SRCDIR)/$(GPGME).$(GPGME_SUFFIX)
GPGME_DIR	:= $(BUILDDIR)/$(GPGME)
GPGME_LICENSE	:= LGPLv2.1+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GPGME_LANG-y				:=
GPGME_LANG-$(PTXCONF_GPGME_CPP)		+= cpp
# TODO: python detection is very broken
# Note: qt bindings are GPLv2.0+

GPGME_LANG := $(subst $(space),$(comma),$(strip $(GPGME_LANG-y)))

#
# autoconf
#
GPGME_CONF_TOOL	:= autoconf
GPGME_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-glibtest \
	--disable-w32-glib \
	--enable-fixed-path="" \
	--enable-languages=$(GPGME_LANG) \
	--enable-build-timestamp="$(PTXDIST_VERSION_YEAR)-$(PTXDIST_VERSION_MONTH)-01T00:00+0000" \
	--disable-gpgconf-test \
	--disable-gpg-test \
	--disable-gpgsm-test \
	--disable-g13-test \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-fd-passing \
	--enable-linux-getdents

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gpgme.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gpgme)
	@$(call install_fixup, gpgme,PRIORITY,optional)
	@$(call install_fixup, gpgme,SECTION,base)
	@$(call install_fixup, gpgme,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, gpgme,DESCRIPTION,missing)

	@$(call install_lib, gpgme, 0, 0, 0644, libgpgme)
ifdef PTXCONF_GPGME_CPP
	@$(call install_lib, gpgme, 0, 0, 0644, libgpgmepp)
endif
	@$(call install_finish, gpgme)

	@$(call touch)

# vim: syntax=make
