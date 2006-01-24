# -*-makefile-*-
# $Id$
#
# This file contains global macro and environment definitions. 
#

# ----------------------------------------------------------------------------
# Programs & Local Defines
# ----------------------------------------------------------------------------

# change this if you have some wired configuration :)

# FIXME: cleanup 

PTXUSER		= $(shell echo $$USER)
GNU_BUILD	= $(shell $(PTXDIST_TOPDIR)/scripts/config.guess)
GNU_HOST	= $(shell echo $(GNU_BUILD) | sed s/-[a-zA-Z0-9_]*-/-host-/)
DEP_OUTPUT	= depend.out
DEP_TREE_PS	= deptree.ps
DEP_TREE_A4_PS	= deptree-a4.ps

SUDO		= sudo
HOSTCC		= gcc
DOT		= dot
SH		= /bin/sh
# FIXME: disabled cashing in wget. Make sure that all patches on the webserver
#        have a version number and reenable caching
WGET		= \
	export ptx_http_proxy=$(PTXCONF_SETUP_HTTP_PROXY); \
	export ptx_ftp_proxy=$(PTXCONF_SETUP_FTP_PROXY); \
	eval \
	$${ptx_http_proxy:+http_proxy=$${ptx_http_proxy}} \
	$${ptx_ftp_proxy:+ftp_proxy=$${ptx_ftp_proxy}} \
	wget --cache=off
MAKE		= make
MAKE_INSTALL	= make install
PATCH		= patch
TAR		= tar
GZIP		= gzip
ZCAT		= zcat
BZIP2		= bzip2
BZCAT		= bzcat
CAT		= cat
RM		= rm
MKDIR		= mkdir
MKTEMP		= mktemp
CD		= cd
MV		= mv
CP		= cp
LN		= ln
AWK		= awk
PERL		= perl
GREP		= grep
INSTALL		= install
PARALLELMFLAGS  = -j$(shell if [ -r /proc/cpuinfo ];			\
	then echo `cat /proc/cpuinfo | grep 'processor' | wc -l`;	\
		else echo 1;						\
	fi)

ifdef PTXCONF_HOST_FAKEROOT
FAKEROOT	= $(PTXCONF_HOST_PREFIX)/bin/fakeroot
else
FAKEROOT	= fakeroot
endif

ifdef PTXCONF_IMAGE_HOST_DEB
CHECKINSTALL	=  INSTALLWATCH_PREFIX=$(PTXCONF_PREFIX)
CHECKINSTALL	+= $(HOST_CHECKINSTALL_DIR)/checkinstall
CHECKINSTALL	+= -D -y
else
CHECKINSTALL	=
endif

HOSTCC_ENV	= CC=$(HOSTCC)


# ----------------------------------------------------------------------------
# Paths and other stuff
# ----------------------------------------------------------------------------

#
# CROSS_LIB_DIR	= the libs for the target system are installed into this dir
#
CROSS_LIB_DIR := $(call remove_quotes,$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET))
SYSROOT := $(call remove_quotes,$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET))

#
# Use the masquerading method of invoking distcc if enabled
#
#
ifdef PTXCONF_XCHAIN-DISTCC
# FIXME: should also allow use of DISTCC for native stuff
DISTCC_PATH_COLON := $(PTXCONF_PREFIX)/lib/distcc/bin:
endif

#
# prepare the search path
#
CROSS_PATH := $(call remove_quotes,$(DISTCC_PATH_COLON)$(PTXCONF_PREFIX)/bin:$(DISTCC_PATH_COLON)$(PTXCONF_PREFIX)/usr/bin:$$PATH)
HOST_PATH := $(call remove_quotes,$(PTXCONF_HOST_PREFIX))/bin:$$PATH

#
# same as PTXCONF_GNU_TARGET, but w/o -linux
# e.g. i486 instead of i486-linux
#
SHORT_TARGET		:= `echo $(PTXCONF_GNU_TARGET) | $(PERL) -i -p -e 's/(.*?)-.*/$$1/'`
SHORT_HOST		:= `echo $(GNU_HOST) | $(PERL) -i -p -e 's/(.*?)-.*/$$1/'`


# ----------------------------------------------------------------------------
# Environment
# ----------------------------------------------------------------------------

#
# CFLAGS / CXXFLAGS
#
# TARGET_CFLAGS and TARGET_CXXFLAGS are included from the architecture
# depended config file that is specified in .config. So here we have to 
# extend it with the stuff we need. 
#
# The option in the .config is called 'TARGET_CONFIG_FILE'
#
#

# FIXME: this is not really consistent any more; we want the arch specific 
#        stuff separate from other options, so we can do NATIVE builds. 

ifdef NATIVE
TARGET_CFLAGS		=
TARGET_CXXFLAGS		=
TARGET_CPPFLAGS		=
TARGET_LDFLAGS		=
endif
TARGET_CFLAGS		+= $(PTXCONF_TARGET_EXTRA_CFLAGS)
TARGET_CXXFLAGS		+= $(PTXCONF_TARGET_EXTRA_CXXFLAGS)
TARGET_CPPFLAGS		+= $(PTXCONF_TARGET_EXTRA_CPPFLAGS)
TARGET_LDFLAGS		+= $(PTXCONF_TARGET_EXTRA_LDFLAGS)

##
## if we use an external crosschain set include and lib dirs correctly: 
## 
## - don't use system standard include paths
## - find out the compiler's sysincludedir
##
ifndef $(PTXCONF_CROSSTOOL)
TARGET_CXXFLAGS		+= -isystem $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
TARGET_CXXFLAGS		+= -isystem $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/usr/include
TARGET_CPPFLAGS		+= -isystem $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
TARGET_CPPFLAGS		+= -isystem $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/usr/include
TARGET_LDFLAGS		+= -L$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib 
TARGET_LDFLAGS		+= -L$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/usr/lib 
endif


# Environment variables for toolchain components
#
# FIXME: Consolidate a bit more
#
ifndef NATIVE
COMPILER_PREFIX		:= $(call remove_quotes,$(PTXCONF_COMPILER_PREFIX))
endif
CROSS_AR		:= $(COMPILER_PREFIX)ar
CROSS_AS		:= $(COMPILER_PREFIX)as
CROSS_LD		:= $(COMPILER_PREFIX)ld
CROSS_NM		:= $(COMPILER_PREFIX)nm
CROSS_CC		:= $(COMPILER_PREFIX)gcc
CROSS_CXX		:= $(COMPILER_PREFIX)g++
CROSS_RANLIB		:= $(COMPILER_PREFIX)ranlib
CROSS_OBJCOPY		:= $(COMPILER_PREFIX)objcopy
CROSS_OBJDUMP		:= $(COMPILER_PREFIX)objdump
CROSS_STRIP		:= $(COMPILER_PREFIX)strip

