# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JS) += js

#
# Paths and names
#
JS_VERSION	:= 1.9.2.16
JS_MD5		:= 229fc3f629200561ad725fcddd435bf6
JS		:= js-$(JS_VERSION)
JS_SUFFIX	:= tar.bz2
JS_URL		:= http://ftp.mozilla.org/pub/mozilla.org/xulrunner/releases/$(JS_VERSION)/source/xulrunner-$(JS_VERSION).source.$(JS_SUFFIX)
JS_SOURCE	:= $(SRCDIR)/xulrunner-$(JS_VERSION).source.$(JS_SUFFIX)
JS_DIR		:= $(BUILDDIR)/$(JS)
JS_SUBDIR	:= js/src
JS_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

JS_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_DOXYGEN=/bin/true \
	ac_cv_path_WHOAMI=/bin/true \
	ac_cv_path_AUTOCONF=/bin/true \
	ac_cv_path_UNZIP=/bin/true \
	ac_cv_va_copy=yes \
	ac_cv___va_copy=yes

# FIXME: is this correct?
ifdef PTXCONF_ARCH_PPC
JS_CONF_ENV += ac_cv_va_val_copy=no
else
JS_CONF_ENV += ac_cv_va_val_copy=yes
endif

#
# autoconf
#
JS_CONF_TOOL	:= autoconf

JS_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--without-x \
	--disable-jig \
	--with-pthreads \
	--disable-tests \
	--disable-debug \
	--enable-optimize \
	--disable-debug-modules \
	--disable-debugger-info-modules \
	--disable-boehm \
	--disable-narcissus \
	--disable-trace-malloc \
	--disable-jemalloc \
	--disable-wrap-malloc \
	--disable-tracevis \
	--disable-valgrind \
	--disable-efence \
	--disable-jprof \
	--disable-shark \
	--disable-callgrind \
	--disable-vtune \
	--disable-gczeal \
	--disable-strip \
	--disable-install-strip \
	--disable-old-abi-compat-wrappers \
	--disable-timeline \
	--disable-eazel-profiler-support \
	--disable-profile-modules \
	--disable-insure \
	--disable-quantify \
	--disable-xterm-updates \
	--enable-long-long-warning \
	--disable-pedantic \
	--disable-cpp-rtti \
	--disable-cpp-exceptions \
	--disable-auto-deps \
	--disable-md \
	--disable-static \
	--disable-readline

# broken: --{en,dis}able-dtrace means both "enable"
#	--disable-dtrace
#	--disable-threadsafe

#  --disable-compile-environment
#                           Disable compiler/library checks.
#  --with-x                use the X Window System
#  --with-system-nspr      Use an NSPR that is already built and installed.
#                          Use the 'nspr-config' script in the current path,
#                          or look for the script in the directories given with
#                          --with-nspr-exec-prefix or --with-nspr-prefix.
#                          (Those flags are only checked if you specify
#                          --with-system-nspr.)
#  --with-nspr-cflags=FLAGS Pass FLAGS to CC when building code that uses NSPR.
#                          Use this when there's no accurate nspr-config
#                          script available.  This is the case when building
#                          SpiderMonkey as part of the Mozilla tree: the
#                          top-level configure script computes NSPR flags
#                          that accomodate the quirks of that environment.
#  --with-nspr-libs=LIBS   Pass LIBS to LD when linking code that uses NSPR.
#                          See --with-nspr-cflags for more details.
#  --with-nspr-prefix=PFX  Prefix where NSPR is installed
#  --with-nspr-exec-prefix=PFX
#                          Exec prefix where NSPR is installed
#  --with-arm-kuser         Use kuser helpers (Linux/ARM only -- requires kernel 2.6.13 or later)
#  --enable-ui-locale=ab-CD
#                          Select the user interface locale (default: en-US)
#  --with-wrap-malloc=DIR  Location of malloc wrapper library
#  --with-static-checking=path/to/gcc_dehydra.so
#                            Enable static checking of code using GCC-dehydra

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

JS_MAKE_OPT := HOST_CXX=$(HOSTCXX) HOST_CC=$(HOSTCC)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/js.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  js)
	@$(call install_fixup, js,PRIORITY,optional)
	@$(call install_fixup, js,SECTION,base)
	@$(call install_fixup, js,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, js,DESCRIPTION,missing)

	@$(call install_copy, js, 0, 0, 0755, -, /usr/lib/libmozjs.so)

	@$(call install_finish, js)

	@$(call touch)

# vim: syntax=make
