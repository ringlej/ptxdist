# -*-makefile-*-
# $Id: openssh.make,v 1.9 2003/07/23 12:39:06 mkl Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_OPENSSH))
PACKAGES += openssh
endif

#
# Paths and names 
#
OPENSSH			= openssh-3.6.1p2
OPENSSH_URL 		= ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/$(OPENSSH).tar.gz
OPENSSH_SOURCE		= $(SRCDIR)/$(OPENSSH).tar.gz
OPENSSH_DIR 		= $(BUILDDIR)/$(OPENSSH)

OPENSSH_PATCH		= openssh.patch
OPENSSH_PATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(OPENSSH_PATCH)
OPENSSH_PATCH_SOURCE	= $(SRCDIR)/$(OPENSSH_PATCH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

openssh_get: $(STATEDIR)/openssh.get

openssh_get_deps = \
	$(OPENSSH_SOURCE) \
	$(OPENSSH_PATCH_SOURCE)

$(STATEDIR)/openssh.get: $(openssh_get_deps)
	@$(call targetinfo, openssh.get)
	touch $@

$(OPENSSH_SOURCE):
	@$(call targetinfo, $(OPENSSH_SOURCE))
	@$(call get, $(OPENSSH_URL))

$(OPENSSH_PATCH_SOURCE):
	@$(call targetinfo, $(OPENSSH_PATCH_SOURCE))
	@$(call get, $(OPENSSH_PATCH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

openssh_extract: $(STATEDIR)/openssh.extract

#
# we depend on openssl.install, because we need the header files
# to patch configure.ac with the version string of the installed
# openssl packet
#
openssh_extract_deps = \
	$(STATEDIR)/autoconf257.install \
	$(STATEDIR)/openssl.install \
	$(STATEDIR)/openssh.get

$(STATEDIR)/openssh.extract: $(openssh_extract_deps)
	@$(call targetinfo, openssh.extract)
	@$(call clean, $(OPENSSH_DIR))
	@$(call extract, $(OPENSSH_SOURCE))

	cd $(OPENSSH_DIR) && patch -p1 < $(OPENSSH_PATCH_SOURCE)
	OPENSSL_VERSION_NUMBER="`sed -n -e 's/.*OPENSSL_VERSION_NUMBER.*0x[0]*\([0-9a-f]*\)L/\1/p' \
		$(CROSS_LIB_DIR)/include/openssl/opensslv.h`" \
	OPENSSL_VERSION_TEXT="`sed -n -e 's/.*OPENSSL_VERSION_TEXT.*"\(.*\)"/\1/p' \
		$(CROSS_LIB_DIR)/include/openssl/opensslv.h`" && \
	perl -i -p -e "s/ssl_library_ver=\"VERSION\"/ssl_library_ver=\"$$OPENSSL_VERSION_NUMBER ($$OPENSSL_VERSION_TEXT)\"/g" \
		$(OPENSSH_DIR)/configure.ac && \
	perl -i -p -e "s/ssl_header_ver=\"VERSION\"/ssl_header_ver=\"$$OPENSSL_VERSION_NUMBER ($$OPENSSL_VERSION_TEXT)\"/g" \
		$(OPENSSH_DIR)/configure.ac

	cd $(OPENSSH_DIR) && PATH=$(PTXCONF_PREFIX)/$(AUTOCONF257)/bin:$$PATH autoconf
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

openssh_prepare: $(STATEDIR)/openssh.prepare

OPENSSH_AUTOCONF =  --prefix=/usr --libexecdir=/usr/sbin
OPENSSH_AUTOCONF += --without-pam --with-ipv4-default
OPENSSH_AUTOCONF += --build=$(GNU_HOST)
OPENSSH_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
OPENSSH_AUTOCONF += --with-privsep-path=/var/run/sshd


openssh_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/openssh.extract

OPENSSH_PATH	= PATH=$(CROSS_PATH)
#
# FIXME:
#
# openssh is a little F*CKED up, is won't compile without ld=gcc in environment
# perhaps someone should fix this....
#
OPENSSH_ENV	= \
	$(CROSS_ENV_AR) $(CORSS_ENV_AS) $(CROSS_ENV_CXX) $(CROSS_ENV_CC) \
	$(CROSS_ENV_NM) $(CROSS_ENV_OBJCOPY) $(CROSS_ENV_RANLIB) \
	$(CROSS_ENV_STRIP) LD=$(PTXCONF_GNU_TARGET)-gcc

$(STATEDIR)/openssh.prepare: $(openssh_prepare_deps)
	@$(call targetinfo, openssh.prepare)
	cd $(OPENSSH_DIR) && \
		$(OPENSSH_PATH) $(OPENSSH_ENV) \
		./configure $(OPENSSH_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

openssh_compile: $(STATEDIR)/openssh.compile

$(STATEDIR)/openssh.compile: $(STATEDIR)/openssh.prepare 
	@$(call targetinfo, openssh.compile)
	$(OPENSSH_PATH) make -C $(OPENSSH_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

openssh_install: $(STATEDIR)/openssh.install

$(STATEDIR)/openssh.install: $(STATEDIR)/openssh.compile
	@$(call targetinfo, openssh.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

openssh_targetinstall: $(STATEDIR)/openssh.targetinstall

$(STATEDIR)/openssh.targetinstall: $(STATEDIR)/openssh.compile
	@$(call targetinfo, openssh.targetinstall)
	touch $(ROOTDIR)/SSH_hostkeys_needed
	install -m 0755 -s $(OPENSSH_DIR)/ssh-keygen $(ROOTDIR)/sbin/ssh-keygen
	$(CROSSSTRIP) -R .notes -R .comment $(ROOTDIR)/sbin/ssh-keygen

	install -m 0755 -s $(OPENSSH_DIR)/sshd $(ROOTDIR)/sbin/sshd
	$(CROSSSTRIP) -R .notes -R .comment $(ROOTDIR)/sbin/sshd
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openssh_clean: 
	rm -rf $(STATEDIR)/openssh.* $(OPENSSH_DIR)

# vim: syntax=make