CROSS_ENV_AR		:= AR=$(CROSS_AR)
CROSS_ENV_AS		:= AS=$(CROSS_AS)
CROSS_ENV_LD		:= LD=$(CROSS_LD)
CROSS_ENV_NM		:= NM=$(CROSS_NM)
CROSS_ENV_CC		:= CC=$(CROSS_CC)
CROSS_ENV_CXX		:= CXX=$(CROSS_CXX)
CROSS_ENV_RANLIB	:= RANLIB=$(CROSS_RANLIB)
CROSS_ENV_OBJCOPY	:= OBJCOPY=$(CROSS_OBJCOPY)
CROSS_ENV_OBJDUMP	:= OBJDUMP=$(CROSS_OBJDUMP)
CROSS_ENV_STRIP		:= STRIP=$(CROSS_STRIP)
CROSS_ENV_CC_FOR_BUILD	:= CC_FOR_BUILD=$(call remove_quotes,$(HOSTCC))
CROSS_ENV_CPP_FOR_BUILD	:= CPP_FOR_BUILD=$(call remove_quotes,$(HOSTCC))
CROSS_ENV_LINK_FOR_BUILD:= LINK_FOR_BUILD=$(call remove_quotes,$(HOSTCC))

# FIXME: check if we have to add quotes for grouping here

CROSS_CFLAGS		= $(call remove_quotes,$(TARGET_CFLAGS))
CROSS_CXXFLAGS		= $(call remove_quotes,$(TARGET_CXXFLAGS))
CROSS_CPPFLAGS		= $(call remove_quotes,$(TARGET_CPPFLAGS))
CROSS_LDFLAGS		= $(call remove_quotes,$(TARGET_LDFLAGS))

ifneq ('','$(strip $(CROSS_CFLAGS))')
CROSS_ENV_CFLAGS		= CFLAGS='$(strip $(CROSS_CFLAGS))'
CROSS_ENV_CFLAGS_FOR_TARGET	= CFLAGS_FOR_TARGET='$(strip $(CROSS_CFLAGS))'
endif

ifneq ('','$(strip $(CROSS_CXXFLAGS))')
CROSS_ENV_CXXFLAGS		= CXXFLAGS='$(strip $(CROSS_CXXFLAGS))'
CROSS_ENV_CXXFLAGS_FOR_TARGET	= CXXFLAGS_FOR_TARGET='$(strip $(CROSS_CXXFLAGS))'
endif

ifneq ('','$(strip $(CROSS_CPPFLAGS))')
CROSS_ENV_CPPFLAGS		= CPPFLAGS='$(strip $(CROSS_CPPFLAGS))'
CROSS_ENF_CPPFLAGS_FOR_TARGET	= CPPFLAGS_FOR_TARGET='$(strip $(CROSS_CPPFLAGS))'
endif

ifneq ('','$(strip $(CROSS_LDFLAGS))')
CROSS_ENV_LDFLAGS		= LDFLAGS='$(strip $(CROSS_LDFLAGS))'
CROSS_ENV_LDFLAGS_FOR_TARGET	= LDFLAGS_FOR_TARGET='$(strip $(CROSS_LDFLAGS))'
endif

# 
# CROSS_ENV is the environment usually set for all configure and compile
# calls in the packet makefiles. 
#
# The ac_cv_* variables are needed to tell configure scripts not to use
# AC_TRY_RUN and run cross compiled things on the development host
# 
CROSS_ENV_PROGS := \
	$(CROSS_ENV_AR) \
	$(CROSS_ENV_AS) \
	$(CROSS_ENV_CXX) \
	$(CROSS_ENV_CC) \
	$(CROSS_ENV_CC_FOR_BUILD) \
	$(CROSS_ENV_CPP_FOR_BUILD) \
	$(CROSS_ENV_LINK_FOR_BUILD) \
	$(CROSS_ENV_LD) \
	$(CROSS_ENV_NM) \
	$(CROSS_ENV_OBJCOPY) \
	$(CROSS_ENV_OBJDUMP) \
	$(CROSS_ENV_RANLIB) \
	$(CROSS_ENV_STRIP)

#
# prepare to use pkg-config with wrapper which takes care of $(SYSROOT). 
# The wrapper's magic doesn't work when pkg-config strips out /usr/lib
# and other system libs/cflags, so we leave them in; the wrapper
# replaces them by proper $(SYSROOT) correspondees. 
#

CROSS_ENV_PKG_CONFIG := \
	SYSROOT=$(SYSROOT) \
	PKG_CONFIG_PATH=$(SYSROOT)/lib/pkgconfig:$(SYSROOT)/usr/lib/pkgconfig

CROSS_ENV_FLAGS := \
	$(CROSS_ENV_CFLAGS) \
	$(CROSS_ENV_CPPFLAGS) \
	$(CROSS_ENV_LDFLAGS) \
	$(CROSS_ENV_CXXFLAGS)

CROSS_ENV_FLAGS_FOR_TARGET := \
	$(CROSS_ENV_CFLAGS_FOR_TARGET) \
	$(CROSS_ENV_CXXFLAGS_FOR_TARGET) \
	$(CROSS_ENV_CPPFLAGS_FOR_TARGET) \
	$(CROSS_ENV_LDFLAGS_FOR_TARGET)

CROSS_ENV_AC := \
	ac_cv_sizeof_long_long=8 \
	ac_cv_sizeof_long_double=8 \
	ac_cv_func_getpgrp_void=yes \
	ac_cv_func_setpgrp_void=yes \
	ac_cv_func_memcmp_clean=yes \
	ac_cv_func_setvbuf_reversed=no \
	ac_cv_func_getrlimit=yes \
	ac_cv_type_uintptr_t=yes \
	ac_cv_func_dcgettext=yes \
	gt_cv_func_gettext_libintl=yes \
	ac_cv_sysv_ipc=yes

CROSS_ENV_DESTDIR := \
	DESTDIR=$(SYSROOT)

#
# We want to use DESTDIR and --prefix=/usr, to get no build paths in our
# binaries. Unfortunately, not all packages support this, especially
# libtool based packets seem to be broken. See for example: 
# 
# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=58664
#
# for a longer discussion [RSC]
#

CROSS_AUTOCONF_SYSROOT_USR := \
	$(call remove_quotes,--prefix=/usr --sysconfdir=/etc)

CROSS_AUTOCONF_SYSROOT_ROOT := \
	$(call remove_quotes,-prefix=/)

CROSS_AUTOCONF_ARCH := \
	$(call remove_quotes,--build=$(GNU_HOST) --host=$(PTXCONF_GNU_TARGET))

