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
# install_init
#
# Deletes $(PKGDIR)/$$PACKET.tmp/ipkg and prepares for new ipkg package creation
#
# $1: packet label
#
install_init =				\
	$(call xpkg/env, $(1))		\
	ptxd_make_install_init

# vim: syntax=make
