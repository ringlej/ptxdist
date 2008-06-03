# -*-makefile-*-
# $Id: gnupg.make,v 1.4 2005/04/26 12:16:24 michl Exp $
#
# Copyright (C) 2005 by Jiri Nesladek
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GNUPG) += gnupg

#
# Paths and names
#
GNUPG_VERSION	= 1.4.1
GNUPG		= gnupg-$(GNUPG_VERSION)
GNUPG_SUFFIX	= tar.bz2
GNUPG_URL	= ftp://ftp.gnupg.org/gcrypt/gnupg/$(GNUPG).$(GNUPG_SUFFIX)
GNUPG_SOURCE	= $(SRCDIR)/$(GNUPG).$(GNUPG_SUFFIX)
GNUPG_DIR	= $(BUILDDIR)/$(GNUPG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gnupg_get: $(STATEDIR)/gnupg.get

$(STATEDIR)/gnupg.get: $(gnupg_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GNUPG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GNUPG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gnupg_extract: $(STATEDIR)/gnupg.extract

$(STATEDIR)/gnupg.extract: $(gnupg_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GNUPG_DIR))
	@$(call extract, GNUPG)
	@$(call patchin, GNUPG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gnupg_prepare: $(STATEDIR)/gnupg.prepare

GNUPG_PATH	= PATH=$(CROSS_PATH)
GNUPG_ENV 	= $(CROSS_ENV)

#
# autoconf
#
GNUPG_AUTOCONF = $(CROSS_AUTOCONF_USR) \
	--disable-card-support \
	--disable-gnupg-iconv \
	--disable-exec \
	--disable-idea \
	--enable-cast5 \
	--enable-blowfish \
	--enable-aes \
	--enable-twofish \
	--enable-sha256 \
	--enable-sha512 \
	--disable-exec \
	--disable-photo-viewers \
	--disable-keyserver-helpers \
	--disable-ldap \
	--disable-hkp \
	--disable-http \
	--disable-finger \
	--disable-ftp \
	--disable-keyserver-path \
	--disable-largefile \
	--disable-dns-srv \
	--disable-nls \
	--disable-rpath \
	--disable-regex

$(STATEDIR)/gnupg.prepare: $(gnupg_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GNUPG_DIR)/config.cache)
	cd $(GNUPG_DIR) && \
		$(GNUPG_PATH) $(GNUPG_ENV) \
		./configure $(GNUPG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gnupg_compile: $(STATEDIR)/gnupg.compile

$(STATEDIR)/gnupg.compile: $(gnupg_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GNUPG_DIR) && $(GNUPG_ENV) $(GNUPG_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gnupg_install: $(STATEDIR)/gnupg.install

$(STATEDIR)/gnupg.install: $(gnupg_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GNUPG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gnupg_targetinstall: $(STATEDIR)/gnupg.targetinstall

$(STATEDIR)/gnupg.targetinstall: $(gnupg_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, gnupg)
	@$(call install_fixup, gnupg,PACKAGE,gnupg)
	@$(call install_fixup, gnupg,PRIORITY,optional)
	@$(call install_fixup, gnupg,VERSION,$(GNUPG_VERSION))
	@$(call install_fixup, gnupg,SECTION,base)
	@$(call install_fixup, gnupg,AUTHOR,"Jiri Nesladek <nesladek\@2n.cz>")
	@$(call install_fixup, gnupg,DEPENDS,)
	@$(call install_fixup, gnupg,DESCRIPTION,missing)

	@$(call install_copy, gnupg, 0, 0, 0755, $(GNUPG_DIR)/g10/gpg, /usr/bin/gpg)

	@$(call install_finish, gnupg)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gnupg_clean:
	rm -rf $(STATEDIR)/gnupg.*
	rm -rf $(PKGDIR)/gnupg_*
	rm -rf $(GNUPG_DIR)

# vim: syntax=make