CROSS_AUTOCONF_BROKEN_USR := \
	$(call remove_quotes,--build=$(GNU_HOST) --host=$(PTXCONF_GNU_TARGET) --prefix=$(SYSROOT))

ifndef NATIVE

CROSS_ENV := \
	$(CROSS_ENV_PROGS) \
	$(CROSS_ENV_FLAGS) \
	$(CROSS_ENV_PKG_CONFIG) \
	$(CROSS_ENV_AC) \
	$(CROSS_ENV_DESTDIR)

CROSS_AUTOCONF_USR  := $(CROSS_AUTOCONF_SYSROOT_USR) $(CROSS_AUTOCONF_ARCH)
CROSS_AUTOCONF_ROOT := $(CROSS_AUTOCONF_SYSROOT_ROOT) $(CROSS_AUTOCONF_ARCH)

else

CROSS_ENV := \
	$(CROSS_ENV_PROGS) \
	$(CROSS_ENV_FLAGS) \
	$(CROSS_ENV_PKG_CONFIG) \
	$(CROSS_ENV_DESTDIR)

CROSS_AUTOCONF_USR  := $(CROSS_AUTOCONF_SYSROOT_USR) 
CROSS_AUTOCONF_ROOT := $(CROSS_AUTOCONF_SYSROOT_ROOT) 

endif

HOST_AUTOCONF  := --prefix=$(PTXCONF_HOST_PREFIX)

# ----------------------------------------------------------------------------
# Convenience macros
# ----------------------------------------------------------------------------


#
# compilercheck
#
# Test if a given compiler has the right version, as specified in
# PTXCONF_CROSSCHAIN_CHECK. This lets you test if an external compiler
# fulfills the requirements for a configuration. 
#
compilercheck =											\
	TOOLCHAIN="$(strip $(call remove_quotes, $(PTXCONF_BUILD_TOOLCHAIN)))";			\
	NATIVE="$(strip $(call remove_quotes, $(NATIVE)))";					\
												\
	if test "$${TOOLCHAIN}" = "y" -o "$${NATIVE}" = "1" -o "$${NATIVE}" = "y"; then		\
		echo > /dev/null;								\
	else											\
		echo -n "compiler check...";							\
		if test \! -x "`which $(CROSS_CC)`"; then					\
			echo;									\
			echo;									\
			echo "No compiler installed!";						\
			echo "Specified: $(CROSS_CC)";						\
			echo;									\
			exit -1;								\
		fi;										\
		if test "$(PTXCONF_CROSSCHAIN_CHECK)" != `$(CROSS_CC) -dumpversion`; then	\
			echo;									\
			echo;									\
			echo "Please use the specified compiler!";				\
			echo;									\
			echo "Specified: $(PTXCONF_CROSSCHAIN_CHECK)";				\
			echo "Found:     "`$(CROSS_CC) -dumpversion`;				\
			echo;									\
			exit -1;								\
		fi;										\
		echo "ok";									\
	fi;

#
# check_prog_exists
#
# $1: Find out if this program does exist. If not, execution stops
#     with an error message. 
#
check_prog_exists = 				\
	@if [ ! -x `which $(1)` ]; then		\
		echo "$(1) not found";		\
		echo "please install $(1)"; 	\
		exit -1;			\
	fi;


#
# check_prog_version
#
# $1: Call program with args $2 (-V, ...) and extract version number from the output;
#     the result is compared to the first argument. 
#
check_prog_version = 				\
	@if [ "`$(1) $(2) | $(AWK) 'BEGIN {count = 0;} {count += match($$0,"$(3)");} END {print $$count;}'`" == "0" ]; then \
		echo "need $(1) version $(3)";	\
		echo "please install";		\
		exit -1;			\
	fi;

#
# check_file_exists
#
# $1: Test if a file exists and exit with an error message if not. 
#
check_file_exists = 				\
	@if [ ! -e $(1) ]; then			\
		echo "$(1) not found";		\
		exit -1;			\
	fi;


#
# targetinfo
#
# Print out the targetinfo line on the terminal and perform the compiler
# check to make sure we are using the right toolchain in case we want
# to perform compile or prepare stages. 
# 
# $1: name of the target to be printed out
# $2: normally empty; if "n", don't run compilercheck
#
targetinfo = 							\
	echo;							\
	TG=`echo $(1) | sed -e "s,/.*/,,g"`; 			\
	NOCHECK=$(strip $(2));					\
	LINE=`echo target: $$TG |sed -e "s/./-/g"`;		\
	echo $$LINE;						\
	echo target: $$TG;					\
	echo $$LINE;						\
	echo;							\
	if [ "$$NOCHECK" != "n" ]; then 			\
		if [ `echo $$TG | $(GREP) "\.compile"` ]; then	\
			$(call compilercheck)			\
		fi;						\
		if [ `echo $$TG | $(GREP) "\.prepare"` ]; then	\
			$(call compilercheck)			\
		fi;						\
	fi;							\
	echo $@ : $^ | sed 					\
		-e "s@$(PTXCONF_SETUP_SRCDIR)@@g"		\
		-e "s@$(STATEDIR)@@g"				\
		-e "s@$(RULESDIR)@@g"				\
		-e "s@$(PROJECTRULESDIR)@@g"			\
		-e "s@$(PROJECTDIR)@@g"				\
		-e "s@$(PTXDIST_TOPDIR)@@g" 			\
		-e "s@/@@g" >> $(DEP_OUTPUT)

#
# touch with prefix-creation
#
# $1: name of the target to be touched
# 
touch =								\
	@mkdir -p $(shell dirname $1);				\
	touch $1;						\
	echo "Finished target $(shell basename $1)";

#
# extract 
#
# Extract a source archive into a directory. 
#
# $1: filename to extract
# $2: dir to extract into; if $2 is not given we extract to $(BUILDDIR)
#
extract =							\
	PACKET="$(strip $(1))";					\
	if [ "$$PACKET" = "" ]; then				\
		echo;						\
		echo Error: empty parameter to \"extract\(\)\";	\
		echo;						\
		exit -1;					\
	fi;							\
	DEST="$(strip $(2))";					\
	DEST=$${DEST:-$(BUILDDIR)};				\
	echo "extract: archive=$$PACKET";			\
	echo "extract: dest=$$DEST";				\
	case "$$PACKET" in					\
	*gz)							\
		EXTRACT=$(GZIP)					\
		;;						\
	*bz2)							\
		EXTRACT=$(BZIP2)				\
		;;						\
	*)							\
		echo;						\
		echo Unknown format, cannot extract!;		\
		echo;						\
		exit -1;					\
		;;						\
	esac;							\
	[ -d $$DEST ] || $(MKDIR) -p $$DEST;			\
	echo $$(basename $$PACKET) >> $(STATEDIR)/packetlist; 	\
	$$EXTRACT -dc $$PACKET | $(TAR) -C $$DEST -xf -;	\
	[ $$? -eq 0 ] || {					\
		echo;						\
		echo "Could not extract packet!";		\
		echo "File: $$PACKET";				\
		echo;						\
		exit -1;					\
	};


