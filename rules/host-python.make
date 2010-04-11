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
HOST_PYTHON_DIR	=  $(HOST_BUILDDIR)/$(PYTHON)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON_PATH	:= PATH=$(HOST_PATH)
HOST_PYTHON_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_PYTHON_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--enable-shared \
	--with-cyclic-gc \
	--with-pymalloc \
	--with-signal-module \
	--with-threads \
	--with-wctype-functions \
	--without-cxx

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python.install:
	@$(call targetinfo)
	@$(call install, HOST_PYTHON,,h)
	install -m 0755 $(HOST_PYTHON_DIR)/Parser/pgen $(HOST_PYTHON_PKGDIR)/bin
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
