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
# targetinfo
#
# Print out the targetinfo line on the terminal
#
ifndef PTXDIST_QUIET
targetinfo = 									\
	target="$(strip $(@))";							\
	target="target: $${target\#\#*/}";					\
	echo -e "\n$${target//?/-}\n$${target}\n$${target//?/-}\n";		\
	echo $@ : $^ | sed 							\
		-e "s@$(SRCDIR)@@g"						\
		-e "s@$(STATEDIR)@@g"						\
		-e "s@$(RULESDIR)@@g"						\
		-e "s@$(PROJECTRULESDIR)@@g"					\
		-e "s@$(PTXDIST_PLATFORMCONFIGDIR)@@g"				\
		-e "s@$(PTXDIST_WORKSPACE)@@g"					\
		-e "s@$(PTXDIST_TOPDIR)@@g" 					\
		-e "s@/@@g" >> $(DEP_OUTPUT)
else
targetinfo = 									\
	target="$(strip $(@))";							\
	target="$${target\#\#*/}";						\
	echo "started : $(PTX_COLOR_BLUE)$${target}$(PTX_COLOR_OFF)" >&2;	\
	target="target: $${target}";						\
	echo -e "\n$${target//?/-}\n$${target}\n$${target//?/-}\n";		\
	echo $@ : $^ | sed 							\
		-e "s@$(SRCDIR)@@g"						\
		-e "s@$(STATEDIR)@@g"						\
		-e "s@$(RULESDIR)@@g"						\
		-e "s@$(PROJECTRULESDIR)@@g"					\
		-e "s@$(PTXDIST_PLATFORMCONFIGDIR)@@g"				\
		-e "s@$(PTXDIST_WORKSPACE)@@g"					\
		-e "s@$(PTXDIST_TOPDIR)@@g" 					\
		-e "s@/@@g" >> $(DEP_OUTPUT)
endif

# vim: syntax=make
