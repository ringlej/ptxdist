# -*-makefile-*-
# $Id: xchain-gccstage1.make,v 1.7 2003/08/14 10:02:18 mkl Exp $
#
# (c) 2002,2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#

ifdef PTXCONF_GCC_2_95_3
GCC_VERSION		= 2.95.3
endif
ifdef PTXCONF_GCC_3_2_3
GCC_VERSION		= 3.2.3
endif

#
# Paths and names 
GCC_PREFIX		= $(PTXCONF_GNU_TARGET)-
GCC			= gcc-$(GCC_VERSION)
GCC_URL			= ftp://ftp.gnu.org/pub/gnu/gcc/$(GCC).tar.gz
GCC_SOURCE		= $(SRCDIR)/$(GCC).tar.gz
GCC_DIR			= $(BUILDDIR)/$(GCC)
GCC_STAGE1_DIR		= $(BUILDDIR)/$(GCC)-$(GCC_PREFIX)stage1
GCC_STAGE2_DIR		= $(BUILDDIR)/$(GCC)-$(GCC_PREFIX)stage2

GCC_ARMPATCH		= gcc-2.95.3.diff
GCC_ARMPATCH_URL	= ftp://ftp.arm.linux.org.uk/pub/armlinux/toolchain/src-2.95.3/$(GCC_ARMPATCH).bz2
GCC_ARMPATCH_SOURCE	= $(SRCDIR)/$(GCC_ARMPATCH).bz2
GCC_ARMPATCH_DIR	= $(GCC_DIR)
GCC_ARMPATCH_EXTRACT	= bzip2 -dc

GCC_PATCH		= gcc-2.95.3-2.patch
GCC_PATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GCC_PATCH).bz2
GCC_PATCH_SOURCE	= $(SRCDIR)/$(GCC_PATCH).bz2
GCC_PATCH_DIR		= $(GCC_DIR)
GCC_PATCH_EXTRACT	= bzip2 -dc

GCC_PPCPATCH		= gcc-3.2.3-ppc-mkb1.patch
GCC_PPCPATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GCC_PPCPATCH)
GCC_PPCPATCH_SOURCE	= $(SRCDIR)/$(GCC_PPCPATCH)
GCC_PPCPATCH_DIR	= $(GCC_DIR)
GCC_PPCPATCH_EXTRACT	= cat

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-gccstage1_get: $(STATEDIR)/xchain-gccstage1.get

xchain-gccstage1_get_deps =  $(GCC_SOURCE)
ifdef PTXCONF_GCC_2_95_3
xchain-gccstage1_get_deps += $(GCC_PATCH_SOURCE)
endif
ifdef PTXCONF_ARCH_ARM
xchain-gccstage1_get_deps += $(GCC_ARMPATCH_SOURCE)
endif
ifdef PTXCONF_ARCH_PPC
xchain-gccstage1_get_deps += $(GCC_PPCPATCH_SOURCE)
endif

$(STATEDIR)/xchain-gccstage1.get: $(xchain-gccstage1_get_deps)
	@$(call targetinfo, xchain-gccstage1.get)
	touch $@

$(GCC_SOURCE): 
	@$(call targetinfo, $(GCC_SOURCE))
	@$(call get, $(GCC_URL))

$(GCC_PATCH_SOURCE):
	@$(call targetinfo, $(GCC_PATCH_SOURCE))
	@$(call get, $(GCC_PATCH_URL))

$(GCC_ARMPATCH_SOURCE): 
	@$(call targetinfo, $(GCC_ARMPATCH_SOURCE))
	@$(call get, $(GCC_ARMPATCH_URL))

