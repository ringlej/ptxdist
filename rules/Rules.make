#
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
GNU_BUILD	= $(shell $(TOPDIR)/scripts/config.guess)
GNU_HOST	= $(shell echo $(GNU_BUILD) | sed s/-[a-zA-Z0-9_]*-/-host-/)
CROSSSTRIP	= PATH=$(CROSS_PATH) $(PTXCONF_COMPILER_PREFIX)strip
DEP_OUTPUT	= depend.out
DEP_TREE_PS	= deptree.ps

SUDO		= sudo
HOSTCC		= gcc
CROSS_STRIP	= $(CROSSSTRIP)
DOT		= dot
SH		= /bin/sh
WGET		= wget
MAKE		= make
PATCH		= patch
TAR		= tar
GZIP		= gzip
ZCAT		= zcat
BZIP2		= bzip2
BZCAT		= bzcat
CAT		= cat
RM		= rm
MKDIR		= mkdir
CD		= cd
MV		= mv
CP		= cp
LN		= ln
PERL		= perl
GREP		= grep
INSTALL		= install

HOSTCC_ENV	= CC=$(HOSTCC)


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
TARGET_CFLAGS		+= -isystem $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include 
# TARGET_CFLAGS		+= -isystem $(shell GCC=$(PTXCONF_COMPILER_PREFIX)gcc $(TOPDIR)/scripts/sysinclude_test)
TARGET_CXXFLAGS		+= -isystem $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
# TARGET_CXXFLAGS	+= -isystem $(shell GCC=$(PTXCONF_COMPILER_PREFIX)g++ $(TOPDIR)/scripts/sysinclude_test)
TARGET_CPPFLAGS		+= -isystem $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
# TARGET_CPPFLAGS	+= -isystem $(shell GCC=$(PTXCONF_COMPILER_PREFIX)gcc $(TOPDIR)/scripts/sysinclude_test)
TARGET_LDFLAGS		+= -L$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib 
# FIXME: hack alert...
# TARGET_LDFLAGS	+= --dynamic-linker $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/ld-linux.so.2
endif


# Environment variables for toolchain components

CROSS_ENV_AR_PROG	= $(call remove_quotes,$(PTXCONF_COMPILER_PREFIX)ar)
CROSS_ENV_AR		= AR=$(CROSS_ENV_AR_PROG)
CROSS_ENV_AS		= AS=$(call remove_quotes,$(PTXCONF_COMPILER_PREFIX)as)
CROSS_ENV_LD		= LD=$(call remove_quotes,$(PTXCONF_COMPILER_PREFIX)ld)
CROSS_ENV_NM		= NM=$(call remove_quotes,$(PTXCONF_COMPILER_PREFIX)nm)
CROSS_ENV_CC_PROG	= $(call remove_quotes,$(PTXCONF_COMPILER_PREFIX)gcc)
CROSS_ENV_CC		= CC=$(CROSS_ENV_CC_PROG)
CROSS_ENV_CC_FOR_BUILD	= CC_FOR_BUILD=$(call remove_quotes,$(HOSTCC))
CROSS_ENV_CPP_FOR_BUILD	= CPP_FOR_BUILD=$(call remove_quotes,$(HOSTCC))
CROSS_ENV_LINK_FOR_BUILD= LINK_FOR_BUILD=$(call remove_quotes,$(HOSTCC))
CROSS_ENV_CXX		= CXX=$(call remove_quotes,$(PTXCONF_COMPILER_PREFIX)g++)
CROSS_ENV_OBJCOPY	= OBJCOPY=$(call remove_quotes,$(PTXCONF_COMPILER_PREFIX)objcopy)
CROSS_ENV_OBJDUMP	= OBJDUMP=$(call remove_quotes,$(PTXCONF_COMPILER_PREFIX)objdump)
CROSS_ENV_RANLIB	= RANLIB=$(call remove_quotes,$(PTXCONF_COMPILER_PREFIX)ranlib)
CROSS_ENV_STRIP		= STRIP=$(call remove_quotes,$(PTXCONF_COMPILER_PREFIX)strip)

