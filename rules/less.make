# -*-makefile-*-
#
# Copyright (C) 2007 by Bjoern Buerger <b.buerger@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LESS) += less

#
# Paths and names
#
LESS_VERSION	:= 418
LESS		:= less-$(LESS_VERSION)
LESS_SUFFIX	:= tar.gz
LESS_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/less/$(LESS).$(LESS_SUFFIX)
LESS_SOURCE	:= $(SRCDIR)/$(LESS).$(LESS_SUFFIX)
LESS_DIR	:= $(BUILDDIR)/$(LESS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LESS_SOURCE):
	@$(call targetinfo)
	@$(call get, LESS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LESS_PATH	:= PATH=$(CROSS_PATH)
LESS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LESS_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LESS_USE_PW
LESS_ENV += ac_cv_lib_PW_regcmp=yes
else
LESS_ENV += ac_cv_lib_PW_regcmp=no
endif

ifdef PTXCONF_LESS_USE_CURSES
LESS_ENV += ac_cv_lib_curses_initscr=yes
else
LESS_ENV += ac_cv_lib_curses_initscr=no
endif

ifdef PTXCONF_LESS_USE_TINFO
LESS_ENV += ac_cv_lib_tinfo_tgoto=yes
else
LESS_ENV += ac_cv_lib_tinfo_tgoto=no
endif

ifdef PTXCONF_LESS_USE_XCURSES
LESS_ENV += ac_cv_lib_xcurses_initscr=yes
else
LESS_ENV += ac_cv_lib_xcurses_initscr=no
endif

ifdef PTXCONF_LESS_USE_NCURSES
LESS_ENV += ac_cv_lib_ncurses_initscr=yes
else
LESS_ENV += ac_cv_lib_ncurses_initscr=no
endif

ifdef PTXCONF_LESS_USE_TERMCAP
LESS_ENV += ac_cv_lib_termcap_tgetent=yes
else
LESS_ENV += ac_cv_lib_termcap_tgetent=no
endif

ifdef PTXCONF_LESS_USE_TERMLIB
LESS_ENV += ac_cv_lib_termlib_tgetent=yes
else
LESS_ENV += ac_cv_lib_termlib_tgetent=no
endif

ifdef PTXCONF_LESS_USE_GEN
LESS_ENV += ac_cv_lib_gen_regcmp=yes
else
LESS_ENV += ac_cv_lib_gen_regcmp=no
endif

ifdef PTXCONF_LESS_USE_INTL
LESS_ENV += ac_cv_lib_intl_regcmp=yes
else
LESS_ENV += ac_cv_lib_intl_regcmp=no
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/less.targetinstall:
	@$(call targetinfo)

	@$(call install_init, less)
	@$(call install_fixup, less,PRIORITY,optional)
	@$(call install_fixup, less,SECTION,base)
	@$(call install_fixup, less,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, less,DESCRIPTION,missing)

ifdef PTXCONF_LESS_BIN
	@$(call install_copy, less, 0, 0, 0755, -, /usr/bin/less)
endif

ifdef PTXCONF_LESS_KEY
	@$(call install_copy, less, 0, 0, 0755, -, /usr/bin/lesskey)
endif

ifdef PTXCONF_LESS_ECHO
	@$(call install_copy, less, 0, 0, 0755, -, /usr/bin/lessecho)
endif

	@$(call install_finish, less)

	@$(call touch)

# vim: syntax=make