#
# get
#
# Download a package from a given URL. This macro has some magic
# to handle different URLs; as wget is not able to transfer
# file URLs this case is being handed over to cp.  
#
# $1: URL of the packet
# $2: source directory
#
get =								\
	URL="$(strip $(1))";					\
	if [ "$$URL" = "" ]; then				\
		echo;						\
		echo Error: empty parameter to \"get\(\)\";	\
		echo;						\
		exit -1;					\
	fi;							\
	[ "$$(expr match $$URL http://)" != "0" ] && URLTYPE="http"; \
	[ "$$(expr match $$URL ftp://)" != "0" ] && URLTYPE="ftp";   \
	[ "$$(expr match $$URL file://)" != "0" ] && URLTYPE="file"; \
	SRC="$(strip $(2))";					\
	SRC=$${SRC:-$(SRCDIR)};					\
	[ -d $$SRC ] || $(MKDIR) -p $$SRC;			\
	[ "$(PTXCONF_SETUP_FTP_PROXY)" != "" ] && FTPPROXY="-Yon";	\
	[ "$(PTXCONF_SETUP_HTTP_PROXY)" != "" ] && HTTPPROXY="-Yon";	\
	case $$URLTYPE in 						\
	http)								\
		$(WGET) -P $$SRC --passive-ftp $$HTTPPROXY $$URL;	\
		[ $$? -eq 0 ] || {					\
			echo;					\
			echo "Could not get packet via http!";	\
			echo "URL: $$URL";			\
			echo;					\
			exit -1;				\
			};					\
		;;						\
	ftp)								\
		$(WGET) -P $$SRC --passive-ftp $$FTPPROXY $$URL;	\
		[ $$? -eq 0 ] || {					\
			echo;					\
			echo "Could not get packet via ftp!";	\
			echo "URL: $$URL";			\
			echo;					\
			exit -1;				\
			};					\
		;;						\
	file)							\
		FILE="$$(echo $$URL | sed s-file://-/-g)";	\
		$(CP) -av $$FILE $$SRC;				\
		[ $$? -eq 0 ] || {				\
			echo;					\
			echo "Could not copy packet!";		\
			echo "File: $$FILE";			\
			echo;					\
			exit -1;				\
			};					\
		;;						\
	*)							\
		echo;						\
		echo "Unknown URL Type!";			\
		echo "URL: $$URL";				\
		echo;						\
		exit -1;					\
		;;						\
	esac;								


#
# get_feature_patch
#
# Download a feature patch from a given URL. 
#
# $1: Name of the package the patch has to be applied to 
# $2: URL of the patch; this may either point to a single unified diff
#     or to a directory containing a 'patcher' like patch series
# $3: patch name; the patch is stored in $(PTXDIST_TOPDIR)/feature-patches/$3
#
get_feature_patch =						\
	FP_PARENT="$(strip $(1))";				\
	FP_URL="$(strip $(2))";					\
	FP_NAME="$(strip $(3))";				\
	FP_FILE="$$(basename $$FP_URL)";                        				\
	if [ -f $(PTXCONF_SETUP_LOCAL_FEATUREPATCH_REPOSITORY)/$$FP_NAME/$$FP_FILE ]; then	\
		echo "patch already in local FP repository, skipping...";			\
		exit 0;										\
	fi;							\
	if [ "$$FP_URL" == "" ] && [ "$$FP_NAME" == "" ]; then	\
		echo "patch inactive" > /dev/null;		\
		exit 0;						\
	fi;							\
	if [ "$$FP_URL" == "" ] || [ "$$FP_NAME" == "" ]; then	\
		echo;						\
		echo "Error: empty feature patch name or URL";	\
		echo;						\
		exit -1;					\
	fi;											\
	FP_DIR="$(PTXCONF_SETUP_LOCAL_FEATUREPATCH_REPOSITORY)/$$FP_NAME/";			\
	[ -d $$FP_DIR ] || $(MKDIR) -p $$FP_DIR;						\
	[ "$$(expr match $$FP_URL http://)" != "0" ] && FP_URLTYPE="http"; 			\
	[ "$$(expr match $$FP_URL ftp://)" != "0" ]  && FP_URLTYPE="ftp";  			\
	[ "$$(expr match $$FP_URL file://)" != "0" ] && FP_URLTYPE="file"; 			\
	case $$FP_URLTYPE in                                    \
	http)                                                   \
		$(WGET) -np -nd -nH --cut-dirs=0 -P $$FP_DIR --passive-ftp $$FP_URL; \
		[ $$? -eq 0 ] || {                              \
			echo;                                   \
			echo "Could not get feature patch via http!";  \
			echo "URL: $$FP_URL";                   \
			echo;                                   \
			exit 1;                                 \
			};                                      \
		;;                                              \
	ftp)                                                    \
		$(WGET) -np -nd -nH --cut-dirs=0 -P $$FP_DIR --passive-ftp $$FP_URL; \
		[ $$? -eq 0 ] || {                              \
			echo;                                   \
			echo "Could not get feature patch via ftp!";   \
			echo "URL: $$FP_URL";                   \
			echo;                                   \
			exit 1;                                 \
			};                                      \
		;;                                              \
	file)                                                   \
		FP_FILE="$$(echo $$FP_URL | sed s-file://-/-g)";\
		$(CP) -av $$FP_FILE $$FP_DIR;			\
		[ $$? -eq 0 ] || {                              \
			echo;                                   \
			echo "Could not copy feature patch!";   \
			echo "File: $$FILE";                    \
			echo;                                   \
			exit 1;                                 \
			};                                      \
		;;                                              \
	*)                                                      \
		echo;                                           \
		echo "Unknown URL Type for feature patch!";     \
		echo "URL: $$URL";                              \
		echo;                                           \
		exit -1;                                        \
		;;                                              \
	esac;

#
# get_patches
#
# Download patches from a local or global patch repository. 
# PTXPATCH_URL contains a list of URLs where to search for patches. 
# First hit matches, so URLs earlier in the list superseed later ones. 
#
#
# $1: packet name. The packet name is the identifier for a patch
#     subdirecotry. 
# 
# These wget options are being used: 
# 
# -r -l1		recursive 1 level
# -nH --cutdirs=3	remove hostname and next 3 dirs from URL, when saving
#			so "http://www.pengutronix.de/software/ptxdist-cvs/patches/glibc-2.2.5/*"
#			becomes "glibc-2.2.5/*"
#

