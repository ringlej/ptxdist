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
ifdef PTXDIST_FD_STDOUT
_targetinfo_opt_output := echo "$$(ptxd_make_print_progress start $${target})started : $(PTX_COLOR_BLUE)$${target}$(PTX_COLOR_OFF)" >&$(PTXDIST_FD_STDOUT);
endif
endif
ifdef PTXCONF_SETUP_GEN_DEP_TREE
_targetinfo_dep_output = echo "$${target} : $(strip $(notdir $^))" >> $(DEP_OUTPUT);
endif

targetinfo = 								\
	target="$(strip $(notdir $(@)))";				\
	$(_targetinfo_dep_output)					\
	$(_targetinfo_opt_output)					\
	target="target: $${target}";					\
	echo -e "\n$${target//?/-}\n$${target}\n$${target//?/-}\n";	\

# vim: syntax=make
