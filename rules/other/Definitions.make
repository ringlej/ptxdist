# -*-makefile-*-

PTXCONFIG		:= $(PTXDIST_PTXCONFIG)
PLATFORMCONFIG		:= $(PTXDIST_PLATFORMCONFIG)
SRCDIR			:= $(PTXDIST_SRCDIR)
PARALLELMFLAGS		:= $(PTXDIST_PARALLELMFLAGS_INTERN)
PARALLELMFLAGS_BROKEN	:= -j1

#
# Some definitions for stuff which even kicks vim's syntax highlighting
# off the corner...
#
comma:=,
nullstring:=
space:= $(nullstring) $(nullstring)
quote:="#"


remove_quotes = $(strip $(subst $(quote),,$(1)))
add_quote = $(strip $(subst $(quote),\$(quote),$(1)))


tr_sh = $(strip $(shell echo $(1) | sed 'y%*+%pp%;s%[^_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789]%_%g'))

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
