# -*-makefile-*-
# $Id: glibc.make,v 1.17 2003/11/13 04:28:13 mkl Exp $
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_GLIBC
PACKAGES	+= glibc
DYNAMIC_LINKER	=  /lib/ld-linux.so.2
endif


#
# Paths and names 
#
GLIBC			= glibc-$(GLIBC_VERSION)
GLIBC_URL		= ftp://ftp.gnu.org/gnu/glibc/$(GLIBC).tar.gz
GLIBC_SOURCE		= $(SRCDIR)/$(GLIBC).tar.gz
GLIBC_DIR		= $(BUILDDIR)/$(GLIBC)

GLIBC_THREADS		= glibc-linuxthreads-$(GLIBC_VERSION)
GLIBC_THREADS_URL	= ftp://ftp.gnu.org/gnu/glibc/$(GLIBC_THREADS).tar.gz
GLIBC_THREADS_SOURCE	= $(SRCDIR)/$(GLIBC_THREADS).tar.gz
GLIBC_THREADS_DIR	= $(GLIBC_DIR)

GLIBC_BUILDDIR		= $(BUILDDIR)/$(GLIBC)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ifdef PTXCONF_BUILD_CROSSCHAIN
glibc_get:		$(STATEDIR)/glibc.get
else
glibc_get:
endif

glibc_get_deps = \
	$(GLIBC_SOURCE) \
	$(STATEDIR)/glibc-patches.get

ifdef PTXCONF_GLIBC_PTHREADS
glibc_get_deps += \
	$(GLIBC_THREADS_SOURCE) \
	$(STATEDIR)/glibc-threads-patches.get
endif

$(STATEDIR)/glibc.get: $(glibc_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/glibc-patches.get:
	@$(call targetinfo, $@)
	@$(call get_patches, $(GLIBC))
	touch $@

$(STATEDIR)/glibc-threads-patches.get:
	@$(call targetinfo, $@)
	@$(call get_patches, $(GLIBC_THREADS))
	touch $@

$(GLIBC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GLIBC_URL))