# FIXME: check if we have to add quotes for grouping here

ifneq ('','$(strip $(subst $(quote),,$(TARGET_CFLAGS)))')
CROSS_ENV_CFLAGS	= CFLAGS='$(call remove_quotes,$(TARGET_CFLAGS))'
endif
ifneq ('','$(strip $(subst $(quote),,$(TARGET_CXXFLAGS)))')
CROSS_ENV_CXXFLAGS	= CXXFLAGS='$(call remove_quotes,$(TARGET_CXXFLAGS))'
endif
ifneq ('','$(strip $(subst $(quote),,$(TARGET_CPPFLAGS)))')
CROSS_ENV_CPPFLAGS	= CPPFLAGS='$(call remove_quotes,$(TARGET_CPPFLAGS))'
endif
ifneq ('','$(strip $(subst $(quote),,$(TARGET_LDFLAGS)))')
CROSS_ENV_LDFLAGS	= LDFLAGS='$(call remove_quotes,$(TARGET_LDFLAGS))'
endif

# 
# CROSS_ENV is the environment usually set for all configure and compile
# calls in the packet makefiles. 
#
# The ac_cv_* variables are needed to tell configure scripts not to use
# AC_TRY_RUN and run cross compiled things on the development host
# 
CROSS_ENV := \
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
	$(CROSS_ENV_STRIP) \
	$(CROSS_ENV_CFLAGS) \
	$(CROSS_ENV_CPPFLAGS) \
	$(CROSS_ENV_LDFLAGS) \
	$(CROSS_ENV_CXXFLAGS) \
	ac_cv_func_getpgrp_void=yes \
	ac_cv_func_setpgrp_void=yes \
	ac_cv_sizeof_long_long=8 \
	ac_cv_sizeof_long_double=8 \
	ac_cv_func_memcmp_clean=yes \
	ac_cv_func_setvbuf_reversed=no \
	ac_cv_func_getrlimit=yes

#
# CROSS_LIB_DIR	= the libs for the target system are installed into this dir
#
CROSS_LIB_DIR = $(call remove_quotes,$(PTXCONF_PREFIX))/$(call remove_quotes,$(PTXCONF_GNU_TARGET))

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
CROSS_PATH = $(call remove_quotes,$(DISTCC_PATH_COLON))$(call remove_quotes,$(PTXCONF_PREFIX))/bin:$$PATH

#
# same as PTXCONF_GNU_TARGET, but w/o -linux
# e.g. i486 instead of i486-linux
#
SHORT_TARGET		:= `echo $(PTXCONF_GNU_TARGET) |  $(PERL) -i -p -e 's/(.*?)-.*/$$1/'`


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
ifneq (y, $(PTXCONF_CROSSTOOL))
compilercheck =								\
	echo -n "compiler check...";					\
	which $(PTXCONF_COMPILER_PREFIX)gcc > /dev/null 2>&1 || {	\
		echo; echo;						\
		echo "No compiler installed!";				\
		echo "Specified: $(PTXCONF_COMPILER_PREFIX)gcc";	\
		echo;							\
		exit -1;						\
	};								\
	if [ "$(PTXCONF_CROSSCHAIN_CHECK)" != `$(PTXCONF_COMPILER_PREFIX)gcc -dumpversion` ]; then	\
		echo; echo;						\
		echo "Please use the specified compiler!";		\
		echo;							\
		echo "Specified: $(PTXCONF_CROSSCHAIN_CHECK)";		\
		echo "Found:     "`$(PTXCONF_COMPILER_PREFIX)gcc -dumpversion`;\
		echo;							\
		exit -1;						\
	fi;								\
	echo "ok";
else
compilercheck =								\
	echo > /dev/null;
