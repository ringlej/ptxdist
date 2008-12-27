# -*-makefile-*-
# $Id$
#
# This file contains global macro and environment definitions.
#

# ----------------------------------------------------------------------------
# Programs & Local Defines
# ----------------------------------------------------------------------------

# FIXME: cleanup

GNU_BUILD	:= $(shell $(SCRIPTSDIR)/external/config.guess)
GNU_HOST	:= $(shell echo $(GNU_BUILD) | sed s/-[a-zA-Z0-9_]*-/-host-/)

HOSTCC		:= $(PTXCONF_SETUP_HOST_CC)
HOSTCXX		:= $(PTXCONF_SETUP_HOST_CXX)
INSTALL		:= install
FAKEROOT	:= $(PTXCONF_SYSROOT_HOST)/bin/fakeroot -l $(PTXCONF_SYSROOT_HOST)/lib/libfakeroot.so

CHECK_PIPE_STATUS := \
	for i in  "$${PIPESTATUS[@]}"; do [ $$i -gt 0 ] && {			\
		echo;								\
		echo "error: a command in the pipe returned $$i, bailing out";	\
		echo;								\
		exit $$i;							\
	}									\
	done;									\
	true;

# ----------------------------------------------------------------------------
# Paths and other stuff
# ----------------------------------------------------------------------------

#
# SYSROOT is the directory stuff is being installed into on the host
#
SYSROOT := $(PTXCONF_SYSROOT_TARGET)

#
# prepare the search path
# In order to work correctly in cross path all local cross tools must be find first!
#
CROSS_PATH := $(PTXCONF_SYSROOT_CROSS)/bin:$(PTXCONF_SYSROOT_CROSS)/sbin:$$PATH

# ----------------------------------------------------------------------------
# Environment
# ----------------------------------------------------------------------------

#
# TARGET_*FLAGS
#
TARGET_CFLAGS		:= $(PTXCONF_TARGET_EXTRA_CFLAGS)
TARGET_CXXFLAGS		:= $(PTXCONF_TARGET_EXTRA_CXXFLAGS)
TARGET_CPPFLAGS		:= \
	$(PTXCONF_TARGET_EXTRA_CPPFLAGS) \
	-isystem $(SYSROOT)/include \
	-isystem $(SYSROOT)/usr/include

TARGET_LDFLAGS		:= \
	$(PTXCONF_TARGET_EXTRA_LDFLAGS) \
	-L$(SYSROOT)/lib \
	-L$(SYSROOT)/usr/lib \
	-Wl,-rpath-link -Wl,$(SYSROOT)/usr/lib


# Environment variables for toolchain components
#
# FIXME: Consolidate a bit more
#
COMPILER_PREFIX		:= $(PTXCONF_COMPILER_PREFIX)
CROSS_AR		:= $(PTXCONF_COMPILER_PREFIX)ar
CROSS_AS		:= $(PTXCONF_COMPILER_PREFIX)as
CROSS_LD		:= $(PTXCONF_COMPILER_PREFIX)ld
CROSS_NM		:= $(PTXCONF_COMPILER_PREFIX)nm
CROSS_CC		:= $(PTXCONF_COMPILER_PREFIX)gcc
CROSS_CXX		:= $(PTXCONF_COMPILER_PREFIX)g++
CROSS_CPP		:= $(PTXCONF_COMPILER_PREFIX)cpp
CROSS_RANLIB		:= $(PTXCONF_COMPILER_PREFIX)ranlib
CROSS_READELF		:= $(PTXCONF_COMPILER_PREFIX)readelf
CROSS_OBJCOPY		:= $(PTXCONF_COMPILER_PREFIX)objcopy
CROSS_OBJDUMP		:= $(PTXCONF_COMPILER_PREFIX)objdump
CROSS_STRIP		:= $(PTXCONF_COMPILER_PREFIX)strip
CROSS_DLLTOOL		:= $(PTXCONF_COMPILER_PREFIX)dlltool

