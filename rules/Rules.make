# -*-makefile-*-
PASSIVEFTP	= --passive-ftp
SUDO		= sudo
PTXUSER		= $(shell echo $$USER)
GNU_HOST	= $(shell $(TOPDIR)/scripts/config.guess)
HOSTCC		= gcc
HOSTCC_ENV	= CC=$(HOSTCC)
CROSSSTRIP	= PATH=$(CROSS_PATH) (PTXCONF_GNU_TARGET)-strip
CROSS_STRIP	= $(CROSSSTRIP)
DOT		= dot
DEP_OUTPUT	= depend.out
DEP_TREE_PS	= deptree.ps

#
# some convenience functions
#

#
# print out header information
#
targetinfo=echo;					\
	TG=`echo $(1) | sed -e "s,/.*/,,g"`; 		\
	LINE=`echo target: $$TG |sed -e "s/./-/g"`;	\
	echo $$LINE;					\
	echo target: $$TG;				\
	echo $$LINE;					\
	echo;						\
	echo $@ : $^ | sed -e "s@$(TOPDIR)@@g" -e "s@/src/@@g" -e "s@/state/@@g" >> $(DEP_OUTPUT)


#
# extract the given source to builddir
#
extract =						\
	DEST="$(strip $(2))";				\
	DEST=$${DEST:-$(BUILDDIR)};			\
	case "$(strip $(1))" in				\
	*gz)						\
		EXTRACT=gzip				\
		;;					\
	*bz2)						\
		EXTRACT=bzip2				\
		;;					\
	*)						\
		false					\
		;;					\
	esac;						\
	[ -d $$DEST ] || mkdir -p $$DEST;		\
	$$EXTRACT -dc $(1) | $(TAR) -C $$DEST -xf -

#
# download the given URL
#
# $1 = URL of the packet
# $2 = source dir
# 
get =							\
	SRC="$(strip $(2))";				\
	SRC=$${SRC:-$(SRCDIR)};				\
	[ -d $$SRC ] || mkdir -p $$SRC;			\
	wget -P $$SRC $(PASSIVEFTP) $(1)

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
	if [ "$(EXTRAVERSION)" = "-cvs" ]; then							\
		PATCH_TREE=cvs;									\
	else											\
		PATCH_TREE=$(FULLVERSION);							\
	fi;											\
	[ -d $(PATCHDIR) ] || mkdir -p $(PATCHDIR);						\
	wget -r -l 1 -nH --cut-dirs=3 -A.diff -A.patch -A.gz -A.bz2 -P $(PATCHDIR)		\
		$(PASSIVEFTP) $(PTXPATCH_URL)-$$PATCH_TREE/$$PACKET_NAME/generic/;		\
	wget -r -l 1 -nH --cut-dirs=3 -A.diff -A.patch -A.gz -A.bz2 -P $(PATCHDIR)		\
		$(PASSIVEFTP) $(PTXPATCH_URL)-$$PATCH_TREE/$$PACKET_NAME/$(PTXCONF_ARCH)/;	\
	echo "return without error" > /dev/null;

#
# cleanup the given directory
#
clean =							\
	DIR="$(strip $(1))";				\
	if [ -d $$DIR ]; then				\
		rm -rf $$DIR;				\
	fi

