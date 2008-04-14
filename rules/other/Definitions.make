# -*-makefile-*-
#
# Some definitions for stuff which even kicks vim's syntax highlighting
# off the corner...
#

comma:=,
nullstring:=
space:= $(nullstring) $(nullstring)
quote:="#"


# remove_quotes
#
# Remove quotes from a variable definition
#
# $1: variable
#
remove_quotes = $(strip $(subst $(quote),,$(1)))
add_quote = $(subst $(quote),\$(quote),$(1))

tr_sh = $(strip $(shell echo $(1) | sed 'y%*+%pp%;s%[^_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789]%_%g'))
uppercase = $(shell echo $(strip $(1)) | tr "a-z.-" "A-Z__")

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
