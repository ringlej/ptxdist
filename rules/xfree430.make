# -*-makefile-*-
# $Id: xfree430.make,v 1.14 2004/02/25 11:00:48 bsp Exp $
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#             Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_XFREE430
PACKAGES += xfree430
endif

#
# Paths and names
#
XFREE430_VERSION	= 4.3.99.902
XFREE430		= XFree86-$(XFREE430_VERSION)
XFREE430_SUFFIX		= tar.bz2
XFREE430_DIR		= $(BUILDDIR)/xc
XFREE430_BUILDDIR	= $(BUILDDIR)/xc-build

XFREE430_URL		= ftp://ftp.xfree86.org/pub/XFree86/develsnaps/$(XFREE430).$(XFREE430_SUFFIX)
XFREE430_SOURCE		= $(SRCDIR)/$(XFREE430).$(XFREE430_SUFFIX)

# FIXME: for a release use split sources
#XFREE430_1_URL		= ftp://ftp.xfree86.org/pub/XFree86/4.3.0/source/$(XFREE430)-1.$(XFREE430_SUFFIX)
#XFREE430_1_SOURCE	= $(SRCDIR)/$(XFREE430)-1.$(XFREE430_SUFFIX)
#XFREE430_2_URL		= ftp://ftp.xfree86.org/pub/XFree86/4.3.0/source/$(XFREE430)-2.$(XFREE430_SUFFIX)
#XFREE430_2_SOURCE	= $(SRCDIR)/$(XFREE430)-2.$(XFREE430_SUFFIX)
#XFREE430_3_URL		= ftp://ftp.xfree86.org/pub/XFree86/4.3.0/source/$(XFREE430)-3.$(XFREE430_SUFFIX)
#XFREE430_3_SOURCE	= $(SRCDIR)/$(XFREE430)-3.$(XFREE430_SUFFIX)
#XFREE430_4_URL		= ftp://ftp.xfree86.org/pub/XFree86/4.3.0/source/$(XFREE430)-4.$(XFREE430_SUFFIX)
#XFREE430_4_SOURCE	= $(SRCDIR)/$(XFREE430)-4.$(XFREE430_SUFFIX)
#XFREE430_5_URL		= ftp://ftp.xfree86.org/pub/XFree86/4.3.0/source/$(XFREE430)-5.$(XFREE430_SUFFIX)
#XFREE430_5_SOURCE	= $(SRCDIR)/$(XFREE430)-5.$(XFREE430_SUFFIX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xfree430_get: $(STATEDIR)/xfree430.get

xfree430_get_deps	= $(XFREE430_SOURCE)

# FIXME: for a release use split sources
#xfree430_get_deps	=  $(XFREE430_1_SOURCE)
#xfree430_get_deps	+= $(XFREE430_2_SOURCE)
#xfree430_get_deps	+= $(XFREE430_3_SOURCE)
#xfree430_get_deps	+= $(XFREE430_4_SOURCE)
#xfree430_get_deps	+= $(XFREE430_5_SOURCE)

$(STATEDIR)/xfree430.get: $(xfree430_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XFREE430))
	touch $@

$(XFREE430_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XFREE430_URL))

# FIXME: for a release use split sources
#$(XFREE430_1_SOURCE):
#	@$(call targetinfo, $@)
#	@$(call get, $(XFREE430_1_URL))
#
#$(XFREE430_2_SOURCE):
#	@$(call targetinfo, $@)
#	@$(call get, $(XFREE430_2_URL))
#
#$(XFREE430_3_SOURCE):
#	@$(call targetinfo, $@)
#	@$(call get, $(XFREE430_3_URL))
#
#$(XFREE430_4_SOURCE):
#	@$(call targetinfo, $@)
#	@$(call get, $(XFREE430_4_URL))
#
#$(XFREE430_5_SOURCE):
#	@$(call targetinfo, $@)
#	@$(call get, $(XFREE430_5_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xfree430_extract: $(STATEDIR)/xfree430.extract

xfree430_extract_deps	=  $(STATEDIR)/xfree430.get

$(STATEDIR)/xfree430.extract: $(xfree430_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XFREE430_DIR))
	@$(call extract, $(XFREE430_SOURCE))
	@$(call patchin, $(XFREE430), $(XFREE430_DIR))

# FIXME: for a release use split sources
#	@$(call extract, $(XFREE430_1_SOURCE))
#	@$(call extract, $(XFREE430_2_SOURCE))
#	@$(call extract, $(XFREE430_3_SOURCE))
#	@$(call extract, $(XFREE430_4_SOURCE))
#	@$(call extract, $(XFREE430_5_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xfree430_prepare: $(STATEDIR)/xfree430.prepare

