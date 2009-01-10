# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
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
PACKAGES-$(PTXCONF_TCL) += tcl

#
# Paths and names
#
TCL_MAJOR	:= 8.5
TCL_PL		:= 6
TCL_VERSION	:= $(TCL_MAJOR).$(TCL_PL)
TCL		:= tcl$(TCL_VERSION)
TCL_SUFFIX	:= -src.tar.gz
TCL_URL		:= $(PTXCONF_SETUP_SFMIRROR)/tcl/$(TCL)$(TCL_SUFFIX)
TCL_SOURCE	:= $(SRCDIR)/$(TCL)$(TCL_SUFFIX)
TCL_DIR		:= $(BUILDDIR)/$(TCL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(TCL_SOURCE):
	@$(call targetinfo)
	@$(call get, TCL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/tcl.extract:
	@$(call targetinfo)
	@$(call clean, $(TCL_DIR))
	@$(call extract, TCL)
	@$(call patchin, TCL)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TCL_PATH	:= PATH=$(CROSS_PATH)
TCL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
TCL_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-rpath \
	--disable-symbols \
	--enable-load

ifdef PTXCONF_TCL_THREADS
TCL_AUTOCONF += --enable-threads
else
TCL_AUTOCONF += --disable-threads
endif

# configure rejects some tests due to cross compiling

# checking system version... Linux-2.6.25.4-ptx <-- it detects host's one!
TCL_ACONF_VAR := tcl_cv_sys_version=Linux-$(PTXCONF_KERNEL_VERSION)

# checking for working memcmp... no
TCL_ACONF_VAR += ac_cv_func_memcmp_working=yes

# checking proper strstr implementation... unknown
TCL_ACONF_VAR += ac_cv_func_strstr=yes tcl_cv_strstr_unbroken=yes

# checking proper strtoul implementation... unknown
TCL_ACONF_VAR += ac_cv_func_strtoul=yes tcl_cv_strtoul_unbroken=yes

# checking proper strtod implementation... unknown
TCL_ACONF_VAR += ac_cv_func_strtod=yes tcl_cv_strtod_unbroken=yes tcl_cv_strtod_buggy=no

# checking if the C stack grows upwards in memory... unknown
TCL_ACONF_VAR += tcl_cv_stack_grows_up=no

# unresolved issues yet
#
# checking for timezone data... /usr/share/zoneinfo <-- it uses host's one
#
$(STATEDIR)/tcl.prepare:
	@$(call targetinfo)
	@$(call clean, $(TCL_DIR)/config.cache)
	cd $(TCL_DIR)/unix && \
		$(TCL_PATH) $(TCL_ENV) \
		./configure $(TCL_AUTOCONF) $(TCL_ACONF_VAR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

# unresolved issues yet:
#
# -DTCL_CFGVAL_ENCODING=\"iso8859-1\" <-- it uses the one from the host
#
$(STATEDIR)/tcl.compile:
	@$(call targetinfo)
	cd $(TCL_DIR)/unix && $(TCL_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tcl.install:
	@$(call targetinfo)
	@$(call install, TCL, $(TCL_DIR)/unix, DESTDIR=$(PTXCONF_SYSROOT_TARGET) install)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tcl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tcl)
	@$(call install_fixup, tcl,PACKAGE,tcl)
	@$(call install_fixup, tcl,PRIORITY,optional)
	@$(call install_fixup, tcl,VERSION,$(TCL_VERSION))
	@$(call install_fixup, tcl,SECTION,base)
	@$(call install_fixup, tcl,AUTHOR,"Juergen Beisert <juergen\@kreuzholzen.de")
	@$(call install_fixup, tcl,DEPENDS,)
	@$(call install_fixup, tcl,DESCRIPTION,missing)

	@$(call install_copy, tcl, 0, 0, 0755, /usr/lib/tcl8/$(TCL_MAJOR))
	@$(call install_copy, tcl, 0, 0, 0755, /usr/lib/tcl$(TCL_MAJOR))

	@$(call install_copy, tcl, 0, 0, 0644, -, /usr/lib/tcl8/$(TCL_MAJOR)/msgcat-1.4.2.tm)
	@$(call install_copy, tcl, 0, 0, 0644, -, /usr/lib/tcl8/$(TCL_MAJOR)/tcltest-2.3.0.tm)

# what the hell do we need from the "/usr/lib/tcl$(TCL_MAJOR)" directory???

	@$(call install_copy, tcl, 0, 0, 0755, -, /usr/bin/tclsh$(TCL_MAJOR))
	@$(call install_link, tcl, /usr/bin/tclsh$(TCL_MAJOR), /usr/bin/tclsh)

	@$(call install_finish, tcl)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tcl_clean:
	rm -rf $(STATEDIR)/tcl.*
	rm -rf $(PKGDIR)/tcl_*
	rm -rf $(TCL_DIR)

# vim: syntax=make