$(GCC_PPCPATCH_SOURCE): 
	@$(call targetinfo, $(GCC_PPCPATCH_SOURCE))
	@$(call get, $(GCC_PPCPATCH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-gccstage1_extract: $(STATEDIR)/xchain-gccstage1.extract

xchain-gccstage1_extract_deps = $(STATEDIR)/xchain-gccstage1.get

$(STATEDIR)/xchain-gccstage1.extract: $(xchain-gccstage1_extract_deps)
	@$(call targetinfo, xchain-gccstage1.extract)
	@$(call clean, $(GCC_DIR))

	@$(call extract, $(GCC_SOURCE))

        ifdef PTXCONF_GCC_2_95_3
        ifdef PTXCONF_ARCH_ARM
	#
	# ARM: add architecure patch
	# 
	cd $(GCC_DIR) && \
		$(GCC_ARMPATCH_EXTRACT) $(GCC_ARMPATCH_SOURCE) | patch -p1
#         else #PTXCONF_ARCH_ARM
	cd $(GCC_DIR) && \
		$(GCC_PATCH_EXTRACT) $(GCC_PATCH_SOURCE) | patch -p1
        endif #PTXCONF_ARCH_ARM
        endif #PTXCONF_GCC_2_95_3


        ifdef PTXCONF_GCC_3_2_3
        ifdef PTXCONF_ARCH_PPC
	cd $(GCC_DIR) && \
		$(GCC_PPCPATCH_EXTRACT) $(GCC_PPCPATCH_SOURCE) | patch -p1
        endif
        endif

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
	perl -i -p -e "s,standard_startfile_prefix_1 = \".*,standard_startfile_prefix_1 =\"$(CROSS_LIB_DIR)/lib/\";,;" $(GCC_DIR)/gcc/gcc.c;
	perl -i -p -e "s,standard_startfile_prefix_2 = \".*,standard_startfile_prefix_2 =\"$(CROSS_LIB_DIR)/usr/lib/\";,;" $(GCC_DIR)/gcc/gcc.c;

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

xchain-gccstage1_prepare_deps =  $(STATEDIR)/xchain-binutils.install
xchain-gccstage1_prepare_deps += $(STATEDIR)/xchain-gccstage1.extract
xchain-gccstage1_prepare_deps += $(STATEDIR)/xchain-kernel.install

GCC_STAGE1_PATH	= PATH=$(CROSS_PATH)
GCC_STAGE1_ENV	= $(HOSTCC_ENV)

GCC_STAGE1_AUTOCONF = \
	--target=$(PTXCONF_GNU_TARGET) \
	--host=$(GNU_HOST) \
	--build=$(GNU_HOST) \
	--prefix=$(PTXCONF_PREFIX) \
	--disable-nls \
	--disable-shared \
	--enable-target-optspace \
	--disable-threads \
	--with-gnu-ld \
	--enable-languages=c

#	--enable-multilib \

$(STATEDIR)/xchain-gccstage1.prepare: $(xchain-gccstage1_prepare_deps)
	@$(call targetinfo, xchain-gccstage1.prepare)
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
	@$(call targetinfo, xchain-gccstage1.compile)
        ifdef PTXCONF_GCC_2_95_3
	cd $(GCC_STAGE1_DIR) && \
		$(GCC_STAGE1_PATH) \
		make MAKE="make TARGET_LIBGCC2_CFLAGS='-Dinhibit_libc -D__gthr_posix_h'"
        else
#
# -DSTAGE1 is a switch for the PPC platfrom
#          it makes some modification active needed only for stage 1
#
	cd $(GCC_STAGE1_DIR) && \
		$(GCC_STAGE1_PATH) \
		make MAKE="make TARGET_LIBGCC2_CFLAGS='-Dinhibit_libc -DSTAGE1'"
        endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-gccstage1_install: $(STATEDIR)/xchain-gccstage1.install

$(STATEDIR)/xchain-gccstage1.install: $(STATEDIR)/xchain-gccstage1.compile
	@$(call targetinfo, xchain-gccstage1.install)
	cd $(GCC_STAGE1_DIR) &&	\
		$(GCC_STAGE1_PATH) $(GCC_STAGE1_ENV) \
		make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-gccstage1_targetinstall: $(STATEDIR)/xchain-gccstage1.targetinstall

$(STATEDIR)/xchain-gccstage1.targetinstall:
	@$(call targetinfo, xchain-gccstage1.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-gccstage1_clean:
	rm -fr $(GCC_STAGE1_DIR)
	rm -fr $(STATEDIR)/xchain-gccstage1.*
	rm -fr $(GCC_DIR)


# vim: syntax=make
