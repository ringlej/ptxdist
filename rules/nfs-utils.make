# -*-makefile-*-
# $Id: nfs-utils.make,v 1.9 2004/06/23 15:31:55 rsc Exp $
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_NFSUTILS
PACKAGES += nfsutils
endif

#
# Paths and names 
#
NFSUTILS		= nfs-utils-1.0.6-ptx3
NFSUTILS_URL		= http://www.pengutronix.de/software/nfs-utils/$(NFSUTILS).tar.gz
NFSUTILS_SOURCE		= $(SRCDIR)/$(NFSUTILS).tar.gz
NFSUTILS_DIR		= $(BUILDDIR)/$(NFSUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

nfsutils_get: $(STATEDIR)/nfsutils.get

$(STATEDIR)/nfsutils.get: $(NFSUTILS_SOURCE)
	@$(call targetinfo, $@)
	@$(call get_patches, $(NFSUTILS))
	touch $@

$(NFSUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(NFSUTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

nfsutils_extract: $(STATEDIR)/nfsutils.extract

$(STATEDIR)/nfsutils.extract: $(STATEDIR)/nfsutils.get $(STATEDIR)/autoconf257.install
	@$(call targetinfo, $@)
	@$(call clean, $(NFSUTILS_DIR))
	@$(call extract, $(NFSUTILS_SOURCE))
	@$(call patchin, $(NFSUTILS))
#
# regenerate configure script with new autoconf, to make cross compiling work
#
	cd $(NFSUTILS_DIR) && PATH=$(PTXCONF_PREFIX)/$(AUTOCONF257)/bin:$$PATH autoconf
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

nfsutils_prepare: $(STATEDIR)/nfsutils.prepare

# 
# arcitecture dependend configuration
#
NFSUTILS_PATH		=  PATH=$(CROSS_PATH)
NFSUTILS_ENV		+= CC_FOR_BUILD=$(HOSTCC) $(CROSS_ENV)

NFSUTILS_AUTOCONF	=  --build=$(GNU_HOST)
NFSUTILS_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

# FIXME: these are not probed correctly when cross compiling...
NFSUTILS_AUTOCONF	+= ac_cv_func_malloc_0_nonnull=yes
NFSUTILS_AUTOCONF	+= ac_cv_func_realloc_0_nonnull=yes

ifdef PTXCONF_NFSUTILS_V3
NFSUTILS_AUTOCONF += --enable-nfsv3
else
NFSUTILS_AUTOCONF += --disable-nfsv3
endif

ifdef PTXCONF_NFSUTILS_SECURE_STATD
NFSUTILS_AUTOCONF += --enable-secure-statd
else
NFSUTILS_AUTOCONF += --disable-secure-statd
endif

ifdef PTXCONF_NFSUTILS_RQUOTAD
NFSUTILS_AUTOCONF += --enable-rquotad
else
NFSUTILS_AUTOCONF += --disable-rquotad
endif

ifdef NFSUTILS_WITH_TCPWRAPPERS
NFSUTILS_AUTOCONF += --with-tcpwrappers=$(PTXCONF_PREFIX)
else
NFSUTILS_AUTOCONF += --without-tcpwrappers
endif

nfsutils_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/nfsutils.extract

$(STATEDIR)/nfsutils.prepare: $(nfsutils_prepare_deps)
	@$(call targetinfo, $@)
	cd $(NFSUTILS_DIR) &&						\
		$(NFSUTILS_PATH) $(NFSUTILS_ENV)			\
		$(NFSUTILS_DIR)/configure $(NFSUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nfsutils_compile: $(STATEDIR)/nfsutils.compile

$(STATEDIR)/nfsutils.compile: $(STATEDIR)/nfsutils.prepare 
	@$(call targetinfo, $@)
	cd $(NFSUTILS_DIR) && $(NFSUTILS_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nfsutils_install: $(STATEDIR)/nfsutils.install

$(STATEDIR)/nfsutils.install: $(STATEDIR)/nfsutils.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

nfsutils_targetinstall: $(STATEDIR)/nfsutils.targetinstall

$(STATEDIR)/nfsutils.targetinstall: $(STATEDIR)/nfsutils.install
	@$(call targetinfo, $@)

	mkdir -p $(ROOTDIR)/etc/init.d
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_CLIENTSCRIPT))
	install $(NFSUTILS_DIR)/etc/nodist/nfs-client $(ROOTDIR)/etc/init.d/
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_FUNCTIONSSCRIPT))
	install $(NFSUTILS_DIR)/etc/nodist/nfs-functions $(ROOTDIR)/etc/init.d/
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_SERVERSCRIPT))
	install $(NFSUTILS_DIR)/etc/nodist/nfs-server $(ROOTDIR)/etc/init.d/
        endif

	mkdir -p $(ROOTDIR)/sbin
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_EXPORTFS))
	install $(NFSUTILS_DIR)/utils/exportfs/.libs/exportfs $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/exportfs
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_LOCKD))
	install $(NFSUTILS_DIR)/utils/lockd/.libs/lockd $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/lockd
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_MOUNTD))
	install $(NFSUTILS_DIR)/utils/mountd/.libs/mountd $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/mountd
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NFSD))
	install $(NFSUTILS_DIR)/utils/nfsd/.libs/nfsd $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/nfsd
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NFSSTAT))
	install $(NFSUTILS_DIR)/utils/nfsstat/.libs/nfsstat $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/nfsstat
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NHFSGRAPH))
	# don't strip, this is a shell script
	install $(NFSUTILS_DIR)/utils/nhfsstone/nhfsgraph $(ROOTDIR)/sbin/
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NHFSNUMS))
	install $(NFSUTILS_DIR)/utils/nhfsstone/nhfsnums $(ROOTDIR)/sbin/
	# don't strip, this is a shell script
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NHFSRUN))
	install $(NFSUTILS_DIR)/utils/nhfsstone/nhfsrun $(ROOTDIR)/sbin/
	# don't strip, this is a shell script
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NHFSSTONE))
	install $(NFSUTILS_DIR)/utils/nhfsstone/.libs/nhfsstone $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/nhfsstone
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_SHOWMOUNT))
	install $(NFSUTILS_DIR)/utils/showmount/.libs/showmount $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/showmount
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_STATD))
	install $(NFSUTILS_DIR)/utils/statd/.libs/statd $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/statd
        endif
	# create stuff necessary for nfs
	mkdir -p $(ROOTDIR)/var/lib/nfs
	touch $(ROOTDIR)/var/lib/nfs/etab
	touch $(ROOTDIR)/var/lib/nfs/rmtab
	touch $(ROOTDIR)/var/lib/nfs/xtab
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nfsutils_clean: 
	rm -rf $(STATEDIR)/nfsutils.* $(NFSUTILS_DIR)

# vim: syntax=make
