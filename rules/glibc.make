# -*-makefile-*-
# $Id: glibc.make,v 1.3 2003/08/14 08:01:57 robert Exp $
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
PACKAGES += glibc
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

GLIBC_BUILDDIR		= $(BUILDDIR)/$(GLIBC)-build
XCHAIN_GLIBC_BUILDDIR	= $(BUILDDIR)/xchain-$(GLIBC)-build

GLIBC_THREADS		= glibc-linuxthreads-$(GLIBC_VERSION)
GLIBC_THREADS_URL	= ftp://ftp.gnu.org/gnu/glibc/$(GLIBC_THREADS).tar.gz
GLIBC_THREADS_SOURCE	= $(SRCDIR)/$(GLIBC_THREADS).tar.gz
GLIBC_THREADS_DIR	= $(GLIBC_DIR)
GLIBC_THREADS_EXTRACT	= gzip -dc

GLIBC_PTXPATCH		= glibc-$(GLIBC_VERSION)-ptx3.diff
GLIBC_PTXPATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PTXPATCH)
GLIBC_PTXPATCH_SOURCE	= $(SRCDIR)/$(GLIBC_PTXPATCH)
GLIBC_PTXPATCH_DIR	= $(GLIBC_DIR)
GLIBC_PTXPATCH_EXTRACT	= cat

GLIBC_MKBPATCH		= glibc-2.2.5-mkb1.patch
GLIBC_MKBPATCH_SOURCE	= $(SRCDIR)/$(GLIBC_MKBPATCH)
GLIBC_MKBPATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_MKBPATCH)

# \t before comment ('#')
# stackdirection for cris architecture
# see:
# http://sources.redhat.com/ml/libc-alpha/2002-06/msg00006.html
# http://sources.redhat.com/ml/libc-alpha/2002-06/msg00007.html
# --- only for cris ---
GLIBC_CRISPATCH		= glibc-2.2.5-cris-mkb1.patch
GLIBC_CRISPATCH_SOURCE	= $(SRCDIR)/$(GLIBC_CRISPATCH)
GLIBC_CRISPATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_CRISPATCH)

#
# fix varous bugs - borrowed from gentoo
#

# Fix for http://www.cert.org/advisories/CA-2003-10.html
GLIBC_XDRPATCH		= glibc-xdr_security.patch
GLIBC_XDRPATCH_SOURCE	= $(SRCDIR)/$(GLIBC_XDRPATCH)
GLIBC_XDRPATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_XDRPATCH)

# This patch apparently eliminates compiler warnings for some versions of gcc.
# For information about the string2 patch, see:
# http://lists.gentoo.org/pipermail/gentoo-dev/2001-June/001559.html
GLIBC_STRINGHPATCH		= glibc-2.2.4-string2.h.diff
GLIBC_STRINGHPATCH_SOURCE	= $(SRCDIR)/$(GLIBC_STRINGHPATCH)
GLIBC_STRINGHPATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_STRINGHPATCH)

# This next one is a new patch to fix thread signal handling.  See:
# http://sources.redhat.com/ml/libc-hacker/2002-02/msg00120.html
GLIBC_THREADSIGPATCH		= glibc-2.2.5-threadsig.diff
GLIBC_THREADSIGPATCH_SOURCE	= $(SRCDIR)/$(GLIBC_THREADSIGPATCH)
GLIBC_THREADSIGPATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_THREADSIGPATCH)

# This next patch fixes a test that will timeout due to ReiserFS' slow handling of sparse files
GLIBC_TIMEOUTPATCH		= glibc-2.2.2-test-lfs-timeout.patch
GLIBC_TIMEOUTPATCH_SOURCE	= $(SRCDIR)/$(GLIBC_TIMEOUTPATCH)
GLIBC_TIMEOUTPATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_TIMEOUTPATCH)

# A buffer overflow vulnerability exists in multiple implementations of DNS
# resolver libraries.  This affects glibc-2.2.5 and earlier. See bug #4923
# and: http://www.cert.org/advisories/CA-2002-19.html
GLIBC_DNSPATCH			= glibc-2.2.5-dns-network-overflow.diff
GLIBC_DNSPATCH_SOURCE		= $(SRCDIR)/$(GLIBC_DNSPATCH)
GLIBC_DNSPATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_DNSPATCH)

# Security update for sunrpc
GLIBC_SUNRPCPATCH		= glibc-2.2.5-sunrpc-overflow.diff
GLIBC_SUNRPCPATCH_SOURCE	= $(SRCDIR)/$(GLIBC_SUNRPCPATCH)
GLIBC_SUNRPCPATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_SUNRPCPATCH)

