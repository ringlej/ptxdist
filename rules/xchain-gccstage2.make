# -*-makefile-*-
# $Id: xchain-gccstage2.make,v 1.21 2003/11/17 03:43:08 mkl Exp $
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_BUILD_CROSSCHAIN
XCHAIN += xchain-gccstage2
endif

#
# Paths and names 
#
GCC_STAGE2_DIR		= $(BUILDDIR)/$(GCC)-$(PTXCONF_GNU_TARGET)-stage2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-gccstage2_get: $(STATEDIR)/xchain-gccstage2.get

$(STATEDIR)/xchain-gccstage2.get: $(xchain-gccstate1_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-gccstage2_extract: $(STATEDIR)/xchain-gccstage2.extract

$(STATEDIR)/xchain-gccstage2.extract: $(STATEDIR)/xchain-gccstage1.extract
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-gccstage2_prepare: $(STATEDIR)/xchain-gccstage2.prepare

xchain-gccstage2_prepare_deps =  $(STATEDIR)/xchain-gccstage2.extract

ifdef PTXCONF_GLIBC
xchain-gccstage2_prepare_deps += $(STATEDIR)/glibc.install
endif
ifdef PTXCONF_UCLIBC
xchain-gccstage2_prepare_deps += $(STATEDIR)/uclibc.install
endif

GCC_STAGE2_PATH	= PATH=$(CROSS_PATH)
GCC_STAGE2_ENV	= $(HOSTCC_ENV)

#
# Robert Schwebel says:
#
# why do we have to define _GNU_SOURCE here? Otherwhise 
# the c++ compiler cannot be compiled. occours in 2.95.3
#
# the error looks like this:
# /home/frogger/projects/ptxdist/ptxdist-generic/build/gcc-2.95.3-i386-linux-stage2/gcc/xgcc
# -B/home/frogger/projects/ptxdist/ptxdist-generic/build/gcc-2.95.3-i386-linux-stage2/gcc/
# -B/home/frogger/ptxdist/xchain/generic/i386-linux/bin/ -c -g -Os
# -fno-implicit-templates
# -I. -I/home/frogger/projects/ptxdist/ptxdist-generic/build/gcc-2.95.3/libio
# -nostdinc++ -D_IO_MTSAFE_IO -fpic
# /home/frogger/projects/ptxdist/ptxdist-generic/build/gcc-2.95.3/libio/iostream.cc
# -o pic/iostream.o
# /home/frogger/projects/ptxdist/ptxdist-generic/build/gcc-2.95.3/libio/iostream.cc:
# In method `class istream & istream::get(char &)':
# /home/frogger/projects/ptxdist/ptxdist-generic/build/gcc-2.95.3/libio/iostream.cc:75:
# `_pthread_cleanup_push_defer' undeclared (first use this function)
# /home/frogger/projects/ptxdist/ptxdist-generic/build/gcc-2.95.3/libio/iostream.cc:75:
# (Each undeclared identifier is reported only once
# /home/frogger/projects/ptxdist/ptxdist-generic/build/gcc-2.95.3/libio/iostream.cc:75:
# for each function it appears in.)
# /home/frogger/projects/ptxdist/ptxdist-generic/build/gcc-2.95.3/libio/iostream.cc:86:
# implicit declaration of function `int
# _pthread_cleanup_pop_restore(...)'
#
ifdef PTXCONF_GCC_2_95_3
GCC_STAGE2_MAKEVARS	= CXXFLAGS_FOR_TARGET="-D_GNU_SOURCE"
endif

GCC_STAGE2_AUTOCONF_THREADS = --disable-threads
ifdef PTXCONF_GLIBC_PTHREADS
GCC_STAGE2_AUTOCONF_THREADS = --enable-threads=posix
endif
ifdef PTXCONF_UCLIBC_UCLIBC_HAS_THREADS
GCC_STAGE2_AUTOCONF_THREADS = --enable-threads=posix
endif

GCC_STAGE2_AUTOCONF = \
	--target=$(PTXCONF_GNU_TARGET) \
	--host=$(GNU_HOST) \
	--build=$(GNU_HOST) \
	--prefix=$(PTXCONF_PREFIX) \
	--with-local-prefix=$(CROSS_LIB_DIR) \
	$(GCC_EXTRA_CONFIG) \
	$(GCC_STAGE2_AUTOCONF_THREADS) \
	--with-headers=$(CROSS_LIB_DIR)/include \
	--disable-nls \
	--disable-multilib \
	--enable-symvers=gnu \
	--enable-target-optspace \
	--enable-c99 \
	--enable-long-long

ifdef PTXCONF_LIBSTDCXX_SHARED
GCC_STAGE2_AUTOCONF	+= --enable-shared
else
GCC_STAGE2_AUTOCONF	+= --disable-shared
endif

#
# build C++ by default
#
# ifdef PTXCONF_CXX
GCC_STAGE2_AUTOCONF	+= --enable-languages="c,c++"
# else
# GCC_STAGE2_AUTOCONF	+= --enable-languages="c"
# endif

ifdef PTXCONF_GLIBC
GCC_STAGE2_AUTOCONF	+= --enable-__cxa_atexit
endif
ifdef PTXCONF_UCLIBC
GCC_STAGE2_AUTOCONF	+= --disable-__cxa_atexit
endif

$(STATEDIR)/xchain-gccstage2.prepare: $(xchain-gccstage2_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GCC_STAGE2_DIR))

	mkdir -p $(GCC_STAGE2_DIR)
	cd $(GCC_STAGE2_DIR) &&	\
	     	$(GCC_STAGE2_PATH) $(GCC_STAGE2_ENV) \
		$(GCC_DIR)/configure $(GCC_STAGE2_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-gccstage2_compile: $(STATEDIR)/xchain-gccstage2.compile

$(STATEDIR)/xchain-gccstage2.compile: $(STATEDIR)/xchain-gccstage2.prepare
	@$(call targetinfo, $@)
	$(GCC_STAGE2_PATH) make -C $(GCC_STAGE2_DIR) $(GCC_STAGE2_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-gccstage2_install: $(STATEDIR)/xchain-gccstage2.install

$(STATEDIR)/xchain-gccstage2.install: $(STATEDIR)/xchain-gccstage2.compile
	@$(call targetinfo, $@)
	$(GCC_STAGE2_PATH) make -C $(GCC_STAGE2_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-gccstage2_targetinstall: $(STATEDIR)/xchain-gccstage2.targetinstall

ifdef PTXCONF_BUILD_CROSSCHAIN
xchain-gccstage2_targetinstall_deps = $(STATEDIR)/xchain-gccstage2.install
endif

$(STATEDIR)/xchain-gccstage2.targetinstall: $(xchain-gccstage2_targetinstall_deps)
	@$(call targetinfo, $@)
ifdef PTXCONF_LIBSTDCXX_SHARED
	mkdir -p $(ROOTDIR)/usr/lib

	for FILE in											\
		`find $(CROSS_LIB_DIR)/lib/ -name "libgcc_s[-.]*so*"`					\
		`find $(PTXCONF_PREFIX)/lib/gcc-lib/$(PTXCONF_GNU_TARGET)/ -name "libgcc_s[-.]*so*"`	\
		;do											\
			cp -d $$FILE $(ROOTDIR)/lib/;							\
			chmod 755 $$FILE;								\
			$(CROSSSTRIP) -R .note -R .comment $$FILE;					\
	done

#
# gcc-2.95.3 has weird permission on libstdc++
# chmod 755 fixes that
#
	for FILE in											\
		`find $(CROSS_LIB_DIR)/lib/ -name "libstdc++[-.]*so*"`					\
		`find $(PTXCONF_PREFIX)/lib/gcc-lib/$(PTXCONF_GNU_TARGET)/ -name "libstdc++[-.]*so*"`	\
		;do											\
			cp -d $$FILE $(ROOTDIR)/usr/lib/;						\
			chmod 755 $$FILE;								\
			$(CROSSSTRIP) -R .note -R .comment $$FILE;					\
	done
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-gccstage2_clean:
	rm -fr $(GCC_STAGE2_DIR) $(STATEDIR)/xchain-gccstage2.* 

# vim: syntax=make
