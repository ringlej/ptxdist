# -*-makefile-*-
# $Id: xfree430.make,v 1.5 2003/09/16 16:58:57 mkl Exp $
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
	@$(call get_patches, $(XFREE))
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
	@$(call targetinfo, xfree430.prepare)
	@$(call clean, $(XFREE430_BUILDDIR))

#	# Out-of-Tree build preparation
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

	cd $(XFREE430_BUILDDIR) && \
		$(XFREE430_ENV) make World CROSSCOMPILEDIR=$(XFREE430_BUILDDIR)/cross_compiler

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xfree430_install: $(STATEDIR)/xfree430.install

$(STATEDIR)/xfree430.install: $(STATEDIR)/xfree430.compile
	@$(call targetinfo, xfree430.install)

#	# These links are set incorrectly :-(
	ln -sf $(XFREE430_BUILDDIR)/programs/Xserver/hw/xfree86/xf86Date.h $(XFREE430_BUILDDIR)/config/cf/date.def
	ln -sf $(XFREE430_BUILDDIR)/programs/Xserver/hw/xfree86/xf86Version.h $(XFREE430_BUILDDIR)/config/cf/version.def

#	# FIXME
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11
	cp -f $(XFREE430_BUILDDIR)/lib/Xft/libXft.so.2.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libXft.so.2.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXft.so.2
	ln -sf libXft.so.2.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXft.so
	cp -f $(XFREE430_BUILDDIR)/lib/Xft/Xft.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include

	rm -fr $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11
	cp -fa $(XFREE430_BUILDDIR)/lib/X11 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/
	cp -fa $(XFREE430_BUILDDIR)/include/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xft
	cp -fa $(XFREE430_BUILDDIR)/lib/Xft/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xft/

	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/extensions
	cp -fa $(XFREE430_BUILDDIR)/lib/Xrender/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/extensions/
	cp -fa $(XFREE430_BUILDDIR)/include/extensions/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/extensions/

	cp -fa $(XFREE430_BUILDDIR)/lib/Xrender/libXrender.so.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libXrender.so.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXrender.so

	cp -fa $(XFREE430_BUILDDIR)/lib/Xext/libXext.so.6.4 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libXext.so.6.4 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXext.so.6
	ln -sf libXext.so.6.4 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXext.so
	cp -fa $(XFREE430_BUILDDIR)/include/extensions/Xext.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/extensions/

	cp -fa $(XFREE430_BUILDDIR)/lib/SM/libSM.so.6.0 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libSM.so.6.0 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libSM.so.6
	ln -sf libSM.so.6.0 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libSM.so
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/SM
	cp -fa $(XFREE430_BUILDDIR)/lib/SM/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/SM

	cp -fa $(XFREE430_BUILDDIR)/lib/ICE/libICE.so.6.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libICE.so.6.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libICE.so.6
	ln -sf libICE.so.6.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libICE.so
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/ICE
	cp -fa $(XFREE430_BUILDDIR)/lib/ICE/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/ICE

	cp -fa $(XFREE430_BUILDDIR)/lib/Xt/libXt.so.6.0 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libXt.so.6.0 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXt.so.6
	ln -sf libXt.so.6.0 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXt.so
	cp -f $(XFREE430_BUILDDIR)/lib/Xt/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/

	cp -fa $(XFREE430_BUILDDIR)/lib/X11/libX11.so.6.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libX11.so.6.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libX11.so.6
	ln -sf libX11.so.6.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libX11.so

# FIXME
#	cp -fa $(XFREE430_BUILDDIR)/lib/X11/libXpm.so.4.11 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
#	ln -sf libXpm.so.4.11 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXpm.so.4
#	ln -sf libXpm.so.4.11 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXpm.so

	cp -f $(XFREE430_BUILDDIR)/lib/freetype2/libfreetype.so.6.3.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libfreetype.so.6.3.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libfreetype.so.6
	ln -sf libfreetype.so.6.3.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libfreetype.so
	cp -af $(XFREE430_BUILDDIR)/lib/font/FreeType/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/

	cp -f $(XFREE430_BUILDDIR)/lib/Xaw/libXaw.so.7.0 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libXaw.so.7.0 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXaw.so.7
	ln -sf libXaw.so.7.0 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXaw.so
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xaw
	cp -af $(XFREE430_BUILDDIR)/lib/Xaw/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xaw/

	cp -f $(XFREE430_BUILDDIR)/lib/Xmu/libXmu.so.6.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libXmu.so.6.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXmu.so.6
	ln -sf libXmu.so.6.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXmu.so
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xmu
	cp -af $(XFREE430_BUILDDIR)/lib/Xmu/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xmu/

	cp -f $(XFREE430_BUILDDIR)/lib/Xpm/libXpm.so.4.11 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libXpm.so.4.11 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXpm.so.4
	ln -sf libXpm.so.4.11 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXpm.so
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xpm
	cp -af $(XFREE430_BUILDDIR)/lib/Xpm/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xpm/

	cp -f $(XFREE430_BUILDDIR)/lib/Xtst/libXtst.so.6.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libXtst.so.6.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXtst.so.6
	ln -sf libXtst.so.6.1 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXtst.so
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xtst
#	#cp -af $(XFREE430_BUILDDIR)/lib/Xtst/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xtst/

	cp -f $(XFREE430_BUILDDIR)/lib/Xi/libXi.so.6.0 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libXi.so.6.0 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXi.so.6
	ln -sf libXi.so.6.0 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libXi.so
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xi
	cp -af $(XFREE430_BUILDDIR)/lib/Xi/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/X11/Xi/

	cp -af $(XFREE430_BUILDDIR)/include/Xmd.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/

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
