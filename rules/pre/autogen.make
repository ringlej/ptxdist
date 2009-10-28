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
	$(PROJECTPATCHDIR)/$(strip $(1))/generic/autogen.sh			\
	$(PROJECTPATCHDIR)/$(strip $(1))/autogen.sh				\
	$(PTXDIST_PLATFORMCONFIGDIR)/patches/$(strip $(1))/generic/autogen.sh	\
	$(PTXDIST_PLATFORMCONFIGDIR)/patches/$(strip $(1))/autogen.sh		\
	$(PATCHDIR)/$(strip $(1))/generic/autogen.sh				\
	$(PATCHDIR)/$(strip $(1))/autogen.sh))

$(STATEDIR)/autogen-tools:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
