# -*-makefile-*-
#
# This file contains global macro and environment definitions.
#

# ----------------------------------------------------------------------------
# Programs & Local Defines
# ----------------------------------------------------------------------------

# FIXME: cleanup

GNU_BUILD	:= $(shell $(SCRIPTSDIR)/autoconf/config.guess)
GNU_HOST	:= $(shell echo $(GNU_BUILD) | sed s/-[a-zA-Z0-9_]*-/-host-/)

INSTALL		:= install
FAKEROOT	:= $(PTXDIST_SYSROOT_HOST)/bin/fakeroot -l $(PTXDIST_SYSROOT_HOST)/lib/libfakeroot.so

CHECK_PIPE_STATUS := \
	for i in  "$${PIPESTATUS[@]}"; do [ $$i -gt 0 ] && {			\
		echo;								\
		echo "error: a command in the pipe returned $$i, bailing out";	\
		echo;								\
		exit $$i;							\
	}									\
	done;									\
	true;

#
# prepare the search path when cross compiling
#
CROSS_PATH := $(PTXDIST_SYSROOT_CROSS)/bin:$(PTXDIST_SYSROOT_CROSS)/sbin:$$PATH


# ----------------------------------------------------------------------------
# Environment
# ----------------------------------------------------------------------------

#
# Environment variables for the compiler
#
CROSS_CFLAGS			:= $(PTXCONF_TARGET_EXTRA_CFLAGS)
CROSS_CXXFLAGS			:= $(PTXCONF_TARGET_EXTRA_CXXFLAGS)
CROSS_CPPFLAGS			:= $(strip $(PTXCONF_TARGET_EXTRA_CPPFLAGS) $(PTXDIST_CROSS_CPPFLAGS))
CROSS_LDFLAGS			:= $(strip $(PTXCONF_TARGET_EXTRA_LDFLAGS)  $(PTXDIST_CROSS_LDFLAGS))

ifneq (,$(CROSS_CFLAGS))
CROSS_ENV_CFLAGS		:= CFLAGS="$(CROSS_CFLAGS)"
CROSS_ENV_CFLAGS_FOR_TARGET	:= CFLAGS_FOR_TARGET="$(CROSS_CFLAGS)"
endif

ifneq (,$(CROSS_CXXFLAGS))
CROSS_ENV_CXXFLAGS		:= CXXFLAGS="$(CROSS_CXXFLAGS)"
CROSS_ENV_CXXFLAGS_FOR_TARGET	:= CXXFLAGS_FOR_TARGET="$(CROSS_CXXFLAGS)"
endif

ifneq (,$(CROSS_CPPFLAGS))
CROSS_ENV_CPPFLAGS		:= CPPFLAGS="$(CROSS_CPPFLAGS)"
CROSS_ENV_CPPFLAGS_FOR_TARGET	:= CPPFLAGS_FOR_TARGET="$(CROSS_CPPFLAGS)"
endif

ifneq (,$(CROSS_LDFLAGS))
CROSS_ENV_LDFLAGS		:= LDFLAGS="$(CROSS_LDFLAGS)"
CROSS_ENV_LDFLAGS_FOR_TARGET	:= LDFLAGS_FOR_TARGET="$(CROSS_LDFLAGS)"
endif

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


#
# Environment variables for toolchain components
#
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
CROSS_GNAT		:= $(PTXCONF_COMPILER_PREFIX)gnat
CROSS_GNATBIND		:= $(PTXCONF_COMPILER_PREFIX)gnatbind
CROSS_GNATCHOP		:= $(PTXCONF_COMPILER_PREFIX)gnatchop
CROSS_GNATCLEAN		:= $(PTXCONF_COMPILER_PREFIX)gnatclean
CROSS_GNATFIND		:= $(PTXCONF_COMPILER_PREFIX)gnatfind
CROSS_GNATKR		:= $(PTXCONF_COMPILER_PREFIX)gnatkr
CROSS_GNATLINK		:= $(PTXCONF_COMPILER_PREFIX)gnatlink
CROSS_GNATLS		:= $(PTXCONF_COMPILER_PREFIX)gnatls
CROSS_GNATMAKE		:= $(PTXCONF_COMPILER_PREFIX)gnatmake
CROSS_GNATNAME		:= $(PTXCONF_COMPILER_PREFIX)gnatname
CROSS_GNATPREP		:= $(PTXCONF_COMPILER_PREFIX)gnatprep
CROSS_GNATXREF		:= $(PTXCONF_COMPILER_PREFIX)gnatxref

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
CROSS_ENV_GNAT		:= GNAT=$(CROSS_GNAT)
CROSS_ENV_GNATBIND	:= GNATBIND=$(CROSS_GNATBIND)
CROSS_ENV_GNATCHOP	:= GNATCHOP=$(CROSS_GNATCHOP)
CROSS_ENV_GNATCLEAN	:= GNATCLEAN=$(CROSS_GNATCLEAN)
CROSS_ENV_GNATFIND	:= GNATFIND=$(CROSS_GNATFIND)
CROSS_ENV_GNATKR	:= GNATKR=$(CROSS_GNATKR)
CROSS_ENV_GNATLINK	:= GNATLINK=$(CROSS_GNATLINK)
CROSS_ENV_GNATLS	:= GNATLS=$(CROSS_GNATLS)
CROSS_ENV_GNATMAKE	:= GNATMAKE=$(CROSS_GNATMAKE)
CROSS_ENV_GNATNAME	:= GNATNAME=$(CROSS_GNATNAME)
CROSS_ENV_GNATPREP	:= GNATPREP=$(CROSS_GNATPREP)
CROSS_ENV_GNATXREF	:= GNATXREF=$(CROSS_GNATXREF)
CROSS_ENV_CC_FOR_BUILD	:= CC_FOR_BUILD=$(HOSTCC)
CROSS_ENV_CPP_FOR_BUILD	:= CPP_FOR_BUILD=$(HOSTCC)
CROSS_ENV_LINK_FOR_BUILD:= LINK_FOR_BUILD=$(HOSTCC)



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
	$(CROSS_ENV_GNAT) \
	$(CROSS_ENV_GNATBIND) \
	$(CROSS_ENV_GNATCHOP) \
	$(CROSS_ENV_GNATCLEAN) \
	$(CROSS_ENV_GNATFIND) \
	$(CROSS_ENV_GNATKR) \
	$(CROSS_ENV_GNATLINK) \
	$(CROSS_ENV_GNATLS) \
	$(CROSS_ENV_GNATMAKE) \
	$(CROSS_ENV_GNATNAME) \
	$(CROSS_ENV_GNATPREP) \
	$(CROSS_ENV_GNATXREF) \
	$(CROSS_ENV_CC_FOR_BUILD) \
	$(CROSS_ENV_CPP_FOR_BUILD) \
	$(CROSS_ENV_LINK_FOR_BUILD)

