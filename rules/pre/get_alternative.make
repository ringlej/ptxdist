# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptx/get-alternative = $(shell ptxd_get_alternative $(1) $(2) && echo $$ptxd_reply)
ptx/get_alternative = $(error ptx/get_alternative has been renamed to ptx/get-alternative)

ptx/in-path = $(shell ptxd_in_path $(1) $(2) && echo $$ptxd_reply)

ptx/in-platformconfigdir = $(if $(strip $(1)),$(shell ptxd_in_platformconfigdir $(1)))

# vim: syntax=make
