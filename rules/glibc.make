# -*-makefile-*-
# $Id: glibc.make,v 1.9 2003/09/16 16:40:36 mkl Exp $
#
# (c) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_GLIBC
PACKAGES	+= glibc
DYNAMIC_LINKER	=  /lib/ld.so.1
endif


#
# Paths and names 
#
ifeq (y, $(PTXCONF_GLIBC_2_3_2))
GLIBC_VERSION		= 2.3.2
endif
ifeq (y, $(PTXCONF_GLIBC_2_2_5))
GLIBC_VERSION		= 2.2.5
endif
ifeq (y, $(PTXCONF_GLIBC_2_2_4))
GLIBC_VERSION		= 2.2.4
endif
ifeq (y, $(PTXCONF_GLIBC_2_2_3))
GLIBC_VERSION		= 2.2.3
endif

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

glibc_get:		$(STATEDIR)/glibc.get

glibc_get_deps	=  $(GLIBC_SOURCE)

ifdef PTXCONF_GLIBC_PTHREADS
glibc_get_deps	+= $(GLIBC_THREADS_SOURCE)
endif

$(STATEDIR)/glibc.get: $(glibc_get_deps)
	@$(call targetinfo, glibc.get)
	@$(call get_patches, $(GLIBC))
	@$(call get_patches, $(GLIBC_THREADS))
	touch $@

$(GLIBC_SOURCE):
	@$(call targetinfo, $(GLIBC_SOURCE))
	@$(call get, $(GLIBC_URL))

