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

#
# We provide this package
#
ifdef PTXCONF_WXWINDOWS_X11
PACKAGES += wxWindows
endif

#
# Paths and names
#
WXWINDOWS_VERSION	= 2.4.2
WXWINDOWS		= wxX11-$(WXWINDOWS_VERSION)
WXWINDOWS_SUFFIX	= tar.gz
WXWINDOWS_URL		= $(PTXCONF_SFMIRROR)/wxwindows/$(WXWINDOWS).$(WXWINDOWS_SUFFIX)
WXWINDOWS_SOURCE	= $(SRCDIR)/$(WXWINDOWS).$(WXWINDOWS_SUFFIX)
WXWINDOWS_DIR		= $(BUILDDIR)/$(WXWINDOWS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

wxWindows_get: $(STATEDIR)/wxWindows.get

wxWindows_get_deps	=  $(WXWINDOWS_SOURCE)

$(STATEDIR)/wxWindows.get: $(wxWindows_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(WXWINDOWS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(WXWINDOWS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

wxWindows_extract: $(STATEDIR)/wxWindows.extract

wxWindows_extract_deps	=  $(STATEDIR)/wxWindows.get

$(STATEDIR)/wxWindows.extract: $(wxWindows_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(WXWINDOWS_DIR))
	@$(call extract, $(WXWINDOWS_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

wxWindows_prepare: $(STATEDIR)/wxWindows.prepare

#
# dependencies
#
wxWindows_prepare_deps =  \
	$(STATEDIR)/wxWindows.extract \
	$(STATEDIR)/virtual-xchain.install

WXWINDOWS_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
WXWINDOWS_ENV 	=  $(CROSS_ENV)
#WXWINDOWS_ENV	+=


#
# autoconf
#
WXWINDOWS_AUTOCONF	=  $(CROSS_AUTOCONF)
WXWINDOWS_AUTOCONF	+= --prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
WXWINDOWS_AUTOCONF	+= --x-includes=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11
WXWINDOWS_AUTOCONF	+= --x-libraries=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
WXWINDOWS_AUTOCONF	+= --disable-shared 

# WARNING : HERE WORK IS STILL IN PROGRESS !

WXWINDOWS_AUTOCONF	+= --with-x11 --without-gtk \
--disable-no_rtti --disable-no_exceptions \
--disable-mdi --disable-printarch --disable-postscript --disable-resources \
--disable-prologio --with-zlib=builtin --with-libpng=builtin \
--disable-joystick --with-libjpeg=builtin --with-libtiff=builtin


$(STATEDIR)/wxWindows.prepare: $(wxWindows_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(WXWINDOWS_BUILDDIR))
	cd $(WXWINDOWS_DIR) && \
		$(WXWINDOWS_PATH) $(WXWINDOWS_ENV) \
		./configure $(WXWINDOWS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

wxWindows_compile: $(STATEDIR)/wxWindows.compile

wxWindows_compile_deps =  $(STATEDIR)/wxWindows.prepare

$(STATEDIR)/wxWindows.compile: $(wxWindows_compile_deps)
	@$(call targetinfo, $@)
	$(WXWINDOWS_PATH) $(WXWINDOWS_ENV) make -C $(WXWINDOWS_DIR)
	touch $@


# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

wxWindows_install: $(STATEDIR)/wxWindows.install

$(STATEDIR)/wxWindows.install: $(STATEDIR)/wxWindows.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

wxWindows_targetinstall: $(STATEDIR)/wxWindows.targetinstall

wxWindows_targetinstall_deps	=  $(STATEDIR)/wxWindows.compile

$(STATEDIR)/wxWindows.targetinstall: $(wxWindows_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

wxWindows_clean:
	rm -rf $(STATEDIR)/wxWindows.*
	rm -rf $(WXWINDOWS_DIR)

# vim: syntax=make
