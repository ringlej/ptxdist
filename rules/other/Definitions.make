# -*-makefile-*-
#
# Copyright (C) 2004, 2005, 2006, 2007, 2008 by the PTXdist project
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PTXCONFIG		:= $(PTXDIST_PTXCONFIG)
PLATFORMCONFIG		:= $(PTXDIST_PLATFORMCONFIG)
SRCDIR			:= $(PTXDIST_SRCDIR)
PARALLELMFLAGS		:= $(PTXDIST_PARALLELMFLAGS_INTERN)
PARALLELMFLAGS_BROKEN	:= -j1

#
# provide defines for some unusual chars
#
ptx/def/comma		:=,
ptx/def/nullstring	:=
ptx/def/space		:=$(ptx/def/nullstring) $(ptx/def/nullstring)
ptx/def/dquote		:="#"
ptx/def/squote		:='#'
ptx/def/dollar		:=$$

define ptx/escape/1
$(subst $(1),\$(1),$(2))
endef

define ptx/escape/2
$(subst $(1),\\$(1),$(2))
endef

define ptx/escape
$(strip $(call ptx/escape/2,$(ptx/def/dollar),$(call ptx/escape/1,$(ptx/def/dquote),$(1))))
endef


# backwards compat
comma		:=,
nullstring	:=
space		:=$(nullstring) $(nullstring)
quote		:="#"

define remove_quotes
$(strip $(subst $(quote),,$(1)))
endef

define add_quote
$(subst $(quote),\$(quote),$(1))
endef

define tr_sh
$(strip $(shell echo $(1) | sed 'y%*+%pp%;s%[^_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789]%_%g'))
endef

define reverse
$(if $(1),$(call reverse,$(wordlist 2,$(words $(1)),$(1)))) $(firstword $(1))
endef

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
