# -*-makefile-*-
#
# Copyright (C) 2012 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSELINUX) += libselinux

#
# Paths and names
#
LIBSELINUX_VERSION	:= 2.1.12
LIBSELINUX_MD5		:= 73270f384a032fad34b5fe075fa05ce2
LIBSELINUX		:= libselinux-$(LIBSELINUX_VERSION)
LIBSELINUX_SUFFIX	:= tar.gz
LIBSELINUX_URL		:= http://userspace.selinuxproject.org/releases/20120924/$(LIBSELINUX).$(LIBSELINUX_SUFFIX)
LIBSELINUX_SOURCE	:= $(SRCDIR)/$(LIBSELINUX).$(LIBSELINUX_SUFFIX)
LIBSELINUX_DIR		:= $(BUILDDIR)/$(LIBSELINUX)
LIBSELINUX_LICENSE	:= public_domain

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSELINUX_CONF_TOOL := NO
# no := due to CROSS_PYTHON
LIBSELINUX_MAKE_ENV = \
	$(CROSS_ENV) \
	CFLAGS="-O2 -Wall -g" \
	PYTHON=$(CROSS_PYTHON)
LIBSELINUX_MAKE_OPT := \
	LIBDIR=$(PTXDIST_SYSROOT_TARGET)/usr/lib
LIBSELINUX_INSTALL_OPT := \
	install

ifdef PTXCONF_LIBSELINUX_PYTHON
LIBSELINUX_MAKE_OPT	+= pywrap
LIBSELINUX_INSTALL_OPT	+= install-pywrap
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

LIBSELINUX_PROGS := \
	avcstat \
	compute_av \
	compute_create \
	compute_member \
	compute_relabel \
	compute_user \
	getconlist \
	getdefaultcon \
	getenforce \
	getfilecon \
	getpidcon \
	getsebool \
	getseuser \
	matchpathcon \
	policyvers \
	selinux_check_securetty_context \
	selinuxenabled \
	selinuxexeccon \
	setenforce \
	setfilecon \
	togglesebool

$(STATEDIR)/libselinux.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libselinux)
	@$(call install_fixup, libselinux,PRIORITY,optional)
	@$(call install_fixup, libselinux,SECTION,base)
	@$(call install_fixup, libselinux,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, libselinux,DESCRIPTION,missing)

	@$(call install_lib, libselinux, 0, 0, 0644, libselinux)

	@$(foreach prog, $(LIBSELINUX_PROGS), \
		$(call install_copy, libselinux, 0, 0, 0755, -, /usr/sbin/$(prog));)

ifdef PTXCONF_LIBSELINUX_PYTHON
	@$(call install_tree, libselinux, 0, 0, -, $(PYTHON_SITEPACKAGES))
endif
	@$(call install_finish, libselinux)

	@$(call touch)

# vim: syntax=make
