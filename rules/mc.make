# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
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
PACKAGES-$(PTXCONF_MC) += mc

#
# Paths and names
#
MC_VERSION	:= 4.6.1
MC		:= mc-$(MC_VERSION)
MC_SUFFIX	:= tar.gz
MC_URL		:= http://www.ibiblio.org/pub/Linux/utils/file/managers/mc/$(MC).$(MC_SUFFIX)
MC_SOURCE	:= $(SRCDIR)/$(MC).$(MC_SUFFIX)
MC_DIR		:= $(BUILDDIR)/$(MC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MC_SOURCE):
	@$(call targetinfo)
	@$(call get, MC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MC_PATH	:= PATH=$(CROSS_PATH)
MC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
MC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-x=no \
	--without-gpm-mouse \
	--disable-rpath

ifdef PTXCONF_MC_USES_NCURSES
MC_AUTOCONF += --with-screen=ncurses
endif

ifdef PTXCONF_MC_USES_SLANG
MC_AUTOCONF += --with-screen=slang
endif

MC_INSTALL_OPT := -C src install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mc)
	@$(call install_fixup, mc,PRIORITY,optional)
	@$(call install_fixup, mc,SECTION,base)
	@$(call install_fixup, mc,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mc,DESCRIPTION,missing)

	@$(call install_copy, mc, 0, 0, 0755, -, /usr/bin/mc)

	@$(call install_finish, mc)

	@$(call touch)

# vim: syntax=make