# FIXME: remove this if patch mechanism works

get_patches =											\
		echo "get_patches is obsolete now"


#
# get_options
# 
# Returns an options from the .config file
#
# $1: regex, that's applied to the .config file
#     format: 's/foo/bar/'
#
# $2: default option, this value is returned if the regex outputs nothing
#
get_option =										\
	$(shell										\
		REGEX="$(strip $(1))";							\
		DEFAULT="$(strip $(2))";						\
		if [ -f $(PTXDIST_WORKSPACE)/.config ]; then				\
			VALUE=`$(CAT) $(PTXDIST_WORKSPACE)/.config | sed -n -e "$${REGEX}p"`;	\
		fi;									\
		echo $${VALUE:-$$DEFAULT}						\
	)


#
# get_option_ext
# 
# Returns an options from the .config file
#
# $1: regex, that's applied to the .config file
#     format: 's/foo/bar/'
# $2: command that get in STDIN the output from the regex magic
#     should return something in STDOUT
#
get_option_ext =									\
	$(shell										\
		REGEX="$(strip $(1))";							\
		if [ -f $(PTXDIST_WORKSPACE)/.config ]; then					\
			$(CAT) $(PTXDIST_WORKSPACE)/.config | sed -n -e "$${REGEX}p" | $(2);	\
		fi;									\
	)


#
# install
#
# Perform standard install actions
#
# $1: label of the packet
# $2: optional: alternative directory
# $3: optional: "h" = install as a host tool
# $4: optional: args to pass to make install call
#
# FIXME: if we don't use --install=no we can make one packet.
#
ifdef PTXCONF_IMAGE_HOST_DEB
install = \
	BUILDDIR="$($(strip $(1)_DIR))";				\
	[ "$(strip $(2))" != ""  ] && BUILDDIR="$(strip $(2))";		\
	[ "$(strip $(3))" != "h" ] && DESTDIR="$(SYSROOT)";		\
	cd $$BUILDDIR && 						\
		$($(strip $(1))_ENV) 					\
		$($(strip $(1))_PATH) 					\
		INSTALLWATCH_PREFIX=$(PTXCONF_PREFIX)			\
		$(HOST_CHECKINSTALL_DIR)/checkinstall			\
		-D -y -pakdir=$(IMAGEDIR) --install=no -nodoc		\
		make install $(4) 					\
		$($(strip $(1))_MAKEVARS)				\
		DESTDIR=$$DESTDIR;					\
	#dpkg-deb -x blablabla $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
else
install = \
	BUILDDIR="$($(strip $(1))_DIR)";				\
	[ "$(strip $(2))" != ""  ] && BUILDDIR="$(strip $(2))";		\
	[ "$(strip $(3))" != "h" ] && DESTDIR="$(SYSROOT)";		\
	cd $$BUILDDIR &&						\
		echo "$($(strip $(1))_ENV)				\
		$($(strip $(1))_PATH)					\
		make install $(4)					\
		$($(strip $(1))_MAKEVARS)				\
		DESTDIR=$$DESTDIR;"					\
		| $(FAKEROOT) --
endif


#
# clean
# 
# Cleanup the given directory or file. 
#
clean =								\
	DIR="$(strip $(1))";					\
	if [ -e $$DIR ]; then					\
		$(RM) -rf $$DIR;				\
	fi

# 	if [ "$$DIR" = "" ]; then				\
# 		echo;						\
# 		echo Error: empty parameter to \"clean\(\)\";	\
# 		echo;						\
# 		exit -1;					\
# 	fi;							\


#
# enable_c
# 
# Enables a define, removes /* */
#
# (often found in .c or .h files)
#
# $1: file
# $2: parameter
#
enable_c =											\
	FILENAME="$(strip $(1))";								\
	PARAMETER="$(strip $(2))";								\
	$(PERL) -p -i -e									\
		"s,^\s*(\/\*)?\s*(\#\s*define\s+$$PARAMETER)\s*(\*\/)?$$,\$$2\n,"		\
		$$FILENAME

#
# disable_c
# 
# Disables a define with, adds /* */
#
# (often found in .c or .h files)
#
# $1: file
# $2: parameter
#
disable_c =											\
	FILENAME="$(strip $(1))";								\
	PARAMETER="$(strip $(2))";								\
	$(PERL) -p -i -e									\
		"s,^\s*(\/\*)?\s*(\#\s*define\s+$$PARAMETER)\s*(\*\/)?$$,\/\*\$$2\*\/\n,"	\
		$$FILENAME

#
# enable_sh
# 
# Enabled something, removes #
#
# often found in shell scripts, Makefiles
#
# $1: file
# $2: parameter
#
enable_sh =						\
	FILENAME="$(strip $(1))";			\
	PARAMETER="$(strip $(2))";			\
	$(PERL) -p -i -e				\
		"s,^\s*(\#)?\s*($$PARAMETER),\$$2,"	\
		$$FILENAME


#
# disable_sh
# 
# Disables a comment, adds #
#
# often found in shell scripts, Makefiles
#
# $1: file
# $2: parameter
#
disable_sh =						\
	FILENAME="$(strip $(1))";			\
	PARAMETER="$(strip $(2))";			\
	$(PERL) -p -i -e				\
		"s,^\s*(\#)?\s*($$PARAMETER),\#\$$2,"	\
		$$FILENAME