$(GLIBC_THREADS_SOURCE):
	@$(call targetinfo, $(GLIBC_THREADS_SOURCE))
	@$(call get, $(GLIBC_THREADS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glibc_extract: $(STATEDIR)/glibc.extract

glibc_extract_deps =  $(STATEDIR)/glibc-base.extract
ifeq (y, $(PTXCONF_GLIBC_PTHREADS))
glibc_extract_deps += $(STATEDIR)/glibc-threads.extract
endif

$(STATEDIR)/glibc.extract: $(glibc_extract_deps)
	@$(call targetinfo, glibc.extract)
	touch $@

$(STATEDIR)/glibc-base.extract: $(STATEDIR)/glibc.get
	@$(call targetinfo, glibc-base.extract)
	@$(call clean, $(GLIBC_DIR))
	@$(call extract, $(GLIBC_SOURCE))
	@$(call patchin, $(GLIBC))
	touch $@

$(STATEDIR)/glibc-threads.extract: $(STATEDIR)/glibc.get
	@$(call targetinfo, glibc-threads.extract)
	@$(call extract, $(GLIBC_THREADS_SOURCE), $(GLIBC_DIR))
	@$(call patchin, $(GLIBC_THREADS), $(GLIBC_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glibc_prepare:		$(STATEDIR)/glibc.prepare

# 
# arcitecture dependend configuration
#
GLIBC_AUTOCONF	=  --build=$(GNU_HOST)
GLIBC_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
GLIBC_AUTOCONF	+= --disable-sanity-checks
GLIBC_PATH	=  PATH=$(PTXCONF_PREFIX)/$(AUTOCONF213)/bin:$(CROSS_PATH)
GLIBC_ENV	=  $(CROSS_ENV)

#
# features
#
ifdef PTXCONF_GLIBC_LIBIO
  GLIBC_AUTOCONF+=--enable-libio
endif
ifdef PTXCONF_GLIBC_SHARED
  GLIBC_AUTOCONF+=--enable-shared
else
  GLIBC_AUTOCONF+=--enable-shared=no
endif
ifdef PTXCONF_GLIBC_PROFILED
  GLIBC_AUTOCONF+=--enable-profile=yes
else
  GLIBC_AUTOCONF+=--enable-profile=no
endif
ifdef PTXCONF_GLIBC_OMITFP
  GLIBC_AUTOCONF+=--enable-omitfp
endif
ifdef PTXCONF_GLIBC_PTHREADS
  GLIBC_AUTOCONF+=--enable-add-ons=linuxthreads
endif

GLIBC_AUTOCONF	+= $(GLIBC_EXTRA_CONFIG)

#
# dependencies
#
glibc_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/autoconf213.install \
	$(STATEDIR)/glibc.extract

$(STATEDIR)/glibc.prepare: $(glibc_prepare_deps)
	@$(call targetinfo, glibc.prepare)
	mkdir -p $(GLIBC_BUILDDIR)
	cd $(GLIBC_BUILDDIR) &&						\
	        $(GLIBC_PATH) $(GLIBC_ENV)				\
		$(GLIBC_DIR)/configure $(PTXCONF_GNU_TARGET) 		\
			$(GLIBC_AUTOCONF)				\
			--prefix=/usr					\
			--libexecdir=/usr/bin
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glibc_compile:		$(STATEDIR)/glibc.compile

$(STATEDIR)/glibc.compile: $(STATEDIR)/glibc.prepare 
	@$(call targetinfo, glibc.compile)
	cd $(GLIBC_BUILDDIR) && $(GLIBC_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glibc_install:		$(STATEDIR)/glibc.install

$(STATEDIR)/glibc.install: $(STATEDIR)/glibc.compile
	@$(call targetinfo, glibc.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glibc_targetinstall:		$(STATEDIR)/glibc.targetinstall

$(STATEDIR)/glibc.targetinstall: $(STATEDIR)/glibc.compile
	@$(call targetinfo, glibc.targetinstall)
	# CAREFUL: don't never ever make install in ldso tree!!!
	mkdir -p $(ROOTDIR)/lib

	install $(GLIBC_BUILDDIR)/elf/ld.so $(ROOTDIR)/lib/ld-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/ld-$(GLIBC_VERSION).so
	ln -sf ld-$(GLIBC_VERSION).so $(ROOTDIR)/lib/ld.so.1
	ln -sf ld-$(GLIBC_VERSION).so $(ROOTDIR)/lib/ld-linux.so.2

	install $(GLIBC_BUILDDIR)/libc.so $(ROOTDIR)/lib/libc-$(GLIBC_VERSION).so.6
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libc-$(GLIBC_VERSION).so.6
	ln -sf libc-$(GLIBC_VERSION).so.6 $(ROOTDIR)/lib/libc.so.6

        ifeq (y, $(PTXCONF_GLIBC_PTHREADS))
	install $(GLIBC_BUILDDIR)/linuxthreads/libpthread.so $(ROOTDIR)/lib/libpthread-0.9.so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libpthread-0.9.so
	ln -sf libpthread-0.9.so $(ROOTDIR)/lib/libpthread.so.0
        endif

        ifeq (y, $(PTXCONF_GLIBC_THREAD_DB))
	install $(GLIBC_BUILDDIR)/linuxthreads_db/libthread_db.so $(ROOTDIR)/lib/libthread_db.so.1
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libthread_db.so.1
        endif

        ifeq (y, $(PTXCONF_GLIBC_DL))
	install $(GLIBC_BUILDDIR)/dlfcn/libdl.so $(ROOTDIR)/lib/libdl-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libdl-$(GLIBC_VERSION).so
	ln -sf libdl-$(GLIBC_VERSION).so $(ROOTDIR)/lib/libdl.so.2
        endif

        ifeq (y, $(PTXCONF_GLIBC_CRYPT))
	install $(GLIBC_BUILDDIR)/crypt/libcrypt.so $(ROOTDIR)/lib/libcrypt-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libcrypt-$(GLIBC_VERSION).so
	ln -sf libcrypt-$(GLIBC_VERSION).so $(ROOTDIR)/lib/libcrypt.so.1
        endif

        ifeq (y, $(PTXCONF_GLIBC_UTIL))
	install $(GLIBC_BUILDDIR)/login/libutil.so $(ROOTDIR)/lib/libutil-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libutil-$(GLIBC_VERSION).so
	ln -sf libutil-$(GLIBC_VERSION).so $(ROOTDIR)/lib/libutil.so.1
        endif

        ifeq (y, $(PTXCONF_GLIBC_LIBM))
	install $(GLIBC_BUILDDIR)/math/libm.so $(ROOTDIR)/lib/libm-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libm-$(GLIBC_VERSION).so
	ln -sf libm-$(GLIBC_VERSION).so $(ROOTDIR)/lib/libm.so.6
        endif

        ifeq (y, $(PTXCONF_GLIBC_NSS_DNS))
	install $(GLIBC_BUILDDIR)/resolv/libnss_dns.so.2 $(ROOTDIR)/lib/libnss_dns-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libnss_dns-$(GLIBC_VERSION).so
	ln -sf libnss_dns-$(GLIBC_VERSION).so $(ROOTDIR)/lib/libnss_dns.so.2
        endif

        ifeq (y, $(PTXCONF_GLIBC_NSS_FILES))
	install $(GLIBC_BUILDDIR)/nss/libnss_files.so.2 $(ROOTDIR)/lib/libnss_files-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libnss_files-$(GLIBC_VERSION).so
	ln -sf libnss_files-$(GLIBC_VERSION).so $(ROOTDIR)/lib/libnss_files.so.2
        endif

        ifeq (y, $(PTXCONF_GLIBC_NSS_HESIOD))
	install $(GLIBC_BUILDDIR)/hesiod/libnss_hesiod.so.2 $(ROOTDIR)/lib/libnss_hesiod-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libnss_hesiod-$(GLIBC_VERSION).so
	ln -sf libnss_hesiod-$(GLIBC_VERSION).so $(ROOTDIR)/lib/libnss_hesiod.so.2
        endif

        ifeq (y, $(PTXCONF_GLIBC_NSS_NIS))
	install $(GLIBC_BUILDDIR)/nis/libnss_nis.so.2 $(ROOTDIR)/lib/libnss_nis-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libnss_nis-$(GLIBC_VERSION).so
	ln -sf libnss_nis-$(GLIBC_VERSION).so $(ROOTDIR)/lib/libnss_nis.so.2
        endif

        ifeq (y, $(PTXCONF_GLIBC_NSS_NISPLUS))
	install $(GLIBC_BUILDDIR)/nis/libnss_nisplus.so.2 $(ROOTDIR)/lib/libnss_nisplus-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libnss_nisplus-$(GLIBC_VERSION).so
	ln -sf libnss_nisplus-$(GLIBC_VERSION).so $(ROOTDIR)/lib/libnss_nisplus.so.2
        endif

        ifeq (y, $(PTXCONF_GLIBC_NSS_COMPAT))
	install $(GLIBC_BUILDDIR)/nis/libnss_compat.so.2 $(ROOTDIR)/lib/libnss_compat-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libnss_compat-$(GLIBC_VERSION).so
	ln -sf libnss_compat-$(GLIBC_VERSION).so $(ROOTDIR)/lib/libnss_compat.so.2
        endif

        ifeq (y, $(PTXCONF_GLIBC_RESOLV))
	install $(GLIBC_BUILDDIR)/resolv/libresolv.so $(ROOTDIR)/lib/libresolv-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libresolv-$(GLIBC_VERSION).so
	ln -sf libresolv-$(GLIBC_VERSION).so $(ROOTDIR)/lib/libresolv.so.2
        endif

        ifeq (y, $(PTXCONF_GLIBC_NSL))
	install $(GLIBC_BUILDDIR)/nis/libnsl.so $(ROOTDIR)/lib/libnsl-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libnsl-$(GLIBC_VERSION).so
	ln -sf libnsl-$(GLIBC_VERSION).so $(ROOTDIR)/lib/libnsl.so.1
        endif

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glibc_clean: 
	-rm -rf $(STATEDIR)/xchain-glibc.extract
	-rm -rf $(STATEDIR)/xchain-glibc.prepare
	-rm -rf $(STATEDIR)/xchain-glibc.compile
	-rm -rf $(STATEDIR)/glibc*
	-rm -rf $(GLIBC_DIR)
	-rm -rf $(GLIBC_BUILDDIR)
	-rm -rf $(XCHAIN_GLIBC_BUILDDIR)
# vim: syntax=make
