# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Bjoern Buerger <b.buerger@pengutronix.de>
# Copyright (C) 2009 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TK) += tk

#
# Paths and names
#
TK_MAJOR	:= 8
TK_MINOR	:= 5
TK_PL		:= 6
TK_VERSION	:= $(TK_MAJOR).$(TK_MINOR).$(TK_PL)
TK		:= tk$(TK_VERSION)
TK_SUFFIX	:= -src.tar.gz
TK_URL		:= $(PTXCONF_SETUP_SFMIRROR)/tcl/$(TK)$(TK_SUFFIX)
TK_SOURCE	:= $(SRCDIR)/$(TK)$(TK_SUFFIX)
TK_DIR		:= $(BUILDDIR)/$(TK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(TK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, TK)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/tk.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(TK_DIR))
	@$(call extract, TK)
	@$(call patchin, TK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TK_PATH	:= PATH=$(CROSS_PATH)
TK_ENV 	:= $(CROSS_ENV)
TK_MAKEVARS	 =  CROSS_COMPILE=$(COMPILER_PREFIX)

#
# autoconf
#
TK_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-rpath \
	--disable-symbols \
	--enable-load \
	--enable-shared \
	--with-tcl=$(PTXCONF_SYSROOT_TARGET)/usr/lib

ifdef PTXCONF_TK_THREADS
TK_AUTOCONF += --enable-threads
else
TK_AUTOCONF += --disable-threads
endif

ifdef PTXCONF_TK_XFT
TK_AUTOCONF += --enable-xft
else
TK_AUTOCONF += --disable-xft
endif

# 'configure' rejects some tests due to cross compiling

# checking system version... Linux-2.6.25.4-ptx <-- it detects host's one!
TK_AUTOCONF += tcl_cv_sys_version=Linux-$(PTXCONF_KERNEL_VERSION)

# FIXME: Currently it ends up in a compiler badness due to xft returns
# host paths when someone queries for its paths
ifdef PTXCONF_TK_XFT
TK_AUTOCONF += \
	ac_cv_header_X11_Xft_Xft_h=yes \
	ac_cv_lib_Xft_FT_New_Face=yes
endif

# it does not detect the BSP variant of X
TK_AUTOCONF += \
	x_includes=$(PTXCONF_SYSROOT_TARGET)/usr/include \
	x_libraries=$(PTXCONF_SYSROOT_TARGET)/usr/lib

$(STATEDIR)/tk.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(TK_DIR)/unix/config.cache)
	cd $(TK_DIR)/unix && \
		$(TK_PATH) $(TK_ENV) \
		./configure $(TK_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/tk.compile:
	@$(call targetinfo, $@)
	cd $(TK_DIR)/unix && $(TK_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tk.install:
	@$(call targetinfo, $@)
	@$(call install, TK, $(TK_DIR)/unix, DESTDIR=$(PTXCONF_SYSROOT_TARGET) install)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tk.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, tk)
	@$(call install_fixup, tk,PACKAGE,tk)
	@$(call install_fixup, tk,PRIORITY,optional)
	@$(call install_fixup, tk,VERSION,$(TK_VERSION))
	@$(call install_fixup, tk,SECTION,base)
	@$(call install_fixup, tk,AUTHOR,"Juergen Beisert <juergen\@kreuzholzen.de>")
	@$(call install_fixup, tk,DEPENDS,)
	@$(call install_fixup, tk,DESCRIPTION,missing)


	@$(call install_copy, tk, 0, 0, 0644, -, \
		/usr/lib/libtk$(TK_MAJOR).$(TK_MINOR).so)

ifdef PTXCONF_TK_WISH
	@$(call install_copy, tk, 0, 0, 0755, -, /usr/bin/wish8.5)
# a simplified link is very useful
	@$(call install_link, tk, \
		/usr/bin/wish$(TK_MAJOR).$(TK_MINOR), /usr/bin/wish)
endif
ifdef PTXCONF_TK_TTK
	@$(call install_copy, tk, 0, 0, 0755, /usr/lib/tk$(TK_MAJOR).$(TK_MINOR)/ttk)
	cd $(TK_DIR)/library/ttk; \
	for file in *.tcl ; do \
		$(call install_copy, tk, 0, 0, 0644, \
			$(TK_DIR)/library/ttk/$$file, \
			/usr/lib/tk$(TK_MAJOR).$(TK_MINOR)/ttk/$$file, n); \
	done
endif

	@$(call install_finish, tk)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tk_clean:
	rm -rf $(STATEDIR)/tk.*
	rm -rf $(PKGDIR)/tk_*
	rm -rf $(TK_DIR)

# vim: syntax=make
