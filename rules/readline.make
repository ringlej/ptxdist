# -*-makefile-*-
#
# Copyright (C) 2004 by Sascha Hauer
#               2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_READLINE) += readline

#
# Paths and names
#
READLINE_VERSION	:= 6.2
READLINE_MD5		:= 67948acb2ca081f23359d0256e9a271c
READLINE		:= readline-$(READLINE_VERSION)
READLINE_SUFFIX		:= tar.gz
READLINE_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/readline/$(READLINE).$(READLINE_SUFFIX)
READLINE_SOURCE		:= $(SRCDIR)/$(READLINE).$(READLINE_SUFFIX)
READLINE_DIR		:= $(BUILDDIR)/$(READLINE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(READLINE_SOURCE):
	@$(call targetinfo)
	@$(call get, READLINE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

READLINE_AUTOCONF := \
	$(CROSS_AUTOCONF_ROOT) \
	--enable-shared \
	--disable-static\
	--disable-multibyte

ifdef PTXCONF_READLINE_TERMCAP
READLINE_AUTOCONF += --without-curses
endif
ifdef PTXCONF_READLINE_NCURSES
READLINE_AUTOCONF += --with-curses
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/readline.targetinstall:
	@$(call targetinfo)

	@$(call install_init, readline)
	@$(call install_fixup, readline,PRIORITY,optional)
	@$(call install_fixup, readline,SECTION,base)
	@$(call install_fixup, readline,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, readline,DESCRIPTION,missing)

	@$(call install_lib, readline, 0, 0, 0644, libreadline)

ifdef PTXCONF_READLINE_ETC_INPUTRC
	@$(call install_alternative, readline, 0, 0, 0644, /etc/inputrc)
endif
	@$(call install_finish, readline)

	@$(call touch)

# vim: syntax=make
