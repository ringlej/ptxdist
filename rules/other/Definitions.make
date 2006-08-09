# -*-makefile-*-
#
# Some definitions for stuff which even kicks vim's syntax highlighting
# off the corner...
#

comma:=,
nullstring:=
space:= $(nullstring) # end of the linespace=
quote:="

#
# remove_quotes
#
# Remove quotes from a variable definition
#
# $1: variable
#
remove_quotes = $(strip $(subst $(quote),,$(1)))
