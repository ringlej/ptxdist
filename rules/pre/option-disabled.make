# -*-makefile-*-

#
# nice little helper from eglibc
#

#
# $(call option-disabled, VAR) is 'y' if VAR is not 'y', or 'n' otherwise.
# VAR should be a variable name, not a variable reference; this is
# less general, but more terse for the intended use.
# You can use it to add a file to a list if an option group is
# disabled, like this:
#   routines-$(call option-disabled, OPTION_POSIX_C_LANG_WIDE_CHAR) += ...
#
define ptx/opt-dis
$(firstword $(subst y,n,$(filter y,$($(strip $(1))))) y)
endef

# vim: syntax=make
