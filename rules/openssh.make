# $Id: openssh.make,v 1.3 2003/06/16 12:05:16 bsp Exp $
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

OPENSSH_AUTOCONF =  --prefix=$(PTXCONF_PREFIX) --with-ipv4-default 
OPENSSH_AUTOCONF += --without-pam --without-shadow --without-md5-passwords 
OPENSSH_AUTOCONF += --with-zlib=$(PTXCONF_PREFIX)
# TODO dont know if this finds its way hardcoded into some binary:
OPENSSH_AUTOCONF += --with-privsep-path=$(PTXCONF_PREFIX)/var/empty

$(STATEDIR)/openssh.prepare: $(STATEDIR)/openssh.extract $(STATEDIR)/openssl.install
	@$(call targetinfo, openssh.prepare)
	cd $(OPENSSH_DIR) && LIBS=-lcrypt ./configure $(OPENSSH_AUTOCONF)
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
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH make -C $(OPENSSH_DIR) install PREFIX=$(PTXCONF_PREFIX)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

openssh_targetinstall: $(STATEDIR)/openssh.targetinstall

$(STATEDIR)/openssh.targetinstall: $(STATEDIR)/openssh.install
	@$(call targetinfo, openssh.targetinstall)
	echo 'TODO: install openssh files (dont forget privsep)'
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openssh_clean: 
	rm -rf $(STATEDIR)/openssh.* $(OPENSSH_DIR)

# vim: syntax=make
