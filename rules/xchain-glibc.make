# $Id: xchain-glibc.make,v 1.6 2003/06/25 13:29:34 robert Exp $
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
ifeq (y, $(PTXCONF_GLIBC_2_2_5))
PACKAGES += glibc
endif
ifeq (y, $(PTXCONF_GLIBC_2_2_4))
PACKAGES += glibc
endif
ifeq (y, $(PTXCONF_GLIBC_2_2_3))
PACKAGES += glibc
endif


#
# Paths and names 
#
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
GLIBC_EXTRACT 		= gzip -dc

GLIBC_THREADS		= glibc-linuxthreads-$(GLIBC_VERSION)
GLIBC_THREADS_URL	= ftp://ftp.gnu.org/gnu/glibc/$(GLIBC_THREADS).tar.gz
GLIBC_THREADS_SOURCE	= $(SRCDIR)/$(GLIBC_THREADS).tar.gz
GLIBC_THREADS_DIR	= $(GLIBC_DIR)
GLIBC_THREADS_EXTRACT	= gzip -dc

GLIBC_PTXPATCH		= glibc-$(GLIBC_VERSION)-ptx1.diff
GLIBC_PTXPATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GLIBC_PTXPATCH)
GLIBC_PTXPATCH_SOURCE	= $(SRCDIR)/$(GLIBC_PTXPATCH)
GLIBC_PTXPATCH_DIR	= $(GLIBC_DIR)
GLIBC_PTXPATCH_EXTRACT	= cat 


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glibc_get: $(STATEDIR)/glibc.get

glibc_get_deps =  $(STATEDIR)/glibc-base.get
glibc_get_deps += $(STATEDIR)/glibc-ptxpatch.get
ifdef PTXCONF_GLIBC_PTHREADS
glibc_get_deps += $(STATEDIR)/glibc-threads.get
endif

$(STATEDIR)/glibc.get: $(glibc_get_deps)
	touch $@

$(STATEDIR)/glibc-base.get: $(GLIBC_SOURCE)
	touch $@

$(STATEDIR)/glibc-threads.get: $(GLIBC_THREADS_SOURCE)
	touch $@

$(STATEDIR)/glibc-ptxpatch.get: $(GLIBC_PTXPATCH_SOURCE)
	touch $@

