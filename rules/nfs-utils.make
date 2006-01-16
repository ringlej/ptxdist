# -*-makefile-*-
# $Id$
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
PACKAGES-$(PTXCONF_NFSUTILS) += nfsutils

#
# Paths and names 
#
NFSUTILS_VERSION	= 1.0.6-ptx4
NFSUTILS		= nfs-utils-$(NFSUTILS_VERSION)
NFSUTILS_URL		= http://www.pengutronix.de/software/nfs-utils/$(NFSUTILS).tar.gz
NFSUTILS_SOURCE		= $(SRCDIR)/$(NFSUTILS).tar.gz
NFSUTILS_DIR		= $(BUILDDIR)/$(NFSUTILS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

nfsutils_get: $(STATEDIR)/nfsutils.get

$(STATEDIR)/nfsutils.get: $(nfsutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(NFSUTILS))
	@$(call touch, $@)

$(NFSUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(NFSUTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

nfsutils_extract: $(STATEDIR)/nfsutils.extract

$(STATEDIR)/nfsutils.extract: $(nfsutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NFSUTILS_DIR))
	@$(call extract, $(NFSUTILS_SOURCE))
	@$(call patchin, $(NFSUTILS))
#
# regenerate configure script with new autoconf, to make cross compiling work
#
	cd $(NFSUTILS_DIR) && PATH=$(PTXCONF_PREFIX)/$(AUTOCONF257)/bin:$$PATH autoconf
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

nfsutils_prepare: $(STATEDIR)/nfsutils.prepare

# 
# arcitecture dependend configuration
#
NFSUTILS_PATH		=  PATH=$(CROSS_PATH)
NFSUTILS_ENV		+= CC_FOR_BUILD=$(HOSTCC) $(CROSS_ENV)

NFSUTILS_AUTOCONF	=  $(CROSS_AUTOCONF_USR)

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

ifdef PTXCONF_NFSUTILS_WITH_TCPWRAPPERS
NFSUTILS_AUTOCONF += --with-tcpwrappers=$(PTXCONF_PREFIX)
else
NFSUTILS_AUTOCONF += --without-tcpwrappers
endif

$(STATEDIR)/nfsutils.prepare: $(nfsutils_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(NFSUTILS_DIR) &&						\
		$(NFSUTILS_PATH) $(NFSUTILS_ENV)			\
		$(NFSUTILS_DIR)/configure $(NFSUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nfsutils_compile: $(STATEDIR)/nfsutils.compile

$(STATEDIR)/nfsutils.compile: $(nfsutils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(NFSUTILS_DIR) && $(NFSUTILS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nfsutils_install: $(STATEDIR)/nfsutils.install

$(STATEDIR)/nfsutils.install: $(nfsutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

nfsutils_targetinstall: $(STATEDIR)/nfsutils.targetinstall

$(STATEDIR)/nfsutils.targetinstall: $(nfsutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,nfsutils)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(NFSUTILS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_CLIENTSCRIPT))
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/etc/nodist/nfs-client, /etc/init.d/nfs-client, n)
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_FUNCTIONSSCRIPT))
	@$(call install_copy, 0, 0, 0644, $(NFSUTILS_DIR)/etc/nodist/nfs-functions, /etc/init.d/nfs-functions, n)
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_SERVERSCRIPT))
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/etc/nodist/nfs-server, /etc/init.d/nfs-server, n)
        endif

        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_EXPORTFS))
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/utils/exportfs/.libs/exportfs, /sbin/exportfs)
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_LOCKD))
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/utils/lockd/.libs/lockd, /sbin/lockd)
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_MOUNTD))
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/utils/mountd/.libs/mountd, /sbin/mountd)
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NFSD))
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/utils/nfsd/.libs/nfsd, /sbin/nfsd)
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NFSSTAT))
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/utils/nfsstat/.libs/nfsstat, /sbin/nfsstat)
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NHFSGRAPH))
# don't strip, this is a shell script
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/utils/nhfsstone/nhfsgraph, /sbin/nhfsgraph, n)
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NHFSNUMS))
# don't strip, this is a shell script
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/utils/nhfsstone/nhfsnums, /sbin/nhfsnums, n)
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NHFSRUN))
# don't strip, this is a shell script
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/utils/nhfsstone/nhfsrun, /sbin/nhfsrun, n)
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NHFSSTONE))
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/utils/nhfsstone/.libs/nhfsstone, /sbin/nhfsstone)
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_SHOWMOUNT))
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/utils/showmount/.libs/showmount, /sbin/showmount)
        endif
        ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_STATD))
	@$(call install_copy, 0, 0, 0755, $(NFSUTILS_DIR)/utils/statd/.libs/statd, /sbin/statd)
        endif
# copy necessary libs
	@$(call install_copy, 0, 0, 0644, \
		$(NFSUTILS_DIR)/support/export/.libs/libexport.so.0.0.0, \
		/usr/lib/libexport.so.0.0.0)
	@$(call install_link, libexport.so.0.0.0, /usr/lib/libexport.so.0.0)
	@$(call install_link, libexport.so.0.0.0, /usr/lib/libexport.so.0)

	@$(call install_copy, 0, 0, 0644, \
		$(NFSUTILS_DIR)/support/nfs/.libs/libnfs.so.0.0.0, \
		/usr/lib/libnfs.so.0.0.0)
	@$(call install_link, libnfs.so.0.0.0, /usr/lib/libnfs.so.0.0)
	@$(call install_link, libnfs.so.0.0.0, /usr/lib/libnfs.so.0)

	@$(call install_copy, 0, 0, 0644, \
		$(NFSUTILS_DIR)/support/misc/.libs/libmisc.so.0.0.0, \
		/usr/lib/libmisc.so.0.0.0)
	@$(call install_link, libmisc.so.0.0.0, /usr/lib/libmisc.so.0.0)
	@$(call install_link, libmisc.so.0.0.0, /usr/lib/libmisc.so.0)

	mkdir -p $(NFSUTILS_DIR)/ptxdist_install_tmp
	touch $(NFSUTILS_DIR)/ptxdist_install_tmp/etab
	@$(call install_copy, 0, 0, 0755, \
		$(NFSUTILS_DIR)/ptxdist_install_tmp/etab, \
		/var/lib/nfs/etab, n)

	touch $(NFSUTILS_DIR)/ptxdist_install_tmp/rmtab
	@$(call install_copy, 0, 0, 0755, \
		$(NFSUTILS_DIR)/ptxdist_install_tmp/rmtab, \
		/var/lib/nfs/rmtab, n)

	touch $(NFSUTILS_DIR)/ptxdist_install_tmp/xtab
	@$(call install_copy, 0, 0, 0755, \
		$(NFSUTILS_DIR)/ptxdist_install_tmp/xtab, \
		/var/lib/nfs/xtab, n)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nfsutils_clean: 
	rm -rf $(STATEDIR)/nfsutils.* 
	rm -rf $(IMAGEDIR)/nfsutils_* 
	rm -rf $(NFSUTILS_DIR)

# vim: syntax=make
