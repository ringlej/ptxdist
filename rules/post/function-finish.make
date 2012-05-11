# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

finish =					\
	target="$(strip $(@))";			\
	target="$${target\#\#*/}";		\
	$(_touch_opt_output)			\
	echo "finished target $${target}"

# vim: syntax=make
