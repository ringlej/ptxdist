# -*-makefile-*-
# $Id: xfree430.make,v 1.1 2003/08/17 00:34:18 robert Exp $
#
# (c) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#             Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
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
XFREE430_VERSION	= 4.3.99.10
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
	@$(call targetinfo, xfree430.get)
	touch $@

$(XFREE430_SOURCE):
	@$(call targetinfo, $(XFREE430_SOURCE))
	@$(call get, $(XFREE430_URL))

# FIXME: for a release use split sources
#$(XFREE430_1_SOURCE):
#	@$(call targetinfo, $(XFREE430_1_SOURCE))
#	@$(call get, $(XFREE430_1_URL))
#
#$(XFREE430_2_SOURCE):
#	@$(call targetinfo, $(XFREE430_2_SOURCE))
#	@$(call get, $(XFREE430_2_URL))
#
#$(XFREE430_3_SOURCE):
#	@$(call targetinfo, $(XFREE430_3_SOURCE))
#	@$(call get, $(XFREE430_3_URL))
#
#$(XFREE430_4_SOURCE):
#	@$(call targetinfo, $(XFREE430_4_SOURCE))
#	@$(call get, $(XFREE430_4_URL))
#
#$(XFREE430_5_SOURCE):
#	@$(call targetinfo, $(XFREE430_5_SOURCE))
#	@$(call get, $(XFREE430_5_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xfree430_extract: $(STATEDIR)/xfree430.extract

xfree430_extract_deps	=  $(STATEDIR)/xfree430.get

$(STATEDIR)/xfree430.extract: $(xfree430_extract_deps)
	@$(call targetinfo, xfree430.extract)
	@$(call clean, $(XFREE430_DIR))
	@$(call extract, $(XFREE430_SOURCE))

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
	$(STATEDIR)/virtual-xchain.install

XFREE430_PATH	=  PATH=$(CROSS_PATH)
XFREE430_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
#XFREE430_AUTOCONF	=  --prefix=/usr
#XFREE430_AUTOCONF	+= --build=$(GNU_HOST)
#XFREE430_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

#ifdef PTXCONF_XFREE430_FOO
#XFREE430_AUTOCONF	+= --enable-foo
#endif

$(STATEDIR)/xfree430.prepare: $(xfree430_prepare_deps)
	@$(call targetinfo, xfree430.prepare)
	@$(call clean, $(XFREE430_BUILDDIR))
	install -d $(XFREE430_BUILDDIR)
	cd $(XFREE430_DIR)/config/util && make -f Makefile.ini lndir
	cd $(XFREE430_BUILDDIR) && $(XFREE430_DIR)/config/util/lndir $(XFREE430_DIR)
	cp $(PTXCONF_XFREE430_CONFIG) $(XFREE430_BUILDDIR)/config/cf/host.def
	cd $(XFREE430_BUILDDIR) && mkdir cross_compiler
	for i in $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin/*; do ln -s $$i $(XFREE430_BUILDDIR)/cross_compiler; done
	ln -sf $(PTXCONF_PREFIX)/bin/cpp $(XFREE430_BUILDDIR)/cross_compiler/
	ln -sf $(PTXCONF_PREFIX)/bin/gcov $(XFREE430_BUILDDIR)/cross_compiler/
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
	@$(call targetinfo, xfree430.compile)
	cd $(XFREE430_BUILDDIR) && make World CROSSCOMPILEDIR=$(XFREE430_BUILDDIR)/cross_compiler
	# FIXME: uggly hack 
	chmod a+x $(XFREE430_BUILDDIR)/lib/freetype2/freetype/config/freetype-config
	perl -i -p -e "s,/usr/X11R6,$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET),g" \
		$(XFREE430_BUILDDIR)/lib/freetype2/freetype/config/freetype-config
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xfree430_install: $(STATEDIR)/xfree430.install

$(STATEDIR)/xfree430.install: $(STATEDIR)/xfree430.compile
	@$(call targetinfo, xfree430.install)
	
	# FIXME
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
	cp -f $(XFREE430_BUILDDIR)/lib/Xft/libXft.so.2.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libXft.so.2.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXft.so.2
	ln -sf libXft.so.2.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXft.so
	cp -f $(XFREE430_BUILDDIR)/lib/Xft/Xft.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
	
	rm -fr $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11
	cp -fa $(XFREE430_BUILDDIR)/lib/X11 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/
	cp -fa $(XFREE430_BUILDDIR)/include/*.h $(PTXCONF_GNU_TARGET)/include/X11/
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xft
	cp -fa $(XFREE430_BUILDDIR)/lib/Xft/*.h $(PTXCONF_GNU_TARGET)/include/X11/Xft/
	
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/extensions
	cp -fa $(XFREE430_BUILDDIR)/lib/Xrender/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/extensions/
	cp -fa $(XFREE430_BUILDDIR)/include/extensions/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/extensions/

	cp -fa $(XFREE430_BUILDDIR)/lib/Xrender/libXrender.so.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libXrender.so.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXrender.so
	
	cp -fa $(XFREE430_BUILDDIR)/lib/Xext/libXext.so.6.4 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libXext.so.6.4 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXext.so.6
	ln -sf libXext.so.6.4 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXext.so
	cp -fa $(XFREE430_BUILDDIR)/include/extensions/Xext.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/extensions/
	
	cp -fa $(XFREE430_BUILDDIR)/lib/X11/libX11.so.6 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libX11.so.6 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libX11.so
	
	cp -fa $(XFREE430_BUILDDIR)/lib/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/

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
	@$(call targetinfo, xfree430.targetinstall)
	# FIXME: this is somehow not being built...
	touch $(XFREE430_BUILDDIR)/fonts/encodings/encodings.dir
	cd $(XFREE430_BUILDDIR) && make install DESTDIR=$(ROOTDIR)
	# FIXME: correct path? 
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
