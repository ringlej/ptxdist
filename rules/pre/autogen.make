# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

autogen_dep = $(strip $(wildcard						\
	$(foreach dir,$(subst :,/$(strip $(1))$(space),$(PTXDIST_PATH_PATCHES)),\
		$(dir)/generic/autogen.sh $(dir)/autogen.sh)))

$(STATEDIR)/autogen-tools:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
