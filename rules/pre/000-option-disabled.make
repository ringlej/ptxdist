# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# nice little helper from eglibc
#
# $(call ptx/opt-dis, VAR) is 'y' if VAR is not 'y', or 'n' otherwise.
# VAR should be a variable name, not a variable reference; this is
# less general, but more terse for the intended use.
# You can use it to add a file to a list if an option group is
# disabled, like this:
#   routines-$(call option-disabled, OPTION_POSIX_C_LANG_WIDE_CHAR) += ...
#

define ptx/opt-dis
$(firstword $(subst y,n,$(filter y,$($(strip $(1))))) y)
endef


#
# $(call ptx/ifdef, PTXCONF_SYMBOL, yes, no) is equivalent to the C
# construct:
#
# PTXCONF_SYMBOL ? "yes" : "no"
#
# $(call ptx/ifdef, SYMBOL, yes, no)
#                     $1,    $2, $3
#
define ptx/ifdef
$(strip $(firstword $(subst y,$(2),$(filter y,$($(strip $(1))))) $(3)))
endef


#
# $(call ptx/endis, PTXCONF_SYMBOL) returns "enable" or "disable"
# depending on the symbol is defined or not
#
# $(call ptx/endis, PTXCONF_SYMBOL)
#                     $1
#
define ptx/endis
$(call ptx/ifdef, $(1), enable, disable)
endef


#
# $(call ptx/wwo, PTXCONF_SYMBOL) returns "with" or "without"
# depending on the symbol is defined or not
#
# $(call ptx/wwo, PTXCONF_SYMBOL)
#                     $1
#
define ptx/wwo
$(call ptx/ifdef, $(1), with, without)
endef

# vim: syntax=make
