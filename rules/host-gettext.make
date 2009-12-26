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

#
# Paths and names
#
HOST_GETTEXT_VERSION	:= 0.17
HOST_GETTEXT		:= gettext-$(HOST_GETTEXT_VERSION)
HOST_GETTEXT_SUFFIX	:= tar.gz
HOST_GETTEXT_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/gettext/$(HOST_GETTEXT).$(HOST_GETTEXT_SUFFIX)
HOST_GETTEXT_SOURCE	:= $(SRCDIR)/$(HOST_GETTEXT).$(HOST_GETTEXT_SUFFIX)
HOST_GETTEXT_DIR	:= $(HOST_BUILDDIR)/$(HOST_GETTEXT)

ifdef PTXCONF_HOST_GETTEXT
$(STATEDIR)/autogen-tools: $(STATEDIR)/host-gettext.install
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_GETTEXT_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_GETTEXT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GETTEXT_ENV 	:= $(HOST_ENV)

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

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-gettext_clean:
	rm -rf $(STATEDIR)/host-gettext.*
	rm -rf $(HOST_GETTEXT_DIR)

# vim: syntax=make
