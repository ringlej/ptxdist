# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GETTEXT) += host-gettext

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_GETTEXT_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-csharp \
	--disable-java \
	--disable-static \
	--disable-libasprintf \
	--disable-native-java \
	--disable-openmp \
	--disable-c++ \
	--enable-relocatable \
	--disable-openmp \
	--disable-curses \
	--without-emacs \
	--without-bzip2 \
	--without-xz

# vim: syntax=make