$(GLIBC_SOURCE):
	@$(call targetinfo, glibc-base.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(GLIBC_URL)

$(GLIBC_THREADS_SOURCE):
	@$(call targetinfo, glibc-threads.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(GLIBC_THREADS_URL)

$(GLIBC_PTXPATCH_SOURCE):
	@$(call targetinfo, glibc-ptxpatch.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(GLIBC_PTXPATCH_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glibc_extract: 		$(STATEDIR)/glibc.extract
glibc-base_extract: 	$(STATEDIR)/glibc-base.extract
glibc-threads_extract: 	$(STATEDIR)/glibc-threads.extract

glibc_extract_deps =  $(STATEDIR)/glibc-base.extract
ifeq (y, $(PTXCONF_GLIBC_PTHREADS))
glibc_extract_deps += $(STATEDIR)/glibc-threads.extract
endif

$(STATEDIR)/glibc.extract: $(glibc_extract_deps)
	@$(call targetinfo, glibc.extract)
	touch $@

$(STATEDIR)/glibc-base.extract: $(STATEDIR)/glibc.get
	@$(call targetinfo, glibc-base.extract)
	$(GLIBC_EXTRACT) $(GLIBC_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	# fix some bugs...
	cd $(GLIBC_DIR) && patch -p1 < $(GLIBC_PTXPATCH_SOURCE)
	# fix: sunrpc's makefile has the wrong magic to find cpp...
	# FIXME: is this the right fix for other versions than 2.2.5? 
	cd $(GLIBC_DIR)/sunrpc && mkdir cpp && ln -s $(PTXCONF_PREFIX)/bin/cpp cpp/
	# this is magically recreated if missing (necessary because
	# of patch against configure.in)
	rm -f $(GLIBC_DIR)/sysdeps/unix/sysv/linux/configure
	touch $@

$(STATEDIR)/glibc-threads.extract: $(STATEDIR)/glibc-threads.get
	@$(call targetinfo, glibc-threads.extract)
	$(GLIBC_THREADS_EXTRACT) $(GLIBC_THREADS_SOURCE) | $(TAR) -C $(GLIBC_DIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glibc_prepare: $(STATEDIR)/glibc.extract $(STATEDIR)/autoconf213.install

GLIBC_AUTOCONF =
GLIBC_ENVIRONMENT =

ifdef PTXCONF_GLIBC

# 
# arcitecture dependend configuration
#

GLIBC_AUTOCONF    += --build=$(GNU_HOST)
GLIBC_AUTOCONF    += --host=$(PTXCONF_GNU_TARGET)
GLIBC_AUTOCONF    += --disable-sanity-checks
GLIBC_ENVIRONMENT =  PATH=$(PTXCONF_PREFIX)/$(AUTOCONF213)/bin:$(PTXCONF_PREFIX)/bin:$$PATH
GLIBC_MAKEVARS    =  AR=$(PTXCONF_GNU_TARGET)-ar
GLIBC_MAKEVARS    += RANLIB=$(PTXCONF_GNU_TARGET)-ranlib
GLIBC_MAKEVARS    += CC=$(PTXCONF_GNU_TARGET)-gcc

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
# optimisation
#
ifdef PTXCONF_OPT_I386
  GLIBC_CFLAGS+=-mcpu=i386 -O2
endif
ifdef PTXCONF_OPT_I486
  GLIBC_CFLAGS+=-mcpu=i486 -O2
endif
ifdef PTXCONF_OPT_I686
  GLIBC_CFLAGS+=-mcpu=i686 -O2
endif
ifdef PTXCONF_ARCH_ARM
# GLIBC_CFLAGS+=-Wall -O2 
endif
ifdef GLIBC_CFLAGS
GLIBC_ENVIRONMENT += CFLAGS="$(GLIBC_CFLAGS)"
endif

endif

#
# dependencies
#
glibc_prepare_deps =  $(STATEDIR)/glibc.extract 
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN))
glibc_prepare_deps += $(STATEDIR)/xchain-gccstage1.install
endif

$(STATEDIR)/glibc.prepare: $(glibc_prepare_deps)
	@$(call targetinfo, glibc.prepare)
        ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN))
	mkdir -p $(BUILDDIR)/$(GLIBC)-obj 
	cd $(BUILDDIR)/$(GLIBC)-obj &&					\
	        $(GLIBC_ENVIRONMENT)					\
		$(GLIBC_DIR)/configure $(PTXCONF_GNU_TARGET) 		\
			$(GLIBC_AUTOCONF)				\
			--prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
        endif
	# 
	# we need a second directory where we configure glibc for the 
	# dynamic linker 
	#
	mkdir -p $(BUILDDIR)/$(GLIBC)-ldso
	cd $(BUILDDIR)/$(GLIBC)-ldso &&					\
		$(GLIBC_ENVIRONMENT)					\
		$(GLIBC_DIR)/configure $(PTXCONF_GNU_TARGET)		\
			$(GLIBC_AUTOCONF)				\
			--prefix=
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glibc_compile: $(STATEDIR)/glibc.compile

$(STATEDIR)/glibc.compile: $(STATEDIR)/glibc.prepare 
        ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN))
	# let makefile find autoconf-2.13 as default
	cd $(BUILDDIR)/$(GLIBC)-obj && $(GLIBC_ENVIRONMENT) make $(MAKEVARS) 
        endif
# FIXME: We need 2 separate targets *here*
	# FIXME: is there another possibility to create an ld.so which has 
	# correct search paths compiled in for /lib? 
	cd $(BUILDDIR)/$(GLIBC)-ldso && $(GLIBC_ENVIRONMENT) make $(MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glibc_install: $(STATEDIR)/glibc.install

$(STATEDIR)/glibc.install: $(STATEDIR)/glibc.compile
	@$(call targetinfo, glibc.install)
        ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN))
	cd $(BUILDDIR)/$(GLIBC)-obj && $(GLIBC_ENVIRONMENT) make install
        endif
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glibc_targetinstall: $(STATEDIR)/glibc.targetinstall

