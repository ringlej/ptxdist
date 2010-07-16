# -*-makefile-*-
#
# Copyright (C) 2005, 2006, 2007 Robert Schwebel <r.schwebel@pengutronix.de>
#               2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# install_fixup
#
# Replaces @MAGIC@ sequences in rules/*.ipkg files
#
# $1: xpkg label
# $2: MAGIC to be replaced
# $3: replacement
#
install_fixup = \
	$(call xpkg/fixup, $(1), $(2), $(3))

#
# xpkg/fixup
#
# replaces @MAGIC@ sequences in rules/*.ipkg files
#
# $1: xpkg label
# $2: MAGIC to be replaced
# $3: replacement
#
xpkg/fixup = \
	$(call xpkg/env, $(1)) \
	pkg_xpkg_fixup_from='$(strip $(2))' \
	pkg_xpkg_fixup_to='$(strip $(3))' \
	ptxd_make_xpkg_fixup

# vim: syntax=make
