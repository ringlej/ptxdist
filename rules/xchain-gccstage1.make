# -*-makefile-*-
# $Id: xchain-gccstage1.make,v 1.10 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# Paths and names 
#
# version stuff in now in rules/Version.make
# NB: make s*cks
#
GCC			=  gcc-$(GCC_VERSION)
GCC_URL			=  ftp://ftp.gnu.org/pub/gnu/gcc/$(GCC).tar.gz
GCC_SOURCE		=  $(SRCDIR)/$(GCC).tar.gz
GCC_DIR			=  $(BUILDDIR)/$(GCC)
GCC_STAGE1_DIR		=  $(BUILDDIR)/$(GCC)-$(PTXCONF_GNU_TARGET)-stage1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-gccstage1_get: $(STATEDIR)/xchain-gccstage1.get

xchain-gccstage1_get_deps = \
	$(GCC_SOURCE) \
	$(STATEDIR)/xchain-gccstage1-patches.get

$(STATEDIR)/xchain-gccstage1.get: $(xchain-gccstage1_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/xchain-gccstage1-patches.get:
	@$(call targetinfo, $@)
	@$(call get_patches, $(GCC))
	touch $@

$(GCC_SOURCE): 
	@$(call targetinfo, $@)
	@$(call get, $(GCC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-gccstage1_extract: $(STATEDIR)/xchain-gccstage1.extract

xchain-gccstage1_extract_deps = $(STATEDIR)/xchain-gccstage1.get

$(STATEDIR)/xchain-gccstage1.extract: $(xchain-gccstage1_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GCC_DIR))
	@$(call extract, $(GCC_SOURCE))
	@$(call patchin, $(GCC))

#
# sto^H^H^Hinspired by Erik Andersen's buildroot
#

#
# Hack things to use the correct shared lib loader
#
	cd $(GCC_DIR) && \
		export LIST=`grep -lr -- "-dynamic-linker.*\.so[\.0-9]*" *` && \
		if [ -n "$$LIST" ] ; then \
			perl -i -p -e "s,-dynamic-linker.*\.so[\.0-9]*},-dynamic-linker $(DYNAMIC_LINKER)},;" $$LIST; \
		fi;

#
# Prevent system glibc start files from leaking in uninvited...
#
	perl -i -p -e "s,standard_startfile_prefix_1 = \".*,standard_startfile_prefix_1 =\"$(CROSS_LIB_DIR)/lib/\";,;" \
		$(GCC_DIR)/gcc/gcc.c;
	perl -i -p -e "s,standard_startfile_prefix_2 = \".*,standard_startfile_prefix_2 =\"$(CROSS_LIB_DIR)/usr/lib/\";,;" \
		$(GCC_DIR)/gcc/gcc.c;

#
# Prevent system glibc include files from leaking in uninvited...
#
	perl -i -p -e "s,^NATIVE_SYSTEM_HEADER_DIR.*,NATIVE_SYSTEM_HEADER_DIR=$(CROSS_LIB_DIR)/include,;" $(GCC_DIR)/gcc/Makefile.in;
	perl -i -p -e "s,^CROSS_SYSTEM_HEADER_DIR.*,CROSS_SYSTEM_HEADER_DIR=$(CROSS_LIB_DIR)/include,;" $(GCC_DIR)/gcc/Makefile.in;
	cd $(GCC_DIR) && \
		export LIST=`grep -lr -- "define STANDARD_INCLUDE_DIR" *` && \
		if [ -n "$$LIST" ] ; then \
			perl -i -p -e "s,^#\s*define.*STANDARD_INCLUDE_DIR.*,#define STANDARD_INCLUDE_DIR \"$(CROSS_LIB_DIR)/include\",;" $$LIST; \
		fi;

#
# Prevent system glibc libraries from being found by collect2 
# when it calls locatelib() and rummages about the system looking 
# for libraries with the correct name...
#
	perl -i -p -e "s,\"/lib,\"$(CROSS_LIB_DIR)/lib,g;" $(GCC_DIR)/gcc/collect2.c
	perl -i -p -e "s,\"/usr/,\"$(CROSS_LIB_DIR)/usr/,g;" $(GCC_DIR)/gcc/collect2.c


ifdef PTXCONF_UCLIBC
#
# Prevent gcc from using the unwind-dw2-fde-glibc code
#
	perl -i -p -e "s,^#ifndef inhibit_libc,#define inhibit_libc\n#ifndef inhibit_libc,g;" $(GCC_DIR)/gcc/unwind-dw2-fde-glibc.c;
endif


ifdef PTXCONF_UCLIBC
ifdef PTXCONF_GCC_2_95_3
#
# Use atexit() directly, rather than cxa_atexit
#
	perl -i -p -e "s,int flag_use_cxa_atexit = 1;,int flag_use_cxa_atexit = 0;,g;"\
		$(GCC_DIR)/gcc/cp/decl2.c;
#
# We do not wish to build the libstdc++ library provided with gcc,
# since it doesn't seem to work at all with uClibc plus gcc 2.95...
#
	mv $(GCC_DIR)/libstdc++ $(GCC_DIR)/libstdc++.orig
	mv $(GCC_DIR)/libio $(GCC_DIR)/libio.orig
endif # PTXCONFIG_GCC_2_95_3

ifdef PTXCONF_GCC_3_2_3
#
# Hack up the soname for libstdc++
# 
	perl -i -p -e "s,\.so\.1,.so.0.9.9,g;" $(GCC_DIR)/gcc/config/t-slibgcc-elf-ver;
	perl -i -p -e "s,-version-info.*[0-9]:[0-9]:[0-9],-version-info 9:9:0,g;" \
		$(GCC_DIR)/libstdc++-v3/src/Makefile.am $(GCC_DIR)/libstdc++-v3/src/Makefile.in;
	perl -i -p -e "s,3\.0\.0,9.9.0,g;" $(GCC_DIR)/libstdc++-v3/acinclude.m4 \
		$(GCC_DIR)/libstdc++-v3/aclocal.m4 $(GCC_DIR)/libstdc++-v3/configure;
#
# For now, we don't support locale-ified ctype (we will soon), 
# so bypass that problem for now...
#
	perl -i -p -e "s,defined.*_GLIBCPP_USE_C99.*,1,g;" \
		$(GCC_DIR)/libstdc++-v3/config/locale/generic/c_locale.cc;
	cp $(GCC_DIR)/libstdc++-v3/config/os/generic/bits/ctype_base.h \
		$(GCC_DIR)/libstdc++-v3/config/os/gnu-linux/bits/
	cp $(GCC_DIR)/libstdc++-v3/config/os/generic/bits/ctype_inline.h \
		$(GCC_DIR)/libstdc++-v3/config/os/gnu-linux/bits/
	cp $(GCC_DIR)/libstdc++-v3/config/os/generic/bits/ctype_noninline.h \
		$(GCC_DIR)/libstdc++-v3/config/os/gnu-linux/bits/

endif # PTXCONF_GCC_3_2_3
endif # PTXCON_UCLIBC
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-gccstage1_prepare: $(STATEDIR)/xchain-gccstage1.prepare

xchain-gccstage1_prepare_deps = \
	$(STATEDIR)/xchain-binutils.install \
	$(STATEDIR)/xchain-kernel.install \
	$(STATEDIR)/xchain-gccstage1.extract
#
# Dan Kegel says:
#
# Only need to install bootstrap glibc headers for gcc-3.0 and above?
# Or maybe just gcc-3.3 and above? This will change for gcc-3.5, I
# think (I hope). See also http://gcc.gnu.org/PR8180, which complains
# about the need for this step. Don't install them if they're already
# there (it's really slow)
#
# Comments:
# gcc-3.2.3 for PPC needs some headers (or a patch that disables the
# #include of the headers)
#
# you will get an error like this:
#
# /home/frogger/projects/ptxdist/ptxdist-ppc/build/gcc-3.2.3-powerpc-405-linux-gnu-stage1/gcc/xgcc
# [...]
# /home/frogger/projects/ptxdist/ptxdist-ppc/build/gcc-3.2.3/gcc/libgcc2.c
# -o libgcc/./_muldi3.o
#
# In file included from tconfig.h:21,
#                 from /home/frogger/projects/ptxdist/ptxdist-ppc/build/gcc-3.2.3/gcc/libgcc2.c:36:
# /home/frogger/projects/ptxdist/ptxdist-ppc/build/gcc-3.2.3/gcc/config/rs6000/linux.h:82:20: signal.h: No such file or directory
# /home/frogger/projects/ptxdist/ptxdist-ppc/build/gcc-3.2.3/gcc/config/rs6000/linux.h:83:26: sys/ucontext.h: No such file or directory
# make[3]: *** [libgcc/./_muldi3.o] Error 1
#
ifdef PTXCONF_GLIBC 
ifeq (3,$(GCC_VERSION_MAJOR))
xchain-gccstage1_prepare_deps += $(STATEDIR)/xchain-glibc.install
endif
endif

GCC_STAGE1_PATH	= PATH=$(CROSS_PATH)
GCC_STAGE1_ENV	= $(HOSTCC_ENV)

GCC_STAGE1_AUTOCONF = \
	--target=$(PTXCONF_GNU_TARGET) \
	--host=$(GNU_HOST) \
	--build=$(GNU_HOST) \
	--prefix=$(PTXCONF_PREFIX) \
	--with-local-prefix=$(CROSS_LIB_DIR) \
	$(GCC_EXTRA_CONFIG) \
	--disable-nls \
	--disable-multilib \
	--disable-threads \
	--disable-shared \
	--enable-languages=c \
	--enable-symvers=gnu \
	--enable-target-optspace \
	--enable-version-specific-runtime-libs \
	--with-newlib \
        --without-headers \
	--with-gnu-ld

ifdef PTXCONF_GLIBC
GCC_STAGE1_AUTOCONF	+= --enable-__cxa_atexit
endif

ifdef PTXCONF_UCLIBC
GCC_STAGE1_AUTOCONF	+= --disable-__cxa_atexit
endif

#
# FIXME: "configure: line 193: cd: no: No such file or directory"
#
# cd /home/frogger/ptxdist/ptxdist-i386/build/gcc-3.2.3-"i386-linux"-stage1 && \
#        PATH="/home/frogger/ptxdist/xchain/i386"/bin:$PATH CC=gcc \
#
# /home/frogger/ptxdist/ptxdist-i386/build/gcc-3.2.3/configure
# --target="i386-linux" --host=powerpc-host-linux-gnu
# --build=powerpc-host-linux-gnu
# --prefix="/home/frogger/ptxdist/xchain/i386"
# --with-local-prefix="/home/frogger/ptxdist/xchain/i386"/"i386-linux"
# --disable-nls --disable-multilib --disable-threads --disable-shared
# --enable-languages=c --enable-symvers=gnu --enable-target-optspace
# --enable-version-specific-runtime-libs --with-newlib
# --without-headers --with-gnu-ld --enable-__cxa_atexit Copying no to
# /home/frogger/ptxdist/xchain/i386/i386-linux/sys-include
# /home/frogger/ptxdist/ptxdist-i386/build/gcc-3.2.3/configure: line
# 193: cd: no: No such file or directory
#
$(STATEDIR)/xchain-gccstage1.prepare: $(xchain-gccstage1_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GCC_STAGE1_DIR))
	[ -d $(GCC_STAGE1_DIR) ] || mkdir -p $(GCC_STAGE1_DIR)

	cd $(GCC_STAGE1_DIR) && 					\
		$(GCC_STAGE1_PATH) $(GCC_STAGE1_ENV)			\
		$(GCC_DIR)/configure $(GCC_STAGE1_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-gccstage1_compile: $(STATEDIR)/xchain-gccstage1.compile

$(STATEDIR)/xchain-gccstage1.compile: $(STATEDIR)/xchain-gccstage1.prepare
	@$(call targetinfo, $@)
	cd $(GCC_STAGE1_DIR) && \
		$(GCC_STAGE1_PATH) \
		make all-gcc
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-gccstage1_install: $(STATEDIR)/xchain-gccstage1.install

$(STATEDIR)/xchain-gccstage1.install: $(STATEDIR)/xchain-gccstage1.compile
	@$(call targetinfo, $@)
	cd $(GCC_STAGE1_DIR) &&	\
		$(GCC_STAGE1_PATH) $(GCC_STAGE1_ENV) \
		make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-gccstage1_targetinstall: $(STATEDIR)/xchain-gccstage1.targetinstall

$(STATEDIR)/xchain-gccstage1.targetinstall:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-gccstage1_clean:
	rm -fr $(GCC_STAGE1_DIR)
	rm -fr $(STATEDIR)/xchain-gccstage1.*
	rm -fr $(GCC_DIR)

# vim: syntax=make
