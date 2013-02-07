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
POLICYCOREUTILS_URL	:= http://userspace.selinuxproject.org/releases/20120924/$(POLICYCOREUTILS).$(POLICYCOREUTILS_SUFFIX)
POLICYCOREUTILS_SOURCE	:= $(SRCDIR)/$(POLICYCOREUTILS).$(POLICYCOREUTILS_SUFFIX)
POLICYCOREUTILS_DIR	:= $(BUILDDIR)/$(POLICYCOREUTILS)
POLICYCOREUTILS_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POLICYCOREUTILS_CONF_TOOL := NO
# no ':=' because of $(PYTHON_SITEPACKAGES)
POLICYCOREUTILS_MAKE_ENV = \
	$(CROSS_ENV) \
	PYTHONLIBDIR=$(POLICYCOREUTILS_PKGDIR)$(PYTHON_SITEPACKAGES)/..
	CFLAGS="-O2 -Wall" \
	INOTIFYH="/usr/include/sys/inotify.h" \
	PAMH="" \
	AUDITH=""
POLICYCOREUTILS_MAKE_OPT := LIBDIR=$(PTXDIST_SYSROOT_TARGET)/usr/lib

#
# We don't have PAM or AUDIT, so turn off.
#
# Use the following to turn on:
# (Use these paths, as of version 2.1.13)
#
# PAMH=/usr/include/security/pam_appl.h
# AUDITH=/usr/include/libaudit.h
#

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

ifdef PTXCONF_POLICYCOREUTILS_AUDIT2ALLOW
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/bin/audit2allow)
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/bin/sepolgen-ifgen)
endif

ifdef PTXCONF_POLICYCOREUTILS_AUDIT2WHY
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/bin/audit2why)
endif

ifdef PTXCONF_POLICYCOREUTILS_CHCAT
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/bin/chcat)
endif

ifdef PTXCONF_POLICYCOREUTILS_FIXFILES
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /sbin/fixfiles)
endif

ifdef PTXCONF_POLICYCOREUTILS_GENHOMEDIRCON
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/sbin/genhomedircon)
endif

ifdef PTXCONF_POLICYCOREUTILS_LOAD_POLICY
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /sbin/load_policy)
	@$(call install_link, policycoreutils, /sbin/load_policy, /usr/sbin/load_policy)
endif

ifdef PTXCONF_POLICYCOREUTILS_NEWROLE
	@$(call install_copy, policycoreutils, 0, 0, 0555, -, /usr/bin/newrole)
endif

ifdef PTXCONF_POLICYCOREUTILS_RESTORECOND
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/sbin/restorecond)
endif

ifdef PTXCONF_POLICYCOREUTILS_RUN_INIT
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/sbin/run_init)
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/sbin/open_init_pty)
endif

ifdef PTXCONF_POLICYCOREUTILS_SANDBOX
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/bin/sandbox)
	@$(call install_copy, policycoreutils, 0, 0, 4555, -, /usr/sbin/seunshare)
endif

ifdef PTXCONF_POLICYCOREUTILS_SECON
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/bin/secon)
endif

ifdef PTXCONF_POLICYCOREUTILS_SEMANAGE
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/sbin/semanage)
	@$(call install_copy, policycoreutils, 0, 0, 0644, -, $(PYTHON_SITEPACKAGES)/seobject.py)
endif

ifdef PTXCONF_POLICYCOREUTILS_SEMODULE
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/sbin/semodule)
endif

ifdef PTXCONF_POLICYCOREUTILS_SEMODULE_DEPS
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/bin/semodule_deps)
endif

ifdef PTXCONF_POLICYCOREUTILS_SEMODULE_EXPAND
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/bin/semodule_expand)
endif

ifdef PTXCONF_POLICYCOREUTILS_SEMODULE_LINK
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/bin/semodule_link)
endif

ifdef PTXCONF_POLICYCOREUTILS_SEMODULE_PACKAGE
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/bin/semodule_package)
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/bin/semodule_unpackage)
endif

ifdef PTXCONF_POLICYCOREUTILS_SEPOLGEN_IFGEN
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/bin/sepolgen-ifgen-attr-helper)
endif

ifdef PTXCONF_POLICYCOREUTILS_SESTATUS
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/sbin/sestatus)
endif

ifdef PTXCONF_POLICYCOREUTILS_SETFILES
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /sbin/setfiles)
	@$(call install_link, policycoreutils, setfiles, /sbin/restorecon)
endif

ifdef PTXCONF_POLICYCOREUTILS_SETSEBOOL
	@$(call install_copy, policycoreutils, 0, 0, 0755, -, /usr/sbin/setsebool)
endif

	@$(call install_alternative, policycoreutils, 0, 0, 0644, /etc/sestatus.conf)

	@$(call install_finish, policycoreutils)

	@$(call touch)

# vim: syntax=make
