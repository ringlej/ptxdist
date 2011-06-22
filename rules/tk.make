# -*-makefile-*-
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
TK_MD5		:= 7da2e00adddc7eed6080df904579d94e
TK		:= tk$(TK_VERSION)
TK_SUFFIX	:= -src.tar.gz
TK_URL		:= $(PTXCONF_SETUP_SFMIRROR)/tcl/$(TK)$(TK_SUFFIX)
TK_SOURCE	:= $(SRCDIR)/$(TK)$(TK_SUFFIX)
TK_DIR		:= $(BUILDDIR)/$(TK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(TK_SOURCE):
	@$(call targetinfo)
	@$(call get, TK)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TK_PATH		:= PATH=$(CROSS_PATH)
TK_ENV 		:= $(CROSS_ENV)

TK_MAKE_OPT	:= CROSS_COMPILE=$(COMPILER_PREFIX)

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

TK_AUTOCONF += tcl_cv_strtod_buggy=ok

# checking system version... Linux-2.6.25.4-ptx <-- it detects host's one!
TK_AUTOCONF += tcl_cv_sys_version=Linux-$(KERNEL_HEADER_VERSION)

# it does not detect the BSP variant of X
TK_AUTOCONF += \
	x_includes=$(PTXCONF_SYSROOT_TARGET)/usr/include \
	x_libraries=$(PTXCONF_SYSROOT_TARGET)/usr/lib

TK_SUBDIR := unix

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tk)
	@$(call install_fixup, tk,PRIORITY,optional)
	@$(call install_fixup, tk,SECTION,base)
	@$(call install_fixup, tk,AUTHOR,"Juergen Beisert <juergen@kreuzholzen.de>")
	@$(call install_fixup, tk,DESCRIPTION,missing)


	@$(call install_copy, tk, 0, 0, 0644, -, \
		/usr/lib/libtk$(TK_MAJOR).$(TK_MINOR).so)

ifdef PTXCONF_TK_WISH
	@$(call install_copy, tk, 0, 0, 0755, -, /usr/bin/wish8.5)
# a simplified link is very useful
	@$(call install_link, tk, \
		wish$(TK_MAJOR).$(TK_MINOR), /usr/bin/wish)
endif
ifdef PTXCONF_TK_TTK
	@$(call install_copy, tk, 0, 0, 0755, /usr/lib/tk$(TK_MAJOR).$(TK_MINOR)/ttk)
	@cd $(TK_PKGDIR)/usr/lib/tk$(TK_MAJOR).$(TK_MINOR)/ttk && \
	for file in *.tcl ; do \
		$(call install_copy, tk, 0, 0, 0644, -, \
			/usr/lib/tk$(TK_MAJOR).$(TK_MINOR)/ttk/$$file, n); \
	done
endif

	@$(call install_finish, tk)

	@$(call touch)

# vim: syntax=make