CROSS_ENV_AR		:= AR=$(CROSS_AR)
CROSS_ENV_AS		:= AS=$(CROSS_AS)
CROSS_ENV_LD		:= LD=$(CROSS_LD)
CROSS_ENV_NM		:= NM=$(CROSS_NM)
CROSS_ENV_CC		:= CC=$(CROSS_CC)
CROSS_ENV_CXX		:= CXX=$(CROSS_CXX)
CROSS_ENV_CPP		:= CPP=$(CROSS_CPP)
CROSS_ENV_RANLIB	:= RANLIB=$(CROSS_RANLIB)
CROSS_ENV_READELF	:= READELF=$(CROSS_READELF)
CROSS_ENV_OBJCOPY	:= OBJCOPY=$(CROSS_OBJCOPY)
CROSS_ENV_OBJDUMP	:= OBJDUMP=$(CROSS_OBJDUMP)
CROSS_ENV_STRIP		:= STRIP=$(CROSS_STRIP)
CROSS_ENV_DLLTOOL	:= DLLTOOL=$(CROSS_DLLTOOL)
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
	$(CROSS_ENV_LD) \
	$(CROSS_ENV_NM) \
	$(CROSS_ENV_CC) \
	$(CROSS_ENV_CXX) \
	$(CROSS_ENV_CPP) \
	$(CROSS_ENV_RANLIB) \
	$(CROSS_ENV_READELF) \
	$(CROSS_ENV_OBJCOPY) \
	$(CROSS_ENV_OBJDUMP) \
	$(CROSS_ENV_STRIP) \
	$(CROSS_ENV_DLLTOOL) \
	$(CROSS_ENV_CC_FOR_BUILD) \
	$(CROSS_ENV_CPP_FOR_BUILD) \
	$(CROSS_ENV_LINK_FOR_BUILD)

#
# prepare to use pkg-config with wrapper which takes care of $(SYSROOT).
# The wrapper's magic doesn't work when pkg-config strips out /usr/lib
# and other system libs/cflags, so we leave them in; the wrapper
# replaces them by proper $(SYSROOT) correspondees.
#

CROSS_ENV_PKG_CONFIG := \
	SYSROOT="$(SYSROOT)" \
	PKG_CONFIG="$(PTXCONF_SYSROOT_CROSS)/bin/$(COMPILER_PREFIX)pkg-config"

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
	ac_cv_func_dcgettext=yes \
	ac_cv_func_getpgrp_void=yes \
	ac_cv_func_getrlimit=yes \
	ac_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_memcmp_clean=yes \
	ac_cv_func_posix_getpwuid_r=yes \
	ac_cv_func_printf_unix98=yes \
	ac_cv_func_realloc_0_nonnull=yes \
	ac_cv_func_setpgrp_void=yes \
	ac_cv_func_setvbuf_reversed=no \
	ac_cv_func_vsnprintf_c99=yes \
	ac_cv_sizeof_long_double=$(PTXCONF_SIZEOF_LONG_DOUBLE) \
	ac_cv_sizeof_long_long=8 \
	ac_cv_sysv_ipc=yes \
	ac_cv_type_uintptr_t=yes \
	glib_cv_long_long_format="ll" \
	gt_cv_func_gettext_libintl=yes


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
	--prefix=/usr --sysconfdir=/etc

CROSS_AUTOCONF_SYSROOT_ROOT := \
	--prefix=

CROSS_AUTOCONF_ARCH := \
	--host=$(PTXCONF_GNU_TARGET) --build=$(GNU_HOST)

CROSS_AUTOCONF_BROKEN_USR := \
	$(CROSS_AUTOCONF_ARCH) --prefix=$(SYSROOT)

CROSS_ENV := \
	$(CROSS_ENV_PROGS) \
	$(CROSS_ENV_FLAGS) \
	$(CROSS_ENV_PKG_CONFIG) \
	$(CROSS_ENV_AC) \
	$(CROSS_ENV_DESTDIR) \
	$(CROSS_ENV_LIBRARY_PATH)