# This patch fixes the nvidia-glx probs, openoffice and vmware probs and such..
# http://sources.redhat.com/ml/libc-hacker/2002-02/msg00152.html
# --- only for X86 and PPC ---
GLIBC_DIVDI3PATCH		= glibc-2.2.5-divdi3.diff
GLIBC_DIVDI3PATCH_SOURCE	= $(SRCDIR)/$(GLIBC_DIVDI3PATCH)
GLIBC_DIVDI3PATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_DIVDI3PATCH)

# This patch fixes the absence of sqrtl on PPC
# http://sources.redhat.com/ml/libc-hacker/2002-05/msg00012.html
# --- only for PPC ---
GLIBC_SRQTPATCH			= glibc-2.2.5-ppc-sqrtl.diff
GLIBC_SRQTPATCH_SOURCE		= $(SRCDIR)/$(GLIBC_SRQTPATCH)
GLIBC_SRQTPATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_SRQTPATCH)

# http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2002/08/0228.html
# --- only gcc.major = 3 gcc.minor >= 2 ---
GLIBC_DIVBYZEROPATCH		= glibc-2.2.5.divbyzero.patch
GLIBC_DIVBYZEROPATCH_SOURCE	= $(SRCDIR)/$(GLIBC_DIVBYZEROPATCH)
GLIBC_DIVBYZEROPATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_DIVBYZEROPATCH)

GLIBC_RESTRICTPATCH		= glibc-2.2.5.restrict_arr.patch
GLIBC_RESTRICTPATCH_SOURCE	= $(SRCDIR)/$(GLIBC_RESTRICTPATCH)
GLIBC_RESTRICTPATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_RESTRICTPATCH)

# Some patches to fixup build on alpha
# --- only for ALPHA ---
# GLIBC_ALPHAGCC3PATCH_SOURCE	= $(SRCDIR)/glibc-2.2.5-alpha-gcc3-fix.diff
# GLIBC_PATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PATCH)
# GLIBC_ALPHAPCDYNPATCH_SOURCE	= $(SRCDIR)/glibc-2.2.5-alpha-pcdyn-fix.diff
# GLIBC_PATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PATCH)
# GLIBC_ALPHAGCCPATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PATCH)
# GLIBC_PATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PATCH)

# Some patches to fixup build on sparc
# --- only SPARC and SPARC64 ---
# GLIBC_SPARCMATHINLINEPATCH_SOURCE= $(SRCDIR)/glibc-2.2.5-sparc-mathinline.patch
# GLIBC_SPARCMISCPATCH_SOURCE	= $(SRCDIR)/glibc-2.2.5-sparc-misc.diff
# GLIBC_PATCH_URL			= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PATCH)
# GLIBC_PATCH_URL		=	 http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PATCH)

# Some patches to fixup build on sparc
# --- only SPARC64 ---
# GLIBC_SPARC64PATCH_SOURCE	= $(SRCDIR)/glibc-2.2.5-sparc64-fixups.diff
# GLIBC_PATCH_URL			= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PATCH)

# Some patches to fixup build on sparc
# --- only SPARC and SPARC64 ---
# GLIBC_SPARC32SEMCTLPATCH_SOURCE	= $(SRCDIR)/glibc-2.2.5-sparc32-semctl.patch
# GLIBC_PATCH_URL			= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PATCH)

# For ppc405, there is no fpu.  The following hack disables a 
# build-error causing code. See thread:
# http://sources.redhat.com/ml/crossgcc/2002-05/msg00131.html
GLIBC_PPCNOFPU1PATCH		= glibc-ppc-nofpu.patch1
GLIBC_PPCNOFPU1PATCH_SOURCE	= $(SRCDIR)/$(GLIBC_PPCNOFPU1PATCH)
GLIBC_PPCNOFPU1PATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PPCNOFPU1PATCH)

GLIBC_PPCNOFPU2PATCH		= glibc-ppc-nofpu.patch2
GLIBC_PPCNOFPU2PATCH_SOURCE	= $(SRCDIR)/$(GLIBC_PPCNOFPU2PATCH)
GLIBC_PPCNOFPU2PATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PPCNOFPU2PATCH)

GLIBC_PPCNOFPU3PATCH		= glibc-ppc-nofpu.patch3
GLIBC_PPCNOFPU3PATCH_SOURCE	= $(SRCDIR)/$(GLIBC_PPCNOFPU3PATCH)
GLIBC_PPCNOFPU3PATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PPCNOFPU3PATCH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glibc_get:		$(STATEDIR)/glibc.get

