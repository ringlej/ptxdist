# -*-makefile-*-
#
# Copyright (C) 2010 by Carsten Schlote <c.schlote@konzeptpark.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUUID) += libuuid

# ----------------------------------------------------------------------------
# Virtual fake package
# ----------------------------------------------------------------------------

$(STATEDIR)/libuuid.get:
	@$(call touch)

$(STATEDIR)/libuuid.extract:
	@$(call touch)

$(STATEDIR)/libuuid.prepare:
	@$(call touch)

$(STATEDIR)/libuuid.compile:
	@$(call touch)

$(STATEDIR)/libuuid.install:
	@$(call targetinfo)
	@$(call touch)

$(STATEDIR)/libuuid.targetinstall:
	@$(call touch)

# vim: syntax=make
