# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de> for
#                       GYRO net GmbH <info@gyro-net.de>, Hannover, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_KAFFE
PACKAGES += kaffe
endif

#
# Paths and names
#
KAFFE_VERSION		= 1.1.0
KAFFE			= kaffe-$(KAFFE_VERSION)
KAFFE_SUFFIX		= tar.gz
KAFFE_URL		= http://www.kaffe.org/ftp/pub/kaffe/v1.1.x-development/$(KAFFE).$(KAFFE_SUFFIX)
KAFFE_SOURCE		= $(SRCDIR)/$(KAFFE).$(KAFFE_SUFFIX)
KAFFE_DIR		= $(BUILDDIR)/$(KAFFE)
KAFFE_BUILDDIR		= $(BUILDDIR)/$(KAFFE)-build

KAFFE_KANGAROO_VERSION	= 0.0.3-user
KAFFE_KANGAROO		= kangaroo-$(KAFFE_KANGAROO_VERSION)
KAFFE_KANGAROO_SUFFIX	= tar.gz
KAFFE_KANGAROO_URL	= http://playground.gyro-net.de/kangaroo/$(KAFFE_KANGAROO).$(KAFFE_KANGAROO_SUFFIX)
KAFFE_KANGAROO_SOURCE	= $(SRCDIR)/$(KAFFE_KANGAROO).$(KAFFE_KANGAROO_SUFFIX)
KAFFE_KANGAROO_DIR	= $(BUILDDIR)/$(KAFFE_KANGAROO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kaffe_get: $(STATEDIR)/kaffe.get

kaffe_get_deps	=  $(KAFFE_SOURCE)
ifdef PTXCONF_KAFFE_API_CLDC
kaffe_get_deps	+= $(KAFFE_KANGAROO_SOURCE)
endif

$(STATEDIR)/kaffe.get: $(kaffe_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KAFFE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KAFFE_URL))