$(STATEDIR)/glibc.targetinstall: $(STATEDIR)/glibc.install
	@$(call targetinfo, glibc.targetinstall)
	# CAREFUL: don't never ever make install in ldso tree!!!
	mkdir -p $(ROOTDIR)/lib
	install $(BUILDDIR)/$(GLIBC)-ldso/elf/ld.so 	$(ROOTDIR)/lib/ld-$(GLIBC_VERSION).so
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/ld-$(GLIBC_VERSION).so
	ln -sf ld-$(GLIBC_VERSION).so $(ROOTDIR)/lib/ld-linux.so.2
	install $(BUILDDIR)/$(GLIBC)-ldso/libc.so	$(ROOTDIR)/lib/libc.so.6
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libc.so.6
	ln -sf libc.so.6 $(ROOTDIR)/lib/libc.so
        ifeq (y, $(PTXCONF_GLIBC_PTHREADS))
	install $(BUILDDIR)/$(GLIBC)-ldso/linuxthreads/libpthread.so $(ROOTDIR)/lib/libpthread.so.0
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libpthread.so.0
        endif
        ifeq (y, $(PTXCONF_GLIBC_THREAD_DB))
	install $(BUILDDIR)/$(GLIBC)-ldso/linuxthreads_db/libthread_db.so $(ROOTDIR)/lib/libthread_db.so.1
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libthread_db.so.1
        endif
        ifeq (y, $(PTXCONF_GLIBC_CRYPT))
	install $(BUILDDIR)/$(GLIBC)-ldso/crypt/libcrypt.so.1 $(ROOTDIR)/lib
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libcrypt.so.1
        endif
        ifeq (y, $(PTXCONF_GLIBC_UTIL))
	install $(BUILDDIR)/$(GLIBC)-ldso/login/libutil.so $(ROOTDIR)/lib
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libutil.so
	ln -sf libutil.so $(ROOTDIR)/lib/libutil.so.1
        endif
        ifeq (y, $(PTXCONF_GLIBC_LIBM))
	install $(BUILDDIR)/$(GLIBC)-ldso/math/libm.so $(ROOTDIR)/lib
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libm.so
	ln -sf libm.so $(ROOTDIR)/lib/libm.so.6
        endif
        ifeq (y, $(PTXCONF_GLIBC_NSS_DNS))
	install $(BUILDDIR)/$(GLIBC)-ldso/resolv/libnss_dns.so.2 $(ROOTDIR)/lib
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libnss_dns.so.2
	$(CROSSSTRIP) $(ROOTDIR)/lib/libnss_dns.so.2
        endif
        ifeq (y, $(PTXCONF_GLIBC_NSS_FILES))
	install $(BUILDDIR)/$(GLIBC)-ldso/nss/libnss_files.so.2 $(ROOTDIR)/lib
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libnss_files.so.2
        endif
        ifeq (y, $(PTXCONF_GLIBC_NSS_HESIOD))
	install $(BUILDDIR)/$(GLIBC)-ldso/hesiod/libnss_hesiod.so.2 $(ROOTDIR)/lib
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libnss_hesiod.so.2
        endif
        ifeq (y, $(PTXCONF_GLIBC_NSS_NIS))
	install $(BUILDDIR)/$(GLIBC)-ldso/nis/libnss_nis.so.2 $(ROOTDIR)/lib
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libnss_nis.so.2
        endif
        ifeq (y, $(PTXCONF_GLIBC_NSS_NISPLUS))
	install $(BUILDDIR)/$(GLIBC)-ldso/nis/libnss_nisplus.so.2 $(ROOTDIR)/lib
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libnss_nisplus.so.2
        endif
        ifeq (y, $(PTXCONF_GLIBC_NSS_COMPAT))
	install $(BUILDDIR)/$(GLIBC)-ldso/nis/libnss_compat.so.2 $(ROOTDIR)/lib
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libnss_compat.so.2
        endif
        ifeq (y, $(PTXCONF_GLIBC_RESOLV))
	install $(BUILDDIR)/$(GLIBC)-ldso/resolv/libresolv.so $(ROOTDIR)/lib/libresolv.so.$(GLIBC_VERSION)
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libresolv.so.$(GLIBC_VERSION)
	ln -sf libresolv.so.$(GLIBC_VERSION) $(ROOTDIR)/lib/libresolv.so
        endif
        ifeq (y, $(PTXCONF_GLIBC_NSL))
	install $(BUILDDIR)/$(GLIBC)-ldso/nis/libnsl.so $(ROOTDIR)/lib/libnsl.so.$(GLIBC_VERSION)
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libnsl.so.$(GLIBC_VERSION)
	ln -sf libnsl.so.$(GLIBC_VERSION) $(ROOTDIR)/lib/libnsl.so
	ln -sf libnsl.so.$(GLIBC_VERSION) $(ROOTDIR)/lib/libnsl.so.1
        endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glibc_clean: 
	-rm -rf $(STATEDIR)/glibc* 
	-rm -rf $(GLIBC_DIR) 
	-rm -rf $(BUILDDIR)/$(GLIBC)-obj 
	-rm -rf $(BUILDDIR)/$(GLIBC)-ldso

# vim: syntax=make
