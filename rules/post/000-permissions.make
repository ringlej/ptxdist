# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


PTX_PERMISSIONS := $(STATEDIR)/permissions

### --- internal ---

#
# FIXME: doesn't work on first run
#
#PTX_PERMISSIONS_FILES = $(foreach pkg,$(PACKAGES-y),$(wildcard $(STATEDIR)/$(pkg)*.perms))

#
# create one file with all permissions from all permission source files
#
$(PTX_PERMISSIONS): $(STATEDIR)/world.targetinstall
	@{								\
	if [ -n "$(PTXDIST_PROD_PLATFORMDIR)" ]; then			\
		cat $(PTXDIST_PROD_PLATFORMDIR)/state/*.perms;		\
	fi;								\
	cat $(STATEDIR)/*.perms;					\
	} > $@

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
