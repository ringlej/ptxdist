# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptx/get_alternative = $(shell ptxd_get_alternative $(1) $(2) && echo $$ptxd_reply)

# vim: syntax=make
