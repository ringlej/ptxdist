# -*-makefile-*-
PASSIVEFTP	= --passive-ftp
SUDO		= sudo
PTXUSER		= $(shell echo $$USER)
GNU_BUILD	= $(shell $(TOPDIR)/scripts/config.guess)
GNU_HOST	= $(shell echo $(GNU_BUILD) | sed s/-[a-zA-Z0-9_]*-/-host-/)
HOSTCC		= gcc
HOSTCC_ENV	= CC=$(HOSTCC)
CROSSSTRIP	= PATH=$(CROSS_PATH) $(PTXCONF_GNU_TARGET)-strip
CROSS_STRIP	= $(CROSSSTRIP)
DOT		= dot
DEP_OUTPUT	= depend.out
DEP_TREE_PS	= deptree.ps

#
# some convenience functions
#

ifneq (y, $(PTXCONF_BUILD_CROSSCHAIN))
compilercheck =								\
	echo -n "compiler check...";					\
	if [ ! -x `which $(PTXCONF_GNU_TARGET)-gcc` ]; then		\
		echo; echo;						\
		echo "No compiler installed!";				\
		echo "Specified: $(PTXCONF_GNU_TARGET)-gcc";		\
		echo;							\
		exit -1;						\
	fi;								\
	if [ "$(PTXCONF_CROSSCHAIN_CHECK)" != `$(PTXCONF_GNU_TARGET)-gcc -dumpversion` ]; then	\
		echo; echo;						\
		echo "Please use the specified compiler!";		\
		echo;							\
		echo "Specified: $(PTXCONF_CROSSCHAIN_CHECK)";		\
		echo "Found:     "`$(PTXCONF_GNU_TARGET)-gcc -dumpversion`;\
		echo;							\
		exit -1;						\
	fi;								\
	echo "ok";
else
compilercheck =								\
	echo > /dev/null;
endif

#
# print out header information and check if we have the right compiler
#
targetinfo = 						\
	echo;						\
	TG=`echo $(1) | sed -e "s,/.*/,,g"`; 		\
	LINE=`echo target: $$TG |sed -e "s/./-/g"`;	\
	echo $$LINE;					\
	echo target: $$TG;				\
	echo $$LINE;					\
	echo;						\
	if [ `echo $$TG | grep "\.compile"` ]; then	\
		$(call compilercheck)			\
	fi;						\
	if [ `echo $$TG | grep "\.prepare"` ]; then	\
		$(call compilercheck)			\
	fi;						\
	echo $@ : $^ | sed -e "s@$(TOPDIR)@@g" -e "s@/src/@@g" -e "s@/state/@@g" >> $(DEP_OUTPUT)


#
# extract the given source to builddir
#
# $1 = filename to extract
# $2 = dir into extract
#
# if $2 is not given, it is extracted to the BUILDDIR
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
	[ -d $$DEST ] || mkdir -p $$DEST;			\
	$$EXTRACT -dc $$PACKET | $(TAR) -C $$DEST -xf -