$(KAFFE_KANGAROO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KAFFE_KANGAROO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

kaffe_extract: $(STATEDIR)/kaffe.extract

kaffe_extract_deps	=  $(STATEDIR)/kaffe-base.extract
ifdef PTXCONF_KAFFE_API_CLDC
kaffe_extract_deps	+= $(STATEDIR)/kaffe-kangaroo.extract
endif

$(STATEDIR)/kaffe.extract: $(kaffe_extract_deps)
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/kaffe-base.extract: $(STATEDIR)/kaffe.get
	@$(call targetinfo, $@)
	@$(call clean, $(KAFFE_DIR))
	@$(call extract, $(KAFFE_SOURCE))
	touch $@

$(STATEDIR)/kaffe-kangaroo.extract: $(STATEDIR)/kaffe.get
	@$(call targetinfo, $@)
	@$(call clean, $(KAFFE_KANGAROO_DIR))
	@$(call extract, $(KAFFE_KANGAROO_SOURCE))
	cp -a $(BUILDDIR)/$(KAFFE_KANGAROO)/* $(BUILDDIR)/$(KAFFE)
	rm -rf $(BUILDDIR)/$(KAFFE_KANGAROO)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

kaffe_prepare: $(STATEDIR)/kaffe.prepare

#
# dependencies
#
kaffe_prepare_deps =  \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/xchain-kaffe.install \
	$(STATEDIR)/kaffe.extract

ifndef PTXCONF_KAFFE_FEAT_JAVAMATH
kaffe_prepare_deps	+= $(STATEDIR)/gmp3.install
endif
ifdef PTXCONF_KAFFE_FEAT_CLDC_GMP
kaffe_prepare_deps	+= $(STATEDIR)/gmp3.install
endif

KAFFE_PATH	= PATH=$(CROSS_PATH)
KAFFE_ENV 	= $(CROSS_ENV) KAFFEH=$(PTXCONF_PREFIX)/bin/kaffeh

#
# autoconf
#
KAFFE_AUTOCONF  =  $(CROSS_KAFFEE)
KAFFE_AUTOCONF  += --prefix=/usr

ifdef PTXCONF_KAFFE_ENG_INTRP
KAFFE_AUTOCONF	+= --with-engine=intrp
endif
ifdef PTXCONF_KAFFE_ENG_JIT
KAFFE_AUTOCONF	+= --with-engine=jit
endif
ifdef PTXCONF_KAFFE_ENG_JIT3
KAFFE_AUTOCONF	+= --with-engine=jit3
endif

ifdef PTXCONF_KAFFE_THREAD_P
KAFFE_AUTOCONF	+= --with-threads=unix-pthreads
endif
ifdef PTXCONF_KAFFE_THREAD_J
KAFFE_AUTOCONF	+= --with-threads=unix-jthreads
endif

ifdef PTXCONF_KAFFE_JIKES
KAFFE_AUTOCONF	+= --with-jikes=$(PTXCONF_KAFFE_JIKES)
endif

# ifdef PTXCONF_KAFFE_API_SE
# KAFFE_AUTOCONF	+= --with-api=se
# endif
ifdef PTXCONF_KAFFE_API_CLDC
KAFFE_AUTOCONF	+= --with-api=cldc
endif

ifdef PTXCONF_KAFFE_DEB_DEV
KAFFE_AUTOCONF	+= --enable-debug
else
KAFFE_AUTOCONF	+= --disable-debug
endif
ifdef PTXCONF_KAFFE_DEB_X
KAFFE_AUTOCONF	+= --enable-xdebugging
else
KAFFE_AUTOCONF	+= --disable-xdebugging
endif
ifdef PTXCONF_KAFFE_DEB_PROFILING
KAFFE_AUTOCONF	+= --with-profiling
else
KAFFE_AUTOCONF	+= --without--profiling
endif
ifdef PTXCONF_KAFFE_DEB_XPROFILING
KAFFE_AUTOCONF	+= --enable-xprofiling
else
KAFFE_AUTOCONF	+= --disable-xprofiling
endif
ifdef PTXCONF_KAFFE_DEB_STATS
KAFFE_AUTOCONF	+= --with-stats
else
KAFFE_AUTOCONF	+= --without-stats
endif

ifdef PTXCONF_KAFFE_FEAT_GCJ
KAFFE_AUTOCONF	+= --enable-gcj
else
KAFFE_AUTOCONF	+= --disable-gcj
endif

ifdef PTXCONF_KAFFE_AWT_NO
KAFFE_AUTOCONF	+= --without-x --with-awt=no
endif 
ifdef PTXCONF_KAFFE_AWT_X
KAFFE_AUTOCONF	+= --with-awt=X
endif
ifdef PTXCONF_KAFFE_AWT_QT
KAFFE_AUTOCONF	+= --with-awt=qt
endif

ifdef PTXCONF_KAFFE_FEAT_FEEDBACK
KAFFE_AUTOCONF	+= --enable-feedback
else
KAFFE_AUTOCONF	+= --disable-feedback
endif
ifdef PTXCONF_KAFFE_FEAT_JAVAMATH
KAFFE_AUTOCONF	+= --enable-pure-java-math
else
KAFFE_AUTOCONF	+= --disable-pure-java-math
endif

ifdef PTXCONF_KAFFE_FEAT_DISABLE_SOUND
KAFFE_AUTOCONF	+= --disable-sound
endif
ifdef PTXCONF_KAFFE_FEAT_DISABLE_ALSA
KAFFE_AUTOCONF	+= --without-alsa
endif
ifdef PTXCONF_KAFFE_FEAT_DISABLE_ESD
KAFFE_AUTOCONF	+= --without-esd
endif
ifdef PTXCONF_KAFFE_FEAT_DISABLE_SUNCOMPAT
KAFFE_AUTOCONF	+= --without-suncompat
endif

ifdef PTXCONF_KAFFE_FEAT_CLDC_GMP
KAFFE_AUTOCONF	+= --enable-cldc-bigint
endif

ifdef PTXCONF_KAFFE_FEAT_CLDC_COMM
KAFFE_AUTOCONF	+= --enable-cldc-comm
endif

ifdef PTXCONF_KAFFE_LINK_BIN
KAFFE_AUTOCONF	+= --with-staticbin
endif
ifdef PTXCONF_KAFFE_LINK_VM
KAFFE_AUTOCONF	+= --with-staticvm
endif
ifdef PTXCONF_KAFFE_LINK_LIB
KAFFE_AUTOCONF	+= --with-staticlib
endif

$(STATEDIR)/kaffe.prepare: $(kaffe_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(KAFFE_BUILDDIR))
	mkdir -p $(KAFFE_BUILDDIR)
	cd $(KAFFE_BUILDDIR) && \
		$(KAFFE_PATH) $(KAFFE_ENV) \
		$(KAFFE_DIR)/configure $(KAFFE_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

kaffe_compile: $(STATEDIR)/kaffe.compile

kaffe_compile_deps =  $(STATEDIR)/kaffe.prepare

ifdef KAFFE_JIKES_WO_DEBUG
KAFFE_MAKEVARS	= JAVAC_FLAGS="-g:none -verbose"
else
KAFFE_MAKEVARS	= JAVAC_FLAGS="-verbose"
endif

$(STATEDIR)/kaffe.compile: $(kaffe_compile_deps)
	@$(call targetinfo, $@)
	$(KAFFE_PATH) make -C $(KAFFE_BUILDDIR) $(KAFFE_MAKEVARS)

ifdef PTXCONF_KAFFE_LINK_GMP
#
# what we here do is:
# - in the .la file is a list of libs this lib depends on
# - during linking this lib against the kaffe-bin, it is passed to the linker
# - we replace the shared library (-lgmp or libgmp.la) with the static one (/path/to/libgmp.a)
#
	perl -i -p -e 's,((\s-lgmp)|(\s.*libgmp.la)), $(CROSS_LIB_DIR)/lib/libgmp.a,' \
		$(KAFFE_BUILDDIR)/libraries/clib-cldc/native/libnative.la
	$(KAFFE_PATH) make -C $(KAFFE_BUILDDIR) $(KAFFE_MAKEVARS)
endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kaffe_install: $(STATEDIR)/kaffe.install

$(STATEDIR)/kaffe.install: $(STATEDIR)/kaffe.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

kaffe_targetinstall: $(STATEDIR)/kaffe.targetinstall

kaffe_targetinstall_deps	=  $(STATEDIR)/kaffe.compile

ifdef PTXCONF_KAFFE_TARGETINSTALL_GMP
kaffe_targetinstall_deps	+= $(STATEDIR)/gmp3.targetinstall
endif

$(STATEDIR)/kaffe.targetinstall: $(kaffe_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(KAFFE_BUILDDIR)-tmp)
	mkdir -p $(ROOTDIR)/usr/jre/bin
	mkdir -p $(ROOTDIR)/usr/jre/lib/$(PTXCONF_ARCH_USERSPACE)

	$(KAFFE_PATH) make -C $(KAFFE_BUILDDIR) $(KAFFE_MAKEVARS) \
		install DESTDIR=$(KAFFE_BUILDDIR)-tmp

	install $(KAFFE_BUILDDIR)-tmp/usr/jre/bin/kaffe-bin \
		$(ROOTDIR)/usr/jre/bin/kaffe-bin
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/jre/bin/kaffe-bin

	install $(KAFFE_BUILDDIR)-tmp/usr/jre/bin/kaffe \
		$(ROOTDIR)/usr/jre/bin/kaffe

	rm -rf $(KAFFE_BUILDDIR)-tmp/usr/jre/lib/$(PTXCONF_ARCH_USERSPACE)/libkaffevm.la
	rm -rf $(KAFFE_BUILDDIR)-tmp/usr/jre/lib/$(PTXCONF_ARCH_USERSPACE)/*.a

ifdef PTXCONF_KAFFE_LINK_VM
	rm -rf $(KAFFE_BUILDDIR)-tmp/usr/jre/lib/$(PTXCONF_ARCH_USERSPACE)/libkaffevm*
endif

ifdef PTXCONF_KAFFE_LINK_LIB
	rm -rf $(KAFFE_BUILDDIR)-tmp/usr/jre/lib/$(PTXCONF_ARCH_USERSPACE)/libkaffevm*
endif

ifdef PTXCONF_KAFFE_LINK_BIN
	rm -rf $(KAFFE_BUILDDIR)-tmp/usr/jre/lib/$(PTXCONF_ARCH_USERSPACE)/libkaffevm*
endif

	cp -av $(KAFFE_BUILDDIR)-tmp/usr/jre/lib/* $(ROOTDIR)/usr/jre/lib/
	$(CROSS_STRIP) -R .note -R .comment \
		$(ROOTDIR)/usr/jre/lib/$(PTXCONF_ARCH_USERSPACE)/*.so || true

	rm -rf $(KAFFE_BUILDDIR)-tmp
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kaffe_clean:
	rm -rf $(STATEDIR)/kaffe*
	rm -rf $(KAFFE_DIR)
	rm -rf $(KAFFE_BUILDDIR)
	rm -rf $(KAFFE_KANGAROO_DIR)

# vim: syntax=make
