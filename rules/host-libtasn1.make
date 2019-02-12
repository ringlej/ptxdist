# -*-makefile-*-
#
# Copyright (C) 2018 by Juergen Borleis <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBTASN1) += host-libtasn1

#
# Paths and names
#
HOST_LIBTASN1_DIR	= $(HOST_BUILDDIR)/$(LIBTASN1)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBTASN1_CONF_TOOL	:= autoconf
HOST_LIBTASN1_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-doc \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-valgrind-tests \
	--disable-gcc-warnings

# vim: syntax=make
