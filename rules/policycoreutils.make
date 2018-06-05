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
PACKAGES-$(PTXCONF_POLICYCOREUTILS) += policycoreutils

#
# Paths and names
#
POLICYCOREUTILS_VERSION	:= 2.1.13
POLICYCOREUTILS_MD5	:= 97c0b828599fe608f37894989820d71d
POLICYCOREUTILS		:= policycoreutils-$(POLICYCOREUTILS_VERSION)
POLICYCOREUTILS_SUFFIX	:= tar.gz
POLICYCOREUTILS_URL	:= https://raw.githubusercontent.com/wiki/SELinuxProject/selinux/files/releases/20120924/$(POLICYCOREUTILS).$(POLICYCOREUTILS_SUFFIX)
POLICYCOREUTILS_SOURCE	:= $(SRCDIR)/$(POLICYCOREUTILS).$(POLICYCOREUTILS_SUFFIX)
POLICYCOREUTILS_DIR	:= $(BUILDDIR)/$(POLICYCOREUTILS)
POLICYCOREUTILS_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POLICYCOREUTILS_SUBDIRS_y := \
	man \
	po \
	scripts

POLICYCOREUTILS_PROGS_y :=

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_AUDIT2ALLOW)		+= audit2allow
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_AUDIT2ALLOW)		+= /usr/bin/audit2allow

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SEPOLGEN_IFGEN)	+= sepolgen-ifgen
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SEPOLGEN_IFGEN)		+= /usr/bin/sepolgen-ifgen
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SEPOLGEN_IFGEN)		+= /usr/bin/sepolgen-ifgen-attr-helper

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_AUDIT2WHY)		+= audit2why
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_AUDIT2WHY)		+= /usr/bin/audit2why

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_LOAD_POLICY)		+= load_policy
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_LOAD_POLICY)		+= /usr/sbin/load_policy

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_NEWROLE)		+= newrole
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_NEWROLE)		+= /usr/bin/newrole

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_RESTORECOND)		+= restorecond
#POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_RESTORECOND)		+=

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_RUN_INIT)		+= run_init
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_RUN_INIT)		+= /usr/sbin/run_init
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_RUN_INIT)		+= /usr/sbin/open_init_pty

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SANDBOX)		+= sandbox
#POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SANDBOX)		+=

# no SUBDIRS needed for scripts
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_CHCAT)			+= /usr/bin/chcat
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_FIXFILES)		+= /usr/sbin/fixfiles
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_GENHOMEDIRCON)		+= /usr/sbin/genhomedircon

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SECON)		+= secon
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SECON)			+= /usr/bin/secon

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SEMANAGE)		+= semanage
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SEMANAGE)		+= /usr/sbin/semanage

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SEMODULE)		+= semodule
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SEMODULE)		+= /usr/sbin/semodule

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SEMODULE_DEPS)	+= semodule_deps
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SEMODULE_DEPS)		+= /usr/bin/semodule_deps

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SEMODULE_EXPAND)	+= semodule_expand
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SEMODULE_EXPAND)	+= /usr/bin/semodule_expand

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SEMODULE_LINK)	+= semodule_link
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SEMODULE_LINK)		+= /usr/bin/semodule_link

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SEMODULE_PACKAGE)	+= semodule_package
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SEMODULE_PACKAGE)	+= /usr/bin/semodule_package
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SEMODULE_PACKAGE)	+= /usr/bin/semodule_unpackage

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SESTATUS)		+= sestatus
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SESTATUS)		+= /usr/sbin/sestatus

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SETFILES)		+= setfiles
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SETFILES)		+= /usr/sbin/setfiles

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SETSEBOOL)		+= setsebool
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SETSEBOOL)		+= /usr/sbin/setsebool

POLICYCOREUTILS_CONF_TOOL := NO

# no ':=' because of $(PYTHON_SITEPACKAGES)
POLICYCOREUTILS_MAKE_ENV = \
	$(CROSS_ENV) \
	SBINDIR=$(POLICYCOREUTILS_PKGDIR)/usr/sbin \
	PYTHONLIBDIR=$(POLICYCOREUTILS_PKGDIR)$(PYTHON_SITEPACKAGES)/.. \
	CFLAGS="-O2 -Wall" \
	INOTIFYH="/usr/include/sys/inotify.h" \
	PAMH="" \
	AUDITH=""
#
# We don't have PAM or AUDIT, so turn off.
#
# Use the following to turn on:
# (Use these paths, as of version 2.1.13)
#
# PAMH=/usr/include/security/pam_appl.h
# AUDITH=/usr/include/libaudit.h
#

POLICYCOREUTILS_MAKE_OPT := \
	SUBDIRS="$(POLICYCOREUTILS_SUBDIRS_y)" \
	LIBDIR=$(PTXDIST_SYSROOT_TARGET)/usr/lib
POLICYCOREUTILS_INSTALL_OPT := \
	SUBDIRS="$(POLICYCOREUTILS_SUBDIRS_y)" \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/policycoreutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, policycoreutils)
	@$(call install_fixup, policycoreutils,PRIORITY,optional)
	@$(call install_fixup, policycoreutils,SECTION,base)
	@$(call install_fixup, policycoreutils,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, policycoreutils,DESCRIPTION,missing)

	@$(foreach prog, $(POLICYCOREUTILS_PROGS_y), \
		$(call install_copy, policycoreutils, 0, 0, 0755, -, $(prog));)

ifdef PTXCONF_POLICYCOREUTILS_SETFILES
	@$(call install_link, policycoreutils, setfiles, /usr/sbin/restorecon)
endif

ifdef PTXCONF_POLICYCOREUTILS_SEMANAGE
	@$(call install_copy, policycoreutils, 0, 0, 0644, -, $(PYTHON_SITEPACKAGES)/seobject.py)
endif

ifdef PTXCONF_POLICYCOREUTILS_SESTATUS
	@$(call install_alternative, policycoreutils, 0, 0, 0644, /etc/sestatus.conf)
endif

	@$(call install_finish, policycoreutils)

	@$(call touch)

# vim: syntax=make
