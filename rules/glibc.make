# -*-makefile-*-
# $Id$
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
ifdef PTXCONF_LIBC
PACKAGES	+= glibc
endif
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

# We build off-tree and build zoneinfo files in a separate directory

GLIBC_BUILDDIR		= $(BUILDDIR)/$(GLIBC)-build
GLIBC_ZONEDIR		= $(BUILDDIR)/$(GLIBC)-zoneinfo

# 
# Time Zone Files
# 
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_AFRICA) += Africa
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_ATLANTIC) += Atlantic
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_EUROPE) += Europe
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_EST5EDT) += EST5EDT
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_CANADA) += Canada
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_FACTORY) += Factory
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_GMT0) += GMT0
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_ICELAND) += Iceland
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_JAPAN) += Japan
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_MST7MDT) += MST7MDT
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_NAVAJO) += Navajo
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_WSU) += WSU
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_AMERICA) += America
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_AUSTRALIA) += Australia
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_CHILE) += Chile
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_EGYPT) += Egypt
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_GB) += GB
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_INDIAN) += Indian
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_KWAJALEIN) += Kwajalein
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_MEXICO) += Mexico
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_PRC) += PRC
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_ROC) += ROC
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_UCT) += UCT
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_WET) += WET
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_ANTARCTICA) += Antarctica
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_BRAZIL) += Brazil
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_CUBA) += Cuba
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_EIRE) += Eire
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_IRAN) += Iran
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_LIBYA) += Libya
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_MIDEAST) += Mideast
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_PST8PDT) += PST8PDT
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_ROK) += ROK
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_US) += US
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_ZULU) += Zulu
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_ARCTIC) += Arctic
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_CET) += CET
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_EET) += EET
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_ETC) += Etc
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_GMT) += GMT
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_HST) += HST
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_ISRAEL) += Israel
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_MET) += MET
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_NZ) += NZ
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_PACIFIC) += Pacific
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_SINGAPORE) += Singapore
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_UTC) += UTC
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_ASIA) += Asia
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_CST6CDT) += CST6CDT
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_EST) += EST
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_HONGKONG) += Hongkong
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_JAMAICA) += Jameica
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_MST) += MST
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_NZ-CHAT) += NZ-Chat
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_SYSTEMV) += Sytemv
GLIBC_ZONEFILES-$(PTXCONF_GLIBC_ZONEINFO_UNIVERSAL) += Universal

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glibc_get: $(STATEDIR)/glibc.get

glibc_get_deps =  $(GLIBC_SOURCE)

ifdef PTXCONF_GLIBC_PTHREADS
glibc_get_deps += $(STATEDIR)/glibc-threads.get
endif

glibc_threads_get_deps = $(GLIBC_THREADS_SOURCE)

$(STATEDIR)/glibc.get: $(glibc_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(GLIBC))
	touch $@

$(STATEDIR)/glibc-threads.get: $(glibc_threads_get_deps)
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

glibc_extract: $(STATEDIR)/glibc.extract

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

glibc_prepare: $(STATEDIR)/glibc.prepare

glibc_prepare_deps =  $(STATEDIR)/autoconf213.install
glibc_prepare_deps += $(STATEDIR)/glibc.extract
glibc_prepare_deps += $(STATEDIR)/xchain-kernel.install

GLIBC_AUTOCONF =  $(CROSS_AUTOCONF)
GLIBC_AUTOCONF += --with-headers=$(CROSS_LIB_DIR)/include
GLIBC_AUTOCONF += --enable-clocale=gnu
GLIBC_AUTOCONF += --without-tls
GLIBC_AUTOCONF += --without-cvs
GLIBC_AUTOCONF += --without-gd
GLIBC_AUTOCONF += --prefix=/usr
GLIBC_AUTOCONF += --libexecdir=/usr/bin

ifdef PTXCONF_GLIBC_OPTKERNEL
GLIBC_AUTOCONF += --enable-kernel=$(KERNEL_VERSION)
endif

ifeq ($(GLIBC_VERSION_MAJOR).$(GLIBC_VERSION_MINOR),2.2)
GLIBC_PATH	=  PATH=$(call remove_quotes,$(PTXCONF_PREFIX))/$(call remove_quotes,$(AUTOCONF213))/bin:$(CROSS_PATH)
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

# from config/arch/*.dat: 
# additional architecture dependend configure options

GLIBC_AUTOCONF	+= $(GLIBC_EXTRA_CONFIG)

$(STATEDIR)/glibc.prepare: $(glibc_prepare_deps)
	@$(call targetinfo, $@)

	# Let's build off-tree
	mkdir -p $(GLIBC_BUILDDIR)
	cd $(GLIBC_BUILDDIR) &&						\
	        $(GLIBC_PATH) $(GLIBC_ENV) 				\
		$(GLIBC_DIR)/configure $(GLIBC_AUTOCONF)

#			$(call remove_quotes,$(PTXCONF_GNU_TARGET)) 	\

	# # FIXME: RSC: this crashed because it wants to run elf/sln
	# # don't compile programs
	# echo "build-programs=no" >> $(GLIBC_BUILDDIR)/configparms

	# Zoneinfo files are not created when being cross compiled :-(
	# So we configure a new tree, but without cross... 
	# FIXME: check if this has endianess issues.  

	cp -a $(GLIBC_DIR)/timezone $(GLIBC_ZONEDIR)
	perl -i -p -e "s,include \.\.\/Makeconfig.*,# include\.\.\/Makeconfig,g" $(GLIBC_ZONEDIR)/Makefile
	perl -i -p -e "s,include \.\.\/Rules,# include \.\.\/Rules,g" $(GLIBC_ZONEDIR)/Makefile

	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glibc_compile: $(STATEDIR)/glibc.compile

