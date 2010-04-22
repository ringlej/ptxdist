# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3) += host-python3

#
# Paths and names
#
HOST_PYTHON3_DIR	=  $(HOST_BUILDDIR)/$(PYTHON3)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_PATH	:= PATH=$(HOST_PATH)
HOST_PYTHON3_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_PYTHON3_AUTOCONF := \
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

$(STATEDIR)/host-python3.install:
	@$(call targetinfo)
	@$(call install, HOST_PYTHON3,,h)
	install -m 0755 $(HOST_PYTHON3_DIR)/Parser/pgen $(HOST_PYTHON3_PKGDIR)/bin
#
# remove "python" so that it doesn't interfere with the build
# machine's python
#
# the target build proces will only use python with the
# python-$(PYTHON3_MAJORMINOR)
#
	@rm -v \
		"$(HOST_PYTHON3_PKGDIR)/bin/python3" \
		"$(HOST_PYTHON3_PKGDIR)/bin/python3-config"
	@$(call touch)

# vim: syntax=make