#
# prepare to use pkg-config with wrapper which takes care of
# $(PTXDIST_SYSROOT_TARGET). The wrapper's magic doesn't work when
# pkg-config strips out /usr/lib and other system libs/cflags, so we
# leave them in; the wrapper replaces them by proper
# $(PTXDIST_SYSROOT_TARGET) correspondees.
#
CROSS_ENV_PKG_CONFIG := \
	SYSROOT="$(PTXDIST_SYSROOT_TARGET)" \
	$(PTXDIST_CROSS_ENV_PKG_CONFIG) \
	PKG_CONFIG="$(PTXDIST_SYSROOT_CROSS)/bin/$(COMPILER_PREFIX)pkg-config"

#
# The ac_cv_* variables are needed to tell configure scripts not to
# use AC_TRY_RUN and run cross compiled things on the development host
#
CROSS_ENV_AC := \
	ac_cv_file__dev_random=yes \
	ac_cv_file__proc_self_exe=yes \
	ac_cv_file__proc_self_fd=yes \
	ac_cv_file__proc_self_maps=yes \
	ac_cv_func_dcgettext=yes \
	ac_cv_func_getpgrp_void=yes \
	ac_cv_func_getrlimit=yes \
	ac_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_memcmp_clean=yes \
	ac_cv_func_memcmp_working=yes \
	ac_cv_func_nonposix_getgrgid_r=no \
	ac_cv_func_nonposix_getpwuid_r=no \
	ac_cv_func_posix_getgrgid_r=yes \
	ac_cv_func_posix_getpwnam_r=yes \
	ac_cv_func_posix_getpwuid_r=yes \
	ac_cv_func_printf_unix98=yes \
	ac_cv_func_realloc_0_nonnull=yes \
	ac_cv_func_setgrent_void=yes \
	ac_cv_func_setpgrp_void=yes \
	ac_cv_func_setvbuf_reversed=no \
	ac_cv_func_strstr=yes \
	ac_cv_func_strtod=yes \
	ac_cv_func_strtoul=yes \
	ac_cv_func_vsnprintf_c99=yes \
	ac_cv_func_wait3_rusage=yes \
	ac_cv_have_abstract_sockets=yes \
	ac_cv_lib_c_inet_aton=yes \
	ac_cv_sizeof_long_double=$(PTXCONF_SIZEOF_LONG_DOUBLE) \
	ac_cv_sizeof_long_long=8 \
	ac_cv_sysv_ipc=yes \
	ac_cv_type_uintptr_t=yes \
	bash_cv_func_ctype_nonascii=yes \
	bash_cv_func_sigsetjmp=present \
	bash_cv_func_strcoll_broken=no \
	bash_cv_must_reinstall_sighandlers=no \
	glib_cv_long_long_format="ll" \
	gt_cv_func_gettext_libintl=yes

ifdef PTXCONF_HAS_MMU
CROSS_ENV_AC += \
	ac_cv_func_fork=yes \
	ac_cv_func_fork_works=yes
else
CROSS_ENV_AC += ac_cv_func_fork=no
endif

ifdef PTXCONF_ICONV
CROSS_ENV_AC += ac_cv_func_iconv_open=yes
else
CROSS_ENV_AC += ac_cv_func_iconv_open=no
endif