CROSS_AUTOCONF_USR  := $(CROSS_AUTOCONF_SYSROOT_USR) $(CROSS_AUTOCONF_ARCH)
CROSS_AUTOCONF_ROOT := $(CROSS_AUTOCONF_SYSROOT_ROOT) $(CROSS_AUTOCONF_ARCH)

# ----------------------------------------------------------------------------
# HOST stuff
# ----------------------------------------------------------------------------

# FIXME: obsolete (mkl)
HOSTCC_ENV	:= CC=$(HOSTCC)
HOSTCXX_ENV	:= CXX=$(HOSTCXX)

HOST_PATH	:= $$PATH

HOST_CPPFLAGS	:= -I$(PTXCONF_SYSROOT_HOST)/include
HOST_LDFLAGS	:= -L$(PTXCONF_SYSROOT_HOST)/lib -Wl,-rpath -Wl,$(PTXCONF_SYSROOT_HOST)/lib

HOST_ENV_CC		:= CC="$(HOSTCC)"
HOST_ENV_CXX		:= CXX="$(HOSTCXX)"
HOST_ENV_CPPFLAGS	:= CPPFLAGS="$(HOST_CPPFLAGS)"
HOST_ENV_LDFLAGS	:= LDFLAGS="$(HOST_LDFLAGS)"
HOST_ENV_PKG_CONFIG	:= PKG_CONFIG_PATH="" PKG_CONFIG_LIBDIR="$(PTXCONF_SYSROOT_HOST)/lib/pkgconfig"

HOST_ENV	:= \
	$(HOST_ENV_CC) \
	$(HOST_ENV_CXX) \
	$(HOST_ENV_CPPFLAGS) \
	$(HOST_ENV_LDFLAGS) \
	$(HOST_ENV_PKG_CONFIG)


HOST_AUTOCONF  := --prefix=$(PTXCONF_SYSROOT_HOST)

# ----------------------------------------------------------------------------
# Convenience macros
# ----------------------------------------------------------------------------


#
# targetinfo
#
# Print out the targetinfo line on the terminal
#
ifndef PTXDIST_QUIET
targetinfo = 									\
	target="$(strip $(@))";							\
	target="target: $${target\#\#*/}";					\
	echo -e "\n$${target//?/-}\n$${target}\n$${target//?/-}\n";		\
	echo $@ : $^ | sed 							\
		-e "s@$(SRCDIR)@@g"						\
		-e "s@$(STATEDIR)@@g"						\
		-e "s@$(RULESDIR)@@g"						\
		-e "s@$(PROJECTRULESDIR)@@g"					\
		-e "s@$(PTXDIST_PLATFORMCONFIGDIR)@@g"				\
		-e "s@$(PTXDIST_WORKSPACE)@@g"					\
		-e "s@$(PTXDIST_TOPDIR)@@g" 					\
		-e "s@/@@g" >> $(DEP_OUTPUT)
else
targetinfo = 									\
	target="$(strip $(@))";							\
	target="$${target\#\#*/}";						\
	echo "started : $(PTX_COLOR_BLUE)$${target}$(PTX_COLOR_OFF)" >&2;	\
	target="target: $${target}";						\
	echo -e "\n$${target//?/-}\n$${target}\n$${target//?/-}\n";		\
	echo $@ : $^ | sed 							\
		-e "s@$(SRCDIR)@@g"						\
		-e "s@$(STATEDIR)@@g"						\
		-e "s@$(RULESDIR)@@g"						\
		-e "s@$(PROJECTRULESDIR)@@g"					\
		-e "s@$(PTXDIST_PLATFORMCONFIGDIR)@@g"				\
		-e "s@$(PTXDIST_WORKSPACE)@@g"					\
		-e "s@$(PTXDIST_TOPDIR)@@g" 					\
		-e "s@/@@g" >> $(DEP_OUTPUT)
endif

