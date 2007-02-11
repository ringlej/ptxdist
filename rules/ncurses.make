# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002-2006 by Pengutronix e.K., Hildesheim, Germany
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
NCURSES_VERSION	:= 5.6
NCURSES		:= ncurses-$(NCURSES_VERSION)
NCURSES_SUFFIX	:= tar.gz
NCURSES_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/ncurses/$(NCURSES).$(NCURSES_SUFFIX)
NCURSES_SOURCE	:= $(SRCDIR)/$(NCURSES).$(NCURSES_SUFFIX)
NCURSES_DIR	:= $(BUILDDIR)/$(NCURSES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ncurses_get: $(STATEDIR)/ncurses.get

$(STATEDIR)/ncurses.get: $(ncurses_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(NCURSES_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, NCURSES)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ncurses_extract: $(STATEDIR)/ncurses.extract

$(STATEDIR)/ncurses.extract: $(ncurses_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NCURSES_DIR))
	@$(call extract, NCURSES)
	@$(call patchin, NCURSES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ncurses_prepare: $(STATEDIR)/ncurses.prepare

NCURSES_PATH	:= PATH=$(CROSS_PATH)
# FIXME: Prevent this: configure: WARNING: Assuming unsigned for type of bool
NCURSES_ENV 	:= $(CROSS_ENV)

# --without-gpm: elsewhere its guessed
NCURSES_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--libdir=/lib \
	--with-normal \
	--with-shared \
	--disable-nls \
	--without-ada \
	--enable-const \
	--enable-overwrite \
	--without-gpm \
	--with-debug \
	--disable-echo

# enable wide char support on demand only
ifdef PTXCONF_NCURSES_WIDE_CHAR
NCURSES_AUTOCONF += --enable-widec
else
NCURSES_AUTOCONF += --disable-widec
endif

ifdef PTXCONF_NCURSES_BIG_CORE
NCURSES_AUTOCONF += --enable-big-core
else
NCURSES_AUTOCONF += --disable-big-core
endif

$(STATEDIR)/ncurses.prepare: $(ncurses_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(NCURSES_DIR) && \
		$(NCURSES_PATH) $(NCURSES_ENV) \
		./configure $(NCURSES_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ncurses_compile: $(STATEDIR)/ncurses.compile

$(STATEDIR)/ncurses.compile: $(ncurses_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(NCURSES_DIR) && $(NCURSES_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ncurses_install: $(STATEDIR)/ncurses.install

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

endif

$(STATEDIR)/ncurses.install: $(ncurses_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, NCURSES)

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
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ncurses_targetinstall: $(STATEDIR)/ncurses.targetinstall

$(STATEDIR)/ncurses.targetinstall: $(ncurses_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, ncurses)
	@$(call install_fixup, ncurses,PACKAGE,ncurses)
	@$(call install_fixup, ncurses,PRIORITY,optional)
	@$(call install_fixup, ncurses,VERSION,$(NCURSES_VERSION))
	@$(call install_fixup, ncurses,SECTION,base)
	@$(call install_fixup, ncurses,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ncurses,DEPENDS,)
	@$(call install_fixup, ncurses,DESCRIPTION,missing)

ifdef PTXCONF_NCURSES_WIDE_CHAR
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(NCURSES_DIR)/lib/libncursesw.so.5.6, /lib/libncursesw.so.5.6)
	@$(call install_link, ncurses, libncursesw.so.5.6, /lib/libncursesw.so.5)
	@$(call install_link, ncurses, libncursesw.so.5.6, /lib/libncursesw.so)
ifdef PTXCONF_NCURSES_BACKWARD_COMPATIBLE_NON_WIDE_CHAR
# for backward compatibility
# only needed if any application is linked against the non wide variant
# Note: Should not happen, if it is compiled by ptxdist!
	@$(call install_link, ncurses, libncursesw.so.5.6, /lib/libncurses.so.5)
	@$(call install_link, ncurses, libncursesw.so.5.6, /lib/libncurses.so)
endif
else
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(NCURSES_DIR)/lib/libncurses.so.5.6, /lib/libncurses.so.5.6)
	@$(call install_link, ncurses, libncurses.so.5.6, /lib/libncurses.so.5)
	@$(call install_link, ncurses, libncurses.so.5.6, /lib/libncurses.so)
endif

ifdef PTXCONF_NCURSES_FORM
ifdef PTXCONF_NCURSES_WIDE_CHAR
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(NCURSES_DIR)/lib/libformw.so.5.6, /lib/libformw.so.5.6)
	@$(call install_link, ncurses, libformw.so.5.6, /lib/libformw.so.5)
	@$(call install_link, ncurses, libformw.so.5.6, /lib/libformw.so)
ifdef PTXCONF_NCURSES_BACKWARD_COMPATIBLE_NON_WIDE_CHAR
	@$(call install_link, ncurses, libformw.so.5.6, /lib/libform.so.5.6)
	@$(call install_link, ncurses, libformw.so.5.6, /lib/libform.so.5)
	@$(call install_link, ncurses, libformw.so.5.6, /lib/libform.so)
endif
else
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(NCURSES_DIR)/lib/libform.so.5.6, /lib/libform.so.5.6)
	@$(call install_link, ncurses, libform.so.5.6, /lib/libform.so.5)
	@$(call install_link, ncurses, libform.so.5.6, /lib/libform.so)
endif
endif

ifdef PTXCONF_NCURSES_MENU
ifdef PTXCONF_NCURSES_WIDE_CHAR
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(NCURSES_DIR)/lib/libmenuw.so.5.6, /lib/libmenuw.so.5.6)
	@$(call install_link, ncurses, libmenuw.so.5.6, /lib/libmenuw.so.5)
	@$(call install_link, ncurses, libmenuw.so.5.6, /lib/libmenuw.so)
ifdef PTXCONF_NCURSES_BACKWARD_COMPATIBLE_NON_WIDE_CHAR
	@$(call install_link, ncurses, libmenuw.so.5.6, /lib/libmenu.so.5.6)
	@$(call install_link, ncurses, libmenuw.so.5.6, /lib/libmenu.so.5)
	@$(call install_link, ncurses, libmenuw.so.5.6, /lib/libmenu.so)
endif
else
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(NCURSES_DIR)/lib/libmenu.so.5.6, /lib/libmenu.so.5.6)
	@$(call install_link, ncurses, libmenu.so.5.6, /lib/libmenu.so.5)
	@$(call install_link, ncurses, libmenu.so.5.6, /lib/libmenu.so)
