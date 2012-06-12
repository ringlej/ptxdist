# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

genimage/config = \
	$(shell ptxd_get_alternative config/images "$(strip $(1))" && echo "$${ptxd_reply}" || echo $(1))

# vim: syntax=make
