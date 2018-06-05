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
$(call ptx/ifdef,$(1),n,y)
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
$(strip $(if $(filter y,$($(strip $(1)))),$(2),$(3)))
endef


#
# $(call ptx/ifeq, SYMBOL, val, yes, no) is equivalent to the C
# construct (plus, strings can be compared here, too):
#
# SYMBOL == val ? "yes" : "no"
#
# $(call ptx/ifeq, SYMBOL, val, yes, no)
#                    $1,    $2,  $3, $4
#
define ptx/ifeq
$(strip $(if $(filter $(strip $(2)),$($(strip $(1)))),$(3),$(4)))
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
# $(call ptx/disen, PTXCONF_SYMBOL) returns "disable" or "enable"
# depending on the symbol is defined or not
#
# $(call ptx/disen, PTXCONF_SYMBOL)
#                     $1
#
define ptx/disen
$(call ptx/ifdef, $(1), disable, enable)
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


#
# $(call ptx/onoff, PTXCONF_SYMBOL) returns "ON" or "OFF"
# depending on the symbol is defined or not
#
# $(call ptx/onoff, PTXCONF_SYMBOL)
#                     $1
#
define ptx/onoff
$(call ptx/ifdef, $(1), ON, OFF)
endef


#
# $(call ptx/truefalse, PTXCONF_SYMBOL) returns "true" or "false"
# depending on the symbol is defined or not
#
# $(call ptx/truefalse, PTXCONF_SYMBOL)
#                     $1
#
define ptx/truefalse
$(call ptx/ifdef, $(1), true, false)
endef


#
# $(call ptx/falsetrue, PTXCONF_SYMBOL) returns "true" or "false"
# depending on the symbol is defined or not
#
# $(call ptx/falsetrue, PTXCONF_SYMBOL)
#                     $1
#
define ptx/falsetrue
$(call ptx/ifdef, $(1), false, true)
endef


#
# $(call ptx/yesno, PTXCONF_SYMBOL) returns "yes" or "no"
# depending on the symbol is defined or not
#
# $(call ptx/yesno, PTXCONF_SYMBOL)
#                     $1
#
define ptx/yesno
$(call ptx/ifdef, $(1), yes, no)
endef

# vim: syntax=make