#
# download the given URL
#
# $1 = URL of the packet
# $2 = source dir
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
	[ -d $$SRC ] || mkdir -p $$SRC;				\
	case $$URLTYPE in 					\
	http)							\
		$(WGET) -P $$SRC $(PASSIVEFTP) $$URL;		\
		[ $$? -eq 0 ] || {				\
			echo;					\
			echo "Could not get packet via http!";	\
			echo "URL: $$URL";			\
			echo;					\
			exit -1;				\
			};					\
		;;						\
	ftp)							\
		$(WGET) -P $$SRC $(PASSIVEFTP) $$URL;		\
		[ $$? -eq 0 ] || {				\
			echo;					\
			echo "Could not get packet via ftp!";	\
			echo "URL: $$URL";			\
			echo;					\
			exit -1;				\
			};					\
		;;						\
	file)							\
		FILE="$$(echo $$URL | sed s-file://-/-g)";	\
		cp -av $$FILE $$SRC;				\
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
# download the given URL
#
# $1 = name of the package the patch has to be applied to 
# $2 = URL of the patch; this may either point to a single unified diff
#      or to a directory containing a 'patcher' like patch series
# $3 = patch name; the patch is stored in $(TOPDIR)/feature-patches/$3
# 
get_feature_patch =						\
	FP_PARENT="$(strip $(1))";				\
	FP_URL="$(strip $(2))";					\
	FP_NAME="$(strip $(3))";				\
	if [ -f $(TOPDIR)/feature-patches/$$FP_NAME/$$FP_FILE ]; then	\
		echo "patch already downloaded, skipping...";	\
		exit 0;						\
	fi;							\
	if [ "$$FP_URL" == "" ] && [ "$$FP_NAME" == "" ]; then	\
		echo "patch not set, silently dropping";	\
		exit 0;						\
	fi;							\
	if [ "$$FP_URL" == "" ] || [ "$$FP_NAME" == "" ]; then	\
		echo;						\
		echo "Error: empty feature patch name or URL";	\
		echo;						\
		exit -1;					\
	fi;							\
	FP_DIR="$(TOPDIR)/feature-patches/$$FP_NAME";		\
	[ -d $$FP_DIR ] || mkdir -p $$FP_DIR;			\
	[ "$$(expr match $$FP_URL http://)" != "0" ] && FP_URLTYPE="http"; \
        [ "$$(expr match $$FP_URL ftp://)" != "0" ] && FP_URLTYPE="ftp";   \
        [ "$$(expr match $$FP_URL file://)" != "0" ] && FP_URLTYPE="file"; \
	case $$FP_URLTYPE in                                    \
        http)                                                   \
                $(WGET) -r -np -nd -nH --cut-dirs=0 -P $$FP_DIR $(PASSIVEFTP) $$FP_URL; \
		[ $$? -eq 0 ] || {                              \
                        echo;                                   \
                        echo "Could not get feature patch via http!";  \
                        echo "URL: $$URL";                      \
                        echo;                                   \
                        exit -1;                                \
                        };                                      \
                ;;                                              \
        ftp)                                                    \
                $(WGET) -r -np -nd -nH --cut-dirs=0 -P $$FP_DIR $(PASSIVEFTP) $$FP_URL; \
		[ $$? -eq 0 ] || {                              \
                        echo;                                   \
                        echo "Could not get feature patch via ftp!";   \
                        echo "URL: $$URL";                      \
                        echo;                                   \
                        exit -1;                                \
                        };                                      \
                ;;                                              \
        file)                                                   \
                FP_FILE="$$(echo $$FP_URL | sed s-file://-/-g)";\
                cp -av $$FP_FILE $$FP_DIR;                      \
                [ $$? -eq 0 ] || {                              \
                        echo;                                   \
                        echo "Could not copy feature patch!";   \
                        echo "File: $$FILE";                    \
                        echo;                                   \
                        exit -1;                                \
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
# download patches from Pengutronix' patch repository
# 
# $1 = packet name = identifier for patch subdir
# 
# the wget options:
# ----------------
# -r -l1		recursive 1 level
# -nH --cutdirs=3	remove hostname and next 3 dirs from URL, when saving
#			so "http://www.pengutronix.de/software/ptxdist-cvs/patches/glibc-2.2.5/*"
#			becomes "glibc-2.2.5/*"
#
get_patches =											\
	PACKET_NAME="$(strip $(1))";								\
	if [ "$$PACKET_NAME" = "" ]; then							\
		echo;										\
		echo Error: empty parameter to \"get_pachtes\(\)\";				\
		echo;										\
		exit -1;									\
	fi;											\
	if [ "$(EXTRAVERSION)" = "-cvs" ]; then							\
		PATCH_TREE=cvs;									\
	else											\
		PATCH_TREE=$(FULLVERSION);							\
	fi;											\
	if [ ! -d $(PATCHDIR) ]; then								\
		mkdir -p $(PATCHDIR);								\
	fi;											\
	if [ -d $(PATCHDIR)/$$PACKET_NAME ]; then						\
		rm -fr $(PATCHDIR)/$$PACKET_NAME;						\
	fi;											\
	$(WGET) -r -l 1 -nH --cut-dirs=3 -A.diff -A.patch -A.gz -A.bz2 -q -P $(PATCHDIR)	\
		$(PASSIVEFTP) $(PTXPATCH_URL)-$$PATCH_TREE/$$PACKET_NAME/generic/;		\
	[ $$? -eq 0 ] || {									\
		echo;										\
		echo "Could not get patch!";							\
		echo "URL: $(PTXPATCH_URL)-$$PATCH_TREE/$$PACKET_NAME/generic/";		\
		echo;										\
		exit -1;									\
	};											\
	$(WGET) -r -l 1 -nH --cut-dirs=3 -A.diff -A.patch -A.gz -A.bz2 -q -P $(PATCHDIR)	\
		$(PASSIVEFTP) $(PTXPATCH_URL)-$$PATCH_TREE/$$PACKET_NAME/$(PTXCONF_ARCH)/;	\
	[ $$? -eq 0 ] || {									\
		echo;										\
		echo "Could not get patch!";							\
		echo "URL: $(PTXPATCH_URL)-$$PATCH_TREE/$$PACKET_NAME/$(PTXCONF_ARCH)/ ";	\
		echo;										\
		exit -1;									\
	};											\
	if [ -d $(PATCHDIR)-local/$$PACKET_NAME ]; then						\
		echo "Copying Local patches from patches-local/"$$PACKET_NAME;			\
		cp -vr $(PATCHDIR)-local/$$PACKET_NAME $(PATCHDIR);				\
	fi;											\
	true

#
# returns an options from the .config file
#
# $1 = regex, that's applied to the .config file
#      format: 's/foo/bar/'
#
# $2 = default option, this value is returned if the regex outputs nothing
#
get_option =										\
	$(shell										\
		REGEX="$(strip $(1))";							\
		DEFAULT="$(strip $(2))";						\
		if [ -f $(TOPDIR)/.config ]; then					\
			VALUE=`cat $(TOPDIR)/.config | sed -n -e "$${REGEX}p"`;		\
		fi;									\
		echo $${VALUE:-$$DEFAULT}						\
	)

#
# returns an options from the .config file
#
# $1 = regex, that's applied to the .config file
#      format: 's/foo/bar/'
# $2 = command that get in STDIN the output from the regex magic
#      should return something in STDOUT
#
get_option_ext =									\
	$(shell										\
		REGEX="$(strip $(1))";							\
		if [ -f $(TOPDIR)/.config ]; then					\
			cat $(TOPDIR)/.config | sed -n -e "$${REGEX}p" | $(2);		\
		fi;									\
	)


#
# cleanup the given directory or file
#
clean =								\
	DIR="$(strip $(1))";					\
	if [ -e $$DIR ]; then					\
		rm -rf $$DIR;					\
	fi

# 	if [ "$$DIR" = "" ]; then				\
# 		echo;						\
# 		echo Error: empty parameter to \"clean\(\)\";	\
# 		echo;						\
# 		exit -1;					\
# 	fi;							\


#
# find latest config
#
latestconfig = `find $(TOPDIR)/config -name $(1)* -print | sort | tail -1`


#
# enables a define, removes /* */
#
# (often found in .c or .h files)
#
# $1 = file
# $2 = parameter
#
enable_c =											\
	FILENAME="$(strip $(1))";								\
	PARAMETER="$(strip $(2))";								\
	perl -p -i -e										\
		"s,^\s*(\/\*)?\s*(\#\s*define\s+$$PARAMETER)\s*(\*\/)?$$,\$$2\n,"		\
		$$FILENAME

#
# disables a define with, adds /* */
#
# (often found in .c or .h files)
#
# $1 = file
# $2 = parameter
#
disable_c =											\
	FILENAME="$(strip $(1))";								\
	PARAMETER="$(strip $(2))";								\
	perl -p -i -e										\
		"s,^\s*(\/\*)?\s*(\#\s*define\s+$$PARAMETER)\s*(\*\/)?$$,\/\*\$$2\*\/\n,"	\
		$$FILENAME

#
# enabled something, removes #
#
# often found in shell scripts, Makefiles
#
# $1 = file
# $2 = parameter
#
enable_sh =						\
	FILENAME="$(strip $(1))";			\
	PARAMETER="$(strip $(2))";			\
	perl -p -i -e					\
		"s,^\s*(\#)?\s*($$PARAMETER),\$$2,"	\
		$$FILENAME

#
# disables a comment, adds #
#
# often found in shell scripts, Makefiles
#
# $1 = file
# $2 = parameter
#
disable_sh =						\
	FILENAME="$(strip $(1))";			\
	PARAMETER="$(strip $(2))";			\
	perl -p -i -e					\
		"s,^\s*(\#)?\s*($$PARAMETER),\#\$$2,"	\
		$$FILENAME

#
# go into a directory and apply all patches from there into a sourcetree
#
# $1 = $(PACKET_NAME) -> identifier
# $2 = path to source tree 
#      if this parameter is omitted, the path will be derived
#      from the packet name
#
patchin =									\
	PACKET_NAME="$(strip $(1))";						\
	if [ "$$PACKET_NAME" = "" ]; then					\
		echo;								\
		echo Error: empty parameter to \"patchin\(\)\";			\
		echo;								\
		exit -1;							\
	fi;									\
	PACKET_DIR="$(strip $(2))";						\
	PACKET_DIR=$${PACKET_DIR:-$(BUILDDIR)/$$PACKET_NAME};			\
	for PATCH_NAME in							\
	    $(TOPDIR)/patches/$$PACKET_NAME/generic/*.diff			\
	    $(TOPDIR)/patches/$$PACKET_NAME/generic/*.patch			\
	    $(TOPDIR)/patches/$$PACKET_NAME/generic/*.gz			\
	    $(TOPDIR)/patches/$$PACKET_NAME/generic/*.bz2			\
	    $(TOPDIR)/patches/$$PACKET_NAME/$(PTXCONF_ARCH)/*.diff		\
	    $(TOPDIR)/patches/$$PACKET_NAME/$(PTXCONF_ARCH)/*.patch		\
	    $(TOPDIR)/patches/$$PACKET_NAME/$(PTXCONF_ARCH)/*.gz		\
	    $(TOPDIR)/patches/$$PACKET_NAME/$(PTXCONF_ARCH)/*.bz2;		\
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
			echo "patchin' $$PATCH_NAME ...";			\
			$$CAT $$PATCH_NAME | $(PATCH) -Np1 -d $$PACKET_DIR || exit -1;	\
		fi;								\
	    done

#
# apply a patch
#
# $1 = the name of the patch to apply
# $2 = apply patch to that directory
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
# go into a directory, look for either a 'series' file and apply all 
# patches listed there into a sourcetree, or, if no 'series' file
# exists, apply the patches as they come
#
# $1 = $(FP_TARGET): path to source tree where the feature patch is
#      to be applied  
#
# $2 = $(FP_NAME): name of the patch to be applied; patches usually live 
#      in $(TOPDIR)/feature-patches/$(FP_NAME). Patches without a name 
#      are silently ignored. 
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
	FP_DIR=$(TOPDIR)/feature-patches/$$FP_NAME;				\
	if [ -f $$FP_DIR/series ]; then						\
		for PATCH_NAME in `cat $$FP_DIR/series`; do			\
			echo "patchin' $$PATCH_NAME ...";			\
			cat $$FP_DIR/$$PATCH_NAME.patch | 			\
			     $(PATCH) -Np1 -d $$FP_TARGET || exit -1; 		\
		done;								\
	else									\
		echo "feature-patchin' in $$FP_DIR...";				\
		cd $$FP_DIR && for PATCH_NAME in 				\
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
# CFLAGS // CXXFLAGS
#
# the TARGET_CFLAGS and TARGET_CXXFLAGS are included from the architecture
# depended config file that is specified in .config
#
# the option in the .config is called 'TARGET_CONFIG_FILE'
#
#
TARGET_CFLAGS		+= $(PTXCONF_TARGET_EXTRA_CFLAGS)
TARGET_CXXFLAGS		+= $(PTXCONF_TARGET_EXTRA_CXXFLAGS)
TARGET_CPPFLAGS		+= $(PTXCONF_TARGET_EXTRA_CPPFLAGS)
TARGET_LDFLAGS		+= $(PTXCONF_TARGET_EXTRA_LDFLAGS)

#
# if we use an external crosschain set include and lib dirs correctly
#
ifndef $(PTXCONF_BUILD_CROSSCHAIN)
TARGET_CFLAGS		+= -I$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
TARGET_CXXFLAGS		+= -I$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
TARGET_CPPFLAGS		+= -I$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
TARGET_LDFLAGS		+= -L$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
endif

#
# crossenvironment
#
CROSS_ENV_AR		= AR=$(PTXCONF_GNU_TARGET)-ar
CROSS_ENV_AS		= AS=$(PTXCONF_GNU_TARGET)-as
CROSS_ENV_LD		= LD=$(PTXCONF_GNU_TARGET)-ld
CROSS_ENV_NM		= NM=$(PTXCONF_GNU_TARGET)-nm
CROSS_ENV_CC		= CC=$(PTXCONF_GNU_TARGET)-gcc
CROSS_ENV_CXX		= CXX=$(PTXCONF_GNU_TARGET)-g++
CROSS_ENV_OBJCOPY	= OBJCOPY=$(PTXCONF_GNU_TARGET)-objcopy
CROSS_ENV_OBJDUMP	= OBJDUMP=$(PTXCONF_GNU_TARGET)-objdump
CROSS_ENV_RANLIB	= RANLIB=$(PTXCONF_GNU_TARGET)-ranlib
CROSS_ENV_STRIP		= STRIP=$(PTXCONF_GNU_TARGET)-strip
ifneq ('','$(strip $(subst ",,$(TARGET_CFLAGS)))')
CROSS_ENV_CFLAGS	= CFLAGS='$(strip $(subst ",,$(TARGET_CFLAGS)))'
endif
ifneq ('','$(strip $(subst ",,$(TARGET_CXXFLAGS)))')
CROSS_ENV_CXXFLAGS	= CXXFLAGS='$(strip $(subst ",,$(TARGET_CXXFLAGS)))'
endif
ifneq ('','$(strip $(subst ",,$(TARGET_CPPFLAGS)))')
CROSS_ENV_CPPFLAGS	= CPPFLAGS='$(strip $(subst ",,$(TARGET_CPPFLAGS)))'
endif
ifneq ('','$(strip $(subst ",,$(TARGET_LDFLAGS)))')
CROSS_ENV_LDFLAGS	= LDFLAGS='$(strip $(subst ",,$(TARGET_LDFLAGS)))'
endif

CROSS_ENV := \
	$(CROSS_ENV_AR) \
	$(CROSS_ENV_AS) \
	$(CROSS_ENV_CXX) \
	$(CROSS_ENV_CC) \
	$(CROSS_ENV_LD) \
	$(CROSS_ENV_NM) \
	$(CROSS_ENV_OBJCOPY) \
	$(CROSS_ENV_OBJDUMP) \
	$(CROSS_ENV_RANLIB) \
	$(CROSS_ENV_STRIP) \
	$(CROSS_ENV_CFLAGS) \
	$(CROSS_ENV_CPPFLAGS) \
	$(CROSS_ENV_LDFLAGS) \
	$(CROSS_ENV_CXXFLAGS) \
	ac_cv_func_getpgrp_void=yes \
	ac_cv_func_setpgrp_void=yes \
	ac_cv_sizeof_long_long=8 \
	ac_cv_func_memcmp_clean=yes \
	ac_cv_func_setvbuf_reversed=no \
	ac_cv_func_getrlimit=yes


#
# CROSS_LIB_DIR	= the libs for the target system are installed into this dir
#
CROSS_LIB_DIR		= $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)

#
# Use the masquerading method of invoking distcc if enabled
#
#
ifdef PTXCONF_XCHAIN-DISTCC
# FIXME: should also allow use of DISTCC for native stuff
DISTCC_PATH_COLON     = $(PTXCONF_PREFIX)/lib/distcc/bin:
endif

#
# prepare the search path
#
CROSS_PATH		= $(DISTCC_PATH_COLON)$(PTXCONF_PREFIX)/bin:$$PATH

#
# same as PTXCONF_GNU_TARGET, but w/o -linux
# e.g. i486 instead of i486-linux
#
SHORT_TARGET		:= `echo $(PTXCONF_GNU_TARGET) |  perl -i -p -e 's/(.*?)-.*/$$1/'`

#
# change this if you have some wired configuration :)
#
SH		:= /bin/sh
WGET		:= wget
MAKE		:= make
PATCH		:= patch
TAR		:= tar
GZIP		:= gzip
ZCAT		:= zcat
BZIP2		:= bzip2
BZCAT		:= bzcat
CAT		:= cat
RM		:= rm
MKDIR		:= mkdir
CD		:= cd
MV		:= mv
CP		:= cp
LN		:= ln
PERL		:= perl
GREP		:= grep
INSTALL		:= install

# vim: syntax=make