#
# patchin
# 
# Go into a directory and apply all patches from there into a
# sourcetree. 
#
# $1: $(PACKET_NAME) -> identifier
# $2: path to source tree 
#     if this parameter is omitted, the path will be derived
#     from the packet name
#
patchin =									\
	PACKET_NAME="$(strip $(1))";						\
	echo "patchin: packet=$$PACKET_NAME";					\
	if [ "$$PACKET_NAME" = "" ]; then					\
		echo;								\
		echo Error: empty parameter to \"patchin\(\)\";			\
		echo;								\
		exit -1;							\
	fi;									\
	PACKET_DIR="$(strip $(2))";						\
	PACKET_DIR=$${PACKET_DIR:-$(BUILDDIR)/$$PACKET_NAME};			\
	echo "patchin: dir=$$PACKET_DIR";					\
	for PATCH_NAME in							\
	    $(PATCHDIR)/$$PACKET_NAME/generic/*.diff				\
	    $(PATCHDIR)/$$PACKET_NAME/generic/*.patch				\
	    $(PATCHDIR)/$$PACKET_NAME/generic/*.gz				\
	    $(PATCHDIR)/$$PACKET_NAME/generic/*.bz2				\
	    $(PATCHDIR)/$$PACKET_NAME/$(PTXCONF_ARCH)/*.diff			\
	    $(PATCHDIR)/$$PACKET_NAME/$(PTXCONF_ARCH)/*.patch			\
	    $(PATCHDIR)/$$PACKET_NAME/$(PTXCONF_ARCH)/*.gz			\
	    $(PATCHDIR)/$$PACKET_NAME/$(PTXCONF_ARCH)/*.bz2			\
	    $(PROJECTPATCHDIR)/$$PACKET_NAME/generic/*.diff			\
	    $(PROJECTPATCHDIR)/$$PACKET_NAME/generic/*.patch			\
	    $(PROJECTPATCHDIR)/$$PACKET_NAME/generic/*.gz			\
	    $(PROJECTPATCHDIR)/$$PACKET_NAME/generic/*.bz2			\
	    $(PROJECTPATCHDIR)/$$PACKET_NAME/$(PTXCONF_ARCH)/*.diff		\
	    $(PROJECTPATCHDIR)/$$PACKET_NAME/$(PTXCONF_ARCH)/*.patch		\
	    $(PROJECTPATCHDIR)/$$PACKET_NAME/$(PTXCONF_ARCH)/*.gz		\
	    $(PROJECTPATCHDIR)/$$PACKET_NAME/$(PTXCONF_ARCH)/*.bz2;		\
	    do									\
		if [ -f $$PATCH_NAME ]; then					\
			case `basename $$PATCH_NAME` in				\
			*.gz)							\
				CAT=$(ZCAT)					\
				;;						\
			*.bz2)							\
				CAT=$(BZCAT)					\
				;;						\
			*.diff|diff*|*.patch|patch*)				\
				CAT=$(CAT)					\
				;;						\
			*)							\
				echo;						\
				echo Unknown patch format, cannot apply!;	\
				echo;						\
				exit -1;					\
				;;						\
			esac;							\
			echo "patchin: name=$$PATCH_NAME ...";			\
			$$CAT $$PATCH_NAME | $(PATCH) -Np1 -d $$PACKET_DIR || exit -1;	\
		fi;								\
	    done


#
# patch_apply
# 
# Apply a patch to a directory. 
#
# $1: the name of the patch to apply
# $2: apply patch to that directory
#
patch_apply =								\
	PATCH_NAME="$(strip $(1))";					\
	if [ "$$PATCH_NAME" = "" ]; then				\
		echo;							\
		echo Error: empty parameter to \"patch_apply\(\)\";	\
		echo;							\
		exit -1;						\
	fi;								\
	PACKET_DIR="$(strip $(2))";					\
	if [ -f $$PATCH_NAME ]; then					\
		case `basename $$PATCH_NAME` in				\
		*.gz)							\
			CAT=$(ZCAT)					\
			;;						\
		*.bz2)							\
			CAT=$(BZCAT)					\
			;;						\
		*.diff|diff*|*.patch|patch*)				\
			CAT=$(CAT)					\
			;;						\
		*)							\
			echo;						\
			echo Unknown patch format, cannot apply!;	\
			echo;						\
			exit -1;					\
			;;						\
		esac;							\
		echo "patchin' $$PATCH_NAME ...";			\
		$$CAT $$PATCH_NAME | $(PATCH) -Np1 -d $$PACKET_DIR || exit -1;	\
	fi;								\
	true;

#
# feature_patchin
#
# Go into a directory, look for either a 'series' file and apply all 
# patches listed there into a sourcetree, or, if no 'series' file
# exists, apply the patches as they come
#
# $1: $(FP_TARGET): path to source tree where the feature patch is
#     to be applied  
#
# $2: $(FP_NAME): name of the patch to be applied; patches usually live in
#     $(PTXCONF_SETUP_LOCAL_FEATUREPATCH_REPOSITORY)/$$FP_NAME/$$FP_FILE
#     Patches without a name are silently being ignored. 
#
feature_patchin =								\
	FP_TARGET="$(strip $(1))";						\
	FP_NAME="$(strip $(2))";						\
	if [ "x$$FP_TARGET" = "x" ]; then					\
		echo;								\
		echo "Error: you didn't specify a feature patch target dir!";	\
		echo "Error: feature_patchin needs this as parameter 2";	\
		echo;								\
		exit -1;							\
	fi;									\
	if [ "x$$FP_NAME" = "x" ]; then						\
		echo "No patch name specified, dropping.";			\
		exit 0;								\
	fi;									\
	FP_DIR=$(PTXCONF_SETUP_LOCAL_FEATUREPATCH_REPOSITORY)/$$FP_NAME;	\
	if [ -f $$FP_DIR/series ]; then						\
		for PATCH_NAME in `$(CAT) $$FP_DIR/series`; do			\
			echo "patchin' $$PATCH_NAME ...";			\
			$(CAT) $$FP_DIR/$$PATCH_NAME.patch | 			\
			     $(PATCH) -Np1 -d $$FP_TARGET || exit -1; 		\
		done;								\
	else									\
		echo "feature-patchin' in $$FP_DIR...";				\
		$(CD) $$FP_DIR && for PATCH_NAME in 				\
			$$(find . -name "*patch*")				\
			$$(find . -name "*diff*"); do				\
			PATCH_NAME_BASE=`basename $$PATCH_NAME`;		\
			echo "basename=$$PATCH_NAME_BASE";			\
			case $$PATCH_NAME_BASE in				\
			*.gz)							\
				echo "patch is gzip compressed";		\
				CAT=$(ZCAT);					\
				;;						\
			*.bz2)							\
				echo "patch is bzip2 compressed";		\
				CAT=$(BZCAT);					\
				;;						\
			*)							\
				echo "patch is uncompressed";			\
				CAT=$(CAT)					\
				;;						\
			esac;							\
			echo "patchin' $$PATCH_NAME ...";			\
			if [ ! -e $$PATCH_NAME ]; then 				\
				echo "Error: patch $$PATCH_NAME doesn't exist!";\
				exit -1; 					\
			fi; 							\
			$$CAT $$PATCH_NAME | $(PATCH) -Np1 -d $$FP_TARGET;	\
			if [ $$? -ne 0 ]; then					\
				echo "Error: feature_patchin failed!";		\
				exit -1;					\
			fi;							\
		done;								\
	fi;									\

