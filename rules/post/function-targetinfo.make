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
# targetinfo
#
# Print out the targetinfo line on the terminal
#
ifdef PTXDIST_QUIET
_targetinfo_opt_output := echo "started : $(PTX_COLOR_BLUE)$${target}$(PTX_COLOR_OFF)" >&$(PTXDIST_FD_STDOUT);
endif

targetinfo = 								\
	target="$(strip $(@))";						\
	target="$${target\#\#*/}";					\
	dep="$(strip $^)";						\
	dep="$${dep\#\#*/}";						\
	echo "$${target} : $${dep}" >> $(DEP_OUTPUT);			\
	$(_targetinfo_opt_output)					\
	target="target: $${target\#\#*/}";				\
	echo -e "\n$${target//?/-}\n$${target}\n$${target//?/-}\n";	\

# vim: syntax=make
