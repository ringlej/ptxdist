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
# Make to bash export (M2B):
#
M2B=$(STATEDIR)/environment
#
# Select make variables for export to shell (by full name)
#
M2B_DUMP_VARIABLES := PTXCONF_CONFIGFILE_VERSION
M2B_DUMP_VARIABLES += PTXCONFIG PTXCONF_PREFIX PTXCONF_PROJECT PTXCONF_PROJECT_VERSION
M2B_DUMP_VARIABLES += PTXDIST_WORKSPACE PTXDIST_TOPDIR
M2B_DUMP_VARIABLES += PTXDIST PTXDIST_FULLVERSION
M2B_DUMP_VARIABLES += RULESDIR SCRIPTSDIR STATEDIR SYSROOT WORKDIR
M2B_DUMP_VARIABLES += PACKAGES- PACKAGES-y

#
# Select make variables for export to shell (by suffix)
#
M2B_DUMP_SUFFIXES := _URL _DIR _VERSION _SOURCE

# remove_quotes
#
# Remove quotes from a variable definition
#
# $1: variable
#
remove_quotes = $(strip $(subst $(quote),,$(1)))
add_quote = $(subst $(quote),\$(quote),$(1))

tr_sh = $(strip $(shell echo $(1) | sed 'y%*+%pp%;s%[^_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789]%_%g'))
