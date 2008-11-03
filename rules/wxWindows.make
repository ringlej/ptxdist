# -*-makefile-*-
# $Id$
#
# Copyright (C) 08/10/2003 by Marco Cavallini <m.cavallini@koansoftware.com>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: ipkgize

#
# We provide this package
#
PACKAGES-$(PTXCONF_WXWINDOWS_X11) += wxwindows

#
# Paths and names
#
WXWINDOWS_VERSION	= 2.4.2
WXWINDOWS		= wxX11-$(WXWINDOWS_VERSION)
WXWINDOWS_SUFFIX	= tar.gz
WXWINDOWS_URL		= $(PTXCONF_SETUP_SFMIRROR)/wxwindows/$(WXWINDOWS).$(WXWINDOWS_SUFFIX)
WXWINDOWS_SOURCE	= $(SRCDIR)/$(WXWINDOWS).$(WXWINDOWS_SUFFIX)
WXWINDOWS_DIR		= $(BUILDDIR)/$(WXWINDOWS)



# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

wxwindows_get: $(STATEDIR)/wxwindows.get

$(STATEDIR)/wxwindows.get: $(wxwindows_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(WXWINDOWS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, WXWINDOWS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

wxwindows_extract: $(STATEDIR)/wxwindows.extract

$(STATEDIR)/wxwindows.extract: $(wxwindows_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(WXWINDOWS_DIR))
	@$(call extract, WXWINDOWS)
	@$(call patchin, WXWINDOWS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

wxwindows_prepare: $(STATEDIR)/wxwindows.prepare

WXWINDOWS_PATH	=  PATH=$(CROSS_PATH)
WXWINDOWS_ENV 	=  $(CROSS_ENV)


#
# autoconf
#
WXWINDOWS_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
WXWINDOWS_AUTOCONF	+= --x-includes=$(SYSROOT)/include/X11
WXWINDOWS_AUTOCONF	+= --x-libraries=$(SYSROOT)/lib
WXWINDOWS_AUTOCONF	+= --disable-shared 

# WARNING : HERE WORK IS STILL IN PROGRESS !

WXWINDOWS_AUTOCONF	+= --with-x11 --without-gtk \
--disable-no_rtti --disable-no_exceptions \
--disable-mdi --disable-printarch --disable-postscript --disable-resources \
--disable-prologio --with-zlib=builtin --with-libpng=builtin \
--disable-joystick --with-libjpeg=builtin --with-libtiff=builtin


$(STATEDIR)/wxwindows.prepare: $(wxwindows_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(WXWINDOWS_BUILDDIR))
	cd $(WXWINDOWS_DIR) && \
		$(WXWINDOWS_PATH) $(WXWINDOWS_ENV) \
		./configure $(WXWINDOWS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

wxwindows_compile: $(STATEDIR)/wxwindows.compile

wxwindows_compile_deps =  $(STATEDIR)/wxwindows.prepare

$(STATEDIR)/wxwindows.compile: $(wxwindows_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(WXWINDOWS_DIR) && $(WXWINDOWS_PATH) $(WXWINDOWS_ENV) make
	@$(call touch, $@)


# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

wxwindows_install: $(STATEDIR)/wxwindows.install

$(STATEDIR)/wxwindows.install: $(wxwindows_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

wxwindows_targetinstall: $(STATEDIR)/wxwindows.targetinstall

$(STATEDIR)/wxwindows.targetinstall: $(wxwindows_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

wxwindows_clean:
	rm -rf $(STATEDIR)/wxwindows.*
	rm -rf $(PKGDIR)/wxwindows_*
	rm -rf $(WXWINDOWS_DIR)

# vim: syntax=make
