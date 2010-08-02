# -*-makefile-*-
#
# Copyright (C) 2004, 2005, 2006, 2007, 2008 by the PTXdist project
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# touch
#
ifdef PTXDIST_QUIET
_touch_opt_output := echo "finished: $(PTX_COLOR_GREEN)$${target}$(PTX_COLOR_OFF)" >&$(PTXDIST_FD_STDOUT);
endif

touch =						\
	target="$(strip $(@))";			\
	touch "$${target}";			\
	target="$${target\#\#*/}";		\
	$(_touch_opt_output)			\
	echo "finished target $${target}"

# vim: syntax=make
