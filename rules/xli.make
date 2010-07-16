# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XLI) += xli

#
# Paths and names
#
XLI_VERSION	:= 1.17.0
XLI		:= xli-$(XLI_VERSION)
XLI_SUFFIX	:= tar.gz
XLI_SOURCE	:= $(SRCDIR)/$(XLI).$(XLI_SUFFIX)
XLI_DIR		:= $(BUILDDIR)/$(XLI)

XLI_URL	:= \
	http://pantransit.reptiles.org/prog/$(XLI).$(XLI_SUFFIX) \
	ftp://ftp.euro.net/pub/mirrors/FreeBSD/ports/distfiles/$(XLI).$(XLI_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XLI_SOURCE):
	@$(call targetinfo)
	@$(call get, XLI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/xli.extract:
	@$(call targetinfo)
	@$(call clean, $(XLI_DIR))
	@$(call extract, XLI)
	@$(call patchin, XLI)
	cd $(XLI_DIR) && ln -sf Makefile.std Makefile
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

XLI_PATH	:= PATH=$(CROSS_PATH)
XLI_MAKE_ENV	:= $(CROSS_ENV) EXTRAFLAGS="$(CROSS_CPPFLAGS) $(CROSS_LDFLAGS)"

XLI_INSTALL_OPT	:= INSTALLDIR=$(XLI_PKGDIR)/usr/bin install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xli.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xli)
	@$(call install_fixup, xli,PRIORITY,optional)
	@$(call install_fixup, xli,SECTION,base)
	@$(call install_fixup, xli,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xli,DESCRIPTION,missing)

	@$(call install_copy, xli, 0, 0, 0755, -, /usr/bin/xli)

	@$(call install_finish, xli)

	@$(call touch)

# vim: syntax=make
