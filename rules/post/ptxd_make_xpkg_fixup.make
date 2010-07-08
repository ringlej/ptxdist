# -*-makefile-*-
#
# Copyright (C) 2005, 2006, 2007 Robert Schwebel <r.schwebel@pengutronix.de>
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# install_fixup
#
# Replaces @...@ sequences in rules/*.ipkg files
#
# $1: packet label
# $2: sequence to be replaced
# $3: replacement
#
install_fixup =							\
	$(call xpkg/env, $(1))					\
	PTXCONF_PROJECT_BUILD="$(PTXCONF_PROJECT_BUILD)"	\
	ptxd_make_install_fixup					\
		-p '$(strip $(1))'				\
		-f '$(strip $(2))'				\
		-t '$(strip $(3))'				\
		-s '$(@)'

# vim: syntax=make
