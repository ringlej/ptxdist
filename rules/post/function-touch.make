# -*-makefile-*-
#
# Copyright (C) 2004, 2005, 2006, 2007, 2008 by the PTXdist project
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# touch
#
ifndef PTXDIST_QUIET
touch =										\
	target="$(strip $(@))";							\
	touch "$${target}";							\
	echo "Finished target $${target\#\#*/}"
else
touch =										\
	target="$(strip $(@))";							\
	touch "$${target}";							\
	target="$${target\#\#*/}";						\
	echo "finished: $(PTX_COLOR_GREEN)$${target}$(PTX_COLOR_OFF)" >&2;	\
	echo "Finished target $${target}"
endif

# vim: syntax=make