glibc_get_deps	=  $(GLIBC_SOURCE)
glibc_get_deps	+= $(GLIBC_PTXPATCH_SOURCE)
glibc_get_deps	+= $(GLIBC_MKBPATCH_SOURCE)
ifdef PTXCONF_ARCH_CRIS
glibc_get_deps	+= $(GLIBC_CRISPATCH_SOURCE)
endif
glibc_get_deps	+= $(GLIBC_XDRPATCH_SOURCE)
glibc_get_deps	+= $(GLIBC_STRINGHPATCH_SOURCE)
glibc_get_deps	+= $(GLIBC_TIMEOUTPATCH_SOURCE)
glibc_get_deps	+= $(GLIBC_DNSPATCH_SOURCE)
glibc_get_deps	+= $(GLIBC_SUNRPCPATCH_SOURCE)
ifdef PTXCONF_ARCH_X86
glibc_get_deps	+= $(GLIBC_DIVDI3PATCH_SOURCE)
endif
ifdef PTXCONF_ARCH_PPC
glibc_get_deps	+= $(GLIBC_DIVDI3PATCH_SOURCE)
glibc_get_deps	+= $(GLIBC_SRQTPATCH_SOURCE)
endif
ifdef PTXCONF_GCC_3_2_3
glibc_get_deps	+= $(GLIBC_DIVBYZEROPATCH_SOURCE)
glibc_get_deps	+= $(GLIBC_RESTRICTPATCH_SOURCE)
endif
ifdef PTXCONF_OPT_PPC405
glibc_get_deps	+= $(GLIBC_PPCNOFPU1PATCH_SOURCE)
glibc_get_deps	+= $(GLIBC_PPCNOFPU2PATCH_SOURCE)
glibc_get_deps	+= $(GLIBC_PPCNOFPU3PATCH_SOURCE)
endif

ifdef PTXCONF_GLIBC_PTHREADS
glibc_get_deps	+= $(GLIBC_THREADS_SOURCE)
glibc_get_deps	+= $(GLIBC_THREADSIGPATCH_SOURCE)
endif

$(STATEDIR)/glibc.get: $(glibc_get_deps)
	@$(call targetinfo, glibc.get)
	touch $@

$(GLIBC_SOURCE):
	@$(call targetinfo, $(GLIBC_SOURCE))
	@$(call get, $(GLIBC_URL))

$(GLIBC_THREADS_SOURCE):
	@$(call targetinfo, $(GLIBC_THREADS_SOURCE))
	@$(call get, $(GLIBC_THREADS_URL))

$(GLIBC_PTXPATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_PTXPATCH_SOURCE))
	@$(call get, $(GLIBC_PTXPATCH_URL))

$(GLIBC_MKBPATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_MKBPATCH_SOURCE))
	@$(call get, $(GLIBC_MKBPATCH_URL))

$(GLIBC_CRISPATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_CRISPATCH_SOURCE))
	@$(call get, $(GLIBC_CRISPATCH_URL))

$(GLIBC_XDRPATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_XDRPATCH_SOURCE))
	@$(call get, $(GLIBC_XDRPATCH_URL))

$(GLIBC_STRINGHPATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_STRINGHPATCH_SOURCE))
	@$(call get, $(GLIBC_STRINGHPATCH_URL))

$(GLIBC_TIMEOUTPATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_TIMEOUTPATCH_SOURCE))
	@$(call get, $(GLIBC_TIMEOUTPATCH_URL))

$(GLIBC_DNSPATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_DNSPATCH_SOURCE))
	@$(call get, $(GLIBC_DNSPATCH_URL))

$(GLIBC_SUNRPCPATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_SUNRPCPATCH_SOURCE))
	@$(call get, $(GLIBC_SUNRPCPATCH_URL))

$(GLIBC_DIVDI3PATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_DIVDI3PATCH_SOURCE))
	@$(call get, $(GLIBC_DIVDI3PATCH_URL))

$(GLIBC_SRQTPATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_SRQTPATCH_SOURCE))
	@$(call get, $(GLIBC_SRQTPATCH_URL))

$(GLIBC_DIVBYZEROPATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_DIVBYZEROPATCH_SOURCE))
	@$(call get, $(GLIBC_DIVBYZEROPATCH_URL))

$(GLIBC_RESTRICTPATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_RESTRICTPATCH_SOURCE))
	@$(call get, $(GLIBC_RESTRICTPATCH_URL))

$(GLIBC_PPCNOFPU1PATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_PPCNOFPU1PATCH_SOURCE))
	@$(call get, $(GLIBC_PPCNOFPU1PATCH_URL))

$(GLIBC_PPCNOFPU2PATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_PPCNOFPU2PATCH_SOURCE))
	@$(call get, $(GLIBC_PPCNOFPU2PATCH_URL))