$(GLIBC_THREADS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GLIBC_THREADS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ifdef PTXCONF_BUILD_CROSSCHAIN
glibc_extract: $(STATEDIR)/glibc.extract
else
glibc_extract: 
endif

glibc_extract_deps =  $(STATEDIR)/glibc-base.extract
ifdef PTXCONF_GLIBC_PTHREADS
glibc_extract_deps += $(STATEDIR)/glibc-threads.extract
endif

$(STATEDIR)/glibc.extract: $(glibc_extract_deps)
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/glibc-base.extract: $(STATEDIR)/glibc.get
	@$(call targetinfo, $@)
	@$(call clean, $(GLIBC_DIR))
	@$(call extract, $(GLIBC_SOURCE))
	@$(call patchin, $(GLIBC))
	touch $@

$(STATEDIR)/glibc-threads.extract: $(STATEDIR)/glibc.get
	@$(call targetinfo, $@)
	@$(call extract, $(GLIBC_THREADS_SOURCE), $(GLIBC_DIR))
	@$(call patchin, $(GLIBC_THREADS), $(GLIBC_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_BUILD_CROSSCHAIN
glibc_prepare:		$(STATEDIR)/glibc.prepare
else
glibc_prepare:
endif

# 
# arcitecture dependend configuration
#
GLIBC_AUTOCONF	= \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--with-headers=$(CROSS_LIB_DIR)/include \
	--enable-clocale=gnu \
	--without-tls \
	--without-cvs \
	--without-gd \
	--prefix=/usr \
	--libexecdir=/usr/bin

ifdef GLIBC_OPTKERNEL
GLIBC_AUTOCONF += --enable-kernel=$(KERNEL_VERSION)
endif

ifeq ($(GLIBC_VERSION_MAJOR).$(GLIBC_VERSION_MINOR),2.2)
GLIBC_PATH	=  PATH=$(PTXCONF_PREFIX)/$(AUTOCONF213)/bin:$(CROSS_PATH)
else
#FIXME: wich autoconf version wants the glibc 2.3.x?
GLIBC_PATH	=  PATH=$(CROSS_PATH)
endif

GLIBC_ENV	=  $(CROSS_ENV) BUILD_CC=$(HOSTCC)

#
# features
#
ifdef PTXCONF_GLIBC_LIBIO
GLIBC_AUTOCONF	+= --enable-libio
endif

ifdef PTXCONF_GLIBC_SHARED
GLIBC_AUTOCONF	+= --enable-shared
else
GLIBC_AUTOCONF	+= --enable-shared=no
endif

ifdef PTXCONF_GLIBC_PROFILED
GLIBC_AUTOCONF	+= --enable-profile=yes
else
GLIBC_AUTOCONF	+= --enable-profile=no
endif

ifdef PTXCONF_GLIBC_OMITFP
GLIBC_AUTOCONF	+= --enable-omitfp
endif

ifdef PTXCONF_GLIBC_PTHREADS
GLIBC_AUTOCONF	+= --enable-add-ons=linuxthreads
endif

GLIBC_AUTOCONF	+= $(GLIBC_EXTRA_CONFIG)

#
# dependencies
#
glibc_prepare_deps = \
	$(STATEDIR)/autoconf213.install \
	$(STATEDIR)/xchain-gccstage1.install \
	$(STATEDIR)/glibc.extract

$(STATEDIR)/glibc.prepare: $(glibc_prepare_deps)
	@$(call targetinfo, $@)
	mkdir -p $(GLIBC_BUILDDIR)
	cd $(GLIBC_BUILDDIR) &&	\
	        $(GLIBC_PATH) $(GLIBC_ENV) \
		$(GLIBC_DIR)/configure $(PTXCONF_GNU_TARGET) \
			$(GLIBC_AUTOCONF)
#
# don't compile programs
#
	echo "build-programs=no" >> $(GLIBC_BUILDDIR)/configparms

	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ifdef PTXCONF_BUILD_CROSSCHAIN
glibc_compile:		$(STATEDIR)/glibc.compile
else
glibc_compile:
endif

$(STATEDIR)/glibc.compile: $(STATEDIR)/glibc.prepare 
	@$(call targetinfo, $@)
	$(GLIBC_PATH) make -C $(GLIBC_BUILDDIR)
#
# fake files which are installed by make install although
# compiling binaries was switched of (tested with 2.2.5)
#
	touch $(GLIBC_BUILDDIR)/iconv/iconv_prog
	touch $(GLIBC_BUILDDIR)/login/pt_chown
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ifdef PTXCONF_BUILD_CROSSCHAIN
glibc_install:		$(STATEDIR)/glibc.install
else
glibc_install:
endif

$(STATEDIR)/glibc.install: $(STATEDIR)/glibc.compile
	@$(call targetinfo, $@)
	$(GLIBC_PATH) make -C $(GLIBC_BUILDDIR) \
		install_root=$(CROSS_LIB_DIR) prefix="" install
#
# Dan Kegel writes:
#
# Fix problems in linker scripts.
# 
# 1. Remove absolute paths
# Any file in a list of known suspects that isn't a symlink is assumed to be a linker script.
# FIXME: test -h is not portable
# FIXME: probably need to check more files than just these three...
# Need to use sed instead of just assuming we know what's in libc.so because otherwise alpha breaks
#
# 2. Remove lines containing BUG per http://sources.redhat.com/ml/bug-glibc/2003-05/msg00055.html,
# needed to fix gcc-3.2.3/glibc-2.3.2 targeting arm
#
	for file in libc.so libpthread.so libgcc_s.so; do								\
		if [ -f $(CROSS_LIB_DIR)/lib/$$file -a ! -h $(CROSS_LIB_DIR)/lib/$$file ]; then				\
			echo $$file;											\
			if [ ! -f $(CROSS_LIB_DIR)/lib/$${file}_orig ]; then						\
				mv $(CROSS_LIB_DIR)/lib/$$file $(CROSS_LIB_DIR)/lib/$${file}_orig;			\
			fi;												\
			sed 's,/lib/,,g;/BUG in libc.scripts.output-format.sed/d' < $(CROSS_LIB_DIR)/lib/$${file}_orig	\
				> $(CROSS_LIB_DIR)/lib/$$file;								\
		fi;													\
	done
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glibc_targetinstall:		$(STATEDIR)/glibc.targetinstall

ifdef PTXCONF_BUILD_CROSSCHAIN
glibc_targetinstall_deps = $(STATEDIR)/glibc.install
endif

ifdef PTXCONF_GLIBC_DEBUG
GLIBC_STRIP	= true
else
GLIBC_STRIP	= $(CROSSSTRIP) -S -R .note -R .comment
endif

$(STATEDIR)/glibc.targetinstall: $(glibc_targetinstall_deps)
	@$(call targetinfo, $@)
#
# CAREFUL: don't never ever make install!!!
# but we never ever run ptxdist as root, do we? :)
#
	mkdir -p $(ROOTDIR)/lib

	cp -d $(CROSS_LIB_DIR)/lib/ld[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/ld[-.]*so*
	cd $(CROSS_LIB_DIR)/lib && \
		ln -sf ld-*.so $(ROOTDIR)$(DYNAMIC_LINKER)
#
# we don't wanna copy libc.so, cause this is ld linker script, no shared lib
#
	cp -d $(CROSS_LIB_DIR)/lib/libc-*so* $(ROOTDIR)/lib/
	cp -d $(CROSS_LIB_DIR)/lib/libc.so.* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libc-*so*

ifdef PTXCONF_GLIBC_PTHREADS
	cp -d $(CROSS_LIB_DIR)/lib/libpthread[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libpthread-*so*
endif

ifdef PTXCONF_GLIBC_THREAD_DB
	cp -d $(CROSS_LIB_DIR)/lib/libthread_db[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libthread_db[-.]*so*
endif

ifdef PTXCONF_GLIBC_DL
	cp -d $(CROSS_LIB_DIR)/lib/libdl[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libdl[-.]*so*
endif

ifdef PTXCONF_GLIBC_CRYPT
	cp -d $(CROSS_LIB_DIR)/lib/libcrypt[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libcrypt[-.]*so*
endif

ifdef PTXCONF_GLIBC_UTIL
	cp -d $(CROSS_LIB_DIR)/lib/libutil[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libutil[-.]*so*
endif

ifdef PTXCONF_GLIBC_LIBM
	cp -d $(CROSS_LIB_DIR)/lib/libm[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libm[-.]*so*
endif

ifdef PTXCONF_GLIBC_NSS_DNS
	cp -d $(CROSS_LIB_DIR)/lib/libnss_dns[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libnss_dns[-.]*so*
endif

ifdef PTXCONF_GLIBC_NSS_FILES
	cp -d $(CROSS_LIB_DIR)/lib/libnss_files[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libnss_files[-.]*so*
endif

ifdef PTXCONF_GLIBC_NSS_HESIOD
	cp -d $(CROSS_LIB_DIR)/lib/libnss_hesiod[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libnss_hesiod[-.]*so*
endif

ifdef PTXCONF_GLIBC_NSS_NIS
	cp -d $(CROSS_LIB_DIR)/lib/libnss_nis[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libnss_nis[-.]*so*
endif

ifdef PTXCONF_GLIBC_NSS_NISPLUS
	cp -d $(CROSS_LIB_DIR)/lib/libnss_nisplus[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libnss_nisplus[-.]*so*
endif

ifdef PTXCONF_GLIBC_NSS_COMPAT
	cp -d $(CROSS_LIB_DIR)/lib/libnss_compat[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libnss_compat[-.]*so*
endif

ifdef PTXCONF_GLIBC_RESOLV
	cp -d $(CROSS_LIB_DIR)/lib/libresolv[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libresolv[-.]*so*
endif

ifdef PTXCONF_GLIBC_NSL
	cp -d $(CROSS_LIB_DIR)/lib/libnsl[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libnsl[-.]*so*
endif

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glibc_clean: 
	-rm -rf $(STATEDIR)/glibc*
	-rm -rf $(GLIBC_DIR)
	-rm -rf $(GLIBC_BUILDDIR)

# vim: syntax=make