endif


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
# $1: Call program with -V and extract version number from the output;
#     the result is compared to the first argument. 
#
check_prog_version = 				\
	@if [ `$(1) -V | head -n 1 |		\
	awk '{gsub ("[a-zA-Z]",""); if ($$1 != $(2)) print "false"; else print "true"}'` == "false" ]; then \
		echo "need $(1) version $(2)";	\
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
#
targetinfo = 						\
	echo;						\
	TG=`echo $(1) | sed -e "s,/.*/,,g"`; 		\
	LINE=`echo target: $$TG |sed -e "s/./-/g"`;	\
	echo $$LINE;					\
	echo target: $$TG;				\
	echo $$LINE;					\
	echo;						\
	if [ `echo $$TG | $(GREP) "\.compile"` ]; then	\
		$(call compilercheck)			\
	fi;						\
	if [ `echo $$TG | $(GREP) "\.prepare"` ]; then	\
		$(call compilercheck)			\
	fi;						\
	echo $@ : $^ | sed -e "s@$(TOPDIR)@@g" -e "s@/src/@@g" -e "s@/state/@@g" >> $(DEP_OUTPUT)


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
	echo $$(basename $$PACKET) >> state/packetlist; 	\
	$$EXTRACT -dc $$PACKET | $(TAR) -C $$DEST -xf -	;	


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
	case $$URLTYPE in 					\
	http)							\
		$(WGET) -P $$SRC --passive-ftp $$URL;		\
		[ $$? -eq 0 ] || {				\
			echo;					\
			echo "Could not get packet via http!";	\
			echo "URL: $$URL";			\
			echo;					\
			exit -1;				\
			};					\
		;;						\
	ftp)							\
		$(WGET) -P $$SRC --passive-ftp $$URL;		\
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
# $3: patch name; the patch is stored in $(TOPDIR)/feature-patches/$3
# 
get_feature_patch =						\
	FP_PARENT="$(strip $(1))";				\
	FP_URL="$(strip $(2))";					\
	FP_NAME="$(strip $(3))";				\
	FP_FILE="$$(basename $$FP_URL)";                        \
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
	[ -d $$FP_DIR ] || $(MKDIR) -p $$FP_DIR;		\
	[ "$$(expr match $$FP_URL http://)" != "0" ] && FP_URLTYPE="http"; \
        [ "$$(expr match $$FP_URL ftp://)" != "0" ]  && FP_URLTYPE="ftp";  \
        [ "$$(expr match $$FP_URL file://)" != "0" ] && FP_URLTYPE="file"; \
	case $$FP_URLTYPE in                                    \
        http)                                                   \
                $(WGET) -r -np -nd -nH --cut-dirs=0 -P $$FP_DIR --passive-ftp $$FP_URL; \
		[ $$? -eq 0 ] || {                              \
                        echo;                                   \
                        echo "Could not get feature patch via http!";  \
                        echo "URL: $$URL";                      \
                        echo;                                   \
                        exit -1;                                \
                        };                                      \
                ;;                                              \
        ftp)                                                    \
                $(WGET) -r -np -nd -nH --cut-dirs=0 -P $$FP_DIR --passive-ftp $$FP_URL; \
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
                $(CP) -av $$FP_FILE $$FP_DIR;			\
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
# get_patches
# 
# Download patches from Pengutronix' patch repository. 
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
	echo "checking if patch dir ($(PATCHDIR)) exists..."; 					\
	if [ ! -d $(PATCHDIR) ]; then								\
		$(MKDIR) -p $(PATCHDIR);							\
	fi;											\
	echo "removing old patches from $(PATCHDIR)..."; 					\
	if [ -d $(PATCHDIR)/$$PACKET_NAME ]; then						\
		$(RM) -fr $(PATCHDIR)/$$PACKET_NAME;						\
	fi;											\
	echo "checking for local or net patches...";						\
	if [ -d $(PATCHDIR)-local ]; then							\
		echo "patches-local/ exists, using this one instead of Pengutronix server";	\
		if [ -d "$(PATCHDIR)-local/$$PACKET_NAME" ]; then 				\
			echo "patch found";							\
			$(CP) -vr $(PATCHDIR)-local/$$PACKET_NAME $(PATCHDIR);			\
		else										\
			echo "no patch available";						\
		fi;										\
	else											\
		echo "copying network patches from Pengutronix server"; 				\
		$(WGET) -r -l 1 -nH --cut-dirs=3 -A.diff -A.patch -A.gz -A.bz2 -q -P $(PATCHDIR)	\
			--passive-ftp $(PTXPATCH_URL)-$$PATCH_TREE/$$PACKET_NAME/generic/;		\
		[ $$? -eq 0 ] || {									\
			echo;										\
			echo "Could not get patch!";							\
			echo "URL: $(PTXPATCH_URL)-$$PATCH_TREE/$$PACKET_NAME/generic/";		\
			echo;										\
			exit -1;									\
		};											\
		$(WGET) -r -l 1 -nH --cut-dirs=3 -A.diff -A.patch -A.gz -A.bz2 -q -P $(PATCHDIR)	\
			--passive-ftp $(PTXPATCH_URL)-$$PATCH_TREE/$$PACKET_NAME/$(PTXCONF_ARCH)/;	\
		[ $$? -eq 0 ] || {									\
			echo;										\
			echo "Could not get patch!";							\
			echo "URL: $(PTXPATCH_URL)-$$PATCH_TREE/$$PACKET_NAME/$(PTXCONF_ARCH)/ ";	\
			echo;										\
			exit -1;									\
		};											\
		true;											\
	fi;


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
		if [ -f $(TOPDIR)/.config ]; then					\
			VALUE=`$(CAT) $(TOPDIR)/.config | sed -n -e "$${REGEX}p"`;	\
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
		if [ -f $(TOPDIR)/.config ]; then					\
			$(CAT) $(TOPDIR)/.config | sed -n -e "$${REGEX}p" | $(2);		\
		fi;									\
	)


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
# FIXME: obsolete
# 
# Go into a directory, look for either a 'series' file and apply all 
# patches listed there into a sourcetree, or, if no 'series' file
# exists, apply the patches as they come
#
# $1: $(FP_TARGET): path to source tree where the feature patch is
#     to be applied  
#
# $2: $(FP_NAME): name of the patch to be applied; patches usually live 
#     in $(TOPDIR)/feature-patches/$(FP_NAME). Patches without a name 
#     are silently ignored. 
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
# copy_root
# 
# Installs a file with user/group ownership and permissions via
# fakeroot. 
#
# $1: UID
# $2: GID
# $3: permissions (octal)
# $4: source (for files); directory (for directories)
# $5: destination (for files); empty (for directories). Prefixed with $(ROOTDIR)
#
copy_root = 									\
	@OWN=`echo $(1) | sed -e 's/[[:space:]]//g'`;				\
	GRP=`echo $(2) | sed -e 's/[[:space:]]//g'`;				\
	PER=`echo $(3) | sed -e 's/[[:space:]]//g'`;				\
	SRC=`echo $(4) | sed -e 's/[[:space:]]//g'`;				\
	DST=`echo $(5) | sed -e 's/[[:space:]]//g'`;				\
	rm -fr $(ROOTDIR)$$DST; 						\
	if [ -z "$(5)" ]; then									 \
		echo "copy_root dir=$$SRC owner=$$OWN group=$$GRP permissions=$$PER"; 		 \
		$(INSTALL) -D $(ROOTDIR)/$$SRC;							 \
		echo "$$SRC:$$OWN:$$GRP:$$PER" >> $(TOPDIR)/permissions;			 \
	else											 \
		echo "copy_root src=$$SRC dst=$$DST owner=$$OWN group=$$GRP permissions=$$PER";  \
		$(INSTALL) -D $$SRC $(ROOTDIR)/$$DST;						 \
		echo "$$DST:$$OWN:$$GRP:$$PER" >> $(TOPDIR)/permissions;			 \
	fi;


#
# link_root
# 
# Installs a soft link in root directory. 
# 
# $1: source
# $2: destination
#
link_root =									\
	@SRC=`echo $(1) | sed -e 's/[[:space:]]//g'`;				\
	DST=`echo $(2) | sed -e 's/[[:space:]]//g'`;				\
	rm -fr $(ROOTDIR)$$DST;							\
	echo "link_root src=$$SRC dst=$$DST "; 					\
	$(LN) -sf $$SRC $(ROOTDIR)$$DST


# vim: syntax=make
