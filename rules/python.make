# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON) += python

#
# Paths and names
#
PYTHON_VERSION		:= 2.6.4
PYTHON_MAJORMINOR	:= 2.6
PYTHON			:= Python-$(PYTHON_VERSION)
PYTHON_SUFFIX		:= tar.bz2
PYTHON_SOURCE		:= $(SRCDIR)/$(PYTHON).$(PYTHON_SUFFIX)
PYTHON_DIR		:= $(BUILDDIR)/$(PYTHON)

PYTHON_URL		:= \
	http://python.org/ftp/python/$(PYTHON_VERSION)/$(PYTHON).$(PYTHON_SUFFIX) \
	http://python.org/ftp/python/$(PYTHON_MAJORMINOR)/$(PYTHON).$(PYTHON_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PYTHON_SOURCE):
	@$(call targetinfo)
	@$(call get, PYTHON)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON_PATH	:= PATH=$(CROSS_PATH)
PYTHON_ENV 	:= \
	$(CROSS_ENV) \
	PYTHON_FOR_BUILD=$(PTXCONF_SYSROOT_HOST)/bin/python$(PYTHON_MAJORMINOR) \
	ac_cv_have_chflags=no \
	ac_cv_have_lchflags=no \
	ac_cv_py_format_size_t=yes \
	ac_cv_broken_sem_getvalue=no

PYTHON_BINCONFIG_GLOB := ""

#
# autoconf
#
PYTHON_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	--enable-shared \
	--with-pymalloc \
	--with-signal-module \
	--with-threads \
	--with-wctype-functions \
	--without-doc-strings

PYTHON_MAKEVARS := \
	PGEN_FOR_BUILD=$(PTXCONF_SYSROOT_HOST)/bin/pgen

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python.install:
	@$(call targetinfo)
	@$(call install, PYTHON)
	@cp "$(PYTHON_DIR)/cross-python-wrapper" "$(PYTHON_PKGDIR)/usr/bin/"
	@sed -i \
		-e "s:$(SYSROOT):@SYSROOT@:g" \
		-e "s:$(PTXCONF_SYSROOT_HOST):@SYSROOT_HOST@:g" \
		$(PYTHON_PKGDIR)/usr/lib/python$(PYTHON_MAJORMINOR)/config/Makefile
	@$(call touch)


$(STATEDIR)/python.install.post:
	@$(call targetinfo)
	@sed -i \
		-e "s:@SYSROOT@:$(SYSROOT):g" \
		-e "s:@SYSROOT_HOST@:$(PTXCONF_SYSROOT_HOST):g" \
		$(PYTHON_PKGDIR)/usr/lib/python$(PYTHON_MAJORMINOR)/config/Makefile
	@$(call world/install.post, PYTHON)
	@rm -f "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo '#!/bin/sh'				>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo ''					>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo 'prefix="/usr"'				>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo 'exec_prefix="$${prefix}"'		>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo ''					>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo 'CROSS_COMPILING=yes'			>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo '_python_sysroot="$(SYSROOT)"'		>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo '_python_prefix="$${prefix}"'		>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo '_python_exec_prefix="$${exec_prefix}"'	>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo ''					>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo 'export CROSS_COMPILING _python_sysroot _python_prefix _python_exec_prefix' \
							>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo ''					>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@echo 'exec $(PTXCONF_SYSROOT_HOST)/bin/python$(PYTHON_MAJORMINOR) "$${@}"' \
							>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"

#	@cp "$(PYTHON_PKGDIR)/usr/bin/cross-python-wrapper" "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@chmod a+x "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)"
	@ln -sf "python$(PYTHON_MAJORMINOR)" \
		"$(PTXCONF_SYSROOT_CROSS)/bin/python"

	@echo "#!/bin/sh" \
		> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)-config"
	@echo "exec \
		\"$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)\" \
		\"$(PTXCONF_SYSROOT_HOST)/bin/python$(PYTHON_MAJORMINOR)-config\" \
		\"\$${@}\"" \
		>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)-config"
	@chmod a+x "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)-config"
	@ln -sf "python$(PYTHON_MAJORMINOR)-config" \
		"$(PTXCONF_SYSROOT_CROSS)/bin/python-config"

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

PYTHON_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON_LIBTK)		+= lib-tk
PYTHON_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON_IDLELIB)		+= idlelib
PYTHON_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON_DISTUTILS)	+= distutils

ifneq ($(PYTHON_SKIP-y),)
PYTHON_SKIP_LIST_PRE  :=-a \! -wholename $(quote)*/
PYTHON_SKIP_LIST_POST :=/*$(quote)

PYTHON_SKIP_LIST := $(subst $(space),$(PYTHON_SKIP_LIST_POST) $(PYTHON_SKIP_LIST_PRE),$(PYTHON_SKIP-y))
PYTHON_SKIP_LIST := $(PYTHON_SKIP_LIST_PRE)$(PYTHON_SKIP_LIST)$(PYTHON_SKIP_LIST_POST)
endif

$(STATEDIR)/python.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python)
	@$(call install_fixup, python,PACKAGE,python)
	@$(call install_fixup, python,PRIORITY,optional)
	@$(call install_fixup, python,VERSION,$(PYTHON_VERSION))
	@$(call install_fixup, python,SECTION,base)
	@$(call install_fixup, python,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, python,DEPENDS,)
	@$(call install_fixup, python,DESCRIPTION,missing)

	@cd $(PYTHON_PKGDIR) && \
		find ./usr/lib/python$(PYTHON_MAJORMINOR) \
		\! -wholename "*/test/*" -a \! -wholename "*/tests/*" \
		$(PYTHON_SKIP_LIST) \
		-a \( -name "*.so" -o -name "*.pyc" \) | \
		while read file; do \
		$(call install_copy, python, 0, 0, 644, -, $${file##.}); \
	done

	@$(call install_copy, python, 0, 0, 755, -, /usr/bin/python$(PYTHON_MAJORMINOR))
	@$(call install_copy, python, 0, 0, 644, -, /usr/lib/libpython$(PYTHON_MAJORMINOR).so.1.0)
	@$(call install_link, python, libpython$(PYTHON_MAJORMINOR).so.1.0, \
		/usr/lib/libpython$(PYTHON_MAJORMINOR).so)

ifdef PTXCONF_PYTHON_SYMLINK
	@$(call install_link, python, python$(PYTHON_MAJORMINOR), /usr/bin/python)
endif

	@$(call install_finish, python)

	@$(call touch)

# vim: syntax=make
