# -*-makefile-*-
# $Id$
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
NCURSES_URL	= $(PTXCONF_SETUP_GNUMIRROR)/ncurses/$(NCURSES).$(NCURSES_SUFFIX)
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

NCURSES_PATH	= PATH=$(CROSS_PATH)
NCURSES_ENV 	= $(CROSS_ENV)

#
# RSC: --with-build-cflags: ncurses seems to forget to include it's own
# include directory...
#

NCURSES_AUTOCONF =  $(CROSS_AUTOCONF)
NCURSES_AUTOCONF += \
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
	cd $(NCURSES_DIR)/ncurses && $(NCURSES_PATH) make CFLAGS='' CXXFLAGS='' make_hash make_keys
	cd $(NCURSES_DIR) && $(NCURSES_PATH) make
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

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,ncurses)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(NCURSES_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, $(NCURSES_DIR)/lib/libncurses.so.5.3, /lib/libncurses.so.5.3)
	@$(call install_link, libncurses.so.5.3, /lib/libncurses.so.5)
	@$(call install_link, libncurses.so.5.3, /lib/libncurses.so)

ifdef PTXCONF_NCURSES_FORM
	@$(call install_copy, 0, 0, 0644, $(NCURSES_DIR)/lib/libncurses.so.5.3, /lib/libncurses.so.5.3)
	@$(call install_link, libncurses.so.5.3, /lib/libncurses.so.5)
	@$(call install_link, libncurses.so.5.3, /lib/libncurses.so)
endif

ifdef PTXCONF_NCURSES_MENU
	@$(call install_copy, 0, 0, 0644, $(NCURSES_DIR)/lib/libmenu.so.5.3, /lib/libmenu.so.5.3)
	@$(call install_link, libmenu.so.5.3, /lib/libmenu.so.5)
	@$(call install_link, libmenu.so.5.3, /lib/libmenu.so)
endif

ifdef PTXCONF_NCURSES_PANEL
	@$(call install_copy, 0, 0, 0644, $(NCURSES_DIR)/lib/libpanel.so.5.3, /lib/libpanel.so.5.3)
	@$(call install_link, libpanel.so.5.3, /lib/libpanel.so.5)
	@$(call install_link, libpanel.so.5.3, /lib/libpanel.so)
endif

ifdef PTXCONF_NCURSES_TERMCAP
	mkdir -p $(ROOTDIR)/usr/share/terminfo
	@$(call install_copy, 0, 0, 0644, $(CROSS_LIB_DIR)/usr/share/terminfo/x/xterm, /usr/share/terminfo/x/xterm, n);
	@$(call install_copy, 0, 0, 0644, $(CROSS_LIB_DIR)/usr/share/terminfo/x/xterm-color, /usr/share/terminfo/x/xterm-color, n);
	@$(call install_copy, 0, 0, 0644, $(CROSS_LIB_DIR)/usr/share/terminfo/x/xterm-xfree86, /usr/share/terminfo/x/xterm-xfree86, n);
	@$(call install_copy, 0, 0, 0644, $(CROSS_LIB_DIR)/usr/share/terminfo/v/vt100, /usr/share/terminfo/v/vt100, n);
	@$(call install_copy, 0, 0, 0644, $(CROSS_LIB_DIR)/usr/share/terminfo/v/vt102, /usr/share/terminfo/v/vt102, n);
	@$(call install_copy, 0, 0, 0644, $(CROSS_LIB_DIR)/usr/share/terminfo/v/vt200, /usr/share/terminfo/v/vt200, n);
	@$(call install_copy, 0, 0, 0644, $(CROSS_LIB_DIR)/usr/share/terminfo/a/ansi, /usr/share/terminfo/a/ansi, n);
	@$(call install_copy, 0, 0, 0644, $(CROSS_LIB_DIR)/usr/share/terminfo/l/linux, /usr/share/terminfo/l/linux, n);
endif

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ncurses_clean: 
	rm -rf $(STATEDIR)/ncurses.* $(NCURSES_DIR)
	rm -rf $(IMAGEDIR)/ncurses_* 

# vim: syntax=make