#
# touch with prefix-creation
#
ifndef PTXDIST_QUIET
touch =										\
	target="$(strip $(@))";							\
	touch "$${target}";							\
	echo "Finished target $${target\#\#*/}"
else
touch =										\
	target="$(strip $(@))";							\
	touch "$${target}";							\
	target="$${target\#\#*/}";						\
	echo "finished: $(PTX_COLOR_GREEN)$${target}$(PTX_COLOR_OFF)" >&2;	\
	echo "Finished target $${target}"
endif

#
# add_locale
#
# add locale support to locales-archive, if not exist, a new locale
# archive will be created automaticly
#
# $1: localename: localename (i.E. zh_CN or zh_CN.GBK)
# $2: localedef; locale definition file (i.E. de_DE or de_DE@euro)
# $3: charmap; charachter encoding map (i.E. ISO-8859-1)
# $4: prefix; installation prefix for locales-archive
#
#
add_locale =							\
	LOCALE_NAME=$(strip $(1));				\
	LOCALE_DEF=$(strip $(2));				\
	CHARMAP=$(strip $(3));					\
	PREF=$(strip $(4));					\
	LE=$(PTXCONF_ENDIAN_LITTLE);				\
	BE=$(PTXCONF_ENDIAN_BIG);				\
	if [ "$$LE" = "y" ]; then				\
		ENDIAN=-l;					\
	elif [ "$$BE" = "y" ]; then				\
		ENDIAN=-b;					\
	else							\
		exit 1;						\
	fi;							\
	${CROSS_ENV_CC} $(CROSS_ENV_STRIP)			\
	$(SCRIPTSDIR)/make_locale.sh 				\
		-e $(PTXCONF_SYSROOT_HOST)/bin/localedef 	\
		-f $$CHARMAP -i $$LOCALE_DEF 			\
		-p $$PREF 					\
		-n $$LOCALE_NAME				\
		$$ENDIAN


#
# add_zoneinfo
#
# add zoneinfo support to glibc-archive
#
# $1: zoneinfoname: zoneinfoname (i.E. Europe)
# $2: prefix; installation prefix for glibc-archive
#
#
add_zoneinfo =							\
	ZONEINFO_NAME=$(strip $(1));				\
	PREF=$(strip $(2));					\
	${CROSS_ENV_CC} $(CROSS_ENV_STRIP)			\
	$(SCRIPTSDIR)/make_zoneinfo.sh				\
	-n $$ZONEINFO_NAME					\
	-p $$PREF

#
# extract
#
# Extract a source archive into a directory. This stage is
# skipped if $1_URL points to a local directory instead of
# an archive or online URL.
#
# $1: Packet label; we extract $1_SOURCE
# $2: dir to extract into; if $2 is not given we extract to $(BUILDDIR)
#
extract =							\
	ptxd_make_extract					\
		-s "$($(strip $(1))_SOURCE)"			\
		-p "$($(strip $(1))_DIR)"			\
		-u "$($(strip $(1))_URL)"			\
		-d "$(strip $(2))"


