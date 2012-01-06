# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptx/mirror = $(foreach mirror,$(PTXCONF_SETUP_$(strip $(1))MIRROR),$(mirror)/$(strip $(2)))

# vim: syntax=make
