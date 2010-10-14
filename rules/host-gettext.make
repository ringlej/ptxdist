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

ifdef PTXCONF_HOST_GETTEXT
$(STATEDIR)/autogen-tools: $(STATEDIR)/host-gettext.install.post
endif

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
	--disable-libasprintf \
	--disable-native-java \
	--disable-openmp \
	--enable-relocatable \
	--without-emacs

# vim: syntax=make