#
# find latest config
#
latestconfig=`find $(TOPDIR)/config -name $(1)* -print | sort | tail -1`


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
		"s,^\s*(\#)?\s*($#PARAMETER)),\$$2,"	\
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
# $1 = $(PACKETNAME) -> identifier
# $2 = path to source tree 
#      if this parameter is omitted, the path will be derived
#      from the packet name
#
patchin =								\
	set -e;								\
	PACKET_NAME="$(strip $(1))";					\
	PACKET_DIR="$(strip $(2))";					\
	PACKET_DIR=$${PACKET_DIR:-$(BUILDDIR)/$$PACKET_NAME};		\
	for p in							\
	    $(TOPDIR)/patches/$$PACKET_NAME/generic/*.diff		\
	    $(TOPDIR)/patches/$$PACKET_NAME/generic/*.patch		\
	    $(TOPDIR)/patches/$$PACKET_NAME/generic/*.gz		\
	    $(TOPDIR)/patches/$$PACKET_NAME/generic/*.bz2		\
	    $(TOPDIR)/patches/$$PACKET_NAME/$(PTXCONF_ARCH)/*.diff	\
	    $(TOPDIR)/patches/$$PACKET_NAME/$(PTXCONF_ARCH)/*.patch	\
	    $(TOPDIR)/patches/$$PACKET_NAME/$(PTXCONF_ARCH)/*.gz	\
	    $(TOPDIR)/patches/$$PACKET_NAME/$(PTXCONF_ARCH)/*.bz2;	\
	    do								\
		if [ -f $$p ]; then					\
			case "$$p" in					\
			*.diff|*.patch)					\
				CAT=cat					\
				;;					\
			*gz)						\
				CAT=zcat				\
				;;					\
			*bz2)						\
				CAT=bzcat				\
				;;					\
			*)						\
				false					\
				;;					\
			esac;						\
			echo "patchin' $$p ...";			\
			$$CAT $$p | $(PATCH) -p1 -d $$PACKET_DIR;	\
		fi;							\
	done

#
# CFLAGS // CXXFLAGS
#
# the target_cflags and target_cxxflags are included from the architecture
# depended config file the is specified in .config
#
# the option in the .config is called 'TARGET_CONFIG_FILE'
#
#
TARGET_CFLAGS		+= $(PTXCONF_TARGET_EXTRA_CFAGS)
TARGET_CXXFLAGS		+= $(PTXCONF_TARGET_EXTRA_CXXFLAGS)


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
CROSS_ENV_CFLAGS	= CFLAGS=$(TARGET_CFLAGS)
CROSS_ENV_CXXFLAGS	= CXXFLAGS=$(TARGET_CXXFLAGS)


CROSS_ENV		=  $(CROSS_ENV_AR)
CROSS_ENV		+= $(CROSS_ENV_AS)
CROSS_ENV		+= $(CROSS_ENV_CXX)
CROSS_ENV		+= $(CROSS_ENV_CC)
CROSS_ENV		+= $(CROSS_ENV_LD)
CROSS_ENV		+= $(CROSS_ENV_NM)
CROSS_ENV		+= $(CROSS_ENV_OBJCOPY)
CROSS_ENV		+= $(CROSS_ENV_OBJDUMP)
CROSS_ENV		+= $(CROSS_ENV_RANLIB)
CROSS_ENV		+= $(CROSS_ENV_STRIP)
CROSS_ENV		+= $(CROSS_ENV_CFLAGS)
CROSS_ENV		+= $(CROSS_ENV_CXXFLAGS)

#
# CROSS_LIB_DIR	= into this dir, the libs for the target system, are installed
#
CROSS_LIB_DIR		= $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)

#
# distcc, perhaps we will use this feature in far future :)
# for more info see:
# http://distcc.samba.org
#
DISTCC_ENV		= CC='distcc $(PTXCONF_GNU_TARGET)-gcc'
DISTCC_MAKE		= CC='distcc $(PTXCONF_GNU_TARGET)-gcc' -j16


#
# prepare the search path
#
CROSS_PATH		= $(PTXCONF_PREFIX)/bin:$$PATH


#
# same as PTXCONF_GNU_TARGET, but w/o -linux
# e.g. i486 instead of i486-linux
#
SHORT_TARGET		= `echo $(PTXCONF_GNU_TARGET) |  perl -i -p -e 's/(.*?)-.*/$$1/'`

#
# change this if you have some wired configuration :)
#
SH		= /bin/sh
WGET		= wget
MAKE		= make
PATCH		= patch
TAR		= tar
GZIP		= gzip
BZIP2		= bzip2
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

# vim: syntax=make
