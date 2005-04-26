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
ifdef PTXCONF_GNUPG
PACKAGES += gnupg
endif

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

gnupg_get_deps = $(GNUPG_SOURCE)

$(STATEDIR)/gnupg.get: $(gnupg_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(GNUPG))
	touch $@

$(GNUPG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GNUPG_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gnupg_extract: $(STATEDIR)/gnupg.extract

gnupg_extract_deps = $(STATEDIR)/gnupg.get

$(STATEDIR)/gnupg.extract: $(gnupg_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GNUPG_DIR))
	@$(call extract, $(GNUPG_SOURCE))
	@$(call patchin, $(GNUPG))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gnupg_prepare: $(STATEDIR)/gnupg.prepare

#
# dependencies
#
gnupg_prepare_deps = \
	$(STATEDIR)/gnupg.extract \
	$(STATEDIR)/virtual-xchain.install

GNUPG_PATH	= PATH=$(CROSS_PATH)
GNUPG_ENV 	= $(CROSS_ENV)

#
# autoconf
#
GNUPG_AUTOCONF = $(CROSS_AUTOCONF)
GNUPG_AUTOCONF += --prefix=$(CROSS_LIB_DIR) \
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

$(STATEDIR)/gnupg.prepare: $(gnupg_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GNUPG_DIR)/config.cache)
	cd $(GNUPG_DIR) && \
		$(GNUPG_PATH) $(GNUPG_ENV) \
		./configure $(GNUPG_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gnupg_compile: $(STATEDIR)/gnupg.compile

gnupg_compile_deps = $(STATEDIR)/gnupg.prepare

$(STATEDIR)/gnupg.compile: $(gnupg_compile_deps)
	@$(call targetinfo, $@)
	cd $(GNUPG_DIR) && $(GNUPG_ENV) $(GNUPG_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gnupg_install: $(STATEDIR)/gnupg.install

$(STATEDIR)/gnupg.install: $(STATEDIR)/gnupg.compile
	@$(call targetinfo, $@)
	cd $(GNUPG_DIR) && $(GNUPG_ENV) $(GNUPG_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gnupg_targetinstall: $(STATEDIR)/gnupg.targetinstall

gnupg_targetinstall_deps = $(STATEDIR)/gnupg.install

$(STATEDIR)/gnupg.targetinstall: $(gnupg_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,gnupg)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(GNUPG_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Jiri Nesladek <nesladek\@2n.cz>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(GNUPG_DIR)/g10/gpg, /usr/bin/gpg)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gnupg_clean:
	rm -rf $(STATEDIR)/gnupg.*
	rm -rf $(IMAGEDIR)/gnupg_*
	rm -rf $(GNUPG_DIR)

# vim: syntax=make