#
# install_copy
# 
# Installs a file with user/group ownership and permissions via
# fakeroot. 
#
# $1: UID
# $2: GID
# $3: permissions (octal)
# $4: source (for files); directory (for directories)
# $5: destination (for files); empty (for directories). Prefixed with $(ROOTDIR), 
#     so it needs to have a leading /
# $6: strip (for files; y|n); default is to strip
#
install_copy = 											\
	OWN=`echo $(1) | sed -e 's/[[:space:]]//g'`;						\
	GRP=`echo $(2) | sed -e 's/[[:space:]]//g'`;						\
	PER=`echo $(3) | sed -e 's/[[:space:]]//g'`;						\
	SRC=`echo $(4) | sed -e 's/[[:space:]]//g'`;						\
	DST=`echo $(5) | sed -e 's/[[:space:]]//g'`;						\
	STRIP="$(strip $(6))";									\
	if [ -z "$(5)" ]; then									\
		echo "install_copy:";								\
		echo "  dir=$$SRC";								\
		echo "  owner=$$OWN";								\
		echo "  group=$$GRP";								\
		echo "  permissions=$$PER";							\
		if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then					\
			$(INSTALL) -d $(IMAGEDIR)/ipkg/$$SRC;					\
			if [ $$? -ne 0 ]; then							\
				echo "Error: install_copy failed!";				\
				exit -1;							\
			fi;									\
		fi;										\
		$(INSTALL) -m $$PER -d $(ROOTDIR)/$$SRC;					\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit -1;								\
		fi;										\
		mkdir -p $(IMAGEDIR);								\
		echo "f:$$SRC:$$OWN:$$GRP:$$PER" >> $(IMAGEDIR)/permissions;			\
	else											\
		echo "install_copy:";								\
		echo "  src=$$SRC";								\
		echo "  dst=$$DST";								\
		echo "  owner=$$OWN";								\
		echo "  group=$$GRP";								\
		echo "  permissions=$$PER"; 							\
		if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then					\
			rm -fr $(IMAGEDIR)/ipkg/$$DST; 						\
			$(INSTALL) -D $$SRC $(IMAGEDIR)/ipkg/$$DST;				\
			if [ $$? -ne 0 ]; then							\
				echo "Error: install_copy failed!";				\
				exit -1;							\
			fi;									\
		fi; 										\
		$(INSTALL) -m $$PER -D $$SRC $(ROOTDIR)$$DST;					\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit -1;								\
		fi;										\
		case "$$STRIP" in								\
		(0 | n | no)									\
			;;									\
		(*)										\
			if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then				\
				$(CROSS_STRIP) -R .note -R .comment $(IMAGEDIR)/ipkg/$$DST;	\
			fi;									\
			$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)$$DST;			\
			;;									\
		esac;										\
		mkdir -p $(IMAGEDIR);								\
		echo "f:$$DST:$$OWN:$$GRP:$$PER" >> $(IMAGEDIR)/permissions;			\
	fi

#
# install_copy_toolchain_lib
#
# $1: source
# $2: destination
# $2: strip (y|n)	default is to strip
#
install_copy_toolchain_lib =									\
	LIB="$(strip $1)";									\
	DST="$(strip $2)";									\
	STRIP="$(strip $3)";									\
												\
	LIB_DIR=`$(CROSS_CC) -print-file-name=$${LIB} | sed -e "s,/$${LIB}\$$,,"`;		\
												\
	if test \! -d "$${LIB_DIR}"; then							\
		echo "install_copy_toolchain_lib: $${LIB_DIR} not found";			\
		exit -1;									\
	fi;											\
												\
	LIB="$(strip $1)";									\
	for FILE in `find $${LIB_DIR} -maxdepth 1 -type l -name "$${LIB}*"`; do			\
		LIB=`basename $${FILE}`;							\
		while test -n "$${LIB}"; do							\
			echo "install_copy_toolchain_lib lib=$${LIB} dst=$${DST}";		\
			rm -fr $(ROOTDIR)$${DST}/$${LIB};					\
			mkdir -p $(ROOTDIR)$${DST};						\
			if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then				\
				mkdir -p $(IMAGEDIR)/ipkg/$${DST};				\
			fi;									\
			if test -h $${LIB_DIR}/$${LIB}; then					\
				cp -d $${LIB_DIR}/$${LIB} $(ROOTDIR)$${DST}/;			\
				if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then			\
					cp -d $${LIB_DIR}/$${LIB} $(IMAGEDIR)/ipkg/$${DST}/;	\
				fi;								\
			elif test -f $${LIB_DIR}/$${LIB}; then					\
				$(INSTALL) -D $${LIB_DIR}/$${LIB} $(ROOTDIR)$${DST}/$${LIB};	\
				if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then			\
					$(INSTALL) -D $${LIB_DIR}/$${LIB} $(IMAGEDIR)/ipkg/$${DST}/$${LIB};\
				fi; 								\
				case "$${STRIP}" in						\
				0 | n | no)							\
					;;							\
				*)								\
					$(CROSS_STRIP) $(ROOTDIR)$${DST}/$${LIB};		\
					if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then		\
						$(CROSS_STRIP) $(IMAGEDIR)/ipkg/$${DST}/$${LIB};\
					fi;							\
					;;							\
				esac;								\
				mkdir -p $(IMAGEDIR);						\
				echo "f:$${DST}/$${LIB}:0:0:755" >> $(IMAGEDIR)/permissions;	\
			else									\
				echo "error: found $${LIB}, but no file or link";		\
				echo;								\
				exit -1;							\
			fi;									\
			LIB="`readlink $${LIB_DIR}/$${LIB} | sed s,^\\\\.,$${LIB_DIR}/\.,`";	\
			if [ -n "$$LIB" ]; then							\
				if [ "`dirname $$LIB`" != "." ]; then				\
					LIB_DIR=`dirname $$LIB`;				\
				fi;								\
				LIB=`basename $$LIB`;						\
			fi;									\
		done;										\
	done;											\
												\
	echo -n