$(GLIBC_PPCNOFPU3PATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_PPCNOFPU3PATCH_SOURCE))
	@$(call get, $(GLIBC_PPCNOFPU3PATCH_URL))

$(GLIBC_THREADSIGPATCH_SOURCE):
	@$(call targetinfo, $(GLIBC_THREADSIGPATCH_SOURCE))
	@$(call get, $(GLIBC_THREADSIGPATCH_URL))

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

	# fix some bugs...
	cd $(GLIBC_DIR) && patch -p1 < $(GLIBC_PTXPATCH_SOURCE)
	cd $(GLIBC_DIR) && patch -p1 < $(GLIBC_MKBPATCH_SOURCE)

ifdef PTXCONF_GLIBC_2_2_5
        ifdef PTXCONF_ARCH_CRIS
	cd $(GLIBC_DIR) && patch -p1 < $(GLIBC_CRISPATCH_SOURCE)
        endif

	cd $(GLIBC_DIR) && patch -p1 < $(GLIBC_XDRPATCH_SOURCE)
	cd $(GLIBC_DIR) && patch -p0 < $(GLIBC_STRINGHPATCH_SOURCE)
	cd $(GLIBC_DIR)/io && patch -p0 < $(GLIBC_TIMEOUTPATCH_SOURCE)
	cd $(GLIBC_DIR) && patch -p1 < $(GLIBC_DNSPATCH_SOURCE)
	cd $(GLIBC_DIR) && patch -p1 < $(GLIBC_SUNRPCPATCH_SOURCE)

        ifdef PTXCONF_ARCH_X86
	cd $(GLIBC_DIR) && patch -p1 < $(GLIBC_DIVDI3PATCH_SOURCE)
        endif
        ifdef PTXCONF_ARCH_PPC
	cd $(GLIBC_DIR) && patch -p1 < $(GLIBC_DIVDI3PATCH_SOURCE)
	cd $(GLIBC_DIR) && patch -p0 < $(GLIBC_SRQTPATCH_SOURCE)
        endif

        ifdef PTXCONF_GCC_3_2_3
	cd $(GLIBC_DIR) && patch -p1 < $(GLIBC_DIVBYZEROPATCH_SOURCE)
	cd $(GLIBC_DIR) && patch -p1 < $(GLIBC_RESTRICTPATCH_SOURCE)
        endif

# FIXME: apply sparc & alpha patches

        ifdef PTXCONF_OPT_PPC405
	cd $(GLIBC_DIR) && mv sysdeps/powerpc/fclrexcpt.c sysdeps/powerpc/fpu/
	cd $(GLIBC_DIR) && rm sysdeps/powerpc/memset.S

	cd $(GLIBC_DIR) && patch -p0 < $(GLIBC_PPCNOFPU1PATCH_SOURCE)
	cd $(GLIBC_DIR) && patch -p0 < $(GLIBC_PPCNOFPU2PATCH_SOURCE)
	cd $(GLIBC_DIR) && patch -p1 < $(GLIBC_PPCNOFPU3PATCH_SOURCE)
        endif
endif # PTXCONF_GLIBC_2_2_5

	# fix: sunrpc's makefile has the wrong magic to find cpp...
	# FIXME: is this the right fix for other versions than 2.2.5? 
	cd $(GLIBC_DIR)/sunrpc && mkdir cpp && \
		ln -sf $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-cpp cpp/

	# this is magically recreated if missing (necessary because
	# of patch against configure.in)
	rm -f $(GLIBC_DIR)/sysdeps/unix/sysv/linux/configure
	
	# We have to rebuild the toplevel configure script. Nobody knows
	# why...
	rm -f $(GLIBC_DIR)/configure
	cd $(GLIBC_DIR) && $(GLIBC_PATH) autoconf
	touch $@

$(STATEDIR)/glibc-threads.extract: $(STATEDIR)/glibc.get
	@$(call targetinfo, glibc-threads.extract)
	@$(call extract, $(GLIBC_THREADS_SOURCE), $(GLIBC_DIR))
	cd $(GLIBC_DIR) && patch -p0 < $(GLIBC_THREADSIGPATCH_SOURCE)
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

# glibc sometimes doesn't find out that it is cross compiled
GLIBC_ENV	+= ac_cv_prog_cc_cross=yes

#
# features
#
ifdef PTXCONF_GLIBC_FLOATINGPOINT
  GLIBC_AUTOCONF+=--with-fp=yes
else
  GLIBC_AUTOCONF+=--with-fp=no
endif
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
	ln -sf libnss_dns-$(GLIBC_VERSION) $(ROOTDIR)/lib/libnss_dns.so.2
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
	ln -sf libresolv.$(GLIBC_VERSION).so $(ROOTDIR)/lib/libresolv.so.2
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
