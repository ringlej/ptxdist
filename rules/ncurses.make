# -*-makefile-*-
# $Id: ncurses.make,v 1.15 2004/01/20 10:54:50 robert Exp $
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_NCURSES
PACKAGES += ncurses
endif

#
# Paths and names 
#
NCURSES_VERSION	= 5.3
NCURSES		= ncurses-$(NCURSES_VERSION)
NCURSES_SUFFIX	= tar.gz
NCURSES_URL	= ftp://ftp.gnu.org/pub/gnu/ncurses/$(NCURSES).$(NCURSES_SUFFIX)
NCURSES_SOURCE	= $(SRCDIR)/$(NCURSES).$(NCURSES_SUFFIX)
NCURSES_DIR	= $(BUILDDIR)/$(NCURSES)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ncurses_get: $(STATEDIR)/ncurses.get

$(STATEDIR)/ncurses.get: $(NCURSES_SOURCE)
	@$(call targetinfo, $@)
	@$(call get_patches, $(NCURSES))
	touch $@

$(NCURSES_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(NCURSES_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ncurses_extract: $(STATEDIR)/ncurses.extract

$(STATEDIR)/ncurses.extract: $(STATEDIR)/ncurses.get
	@$(call targetinfo, $@)
	@$(call clean, $(NCURSES_DIR))
	@$(call extract, $(NCURSES_SOURCE))
	@$(call patchin, $(NCURSES))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ncurses_prepare: $(STATEDIR)/ncurses.prepare

#
# dependencies
#
ncurses_prepare_deps =  \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/ncurses.extract

NCURSES_PATH	=  PATH=$(CROSS_PATH)
NCURSES_ENV = \
	$(CROSS_ENV)

#
# RSC: --with-build-cflags: ncurses seems to forget to include it's own
# include directory...
#

NCURSES_AUTOCONF =\
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=/usr \
	--exec-prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--with-shared \
	--disable-nls \
	--disable-rpath \
	--without-ada \
	--enable-const \
	--enable-overwrite \
	--with-terminfo-dirs=/usr/share/terminfo \
	--with-default-terminfo-dir=/usr/share/terminfo \
	--with-build-cc=$(HOSTCC) \
	--with-build-cflags=-I../include \
	--with-build-ldflags= \
	--with-build-cppflags= \
	--with-build-libs= 

ifndef PTXCONF_CXX
NCURSES_AUTOCONF += --without-cxx-binding
endif

$(STATEDIR)/ncurses.prepare: $(ncurses_prepare_deps)
	@$(call targetinfo, $@)
	cd $(NCURSES_DIR) && \
		$(NCURSES_PATH) $(NCURSES_ENV) \
		./configure $(NCURSES_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ncurses_compile: $(STATEDIR)/ncurses.compile

$(STATEDIR)/ncurses.compile: $(STATEDIR)/ncurses.prepare 
	@$(call targetinfo, $@)
#
# the two tools make_hash and make_keys are compiled for the host system
# these tools are needed later in the compile progress
#
# it's not good to pass target CFLAGS to the host compiler :)
# so override these
#
	$(NCURSES_PATH) make -C $(NCURSES_DIR)/ncurses CFLAGS='' CXXFLAGS='' make_hash make_keys
	$(NCURSES_PATH) make -C $(NCURSES_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ncurses_install: $(STATEDIR)/ncurses.install

$(STATEDIR)/ncurses.install: $(STATEDIR)/ncurses.compile
	@$(call targetinfo, $@)
	$(NCURSES_PATH) make -C $(NCURSES_DIR) DESTDIR=$(CROSS_LIB_DIR) prefix='' exec_prefix='' install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ncurses_targetinstall: $(STATEDIR)/ncurses.targetinstall

$(STATEDIR)/ncurses.targetinstall: $(STATEDIR)/ncurses.install
	@$(call targetinfo, $@)

	install -d $(ROOTDIR)/lib
	install -d $(ROOTDIR)/usr/lib

	cp -d $(NCURSES_DIR)/lib/libncurses.so* $(ROOTDIR)/lib/
	$(CROSS_STRIP) --strip-unneeded -R .comment -R .note $(ROOTDIR)/lib/libncurses.so*

ifdef PTXCONF_NCURSES_FORM
	cp -d $(NCURSES_DIR)/lib/libform.so* $(ROOTDIR)/usr/lib/
	$(CROSS_STRIP) --strip-unneeded -R .comment -R .note $(ROOTDIR)/usr/lib/libform.so*
endif

ifdef PTXCONF_NCURSES_MENU
	cp -d $(NCURSES_DIR)/lib/libmenu.so* $(ROOTDIR)/usr/lib/
	$(CROSS_STRIP) --strip-unneeded -R .comment -R .note $(ROOTDIR)/usr/lib/libmenu.so*
endif

ifdef PTXCONF_NCURSES_PANEL
	cp -d $(NCURSES_DIR)/lib/libpanel.so* $(ROOTDIR)/usr/lib/
	$(CROSS_STRIP) --strip-unneeded -R .comment -R .note $(ROOTDIR)/usr/lib/libpanel.so*
endif

ifdef PTXCONF_NCURSES_TERMCAP
	mkdir -p $(ROOTDIR)/usr/share/terminfo
	for FILE in x/xterm x/xterm-color x/xterm-xfree86 v/vt100 v/vt200 a/ansi l/linux; do			\
		install -D $(CROSS_LIB_DIR)/usr/share/terminfo/$$FILE $(ROOTDIR)/usr/share/terminfo/$$FILE;	\
	done
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ncurses_clean: 
	rm -rf $(STATEDIR)/ncurses.* $(NCURSES_DIR)

# vim: syntax=make