#
# dependencies
#
xfree430_prepare_deps =  \
	$(STATEDIR)/xfree430.extract \
	$(STATEDIR)/zlib.install \
	$(STATEDIR)/ncurses.install \
	$(STATEDIR)/libpng125.install \
	$(STATEDIR)/virtual-xchain.install

XFREE430_PATH	=  PATH=$(CROSS_PATH)
XFREE430_ENV	=  XCURSORGEN=xcursorgen

$(STATEDIR)/xfree430.prepare: $(xfree430_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XFREE430_BUILDDIR))

#	# Out-of-Tree build preparation
	install -d $(XFREE430_BUILDDIR)
	cd $(XFREE430_DIR)/config/util && make -f Makefile.ini lndir
	cd $(XFREE430_BUILDDIR) && $(XFREE430_DIR)/config/util/lndir $(XFREE430_DIR)
	cp $(PTXCONF_XFREE430_CONFIG) $(XFREE430_BUILDDIR)/config/cf/host.def
	echo "#define ProjectRoot $(CROSS_LIB_DIR)/X11R6" >> \
		$(XFREE430_BUILDDIR)/config/cf/host.def
	cd $(XFREE430_BUILDDIR) && mkdir cross_compiler
	for i in $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin/*; do ln -s $$i $(XFREE430_BUILDDIR)/cross_compiler; done
	ln -sf $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-cpp $(XFREE430_BUILDDIR)/cross_compiler/cpp
	ln -sf $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-gcov $(XFREE430_BUILDDIR)/cross_compiler/gcov
	ln -sf gcc $(XFREE430_BUILDDIR)/cross_compiler/cc
	ln -sf $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-g++ $(XFREE430_BUILDDIR)/cross_compiler/
	ln -sf $(PTXCONF_GNU_TARGET)-g++ $(XFREE430_BUILDDIR)/cross_compiler/g++
	ln -sf g++ $(XFREE430_BUILDDIR)/cross_compiler/c++

	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xfree430_compile: $(STATEDIR)/xfree430.compile

xfree430_compile_deps =  $(STATEDIR)/xfree430.prepare

$(STATEDIR)/xfree430.compile: $(xfree430_compile_deps)
	@$(call targetinfo, $@)

	cd $(XFREE430_BUILDDIR) && \
		$(XFREE430_ENV) make World prefix=$(CROSS_LIB_DIR) CROSSCOMPILEDIR=$(XFREE430_BUILDDIR)/cross_compiler

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xfree430_install: $(STATEDIR)/xfree430.install

$(STATEDIR)/xfree430.install: $(STATEDIR)/xfree430.compile
	@$(call targetinfo, $@)

	# These links are set incorrectly :-(
	# ln -sf $(XFREE430_BUILDDIR)/programs/Xserver/hw/xfree86/xf86Date.h $(XFREE430_BUILDDIR)/config/cf/date.def
	# ln -sf $(XFREE430_BUILDDIR)/programs/Xserver/hw/xfree86/xf86Version.h $(XFREE430_BUILDDIR)/config/cf/version.def
	
	cd $(XFREE430_BUILDDIR) && \
		$(XFREE430_ENV) make install
	
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xfree430_targetinstall: $(STATEDIR)/xfree430.targetinstall

xfree430_targetinstall_deps =  $(STATEDIR)/xfree430.compile
xfree430_targetinstall_deps += $(STATEDIR)/ncurses.targetinstall
xfree430_targetinstall_deps += $(STATEDIR)/libpng125.targetinstall
xfree430_targetinstall_deps += $(STATEDIR)/zlib.targetinstall

$(STATEDIR)/xfree430.targetinstall: $(xfree430_targetinstall_deps)
	@$(call targetinfo, $@)

#	# These links are set incorrectly :-(
	ln -sf $(XFREE430_BUILDDIR)/programs/Xserver/hw/xfree86/xf86Date.h $(XFREE430_BUILDDIR)/config/cf/date.def
	ln -sf $(XFREE430_BUILDDIR)/programs/Xserver/hw/xfree86/xf86Version.h $(XFREE430_BUILDDIR)/config/cf/version.def

#	# FIXME: this is somehow not being built...
	touch $(XFREE430_BUILDDIR)/fonts/encodings/encodings.dir
	cd $(XFREE430_BUILDDIR) && make install DESTDIR=$(ROOTDIR)

#	# FIXME: correct path? 
	cp -f $(XFREE430_BUILDDIR)/lib/freetype2/libfreetype.so.6.3.3 $(ROOTDIR)/lib
	ln -sf libfreetype.so.6.3.3 $(ROOTDIR)/lib/libfreetype.so.6
	ln -sf libfreetype.so.6.3.3 $(ROOTDIR)/lib/libfreetype.so

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xfree430_clean:
	rm -rf $(STATEDIR)/xfree430.*
	rm -rf $(XFREE430_DIR) $(XFREE430_BUILDDIR)

# vim: syntax=make
