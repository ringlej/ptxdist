# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SWIG) += host-swig

#
# Paths and names
#
HOST_SWIG_VERSION	:= 2.0.9
HOST_SWIG_MD5		:= 54d534b14a70badc226129159412ea85
HOST_SWIG		:= swig-$(HOST_SWIG_VERSION)
HOST_SWIG_SUFFIX	:= tar.gz
HOST_SWIG_URL		:= $(call ptx/mirror, SF, swig/$(HOST_SWIG).$(HOST_SWIG_SUFFIX))
HOST_SWIG_SOURCE	:= $(SRCDIR)/$(HOST_SWIG).$(HOST_SWIG_SUFFIX)
HOST_SWIG_DIR		:= $(HOST_BUILDDIR)/$(HOST_SWIG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_SWIG_CONF_TOOL := autoconf
HOST_SWIG_DEVPKG := NO

# no := due to CROSS_PYTHON
HOST_SWIG_CONF_OPT = \
	$(HOST_AUTOCONF_SYSROOT) \
	--without-boost \
	--without-x \
	--without-tcl \
	--with-python=$(CROSS_PYTHON) \
	--without-python3 \
	--without-perl5 \
	--without-octave \
	--without-java \
	--without-gcj \
	--without-android \
	--without-guile \
	--without-mzscheme \
	--without-ruby \
	--without-php \
	--without-ocaml \
	--without-pike \
	--without-chicken \
	--without-csharp \
	--without-lua \
	--without-allegrocl \
	--without-clisp \
	--without-r \
	--without-go \
	--without-d

# vim: syntax=make
