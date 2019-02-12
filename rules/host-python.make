# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON) += host-python

#
# Paths and names
#
HOST_PYTHON_DIR	= $(HOST_BUILDDIR)/$(PYTHON)

HOSTPYTHON	= $(PTXCONF_SYSROOT_HOST)/bin/python$(PYTHON_MAJORMINOR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON_PATH	:= PATH=$(HOST_PATH)
HOST_PYTHON_ENV 	:= \
	$(HOST_ENV) \
	ac_sys_system=Linux \
	ac_sys_release=2 \
	MACHDEP=linux2

#
# autoconf
#
HOST_PYTHON_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--enable-shared \
	--disable-profiling \
	--disable-optimizations \
	--disable-toolbox-glue \
	--without-pydebug \
	--without-lto \
	--with-signal-module \
	--with-threads \
	--without-doc-strings \
	--with-pymalloc \
	--without-valgrind \
	--with-wctype-functions \
	--with-fpectl \
	--with-computed-gotos \
	--without-ensurepip

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python.install:
	@$(call targetinfo)
	@$(call install, HOST_PYTHON,,h)
#
# remove "python" so that it doesn't interfere with the build
# machine's python
#
# the target build proces will only use python with the
# python-$(PYTHON_MAJORMINOR)
#
	@rm -v \
		"$(HOST_PYTHON_PKGDIR)/bin/python" \
		"$(HOST_PYTHON_PKGDIR)/bin/python-config"
	@$(call touch)

# vim: syntax=make
