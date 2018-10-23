# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3) += python3

#
# Paths and names
#
PYTHON3_VERSION		:= 3.7.0
PYTHON3_MD5		:= eb8c2a6b1447d50813c02714af4681f3
PYTHON3_MAJORMINOR	:= $(basename $(PYTHON3_VERSION))
PYTHON3_SITEPACKAGES	:= /usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages
PYTHON3			:= Python-$(PYTHON3_VERSION)
PYTHON3_SUFFIX		:= tar.xz
PYTHON3_SOURCE		:= $(SRCDIR)/$(PYTHON3).$(PYTHON3_SUFFIX)
PYTHON3_DIR		:= $(BUILDDIR)/$(PYTHON3)

PYTHON3_URL		:= \
	http://python.org/ftp/python/$(PYTHON3_VERSION)/$(PYTHON3).$(PYTHON3_SUFFIX) \
	http://python.org/ftp/python/$(PYTHON3_MAJORMINOR)/$(PYTHON3).$(PYTHON3_SUFFIX)

CROSS_PYTHON3		:= $(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# Note: the LDFLAGS are used by setup.py for manual searches
PYTHON3_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_sys_system=Linux \
	ac_sys_release=2 \
	MACHDEP=linux2 \
	ac_cv_have_chflags=no \
	ac_cv_have_lchflags=no \
	ac_cv_broken_sem_getvalue=no \
	ac_cv_file__dev_ptmx=no \
	ac_cv_file__dev_ptc=no \
	ac_cv_working_tzset=yes \
	LDFLAGS="-L $(PTXDIST_SYSROOT_TARGET)/usr/lib"

PYTHON3_BINCONFIG_GLOB := ""

#
# autoconf
#
PYTHON3_CONF_TOOL	:= autoconf
PYTHON3_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-profiling \
	--disable-optimizations \
	--disable-loadable-sqlite-extensions \
	$(GLOBAL_IPV6_OPTION) \
	--without-pydebug \
	--without-assertions \
	--without-lto \
	--with-system-expat \
	--without-system-libmpdec \
	--with-dbmliborder=$(call ptx/ifdef, PTXCONF_PYTHON3_DB,bdb) \
	--without-doc-strings \
	--with-pymalloc \
	--with-c-locale-coercion \
	--with-c-locale-warning \
	--without-valgrind \
	--without-dtrace \
	--with-computed-gotos \
	--without-ensurepip \
	--with-openssl=$(SYSROOT)/usr

# Keep dictionary order in .pyc files stable
PYTHON3_MAKE_ENV := \
	PYTHONHASHSEED=0

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3.install:
	@$(call targetinfo)

#	# remove unneeded stuff
	@find $(PYTHON3_DIR) \( -name test -o -name tests \) -print0 | xargs -0 rm -vrf

	@$(call install, PYTHON3)

	@rm -vrf $(PYTHON3_PKGDIR)/usr/lib/python$(PYTHON3_MAJORMINOR)/config-$(PYTHON3_MAJORMINOR)m
	@$(call world/env, PYTHON3) ptxd_make_world_install_python_cleanup

	@$(call touch)

PYTHON3_PLATFORM := $(call remove_quotes,$(PTXCONF_ARCH_STRING))
ifdef PTXCONF_ARCH_ARM64
PYTHON3_PLATFORM := arm
endif

$(STATEDIR)/python3.install.post:
	@$(call targetinfo)
	@$(call world/install.post, PYTHON3)

	@rm -f "$(CROSS_PYTHON3)"
	@echo '#!/bin/sh'						>> "$(CROSS_PYTHON3)"
	@echo '_PYTHON_PROJECT_BASE=$(PYTHON3_DIR)'			>> "$(CROSS_PYTHON3)"
	@echo '_PYTHON_HOST_PLATFORM=linux2-$(PYTHON3_PLATFORM)'	>> "$(CROSS_PYTHON3)"
	@m=`sed -n 's/^MULTIARCH=[\t ]*\(.*\)/\1/p' $(PYTHON3_DIR)/Makefile` && \
	 d=`cat $(PYTHON3_DIR)/pybuilddir.txt` && \
	 cross_dir="$(PTXDIST_SYSROOT_CROSS)/lib/python$(PYTHON3_MAJORMINOR)" && \
	 mkdir -p "$${cross_dir}" && \
	 cp "$(PYTHON3_DIR)/$$d/_sysconfigdata_m_linux2_$${m}.py" "$${cross_dir}" && \
	 echo "_PYTHON_SYSCONFIGDATA_NAME=_sysconfigdata_m_linux2_$$m"	>> "$(CROSS_PYTHON3)" && \
	 echo "PYTHONPATH=$${cross_dir}"				>> "$(CROSS_PYTHON3)"
	@echo 'PYTHONHASHSEED=0'					>> "$(CROSS_PYTHON3)"
	@echo 'export _PYTHON_PROJECT_BASE _PYTHON_HOST_PLATFORM'	>> "$(CROSS_PYTHON3)"
	@echo 'export _PYTHON_SYSCONFIGDATA_NAME PYTHONPATH'		>> "$(CROSS_PYTHON3)"
	@echo 'export PYTHONHASHSEED'					>> "$(CROSS_PYTHON3)"
	@echo 'exec $(HOSTPYTHON3) "$${@}"'				>> "$(CROSS_PYTHON3)"
	@chmod a+x "$(CROSS_PYTHON3)"
	@ln -sf "python$(PYTHON3_MAJORMINOR)" \
		"$(PTXCONF_SYSROOT_CROSS)/bin/python3"
	@sed -e 's;prefix_real=.*;prefix_real=$(SYSROOT)/usr;' \
		"$(PTXCONF_SYSROOT_TARGET)/usr/bin/python$(PYTHON3_MAJORMINOR)-config" \
		> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)-config"
	@chmod +x "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)-config"

