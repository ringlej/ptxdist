# $Id: nfs-utils.make,v 1.2 2003/06/16 12:05:16 bsp Exp $
#
# (c) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y, $(PTXCONF_NFSUTILS))
PACKAGES += nfsutils
endif

#
# Paths and names 
#
NFSUTILS		= nfs-utils-1.0.1
NFSUTILS_URL		= http://unc.dl.sourceforge.net/sourceforge/nfs/$(NFSUTILS).tar.gz
NFSUTILS_SOURCE		= $(SRCDIR)/$(NFSUTILS).tar.gz
NFSUTILS_DIR		= $(BUILDDIR)/$(NFSUTILS)
NFSUTILS_EXTRACT	= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

nfsutils_get: $(STATEDIR)/nfsutils.get

$(STATEDIR)/nfsutils.get: $(NFSUTILS_SOURCE)
	touch $@

$(NFSUTILS_SOURCE):
	@$(call targetinfo, nfsutils.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(NFSUTILS_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

nfsutils_extract: $(STATEDIR)/nfsutils.extract

$(STATEDIR)/nfsutils.extract: $(STATEDIR)/nfsutils.get $(STATEDIR)/autoconf257.targetinstall
	@$(call targetinfo, nfsutils.extract)
	$(NFSUTILS_EXTRACT) $(NFSUTILS_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	#
	# regenerate configure script with new autoconf, to make cross compiling work
	cd $(NFSUTILS_DIR) && PATH=$(PTXCONF_PREFIX)/$(AUTOCONF257)/bin:$$PATH autoconf
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

nfsutils_prepare: $(STATEDIR)/nfsutils.prepare

NFSUTILS_AUTOCONF =
NFSUTILS_ENVIRONMENT =

# 
# # arcitecture dependend configuration
# #
#
NFSUTILS_AUTOCONF    += --build=i686-linux
NFSUTILS_AUTOCONF    += --host=$(PTXCONF_GNU_TARGET)
NFSUTILS_ENVIRONMENT =  PATH=$(PTXCONF_PREFIX)/bin:$$PATH
NFSUTILS_ENVIRONMENT += CC=$(PTXCONF_GNU_TARGET)-gcc CC_FOR_BUILD=gcc
NFSUTILS_MAKEVARS    =  

ifeq (y, $(PTXCONF_NFSUTILS_V3))
NFSUTILS_AUTOCONF += --enable-nfsv3
else
NFSUTILS_AUTOCONF += --disable-nfsv3
endif
ifeq (y, $(PTXCONF_NFSUTILS_SECURE_STATD))
NFSUTILS_AUTOCONF += --enable-secure-statd
else
NFSUTILS_AUTOCONF += --disable-secure-statd
endif
ifeq (y, $(PTXCONF_NFSUTILS_RQUOTAD))
NFSUTILS_AUTOCONF += --enable-rquotad
else
NFSUTILS_AUTOCONF += --disable-rquotad
endif
 
$(STATEDIR)/nfsutils.prepare: $(STATEDIR)/nfsutils.extract
	@$(call targetinfo, nfsutils.prepare)
	cd $(NFSUTILS_DIR) &&						\
		$(NFSUTILS_ENVIRONMENT)					\
		$(NFSUTILS_DIR)/configure 				\
			$(NFSUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nfsutils_compile: $(STATEDIR)/nfsutils.compile

$(STATEDIR)/nfsutils.compile: $(STATEDIR)/nfsutils.prepare 
	@$(call targetinfo, nfsutils.compile)
	$(NFSUTILS_ENVIRONMENT) make -C $(NFSUTILS_DIR) $(NFSUTILS_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nfsutils_install: $(STATEDIR)/nfsutils.install

$(STATEDIR)/nfsutils.install: $(STATEDIR)/nfsutils.compile
	@$(call targetinfo, nfsutils.install)
	# make -C $(NFSUTILS_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

nfsutils_targetinstall: $(STATEDIR)/nfsutils.targetinstall

$(STATEDIR)/nfsutils.targetinstall: $(STATEDIR)/nfsutils.install
	@$(call targetinfo, nfsutils.targetinstall)
	# don't forget to $(CROSSSTRIP) -S your source!
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

        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_EXPORTFS))
	install $(NFSUTILS_DIR)/utils/exportfs/exportfs $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/exportfs
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_LOCKD))
	install $(NFSUTILS_DIR)/utils/lockd/lockd $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/lockd
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_MOUNTD))
	install $(NFSUTILS_DIR)/utils/mountd/mountd $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/mountd
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NFSD))
	install $(NFSUTILS_DIR)/utils/nfsd/nfsd $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/nfsd
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NFSSTAT))
	install $(NFSUTILS_DIR)/utils/nfsstat/nfsstat $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/nfsstat
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
	install $(NFSUTILS_DIR)/utils/nhfsstone/nhfsstone $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/nhfsstone
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_SHOWMOUNT))
	install $(NFSUTILS_DIR)/utils/showmount/showmount $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/showmount
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_STATD))
	install $(NFSUTILS_DIR)/utils/statd/statd $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/statd
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