$(STATEDIR)/glibc.compile: $(STATEDIR)/glibc.prepare 
	@$(call targetinfo, $@)

	# some tools have to be built for host, not for target!
	cd $(GLIBC_ZONEDIR) && CC=$(HOSTCC) make zic

	# Now the "normal" build; override some programs which are being
	# run during compile time to avoid glibc runs cross compiled
	# binaries
	#cd $(GLIBC_BUILDDIR) && $(GLIBC_PATH) make 		\
	#	rpcgen_FOR_BUILD=rpcgen				\
	#	zic_FOR_BUILD=$(GLIBC_ZONEDIR)/timezone/zic	\

	cd $(GLIBC_BUILDDIR) && $(GLIBC_PATH) make

	# fake files which are installed by make install although
	# compiling binaries was switched of (tested with 2.2.5)
	#touch $(GLIBC_BUILDDIR)/iconv/iconv_prog
	#touch $(GLIBC_BUILDDIR)/login/pt_chown

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glibc_install: $(STATEDIR)/glibc.install

$(STATEDIR)/glibc.install: $(STATEDIR)/glibc.compile
	@$(call targetinfo, $@)
	
	
	# Install as usual
	cd $(GLIBC_BUILDDIR) && $(GLIBC_PATH) make 		\
		install_root=$(CROSS_LIB_DIR) 			\
		prefix="" 					\
		zic_FOR_BUILD=$(GLIBC_BUILDDIR)/timezone/zic	\
		install

	# Dan Kegel writes:
	#
	# Fix problems in linker scripts.
	# 
	# 1. Remove absolute paths
	# Any file in a list of known suspects that isn't a symlink is assumed 
	# to be a linker script.
	# 
	# FIXME: test -h is not portable
	# FIXME: probably need to check more files than just these three...
	# 
	# Need to use sed instead of just assuming we know what's in libc.so 
	# because otherwise alpha breaks
	#
	# 2. Remove lines containing BUG per 
	# http://sources.redhat.com/ml/bug-glibc/2003-05/msg00055.html,
	# needed to fix gcc-3.2.3/glibc-2.3.2 targeting arm

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

ifdef PTXCONF_GLIBC_ZONEINFO
	( cd $(GLIBC_ZONEDIR) &&  							\
		for file in `find . -name "z.*" | sed -e "s,.*z.\(.*\),\1,g"`; do	\
			./zic -d zoneinfo $$file || echo "failed [$$FILE]";		\
		done									\
	)
endif
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glibc_targetinstall: $(STATEDIR)/glibc.targetinstall

glibc_targetinstall_deps = $(STATEDIR)/glibc.install

ifdef PTXCONF_GLIBC_DEBUG
GLIBC_STRIP	= true
else
GLIBC_STRIP	= $(CROSSSTRIP) -R .note -R .comment
endif

$(STATEDIR)/glibc.targetinstall: $(glibc_targetinstall_deps)
	@$(call targetinfo, $@)

	# FIXME: use our root install macros here

	# CAREFUL: don't never ever make install!!!
	# but we never ever run ptxdist as root, do we? :)
	mkdir -p $(ROOTDIR)/lib

	cp -d $(CROSS_LIB_DIR)/lib/ld[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/ld[-.]*so*
	cd $(CROSS_LIB_DIR)/lib && \
		ln -sf ld-$(GLIBC_VERSION).so $(ROOTDIR)$(DYNAMIC_LINKER)

	# we don't wanna copy libc.so, cause this is a ld linker script, 
	# no shared lib
	cp -d $(CROSS_LIB_DIR)/lib/libc-*so* $(ROOTDIR)/lib/
	cp -d $(CROSS_LIB_DIR)/lib/libc.so.* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libc[-.]*so*

	# copy librt
ifdef PTXCONF_GLIBC_LIBRT
	cp -d $(CROSS_LIB_DIR)/lib/librt[-.]*so* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/librt[-.]*so*
endif

	# we don't wanna copy libpthread.so, cause this may be a 
	# ld linker script, no shared lib

ifdef PTXCONF_GLIBC_PTHREADS
	cp -d $(CROSS_LIB_DIR)/lib/libpthread-*so* $(ROOTDIR)/lib/
	cp -d $(CROSS_LIB_DIR)/lib/libpthread.so.* $(ROOTDIR)/lib/
	$(GLIBC_STRIP) $(ROOTDIR)/lib/libpthread[-.]*so*
	cd $(CROSS_LIB_DIR)/lib && \
		ln -sf libpthread.so.* $(ROOTDIR)/lib/libpthread.so
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

ifdef PTXCONF_GLIBC_GCONV
	install -d $(ROOTDIR)/usr/lib/gconv
	rm -f $(ROOTDIR)/usr/lib/gconv/gconv-modules

ifdef PTXCONF_GLIBC_GCONV_ISO8859_1
	cp $(GLIBC_BUILDDIR)/iconvdata/ISO8859-1.so $(ROOTDIR)/usr/lib/gconv/
	echo "module INTERNAL ISO-8859-1// ISO8859-1 1" \
		>> $(ROOTDIR)/usr/lib/gconv/gconv-modules
endif
	
endif
	# Zonefiles
	$(call copy_root, 0, 0, 0755, /usr/share/zoneinfo)
	for target in $(GLIBC_ZONEFILES-y); do 							\
		cp -a $(GLIBC_ZONEDIR)/zoneinfo/$$target $(ROOTDIR)/usr/share/zoneinfo/;	\
	done;

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glibc_clean: 
	-rm -rf $(STATEDIR)/glibc*
	-rm -rf $(GLIBC_DIR)
	-rm -rf $(GLIBC_BUILDDIR)
	-rm -rf $(GLIBC_ZONEDIR)

# vim: syntax=make
