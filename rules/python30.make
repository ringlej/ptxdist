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
PYTHON30_VERSION	:= 3.0rc2
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
	CROSS_COMPILE=yes \
	ac_cv_have_chflags=no \
	ac_cv_have_lchflags=no \
	ac_cv_py_format_size_t=z

#
# autoconf
#
PYTHON30_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-profiling \
	--with-suffix="" \
	--without-pydebug \
	--without-system-ffi \
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

PYTHON30_MAKEVARS = \
	HOSTPYTHON=$(PTXCONF_SYSROOT_HOST)/bin/python3.0 \
	HOSTPGEN=$(HOST_PYTHON30_DIR)/Parser/pgen \
	DESTDIR=$(PTXCONF_SYSROOT_TARGET)

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
		$(PYTHON30_PATH) $(MAKE) $(PARALLELMFLAGS) $(PYTHON30_MAKEVARS) --debug=base
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python30.install:
	@$(call targetinfo)
	@$(call install, PYTHON30)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python30.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python30)
	@$(call install_fixup, python30,PACKAGE,python30)
	@$(call install_fixup, python30,PRIORITY,optional)
	@$(call install_fixup, python30,VERSION,$(PYTHON30_VERSION))
	@$(call install_fixup, python30,SECTION,base)
	@$(call install_fixup, python30,AUTHOR,"Robert Schwebel")
	@$(call install_fixup, python30,DEPENDS,)
	@$(call install_fixup, python30,DESCRIPTION,missing)

	@$(call install_copy, python30, 0, 0, 0755, $(PYTHON30_DIR)/foobar, /dev/null)

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
