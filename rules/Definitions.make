# -*-makefile-*-
#
# Some definitions for stuff which even kicks vim's syntax highlighting
# off the corner...
#

comma=,
space= 
quote="

#
# remove_quotes
#
# Remove quotes from a variable definition
#
# $1: variable
#
remove_quotes = $(subst $(quote),,$(1))



