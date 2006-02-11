# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENSSH) += openssh

#
# Paths and names 
#
OPENSSH_VERSION		= 3.9p1
OPENSSH			= openssh-$(OPENSSH_VERSION)
OPENSSH_URL 		= ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/$(OPENSSH).tar.gz
OPENSSH_SOURCE		= $(SRCDIR)/$(OPENSSH).tar.gz
OPENSSH_DIR 		= $(BUILDDIR)/$(OPENSSH)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

openssh_get: $(STATEDIR)/openssh.get

$(STATEDIR)/openssh.get: $(openssh_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(OPENSSH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(OPENSSH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

openssh_extract: $(STATEDIR)/openssh.extract

$(STATEDIR)/openssh.extract: $(openssh_extract_deps_default)
	@$(call targetinfo, openssh.extract)
	@$(call clean, $(OPENSSH_DIR))
	@$(call extract, $(OPENSSH_SOURCE))
	@$(call patchin, $(OPENSSH))

	OPENSSL_VERSION_NUMBER="`sed -n -e 's/.*OPENSSL_VERSION_NUMBER.*0x[0]*\([0-9a-f]*\)L/\1/p' \
		$(CROSS_LIB_DIR)/include/openssl/opensslv.h`" \
	OPENSSL_VERSION_TEXT="`sed -n -e 's/.*OPENSSL_VERSION_TEXT.*"\(.*\)"/\1/p' \
		$(CROSS_LIB_DIR)/include/openssl/opensslv.h`" && \
	perl -i -p -e "s/ssl_library_ver=\"VERSION\"/ssl_library_ver=\"$$OPENSSL_VERSION_NUMBER ($$OPENSSL_VERSION_TEXT)\"/g" \
		$(OPENSSH_DIR)/configure.ac && \
	perl -i -p -e "s/ssl_header_ver=\"VERSION\"/ssl_header_ver=\"$$OPENSSL_VERSION_NUMBER ($$OPENSSL_VERSION_TEXT)\"/g" \
		$(OPENSSH_DIR)/configure.ac

	cd $(OPENSSH_DIR) && PATH=$(PTXCONF_PREFIX)/$(AUTOCONF257)/bin:$$PATH autoconf
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

openssh_prepare: $(STATEDIR)/openssh.prepare

OPENSSH_PATH	= PATH=$(CROSS_PATH)
#
# openssh is a little F*CKED up, is won't compile without LD=gcc in environment
# perhaps someone should fix this....
#
# powerpc-linux-ld -o ssh ssh.o readconf.o clientloop.o sshtty.o
# sshconnect.o sshconnect1.o sshconnect2.o -L. -Lopenbsd-compat/ -lssh
# -lopenbsd-compat -lutil -lz -lnsl -lcrypto -lcrypt
# powerpc-linux-ld: warning: cannot find entry symbol _start;
# defaulting to 10001ba8
# ./libssh.a(packet.o): In function `set_newkeys':
# /home/frogger/projects/ptxdist/ptxdist-ppc/build/openssh-3.7.1p2/packet.c:643:
# undefined reference to `__ashldi3'
# /home/frogger/projects/ptxdist/ptxdist-ppc/build/openssh-3.7.1p2/packet.c:643:
# relocation truncated to fit: R_PPC_REL24 __ashldi3
# make[1]: *** [ssh] Error 1
#
OPENSSH_ENV	= \
	$(CROSS_ENV_AR) \
	$(CORSS_ENV_AS) \
	$(CROSS_ENV_CXX) \
	$(CROSS_ENV_CC) \
	$(CROSS_ENV_NM) \
	$(CROSS_ENV_OBJCOPY) \
	$(CROSS_ENV_RANLIB) \
	$(CROSS_ENV_STRIP) \
	LD=$(COMPILER_PREFIX)gcc

#
# autoconf
#
OPENSSH_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--libexecdir=/usr/sbin \
	--libdir=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib \
	--with-ldflags=-L$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib \
	--with-cflags=-I$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include \
	--sysconfdir=/etc/ssh \
	--with-privsep-path=/var/run/sshd \
	--with-rand-helper=no \
	--without-pam \
	--with-ipv4-default \
	--disable-etc-default-login \
	--disable-lastlog \
	--disable-utmp \
	--disable-utmpx \
	--disable-wtmp \
	--disable-wtmpx \
	--with-zlib=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET) \
	--with-ssl-dir=$(CROSS_LIB_DIR)


$(STATEDIR)/openssh.prepare: $(openssh_prepare_deps_default)
	@$(call targetinfo, openssh.prepare)
	cd $(OPENSSH_DIR) && \
		$(OPENSSH_PATH) $(OPENSSH_ENV) \
		./configure $(OPENSSH_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

openssh_compile: $(STATEDIR)/openssh.compile

$(STATEDIR)/openssh.compile: $(openssh_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(OPENSSH_DIR) && $(OPENSSH_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

openssh_install: $(STATEDIR)/openssh.install

$(STATEDIR)/openssh.install: $(openssh_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

openssh_targetinstall: $(STATEDIR)/openssh.targetinstall

$(STATEDIR)/openssh.targetinstall: $(openssh_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,openssh)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(OPENSSH_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
ifdef PTXCONF_OPENSSH_SSH
	@$(call install_copy, 0, 0, 0644, $(OPENSSH_DIR)/ssh_config.out, /etc/ssh/ssh_config, n)
	@$(call install_copy, 0, 0, 0755, $(OPENSSH_DIR)/ssh, /usr/bin/ssh)
endif

ifdef PTXCONF_OPENSSH_SSHD
	@$(call install_copy, 0, 0, 0644, $(OPENSSH_DIR)/moduli.out, /etc/ssh/moduli, n)
	@$(call install_copy, 0, 0, 0644, $(OPENSSH_DIR)/sshd_config.out, /etc/ssh/sshd_config, n)
	perl -p -i -e "s/#PermitRootLogin yes/PermitRootLogin yes/" \
		$(ROOTDIR)/etc/ssh/sshd_config
	perl -p -i -e "s/#PermitRootLogin yes/PermitRootLogin yes/" \
		$(IMAGEDIR)/ipkg/etc/ssh/sshd_config
	@$(call install_copy, 0, 0, 0755, $(OPENSSH_DIR)/sshd, /usr/sbin/sshd)
endif

ifdef PTXCONF_OPENSSH_SCP
	@$(call install_copy, 0, 0, 0755, $(OPENSSH_DIR)/scp, /usr/bin/scp)
endif

ifdef PTXCONF_OPENSSH_SFTP_SERVER
	@$(call install_copy, 0, 0, 0755, $(OPENSSH_DIR)/sftp-server, /usr/sbin/sftp-server)
endif

ifdef PTXCONF_OPENSSH_KEYGEN
	# FIXME: if this is the only file in this directory move it
	# to somewhere else (patch, echo << EOF?) [RSC]
	@$(call install_copy, 0, 0, 0755, $(PTXDIST_TOPDIR)/scripts/openssh-host-keygen.sh, /sbin/openssh-host-keygen.sh, n)
	@$(call install_copy, 0, 0, 0755, $(OPENSSH_DIR)/ssh-keygen, /usr/bin/ssh-keygen)
endif
	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openssh_clean: 
	rm -rf $(STATEDIR)/openssh.* 
	rm -rf $(IMAGEDIR)/openssh_* 
	rm -rf $(OPENSSH_DIR)

# vim: syntax=make