#
# CROSS_ENV is the environment usually set for all configure and
# compile calls in the packet makefiles.
#
CROSS_ENV := \
	$(CROSS_ENV_PROGS) \
	$(CROSS_ENV_FLAGS) \
	$(CROSS_ENV_PKG_CONFIG) \
	$(CROSS_ENV_AC)


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
	--host=$(PTXCONF_GNU_TARGET) \
	--build=$(GNU_HOST)

CROSS_AUTOCONF_USR  := $(CROSS_AUTOCONF_SYSROOT_USR)  $(CROSS_AUTOCONF_ARCH)
CROSS_AUTOCONF_ROOT := $(CROSS_AUTOCONF_SYSROOT_ROOT) $(CROSS_AUTOCONF_ARCH)

CROSS_CMAKE_USR	 := -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo
CROSS_CMAKE_ROOT := -DCMAKE_INSTALL_PREFIX=/    -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo

CROSS_QMAKE_OPT := -recursive

# ----------------------------------------------------------------------------
# HOST stuff
# ----------------------------------------------------------------------------

HOST_PATH	:= $$PATH

HOST_CPPFLAGS	:= -I$(PTXDIST_SYSROOT_HOST)/include
HOST_LDFLAGS	:= -L$(PTXDIST_SYSROOT_HOST)/lib -Wl,-rpath -Wl,$(PTXDIST_SYSROOT_HOST)/lib

HOST_ENV_CC		:= CC="$(HOSTCC)"
HOST_ENV_CXX		:= CXX="$(HOSTCXX)"
HOST_ENV_CPPFLAGS	:= CPPFLAGS="$(HOST_CPPFLAGS)"
HOST_ENV_LDFLAGS	:= LDFLAGS="$(HOST_LDFLAGS)"

HOST_ENV_PKG_CONFIG	:= \
	PKG_CONFIG_PATH="" \
	PKG_CONFIG_LIBDIR="$(PTXDIST_SYSROOT_HOST)/lib/pkgconfig:$(PTXDIST_SYSROOT_HOST)/share/pkgconfig"

HOST_ENV_PYTHONPATH	:= \
	PYTHONPATH="$(shell python -c 'import distutils.sysconfig as sysconfig; \
		print "%s" % sysconfig.get_python_lib(prefix="'"$(PTXDIST_SYSROOT_HOST)"'")')"

HOST_ENV	:= \
	$(HOST_ENV_CC) \
	$(HOST_ENV_CXX) \
	$(HOST_ENV_CPPFLAGS) \
	$(HOST_ENV_LDFLAGS) \
	$(HOST_ENV_PKG_CONFIG) \
	$(HOST_ENV_PYTHONPATH)


HOST_AUTOCONF  := --prefix=$(PTXDIST_SYSROOT_HOST)

HOST_CMAKE_OPT := -DCMAKE_INSTALL_PREFIX=$(PTXDIST_SYSROOT_HOST) -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo

# ----------------------------------------------------------------------------
# HOST_CROSS stuff
# ----------------------------------------------------------------------------

HOST_CROSS_PATH := $(CROSS_PATH)

HOST_CROSS_ENV := $(HOST_ENV)

HOST_CROSS_AUTOCONF := --prefix=$(PTXDIST_SYSROOT_CROSS)

# ----------------------------------------------------------------------------
# Convenience macros
# ----------------------------------------------------------------------------

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
		-e $(PTXDIST_SYSROOT_HOST)/bin/localedef 	\
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
	PTXCONF_SETUP_NO_DOWNLOAD="$(PTXCONF_SETUP_NO_DOWNLOAD)"\
	ptxd_make_get "$($(strip $(1))_URL)"


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
# 'generic'-directories are obsolete and just supported for
# backwards compatibility.
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
			    $(PROJECTPATCHDIR)/$$PACKET_NAME					\
		            $(PTXDIST_PLATFORMCONFIGDIR)/patches/$$PACKET_NAME/generic		\
		            $(PTXDIST_PLATFORMCONFIGDIR)/patches/$$PACKET_NAME			\
		            $(PATCHDIR)/$$PACKET_NAME/generic					\
		            $(PATCHDIR)/$$PACKET_NAME";						\
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
	autogen_sh="$${patch_dir}/autogen.sh";							\
	if [ -x "$${autogen_sh}" ]; then							\
		echo "PATCHIN: running autogen"; 						\
		( cd "$${PACKET_DIR}" &&"$${autogen_sh}" ) || exit 1;				\
	fi; 											\
												\
	case "$(notdir $@)" in									\
		(host-*|cross-*)	exit 0;;						\
	esac;											\
												\
	find "$${PACKET_DIR}/" -name "configure" -a -type f -a \! -path "*/.pc/*" | while read conf; do	\
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
	find "$${PACKET_DIR}/" -name "ltmain.sh" -a -type f -a \! -path "*/.pc/*" | while read conf; do	\
		echo "Fixing up $${conf}";							\
		sed -i										\
		-e "s:\(need_relink\)=yes:\1=no:"						\
		"$${conf}";									\
		$(CHECK_PIPE_STATUS)								\
	done

# vim: syntax=make
