# -*-makefile-*-
# $Id: lsh.make,v 1.7 2003/10/26 13:29:46 mkl Exp $
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
ifdef PTXCONF_LSH
PACKAGES += lsh
endif

#
# Paths and names
#
LSH_VERSION	= 1.5.3
LSH		= lsh-$(LSH_VERSION)
LSH_SUFFIX	= tar.gz
LSH_URL		= http://www.lysator.liu.se/~nisse/archive/$(LSH).$(LSH_SUFFIX)
LSH_SOURCE	= $(SRCDIR)/$(LSH).$(LSH_SUFFIX)
LSH_DIR		= $(BUILDDIR)/$(LSH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

lsh_get: $(STATEDIR)/lsh.get

lsh_get_deps = \
	$(LSH_SOURCE) \
	$(STATEDIR)/lsh-patches.get

$(STATEDIR)/lsh.get: $(lsh_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/lsh-patches.get:
	@$(call get_patches, $(LSH))
	touch $@

$(LSH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LSH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

lsh_extract: $(STATEDIR)/lsh.extract

lsh_extract_deps = $(STATEDIR)/lsh.get

$(STATEDIR)/lsh.extract: $(lsh_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LSH_DIR))
	@$(call extract, $(LSH_SOURCE))
	@$(call patchin, $(LSH))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

lsh_prepare: $(STATEDIR)/lsh.prepare

#
# dependencies
#
lsh_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/zlib.install \
	$(STATEDIR)/gmp3.install \
	$(STATEDIR)/liboop.install \
	$(STATEDIR)/lsh.extract \

LSH_PATH	=  PATH=$(CROSS_PATH)
LSH_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LSH_AUTOCONF = \
	--prefix=/usr \
	--sysconfdir=/etc/lsh \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--disable-kerberos \
	--disable-pam \
	--disable-tcp-forward \
	--disable-x11-forward \
	--disable-agent-forward \
	--disable-ipv6 \
	--disable-utmp \
	--without-system-argp


$(STATEDIR)/lsh.prepare: $(lsh_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LSH_DIR)/config.cache)
	cd $(LSH_DIR) && \
		$(LSH_PATH) $(LSH_ENV) \
		$(LSH_DIR)/configure $(LSH_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

lsh_compile: $(STATEDIR)/lsh.compile

lsh_compile_deps = $(STATEDIR)/lsh.prepare

$(STATEDIR)/lsh.compile: $(lsh_compile_deps)
	@$(call targetinfo, $@)
	$(LSH_PATH) make -C $(LSH_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

lsh_install: $(STATEDIR)/lsh.install

$(STATEDIR)/lsh.install: $(STATEDIR)/lsh.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

lsh_targetinstall: $(STATEDIR)/lsh.targetinstall

lsh_targetinstall_deps = \
	$(STATEDIR)/lsh.compile \
	$(STATEDIR)/gmp3.targetinstall \
	$(STATEDIR)/liboop.targetinstall \
	$(STATEDIR)/zlib.targetinstall

$(STATEDIR)/lsh.targetinstall: $(lsh_targetinstall_deps)
	@$(call targetinfo, $@)

	mkdir -p $(ROOTDIR)/sbin
	mkdir -p $(ROOTDIR)/bin
	mkdir -p $(ROOTDIR)/var/spool/lsh

ifdef PTXCONF_LSH_EXECUV
	install $(PTXCONF_PREFIX)/sbin/lsh-execuv $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/lsh-execuv 
endif
ifdef PTXCONF_LSH_PROXY
	install $(PTXCONF_PREFIX)/sbin/lsh_proxy $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/lsh_proxy 
endif
ifdef PTXCONF_LSH_LSHD
	install $(LSH_DIR)/src/lshd $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/lshd 
endif
ifdef PTXCONF_LSH_SFTPD
	install $(PTXCONF_PREFIX)/sbin/sftp-server $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/sftp-server
endif
ifdef PTXCONF_LSH_MAKESEED
	install $(LSH_DIR)/src/lsh-make-seed $(ROOTDIR)/bin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/bin/lsh-make-seed
endif
ifdef PTXCONF_LSH_WRITEKEY
	install $(LSH_DIR)/src/lsh-writekey $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/lsh-writekey
endif
ifdef PTXCONF_LSH_KEYGEN
	install $(LSH_DIR)/src/lsh-keygen $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/lsh-keygen
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lsh_clean:
	rm -rf $(STATEDIR)/lsh.*
	rm -rf $(LSH_DIR)

# vim: syntax=make