endif
endif

ifdef PTXCONF_NCURSES_PANEL
ifdef PTXCONF_NCURSES_WIDE_CHAR
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(NCURSES_DIR)/lib/libpanelw.so.5.6, /lib/libpanelw.so.5.6)
	@$(call install_link, ncurses, libpanelw.so.5.6, /lib/libpanelw.so.5)
	@$(call install_link, ncurses, libpanelw.so.5.6, /lib/libpanelw.so)
ifdef PTXCONF_NCURSES_BACKWARD_COMPATIBLE_NON_WIDE_CHAR
	@$(call install_link, ncurses, libpanelw.so.5.6, /lib/libpanel.so.5.6)
	@$(call install_link, ncurses, libpanelw.so.5.6, /lib/libpanel.so.5)
	@$(call install_link, ncurses, libpanelw.so.5.6, /lib/libpanel.so)
endif
else
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(NCURSES_DIR)/lib/libpanel.so.5.6, /lib/libpanel.so.5.6)
	@$(call install_link, ncurses, libpanel.so.5.6, /lib/libpanel.so.5)
	@$(call install_link, ncurses, libpanel.so.5.6, /lib/libpanel.so)
endif
endif

ifdef PTXCONF_NCURSES_TERMCAP
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(SYSROOT)/usr/share/terminfo/x/xterm, \
		/usr/share/terminfo/x/xterm, n);
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(SYSROOT)/usr/share/terminfo/x/xterm-color, \
		/usr/share/terminfo/x/xterm-color, n);
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(SYSROOT)/usr/share/terminfo/x/xterm-xfree86, \
		/usr/share/terminfo/x/xterm-xfree86, n);
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(SYSROOT)/usr/share/terminfo/v/vt100, \
		/usr/share/terminfo/v/vt100, n);
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(SYSROOT)/usr/share/terminfo/v/vt102, \
		/usr/share/terminfo/v/vt102, n);
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(SYSROOT)/usr/share/terminfo/v/vt200, \
		/usr/share/terminfo/v/vt200, n);
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(SYSROOT)/usr/share/terminfo/a/ansi, \
		/usr/share/terminfo/a/ansi, n);
	@$(call install_copy, ncurses, 0, 0, 0644, \
		$(SYSROOT)/usr/share/terminfo/l/linux, \
		/usr/share/terminfo/l/linux, n);
endif

	@$(call install_finish, ncurses)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ncurses_clean:
	rm -rf $(STATEDIR)/ncurses.* $(NCURSES_DIR)
	rm -rf $(IMAGEDIR)/ncurses_*

# vim: syntax=make