#	# make sure grammer pickle is generated to avoid parallel building issues
	@"$(CROSS_PYTHON3)" -c 'from setuptools.command import build_py'

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

# may add extra dependencies and is not useful for embedded
PYTHON3_SKIP-y							+= */nis.*

# These cannot be disabled during build, so just don't install the disabled modules
PYTHON3_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON3_BZ2)		+= */bz2.pyc */_bz2*.so
PYTHON3_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON3_LZMA)		+= */lzma.pyc */_lzma*.so
PYTHON3_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON3_NCURSES)	+= */curses */_curses*.so
PYTHON3_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON3_READLINE)	+= */readline*so
PYTHON3_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON3_SQLITE)	+= */sqlite3
PYTHON3_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON3_SSL)		+= */ssl.pyc */_ssl*.so
PYTHON3_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON3_LIBTK)		+= */tkinter
PYTHON3_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON3_IDLELIB)	+= */idlelib
PYTHON3_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON3_DISTUTILS)	+= */distutils

$(STATEDIR)/python3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3)
	@$(call install_fixup, python3,PRIORITY,optional)
	@$(call install_fixup, python3,SECTION,base)
	@$(call install_fixup, python3,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, python3,AUTHOR,"Han Sierkstra <han@protonic.nl>")
	@$(call install_fixup, python3,DESCRIPTION,missing)

	@$(call install_glob, python3, 0, 0, -, /usr/lib/python$(PYTHON3_MAJORMINOR), \
		*.so *.pyc, */test */tests */__pycache__ $(PYTHON3_SKIP-y))

	@$(call install_copy, python3, 0, 0, 755, -, /usr/bin/python$(PYTHON3_MAJORMINOR))
	@$(call install_link, python3, python$(PYTHON3_MAJORMINOR), /usr/bin/python3)
	@$(call install_lib, python3, 0, 0, 644, libpython$(PYTHON3_MAJORMINOR)m)

ifdef PTXCONF_PYTHON3_SYMLINK
	@$(call install_link, python3, python$(PYTHON3_MAJORMINOR), /usr/bin/python)
endif

	@$(call install_finish, python3)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/python3.clean:
	@$(call targetinfo)
	@$(call clean_pkg, MESA_DEMOS)
	@rm -vf \
		"$(CROSS_PYTHON3)" \
		"$(PTXCONF_SYSROOT_CROSS)/bin/python3" \
		"$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)-config" \
		"$(PTXDIST_SYSROOT_CROSS)/lib/python$(PYTHON3_MAJORMINOR)/"_sysconfigdata_m_linux2_*.py

# vim: syntax=make
