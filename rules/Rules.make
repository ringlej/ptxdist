# -*-makefile-*-
PASSIVEFTP	= --passive-ftp
SUDO		= sudo
PTXUSER		= $(shell echo $$USER)
GNU_HOST	= $(shell $(TOPDIR)/scripts/config.guess)
HOSTCC		= gcc
HOSTCC_ENV	= CC=$(HOSTCC)
CROSSSTRIP	= $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-strip
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
targetinfo=echo ; \
TG=`echo $(1) | sed -e "s,/.*/,,g"` ; 		\
LINE=`echo target: $$TG |sed -e "s/./-/g"` ;	\
echo $$LINE ;					\
echo target: $$TG ;				\
echo $$LINE ;					\
echo ;						\
echo $@ : $^ | sed -e "s@$(TOPDIR)@@g" -e "s@/src/@@g" -e "s@/state/@@g" >> $(DEP_OUTPUT)


#
# extract the given source to sourcedir
#
extract =						\
	DEST="$(2)";					\
	DEST=$${DEST:-$(BUILDDIR)};			\
	case "$(1)" in					\
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
get =							\
	SRC="$(2)";					\
	SRC=$${SRC:-$(SRCDIR)};				\
	[ -d $$SRC ] || mkdir -p $$SRC;			\
	wget -P $$SRC $(PASSIVEFTP) $(1)

#
# cleanup the given directory
#
clean =							\
	[ -d $(1) ] && rm -rf $(1) || true

#
# find latest config
#
latestconfig=`find $(TOPDIR)/config -name $(1)* -print | sort | tail -1`


#
# enables a define
#
# (often found in .c or .h files)
#
# $1 = file
# $2 = parameter
#
enable_c =									\
	perl -p -i -e								\
		's,^\s*(\/\*)?\s*(\#\s*define\s+$(2))\s*(\*\/)?$$,$$2\n,'	\
		$(1)

#
# disables a define
#
# (often found in .c or .h files)
#
# $1 = file
# $2 = parameter
#
disable_c =										\
	perl -p -i -e									\
		's,^\s*(\/\*)?\s*(\#\s*define\s+$(2))\s*(\*\/)?$$,\/\*$$2\*\/\n,'	\
		$(1)

#
# crossenvironment
#
CROSS_ENV_AR		= AR=$(PTXCONF_GNU_TARGET)-ar
CROSS_ENV_AS		= AS=$(PTXCONF_GNU_TARGET)-as
CROSS_ENV_LD		= LD=$(PTXCONF_GNU_TARGET)-ld
CROSS_ENV_NM		= NM=$(PTXCONF_GNU_TARGET)-nm
CROSS_ENV_CC		= CC=$(PTXCONF_GNU_TARGET)-gcc
CROSS_ENV_CXX		= CXX=$(PTXCONF_GNU_TARGET)-c++
CROSS_ENV_OBJCOPY	= OBJCOPY=$(PTXCONF_GNU_TARGET)-objcopy
CROSS_ENV_OBJDUMP	= OBJDUMP=$(PTXCONF_GNU_TARGET)-objdump
CROSS_ENV_RANLIB	= RANLIB=$(PTXCONF_GNU_TARGET)-ranlib
CROSS_ENV_STRIP		= STRIP=$(PTXCONF_GNU_TARGET)-strip

CROSS_ENV		=  $(CROSS_ENV_AR)
CROSS_ENV		+= $(CORSS_ENV_AS)
CROSS_ENV		+= $(CROSS_ENV_CXX)
CROSS_ENV		+= $(CROSS_ENV_CC)
CROSS_ENV		+= $(CROSS_ENV_LD)
CROSS_ENV		+= $(CROSS_ENV_NM)
CROSS_ENV		+= $(CROSS_ENV_OBJCOPY)
CROSS_ENV		+= $(CROSS_ENV_OBJDUMP)
CROSS_ENV		+= $(CROSS_ENV_RANLIB)
CROSS_ENV		+= $(CROSS_ENV_STRIP)

#
# CORSS_LIB_DIR	= into this dir, the libs for the target system, are installed
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
