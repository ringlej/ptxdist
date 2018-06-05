# -*-makefile-*-

#
# ncurses-config handling
#
# add $(CROSS_ENV_AC_NCURSES) to your _ENV if ncurses should be detected
# use $(CROSS_ENV_AC_NO_NCURSES) if you ncurses should not be detected
#

# defaults
CROSS_ENV_AC_NCURSESW6_CONFIG	:= no
CROSS_ENV_AC_NCURSES6_CONFIG	:= no

# modify if ncurses is enabled
ifdef PTXCONF_NCURSES
ifdef PTXCONF_NCURSES_WIDE_CHAR
CROSS_ENV_AC_NCURSESW6_CONFIG	:= yes
endif
CROSS_ENV_AC_NCURSES6_CONFIG	:= yes
endif

CROSS_ENV_AC_NCURSES := \
	ac_cv_prog_ncurses6_config=$(CROSS_ENV_AC_NCURSES6_CONFIG) \
	ac_cv_prog_ncursesw6_config=$(CROSS_ENV_AC_NCURSESW6_CONFIG)

CROSS_ENV_AC_NO_NCURSES := \
	ac_cv_header_ncurses_h=no \
	ac_cv_header_ncurses_ncurses_h=no \
	ac_cv_lib_ncurses_initscr=no \
	ac_cv_prog_ncurses6_config=no \
	ac_cv_prog_ncursesw6_config=no

#
# $(call ptx/ncurses, PTXCONF_SYMBOL) returns env with ncurses hint or not
# depending on the symbol is defined or not
#
# $(call ptx/ncurses, PTXCONF_SYMBOL)
#                     $1
#
define ptx/ncurses
$(call ptx/ifdef, $(1), $(CROSS_ENV_AC_NCURSES), $(CROSS_ENV_AC_NO_NCURSES))
endef


# vim: syntax=make