#
# install_copy_toolchain_dl
#
# $1: destination
# $2: strip (y|n)	default is to strip
#
install_copy_toolchain_dl =									\
	DST="$(strip $1)";									\
	STRIP="$(strip $2)";									\
												\
	LIB="`echo 'int main(void){return 0;}' | 						\
		$(CROSS_CC) -x c -o /dev/null -v - 2>&1 | 					\
		grep dynamic-linker | 								\
		perl -n -p -e 's/.* -dynamic-linker ([^ ]*).*/\1/'`";				\
												\
	LIB="`basename $${LIB}`";								\
												\
	LIB_DIR=`$(CROSS_CC) -print-file-name=$${LIB} | sed -e "s,/$${LIB}\$$,,"`;		\
												\
	if test \! -d "$${LIB_DIR}"; then							\
		echo "copy_toolchain_ld_root: lib=$${LIB} not found";				\
		exit -1;									\
	fi;											\
												\
	for FILE in `find $${LIB_DIR} -maxdepth 1 -type l -name "$${LIB}*"`; do			\
		LIB=`basename $${FILE}`;							\
		while test -n "$${LIB}"; do							\
			echo "copy_toolchain_ld_root lib=$${LIB} dst=$${DST}";			\
			rm -fr $(ROOTDIR)$${DST}/$${LIB};					\
			mkdir -p $(ROOTDIR)$${DST};						\
			if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then				\
				rm -fr $(IMAGEDIR)/ipkg/$${DST}/$${LIB};			\
				mkdir -p $(IMAGEDIR)/ipkg/$${DST};				\
			fi;									\
			if test -h $${LIB_DIR}/$${LIB}; then					\
				cp -d $${LIB_DIR}/$${LIB} $(ROOTDIR)$${DST}/;			\
				if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then			\
					cp -d $${LIB_DIR}/$${LIB} $(IMAGEDIR)/ipkg/$${DST}/;	\
				fi;								\
			elif test -f $${LIB_DIR}/$${LIB}; then					\
				$(INSTALL) -D $${LIB_DIR}/$${LIB} $(ROOTDIR)$${DST}/$${LIB};	\
				if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then			\
					$(INSTALL) -D $${LIB_DIR}/$${LIB} $(IMAGEDIR)/ipkg/$${DST}/$${LIB};\
				fi;								\
				case "$${STRIP}" in						\
				0 | n | no)							\
					;;							\
				*)								\
					$(CROSS_STRIP) $(ROOTDIR)$${DST}/$${LIB};		\
					if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then		\
						$(CROSS_STRIP) $(ROOTDIR)$${DST}/$${LIB};	\
					fi;							\
					;;							\
				esac;								\
				mkdir -p $(IMAGEDIR);						\
				echo "f:$${DST}/$${LIB}:0:0:755" >> $(IMAGEDIR)/permissions;	\
			else									\
				exit -1;							\
			fi;									\
			LIB="`readlink $${LIB_DIR}/$${LIB}`";					\
		done;										\
	done;											\
												\
	echo -n

#
# install_link
# 
# Installs a soft link in root directory in an ipkg packet. 
# 
# $1: source
# $2: destination
#
install_link =									\
	SRC=$(strip $(1));							\
	DST=$(strip $(2));							\
	rm -fr $(ROOTDIR)$$DST;							\
	echo "install_link: src=$$SRC dst=$$DST "; 				\
	mkdir -p `dirname $(ROOTDIR)$$DST`;					\
	$(LN) -sf $$SRC $(ROOTDIR)$$DST; 					\
	if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then				\
		mkdir -p `dirname $(IMAGEDIR)/ipkg$$DST`;			\
		$(LN) -sf $$SRC $(IMAGEDIR)/ipkg/$$DST;				\
	fi

#
# install_node
#
# Installs a device node in root directory in an ipkg packet.
#
# $1: UID
# $2: GID
# $3: permissions (octal)
# $4: type
# $5: major
# $6: minor
# $7: device node name
#
install_node =				\
	OWN=$(strip $(1));		\
	GRP=$(strip $(2));		\
	PER=$(strip $(3));		\
	TYP=$(strip $(4));		\
	MAJ=$(strip $(5));		\
	MIN=$(strip $(6));		\
	DEV=$(strip $(7));		\
	echo "install_node:";		\
	echo "  owner=$$OWN";		\
	echo "  group=$$GRP";		\
	echo "  permissions=$$PER";	\
	echo "  type=$$TYP";		\
	echo "  major=$$MAJ";		\
	echo "  minor=$$MIN";		\
	echo "  name=$$DEV";		\
	mkdir -p $(IMAGEDIR);		\
	echo "n:$$DEV:$$OWN:$$GRP:$$PER:$$TYP:$$MAJ:$$MIN" >> $(IMAGEDIR)/permissions

#
# install_fixup
#
# Replaces @...@ sequences in rules/*.ipkg files
#
# $1: sequence to be replaced
# $2: replacement
#
install_fixup = 									\
	if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then					\
		REPLACE_FROM=$(strip $(1));						\
		REPLACE_TO=$(strip $(2));						\
		echo -n "install_fixup:  @$$REPLACE_FROM@ -> $$REPLACE_TO ... "; 	\
		perl -i -p -e "s,\@$$REPLACE_FROM@,$$REPLACE_TO,g" $(IMAGEDIR)/ipkg/CONTROL/control;	\
		echo "done.";								\
	fi

#
# install_init
#
# Deletes $(IMAGEDIR)/ipkg and prepares for new ipkg package creation
#
install_init =											\
	if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then						\
		PACKET=$(strip $(1));								\
		echo "install_init: preparing for image creation...";				\
		rm -fr $(IMAGEDIR)/ipkg;							\
		mkdir -p $(IMAGEDIR)/ipkg/CONTROL; 						\
		cp -f $(RULESDIR)/default.ipkg $(IMAGEDIR)/ipkg/CONTROL/control;		\
		if [ -z $(PTXCONF_IMAGE_IPKG_ARCH) ]; then					\
			echo "Error: please specify an architecure name for ipkg!";		\
			exit -1;								\
		fi;										\
		REPLACE_FROM="ARCH";								\
		REPLACE_TO=$(PTXCONF_IMAGE_IPKG_ARCH);						\
		echo -n "install_init:   @$$REPLACE_FROM@ -> $$REPLACE_TO ... ";	 	\
		perl -i -p -e "s,\@$$REPLACE_FROM@,$$REPLACE_TO,g" $(IMAGEDIR)/ipkg/CONTROL/control;	\
		echo "done";									\
	fi

#
# install_finish
#
# Finishes ipkg packet creation
#
install_finish = 													\
	export LANG=C; 													\
	if [ "$(PTXCONF_IMAGE_IPKG)" != "" ]; then									\
		echo -n "install_finish: writing ipkg packet ... ";							\
		(echo "pushd $(IMAGEDIR)/ipkg;"; $(AWK) -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions; echo "popd;"; 	\
		echo "$(PTXCONF_HOST_PREFIX)/usr/bin/ipkg-build $(PTXCONF_IMAGE_IPKG_EXTRA_ARGS) $(IMAGEDIR)/ipkg $(IMAGEDIR)") |\
			$(FAKEROOT) -- 2>&1 | grep -v "cannot access" | grep -v "No such file or directory";		\
		rm -fr $(IMAGEDIR)/ipkg;										\
		echo "done."; 												\
	fi

# ----------------------------------------------------
#  autogeneration of dependencies
# ----------------------------------------------------

package_depfile=\
	$(STATEDIR)/$(shell basename $(patsubst %.make,%.dep,$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))))

# vim: syntax=make
