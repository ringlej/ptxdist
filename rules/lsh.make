# -*-makefile-*-
# $Id: lsh.make,v 1.5 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_LSH))
PACKAGES += lsh
endif

#
# Paths and names 
#
LSH			= lsh-1.5
LSH_URL			= http://www.lysator.liu.se/~nisse/archive/$(LSH).tar.gz
LSH_SOURCE		= $(SRCDIR)/$(LSH).tar.gz
LSH_DIR			= $(BUILDDIR)/$(LSH)
LSH_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

lsh_get: $(STATEDIR)/lsh.get

$(STATEDIR)/lsh.get: $(LSH_SOURCE)
	@$(call targetinfo, lsh.get)
	touch $@

$(LSH_SOURCE):
	@$(call targetinfo, $(LSH_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(LSH_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

lsh_extract: $(STATEDIR)/lsh.extract

$(STATEDIR)/lsh.extract: $(STATEDIR)/lsh.get
	@$(call targetinfo, lsh.extract)
	$(LSH_EXTRACT) $(LSH_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	cd $(LSH_DIR) && patch -p0 < $(SRCDIR)/lsh-1.5-ptx1.diff
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

lsh_prepare: $(STATEDIR)/lsh.prepare

lsh_prepare_deps =  $(STATEDIR)/lsh.extract
lsh_prepare_deps += $(STATEDIR)/nettle.install
lsh_prepare_deps += $(STATEDIR)/gmp.install
lsh_prepare_deps += $(STATEDIR)/zlib.install
lsh_prepare_deps += $(STATEDIR)/liboop.install

LSH_AUTOCONF =
LSH_AUTOCONF += --disable-kerberos
LSH_AUTOCONF += --prefix=$(PTXCONF_PREFIX)  
LSH_AUTOCONF += --disable-pam
LSH_AUTOCONF += --disable-tcp-forward
LSH_AUTOCONF += --disable-x11-forward
LSH_AUTOCONF += --disable-agent-forward
LSH_AUTOCONF += --disable-ipv6
LSH_AUTOCONF += --disable-utmp
LSH_AUTOCONF += --without-system-argp
LSH_AUTOCONF += --build=$(GNU_HOST)
LSH_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
LSH_AUTOCONF += --with-lib-path=$(PTXCONF_PREFIX)/lib 
LSH_AUTOCONF += --with-include-path=$(PTXCONF_PREFIX)/include

$(STATEDIR)/lsh.prepare: $(lsh_prepare_deps)
	@$(call targetinfo, lsh.prepare)
	cd $(LSH_DIR) && ./configure $(LSH_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

lsh_compile: $(STATEDIR)/lsh.compile

$(STATEDIR)/lsh.compile: $(STATEDIR)/lsh.prepare 
	@$(call targetinfo, lsh.compile)
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH make -C $(LSH_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

lsh_install: $(STATEDIR)/lsh.install

$(STATEDIR)/lsh.install: $(STATEDIR)/lsh.compile
	@$(call targetinfo, lsh.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

lsh_targetinstall: $(STATEDIR)/lsh.targetinstall

lsh_targetinstall_deps =  $(STATEDIR)/lsh.install
lsh_targetinstall_deps += $(STATEDIR)/gmp.targetinstall
lsh_targetinstall_deps += $(STATEDIR)/liboop.targetinstall
lsh_targetinstall_deps += $(STATEDIR)/zlib.targetinstall

$(STATEDIR)/lsh.targetinstall: $(lsh_targetinstall_deps)
	@$(call targetinfo, lsh.targetinstall)
        ifeq (y, $(PTXCONF_LSH_EXECUV))
	mkdir -p $(ROOTDIR)/sbin
	install $(PTXCONF_PREFIX)/sbin/lsh-execuv $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/lsh-execuv 
        endif
        ifeq (y, $(PTXCONF_LSH_PROXY))		
	mkdir -p $(ROOTDIR)/sbin
	install $(PTXCONF_PREFIX)/sbin/lsh_proxy $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/lsh_proxy 
        endif
        ifeq (y, $(PTXCONF_LSH_LSHD))	
	mkdir -p $(ROOTDIR)/sbin
	install $(LSH_DIR)/src/lshd $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/lshd 
        endif
        ifeq (y, $(PTXCONF_LSH_SFTPD))
	mkdir -p $(ROOTDIR)/sbin
	install $(PTXCONF_PREFIX)/sbin/sftp-server $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/sftp-server
        endif
        ifeq (y, $(PTXCONF_LSH_MAKESEED))
	mkdir -p $(ROOTDIR)/bin
	install $(LSH_DIR)/src/lsh-make-seed $(ROOTDIR)/bin/
	$(CROSSSTRIP) -S $(ROOTDIR)/bin/lsh-make-seed
        endif
        ifeq (y, $(PTXCONF_LSH_WRITEKEY))
	mkdir -p $(ROOTDIR)/sbin
	install $(LSH_DIR)/src/lsh-writekey $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/lsh-writekey
        endif
        ifeq (y, $(PTXCONF_LSH_KEYGEN))
	mkdir -p $(ROOTDIR)/sbin
	install $(LSH_DIR)/src/lsh-keygen $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/lsh-keygen
        endif
	mkdir -p $(ROOTDIR)/var/spool/lsh
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lsh_clean: 
	rm -rf $(STATEDIR)/lsh.* $(LSH_DIR) 

# vim: syntax=make
