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
PYTHON3_VERSION		:= 3.1.2
PYTHON3_MAJORMINOR	:= 3.1
PYTHON3			:= Python-$(PYTHON3_VERSION)
PYTHON3_SUFFIX		:= tar.bz2
PYTHON3_SOURCE		:= $(SRCDIR)/$(PYTHON3).$(PYTHON3_SUFFIX)
PYTHON3_DIR		:= $(BUILDDIR)/$(PYTHON3)

PYTHON3_URL		:= \
	http://python.org/ftp/python/$(PYTHON3_VERSION)/$(PYTHON3).$(PYTHON3_SUFFIX) \
	http://python.org/ftp/python/$(PYTHON3_MAJORMINOR)/$(PYTHON3).$(PYTHON3_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PYTHON3_SOURCE):
	@$(call targetinfo)
	@$(call get, PYTHON3)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PATH	:= PATH=$(CROSS_PATH)
PYTHON3_ENV 	:= \
	$(CROSS_ENV) \
	PYTHON_FOR_BUILD=$(PTXCONF_SYSROOT_HOST)/bin/python$(PYTHON3_MAJORMINOR) \
	ac_cv_have_chflags=no \
	ac_cv_have_lchflags=no \
	ac_cv_py_format_size_t=yes \
	ac_cv_broken_sem_getvalue=no

PYTHON3_BINCONFIG_GLOB := ""

#
# autoconf
#
PYTHON3_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	--enable-shared \
	--with-pymalloc \
	--with-signal-module \
	--with-threads \
	--with-wctype-functions \
	--without-doc-strings

PYTHON3_MAKEVARS := \
	PGEN_FOR_BUILD=$(PTXCONF_SYSROOT_HOST)/bin/pgen

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3.install:
	@$(call targetinfo)
	@$(call install, PYTHON3)
	@cp "$(PYTHON3_DIR)/cross-python-wrapper" "$(PYTHON3_PKGDIR)/usr/bin/"
	@sed -i \
		-e "s:$(SYSROOT):@SYSROOT@:g" \
		-e "s:$(PTXCONF_SYSROOT_HOST):@SYSROOT_HOST@:g" \
		$(PYTHON3_PKGDIR)/usr/lib/python$(PYTHON3_MAJORMINOR)/config/Makefile
	@$(call touch)


$(STATEDIR)/python3.install.post:
	@$(call targetinfo)
	@sed -i \
		-e "s:@SYSROOT@:$(SYSROOT):g" \
		-e "s:@SYSROOT_HOST@:$(PTXCONF_SYSROOT_HOST):g" \
		$(PYTHON3_PKGDIR)/usr/lib/python$(PYTHON3_MAJORMINOR)/config/Makefile
	@$(call world/install.post, PYTHON3)
	@rm -f "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo '#!/bin/sh'				>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo ''					>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo 'prefix="/usr"'				>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo 'exec_prefix="$${prefix}"'		>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo ''					>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo 'CROSS_COMPILING=yes'			>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo '_python_sysroot="$(SYSROOT)"'		>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo '_python_prefix="$${prefix}"'		>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo '_python_exec_prefix="$${exec_prefix}"'	>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo ''					>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo 'export CROSS_COMPILING _python_sysroot _python_prefix _python_exec_prefix' \
							>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo ''					>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@echo 'exec $(PTXCONF_SYSROOT_HOST)/bin/python$(PYTHON3_MAJORMINOR) "$${@}"' \
							>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"

#	@cp "$(PYTHON3_PKGDIR)/usr/bin/cross-python-wrapper" "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@chmod a+x "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)"
	@ln -sf "python$(PYTHON3_MAJORMINOR)" \
		"$(PTXCONF_SYSROOT_CROSS)/bin/python3"

	@echo "#!/bin/sh" \
		> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)-config"
	@echo "exec \
		\"$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)\" \
		\"$(PTXCONF_SYSROOT_HOST)/bin/python$(PYTHON3_MAJORMINOR)-config\" \
		\"\$${@}\"" \
		>> "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)-config"
	@chmod a+x "$(PTXCONF_SYSROOT_CROSS)/bin/python$(PYTHON3_MAJORMINOR)-config"
	@ln -sf "python$(PYTHON3_MAJORMINOR)-config" \
		"$(PTXCONF_SYSROOT_CROSS)/bin/python3-config"

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

PYTHON3_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON3_LIBTK)		+= lib-tk
PYTHON3_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON3_IDLELIB)	+= idlelib
PYTHON3_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON3_DISTUTILS)	+= distutils

ifneq ($(PYTHON3_SKIP-y),)
PYTHON3_SKIP_LIST_PRE  :=-a \! -wholename $(quote)*/
PYTHON3_SKIP_LIST_POST :=/*$(quote)

PYTHON3_SKIP_LIST := $(subst $(space),$(PYTHON3_SKIP_LIST_POST) $(PYTHON3_SKIP_LIST_PRE),$(PYTHON3_SKIP-y))
PYTHON3_SKIP_LIST := $(PYTHON3_SKIP_LIST_PRE)$(PYTHON3_SKIP_LIST)$(PYTHON3_SKIP_LIST_POST)
endif

$(STATEDIR)/python3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3)
	@$(call install_fixup, python3,PACKAGE,python3)
	@$(call install_fixup, python3,PRIORITY,optional)
	@$(call install_fixup, python3,VERSION,$(PYTHON3_VERSION))
	@$(call install_fixup, python3,SECTION,base)
	@$(call install_fixup, python3,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, python3,DEPENDS,)
	@$(call install_fixup, python3,DESCRIPTION,missing)

	@cd $(PYTHON3_PKGDIR) && \
		find ./usr/lib/python$(PYTHON3_MAJORMINOR) \
		\! -wholename "*/test/*" -a \! -wholename "*/tests/*" \
		$(PYTHON3_SKIP_LIST) \
		-a \( -name "*.so" -o -name "*.pyc" \) | \
		while read file; do \
		$(call install_copy, python3, 0, 0, 644, -, $${file##.}); \
	done

	@$(call install_copy, python3, 0, 0, 755, -, /usr/bin/python$(PYTHON3_MAJORMINOR))
	@$(call install_copy, python3, 0, 0, 644, -, /usr/lib/libpython$(PYTHON3_MAJORMINOR).so.1.0)
	@$(call install_link, python3, libpython$(PYTHON3_MAJORMINOR).so.1.0, \
		/usr/lib/libpython$(PYTHON3_MAJORMINOR).so)

ifdef PTXCONF_PYTHON3_SYMLINK
	@$(call install_link, python3, python$(PYTHON3_MAJORMINOR), /usr/bin/python3)
endif

	@$(call install_finish, python3)

	@$(call touch)

# vim: syntax=make