#
# get
#
# Download a package from a given URL. This macro has some magic
# to handle different URLs; as wget is not able to transfer
# file URLs this case is being handed over to cp.
#
# $1: Packet Label; this macro gets $1_URL
#
get =								\
	ptxd_make_get "$($(strip $(1))_URL)"


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
# workflow:
# - mangle all *.la files in $BUILDDIR
# - make install to _standard_ SYSROOT
# - again, mangle all *.la files in $BUILDDIR and reset libdir
# - make install to _package_local_ SYSROOT (can be used as install base)
# - mangle all *.la files in the _default_ $SYSROOT for further development
#
install = \
	BUILDDIR="$($(strip $(1))_DIR)/";				\
	PKG_PKGDIR="$(PKGDIR)/$($(strip $(1)))";			\
	[ "$(strip $(2))" != ""  ] && BUILDDIR="$(strip $(2))/";	\
	if [ "$(strip $(3))" = "h" ]; then				\
		cd $$BUILDDIR &&					\
			$($(strip $(1))_ENV)				\
			$($(strip $(1))_PATH)				\
			$(MAKE) install $(PARALLELMFLAGS_BROKEN) $(4)	\
			$($(strip $(1))_MAKEVARS)			\
			DESTDIR=;					\
		$(CHECK_PIPE_STATUS)					\
	else								\
		cd $$BUILDDIR &&					\
			echo "$($(strip $(1))_ENV)			\
			$($(strip $(1))_PATH)				\
			$(MAKE) $(PARALLELMFLAGS_BROKEN) install $(4)	\
			$($(strip $(1))_MAKEVARS)			\
			DESTDIR=$(SYSROOT);"				\
			| $(FAKEROOT) --;				\
		$(CHECK_PIPE_STATUS)					\
									\
		sed -i -e "/^dependency_libs/s:\( \)\(/lib\|/usr/lib\):\1${SYSROOT}\2:g"		\
			-e "/^libdir=/s:\(libdir='\)\(/lib\|/usr/lib\):\1${SYSROOT}\2:g"		\
			`find ${SYSROOT} -name "*.la"`;			\
									\
		if [ -e "$$PKG_PKGDIR" ]; then				\
			rm -rf "$${PKG_PKGDIR}";			\
		fi;							\
		mkdir -p $$PKG_PKGDIR/{,usr/}{lib,{,s}bin,include,{,share/}man/man{1,2,3,4,5,6,7,8,9}}; \
									\
		cd $$BUILDDIR &&					\
			echo "$($(strip $(1))_ENV)			\
			$($(strip $(1))_PATH)				\
			LIBDIR=$(SYSROOT)				\
			$(MAKE) $(PARALLELMFLAGS_BROKEN) install $(4)	\
			$($(strip $(1))_MAKEVARS)			\
			DESTDIR=$$PKG_PKGDIR;"				\
			| $(FAKEROOT) --;				\
		$(CHECK_PIPE_STATUS)					\
	fi;



#
# clean
#
# Cleanup the given directory or file.
#
clean =								\
	DIR="$(strip $(1))";					\
	if [ -e $$DIR ]; then					\
		rm -rf $$DIR;					\
	fi


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
	sed -i -e										\
		"s,^\s*\(\/\*\)\?\s*\(\\\#\s*define\s\+$$PARAMETER\)\s*\(\*\/\)\?$$,\2,"	\
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
	sed -i -e										\
		"s,^\s*\(\/\*\)\?\s*\(\\\#\s*define\s\+$$PARAMETER\)\s*\(\*\/\)\?$$,\/\*\2\*\/," \
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
	sed -i -e					\
		"s,^\s*\(\#\)\?\s*\($$PARAMETER\),\2,"	\
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
	sed -i -e					\
		"s,^\s*\(\#\)\?\s*\($$PARAMETER\),\#\2,"\
		$$FILENAME

