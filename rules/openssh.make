# $Id: openssh.make,v 1.6 2003/07/07 13:19:04 bsp Exp $
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
OPENSSH_EXTRACT		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

openssh_get: $(STATEDIR)/openssh.get

$(STATEDIR)/openssh.get: $(OPENSSH_SOURCE)
	touch $@

$(OPENSSH_SOURCE):
	@$(call targetinfo, openssh.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(OPENSSH_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

openssh_extract: $(STATEDIR)/openssh.extract

$(STATEDIR)/openssh.extract: $(STATEDIR)/openssh.get
	@$(call targetinfo, openssh.extract)
	$(OPENSSH_EXTRACT) $(OPENSSH_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

openssh_prepare: $(STATEDIR)/openssh.prepare

OPENSSH_AUTOCONF =  --prefix=/ --with-ipv4-default 
OPENSSH_AUTOCONF += --without-pam --without-md5-passwords 
OPENSSH_AUTOCONF += --with-zlib=$(PTXCONF_PREFIX)
# TODO dont know if this finds its way hardcoded into some binary:
OPENSSH_AUTOCONF += --with-privsep-path=/var/run/sshd

$(STATEDIR)/openssh.prepare: $(STATEDIR)/openssh.extract $(STATEDIR)/openssl.install
	@$(call targetinfo, openssh.prepare)
	cd $(OPENSSH_DIR) && LIBS=-lcrypt \
	CC=$(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-gcc ./configure $(OPENSSH_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

openssh_compile: $(STATEDIR)/openssh.compile

$(STATEDIR)/openssh.compile: $(STATEDIR)/openssh.prepare 
	@$(call targetinfo, openssh.compile)
	cd $(OPENSSH_DIR) && PATH=$(PTXCONF_PREFIX)/bin:$$PATH make
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

$(STATEDIR)/openssh.targetinstall: $(STATEDIR)/openssh.install
	@$(call targetinfo, openssh.targetinstall)
	touch $(ROOTDIR)/SSH_hostkeys_needed
	cd $(OPENSSH_DIR) && install -m 0755 -s ssh-keygen $(ROOTDIR)/sbin/ssh-keygen
	cd $(OPENSSH_DIR) && install -m 0755 -s sshd $(ROOTDIR)/sbin/sshd
	touch $@
# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openssh_clean: 
	rm -rf $(STATEDIR)/openssh.* $(OPENSSH_DIR)

# vim: syntax=make
