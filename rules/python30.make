# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON30) += python30

#
# Paths and names
#
PYTHON30_VERSION	:= 3.0
PYTHON30		:= Python-$(PYTHON30_VERSION)
PYTHON30_SUFFIX		:= tar.bz2
PYTHON30_URL		:= http://www.python.org/ftp/python/3.0/$(PYTHON30).$(PYTHON30_SUFFIX)
PYTHON30_SOURCE		:= $(SRCDIR)/$(PYTHON30).$(PYTHON30_SUFFIX)
PYTHON30_DIR		:= $(BUILDDIR)/$(PYTHON30)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PYTHON30_SOURCE):
	@$(call targetinfo)
	@$(call get, PYTHON30)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/python30.extract:
	@$(call targetinfo)
	@$(call clean, $(PYTHON30_DIR))
	@$(call extract, PYTHON30)
	@$(call patchin, PYTHON30)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON30_PATH	:= PATH=$(CROSS_PATH)

PYTHON30_ENV := \
	$(CROSS_ENV) \
	LDSHARED=$(CROSS_LD) \
	CROSS_COMPILE=yes \
	ac_cv_have_chflags=no \
	ac_cv_have_lchflags=no

#
# autoconf
#
PYTHON30_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-profiling \
	--with-suffix="" \
	--without-pydebug \
	--with-system-ffi \
	--without-signal-module \
	--with-doc-strings \
	--with-pymalloc \
	--without-wctype-functions \
	--without-fpectl

ifdef PTXCONF_PYTHON30__IPV6
PYTHON30_AUTOCONF += --enable-ipv6
else
PYTHON30_AUTOCONF += --disable-ipv6
endif
ifdef PTXCONF_ARCH_X86
PYTHON30_AUTOCONF += --with-tsc
else
PYTHON30_AUTOCONF += --without-tsc
endif

# FIXME: yet unhandled
#
#  --with-pth
#  --enable-universalsdk[=SDKDIR]
#                          Build against Mac OS X 10.4u SDK (ppc/i386)
#  --with-universal-archs=ARCH
#                          select architectures for universal build ("32-bit",
#                          "64-bit" or "all")
#  --with-framework-name=FRAMEWORK
#                          specify an alternate name of the framework built
#                          with --enable-framework
#  --with-libm=STRING      math library
#  --with-libc=STRING      C library
#  --with-wide-unicode     Use 4-byte Unicode characters (default is 2 bytes)

#
# Hack Alert:
#
# LDFLAGS is needed to convince the linker to link against the cross
# compiled libpython.so, and -L. is an uggly hack that lets it find the
# cross lib before that one incorrectly determined by the PYTHON_FOR_BUILD
#

PYTHON30_MAKEVARS = \
	CC_FOR_BUILD=gcc \
	LDFLAGS="-shared -L." \
	GNU_HOST=$(PTXCONF_GNU_TARGET) \
	GNU_BUILD=$(GNU_HOST) \
	PYTHON_FOR_BUILD=$(PTXCONF_SYSROOT_HOST)/bin/python3.0

$(STATEDIR)/python30.prepare:
	@$(call targetinfo)
	@$(call clean, $(PYTHON30_DIR)/config.cache)
	cd $(PYTHON30_DIR) && \
		$(PYTHON30_PATH) $(PYTHON30_ENV) \
		./configure $(PYTHON30_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/python30.compile:
	@$(call targetinfo)
	cd $(PYTHON30_DIR) && \
		$(PYTHON30_PATH) $(MAKE) $(PARALLELMFLAGS) $(PYTHON30_MAKEVARS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python30.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

PYTHON30_INST_TMP := $(PYTHON30_DIR)/install_temp

$(STATEDIR)/python30.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  python30)
	@$(call install_fixup, python30,PACKAGE,python30)
	@$(call install_fixup, python30,PRIORITY,optional)
	@$(call install_fixup, python30,VERSION,$(PYTHON30_VERSION))
	@$(call install_fixup, python30,SECTION,base)
	@$(call install_fixup, python30,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, python30,DEPENDS,)
	@$(call install_fixup, python30,DESCRIPTION,missing)

	# FIXME: backport install options from the python24 image

	rm -rf $(PYTHON30_INST_TMP)
	mkdir -p $(PYTHON30_INST_TMP)

	$(PYTHON30_PATH) make -C $(PYTHON30_DIR) $(PYTHON30_MAKEVARS) \
		altbininstall DESTDIR=$(PYTHON30_INST_TMP)

	umask 022 && \
		$(PYTHON30_PATH) make -C $(PYTHON30_DIR) $(PYTHON30_MAKEVARS) \
		libinstall DESTDIR=$(PYTHON30_INST_TMP)

	$(PYTHON30_PATH) make -C $(PYTHON30_DIR) $(PYTHON30_MAKEVARS) \
		libainstall DESTDIR=$(PYTHON30_INST_TMP)

	$(PYTHON30_PATH) make -C $(PYTHON30_DIR) $(PYTHON30_MAKEVARS) \
		sharedinstall DESTDIR=$(PYTHON30_INST_TMP)

	$(PYTHON30_PATH) make -C $(PYTHON30_DIR) $(PYTHON30_MAKEVARS) \
		oldsharedinstall DESTDIR=$(PYTHON30_INST_TMP)

	# remove redundant files
	find $(PYTHON30_INST_TMP)/usr/lib/python2.4 -name "*.py"  | xargs rm -f
	find $(PYTHON30_INST_TMP)/usr/lib/python2.4 -name "*.pyo" | xargs rm -f
	rm -fr $(PYTHON30_INST_TMP)/usr/lib/python2.4/config
	rm -fr $(PYTHON30_INST_TMP)/usr/lib/python2.4/test

	files=$$(cd $(PYTHON30_INST_TMP) && find -type f | sed "s/^\.//"); \
	for i in $$files; do \
		access=$$(stat -c "%a" $(PYTHON30_INST_TMP)$$i); \
		$(call install_copy, python30, 0, 0, $$access, $(PYTHON30_INST_TMP)$$i, $$i); \
	done

	@$(call install_finish, python30)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

python30_clean:
	rm -rf $(STATEDIR)/python30.*
	rm -rf $(PKGDIR)/python30_*
	rm -rf $(PYTHON30_DIR)

# vim: syntax=make