#
# patchin
#
# Go into a directory and apply all patches from there into a
# sourcetree. if a series file exists in that directory the
# patches from the series file are used instead of all patches.
# If parameter $3 is given, this series file will be used,
# not a derived one.
# if the variable PTXCONF_$(PACKET_LABEL)_SERIES exists, the
# series file from this variable is used instead of "series"
# This macro skips if $1 points to a local directory.
#
# $1: packet label; $($(1)_NAME) -> identifier
# $2: path to source tree
#     if this parameter is omitted, the path will be derived
#     from the packet name
# $3: abs path to series file
#
patchin =											\
	PACKET_NAME="$($(strip $(1)))"; 							\
	URL="$($(strip $(1))_URL)";								\
	PACKET_DIR="$(strip $(2))";								\
												\
	if [ "$$PACKET_NAME" = "" ]; then							\
		echo;										\
		echo Error: empty parameter to \"patchin\(\)\";					\
		echo;										\
		exit 1;										\
	fi;											\
												\
	echo "PATCHIN: packet=$$PACKET_NAME";							\
												\
	APPLY_PATCH=true;									\
	case $$URL in										\
	file*)											\
		THING="$$(echo $$URL | sed s-file://-/-g)";					\
		if [ -d "$$THING" -a "$(strip $(1))" != "KERNEL" ]; then			\
			echo "local directory instead of tar file, skipping patch"; 		\
			APPLY_PATCH=false;							\
		fi; 										\
	esac; 											\
												\
												\
	PACKET_DIR=$${PACKET_DIR:-$(BUILDDIR)/$$PACKET_NAME};					\
	echo "PATCHIN: dir=$$PACKET_DIR";							\
												\
	if [ ! -d $${PACKET_DIR} ]; then							\
		echo;										\
		echo "Error: dir \"$${PACKET_DIR}\" does not exist";				\
		echo;										\
		exit 1;										\
												\
	fi;											\
												\
	if $${APPLY_PATCH}; then								\
		patch_dirs="$(PROJECTPATCHDIR)/$$PACKET_NAME/generic				\
		            $(PTXDIST_PLATFORMCONFIGDIR)/patches/$$PACKET_NAME/generic		\
		            $(PATCHDIR)/$$PACKET_NAME/generic";					\
												\
		for dir in $$patch_dirs; do							\
			if [ -d $$dir ]; then							\
				patch_dir=$$dir;						\
				break;								\
			fi;									\
		done;										\
												\
		if [ -z "$$patch_dir" ]; then							\
			echo "PATCHIN: no patches for $$PACKET_NAME available";			\
		else										\
			PACKET_SERIES="$(PTXCONF_$(strip $(1))_SERIES)";			\
			if [ -n "$$PACKET_SERIES" -a ! -f "$$patch_dir/$$PACKET_SERIES" ]; then	\
				echo -n "Series file for $$PACKET_NAME given, but series file ";\
				echo "\"$$patch_dir/$$PACKET_SERIES\" does not exist";		\
				exit 1;								\
			fi;									\
												\
			if [ -z "$$PACKET_SERIES" ]; then					\
				PACKET_SERIES="series";						\
			fi;									\
			ABS_SERIES_FILE="$$patch_dir/$$PACKET_SERIES";				\
												\
			if [ -f "$${ABS_SERIES_FILE}" ]; then					\
				echo "PATCHIN: using series file $${ABS_SERIES_FILE}";		\
				$(SCRIPTSDIR)/apply_patch_series.sh -s "$${ABS_SERIES_FILE}"	\
					-d $$PACKET_DIR;					\
			else									\
				$(SCRIPTSDIR)/apply_patch_series.sh -p "$$patch_dir"		\
					-d $$PACKET_DIR	;					\
			fi;									\
			if [ "$$?" -gt 0 ]; then exit 1; fi;					\
		fi;										\
	fi;											\
												\
	find "$${PACKET_DIR}/" -name "configure" -a \! -path "*/.pc/*" | while read conf; do	\
		echo "Fixing up $${conf}";							\
		sed -i										\
		-e "s=sed -e \"s/\\\\(\.\*\\\\)/\\\\1;/\"=sed -e \"s/\\\\(.*\\\\)/'\"\$$ac_symprfx\"'\\\\1;/\"=" \
		-e "s:^\(hardcode_into_libs\)=.*:\1=\"no\":"					\
		-e "s:^\(hardcode_libdir_flag_spec\)=.*:\1=\"\":"				\
		-e "s:^\(hardcode_libdir_flag_spec_ld\)=.*:\1=\"\":"				\
		"$${conf}";									\
		$(CHECK_PIPE_STATUS)								\
	done;											\
												\
	find "$${PACKET_DIR}/" -name "ltmain.sh" -a \! -path "*/.pc/*" | while read conf; do	\
		echo "Fixing up $${conf}";							\
		sed -i										\
		-e "s:\(need_relink\)=yes:\1=no:"						\
		"$${conf}";									\
		$(CHECK_PIPE_STATUS)								\
	done

# vim: syntax=make
