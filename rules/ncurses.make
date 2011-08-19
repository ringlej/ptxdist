# -*-makefile-*-
#
# Copyright (C) 2002-2009 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NCURSES) += ncurses

#
# Paths and names
#
NCURSES_VERSION	:= 5.9
NCURSES_MAJOR	:= $(word 1,$(subst ., ,$(NCURSES_VERSION)))
NCURSES_MD5	:= 8cb9c412e5f2d96bc6f459aa8c6282a1
NCURSES		:= ncurses-$(NCURSES_VERSION)
NCURSES_SUFFIX	:= tar.gz
NCURSES_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/ncurses/$(NCURSES).$(NCURSES_SUFFIX)
NCURSES_SOURCE	:= $(SRCDIR)/$(NCURSES).$(NCURSES_SUFFIX)
NCURSES_DIR	:= $(BUILDDIR)/$(NCURSES)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(NCURSES_SOURCE):
	@$(call targetinfo)
	@$(call get, NCURSES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NCURSES_ENV := \
	$(CROSS_ENV) \
	TIC_PATH="$(PTXCONF_SYSROOT_HOST)/bin/tic"

NCURSES_AUTOCONF_SHARED := \
	--disable-echo \
	--disable-nls \
	--enable-const \
	--enable-overwrite \
	--libdir=/lib \
	--with-debug \
	--with-normal \
	--with-shared \
	--without-ada \
	--without-gpm \
	--without-manpages \
	--without-tests \
	--enable-mixed-case \
	--with-ticlib=yes \
	--disable-relink \
	--disable-big-strings \
	--disable-sp-funcs \
	--disable-term-driver \
	--disable-ext-mouse \
	--disable-interop \
	--disable-rpath \
	--disable-rpath-hack \
	--disable-ext-colors \
	--without-pthread \
	--disable-reentrant

# NOTE: reentrant enables opaque, which breaks other packages
# pthread enables reentrant, so don't enable it either

# enable wide char support on demand only
ifdef PTXCONF_NCURSES_WIDE_CHAR
NCURSES_AUTOCONF_SHARED += --enable-widec
else
NCURSES_AUTOCONF_SHARED += --disable-widec
endif

ifdef PTXCONF_NCURSES_BIG_CORE
NCURSES_AUTOCONF_SHARED += --enable-big-core
else
NCURSES_AUTOCONF_SHARED += --disable-big-core
endif

NCURSES_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(NCURSES_AUTOCONF_SHARED) \
	--without-progs

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ifdef PTXCONF_NCURSES_WIDE_CHAR
#
# we need a tweak, to force all programs to use the wide char
# library even if they request for the non wide char library
# Done by forcing the linker to use the right library instead
#
NCURSES_LIBRARY_LIST := curses ncurses

ifdef PTXCONF_NCURSES_FORM
NCURSES_LIBRARY_LIST += form
endif
ifdef PTXCONF_NCURSES_MENU
NCURSES_LIBRARY_LIST += menu
endif
ifdef PTXCONF_NCURSES_PANEL
NCURSES_LIBRARY_LIST += panel
endif

NCURSES_WIDE := w
endif

$(STATEDIR)/ncurses.install.post:
	@$(call targetinfo)
	@$(call world/install.post, NCURSES)

	@cp -dp -- "$(NCURSES_PKGDIR)/usr/bin/"*config* "$(PTXCONF_SYSROOT_CROSS)/bin"

ifdef PTXCONF_NCURSES_WIDE_CHAR
# Note: This tweak only works if we build the application with these settings!
# Already built applications may continue to use the non wide library!
# For this, the links at runtime are required
#
	for lib in $(NCURSES_LIBRARY_LIST); do \
		echo "INPUT(-l$${lib}w)" > $(SYSROOT)/lib/lib$${lib}.so ; \
	done
	ln -sf libncurses++w.a $(SYSROOT)/lib/libncurses++.a
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ncurses.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ncurses)
	@$(call install_fixup, ncurses,PRIORITY,optional)
	@$(call install_fixup, ncurses,SECTION,base)
	@$(call install_fixup, ncurses,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ncurses,DESCRIPTION,missing)

	@$(call install_lib, ncurses, 0, 0, 0644, libncurses$(NCURSES_WIDE))

ifdef PTXCONF_NCURSES_BACKWARD_COMPATIBLE_NON_WIDE_CHAR
	@$(call install_link, ncurses, libncursesw.so.$(NCURSES_VERSION), \
		/lib/libncurses.so.$(NCURSES_VERSION))
	@$(call install_link, ncurses, libncursesw.so.$(NCURSES_VERSION), \
		/lib/libncurses.so.$(NCURSES_MAJOR))
	@$(call install_link, ncurses, libncursesw.so.$(NCURSES_VERSION), \
		/lib/libncurses.so)
endif

ifdef PTXCONF_NCURSES_FORM
	@$(call install_lib, ncurses, 0, 0, 0644, libform$(NCURSES_WIDE))
ifdef PTXCONF_NCURSES_BACKWARD_COMPATIBLE_NON_WIDE_CHAR
	@$(call install_link, ncurses, libformw.so.$(NCURSES_VERSION), \
		/lib/libform.so.$(NCURSES_VERSION))
	@$(call install_link, ncurses, libformw.so.$(NCURSES_VERSION), \
		/lib/libform.so.$(NCURSES_MAJOR))
	@$(call install_link, ncurses, libformw.so.$(NCURSES_VERSION), \
		/lib/libform.so)
endif
endif


ifdef PTXCONF_NCURSES_MENU
	@$(call install_lib, ncurses, 0, 0, 0644, libmenu$(NCURSES_WIDE))
ifdef PTXCONF_NCURSES_BACKWARD_COMPATIBLE_NON_WIDE_CHAR
	@$(call install_link, ncurses, libmenuw.so.$(NCURSES_VERSION), \
		/lib/libmenu.so.$(NCURSES_VERSION))
	@$(call install_link, ncurses, libmenuw.so.$(NCURSES_VERSION), \
		/lib/libmenu.so.$(NCURSES_MAJOR))
	@$(call install_link, ncurses, libmenuw.so.$(NCURSES_VERSION), \
		/lib/libmenu.so)
endif
endif


ifdef PTXCONF_NCURSES_PANEL
	@$(call install_lib, ncurses, 0, 0, 0644, libpanel$(NCURSES_WIDE))
ifdef PTXCONF_NCURSES_BACKWARD_COMPATIBLE_NON_WIDE_CHAR
	@$(call install_link, ncurses, libpanelw.so.$(NCURSES_VERSION), \
		/lib/libpanel.so.$(NCURSES_VERSION))
	@$(call install_link, ncurses, libpanelw.so.$(NCURSES_VERSION), \
		/lib/libpanel.so.$(NCURSES_MAJOR))
	@$(call install_link, ncurses, libpanelw.so.$(NCURSES_VERSION), \
		/lib/libpanel.so)
endif
endif


ifdef PTXCONF_NCURSES_TERMCAP
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/x/xterm, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/x/xterm-color, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/x/xterm-xfree86, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/v/vt100, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/v/vt102, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/v/vt200, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/a/ansi, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/l/linux, n);
	@$(call install_copy, ncurses, 0, 0, 0644, -, /usr/share/terminfo/s/screen, n);
endif

	@$(call install_finish, ncurses)

	@$(call touch)

# vim: syntax=make
