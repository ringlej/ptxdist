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
HOST_PACKAGES-$(PTXCONF_HOST_LIBUUID) += host-libuuid

# ----------------------------------------------------------------------------
# Virtual fake package
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libuuid.get:
	@$(call touch)

$(STATEDIR)/host-libuuid.extract:
	@$(call touch)

$(STATEDIR)/host-libuuid.prepare:
	@$(call touch)

$(STATEDIR)/host-libuuid.compile:
	@$(call touch)

$(STATEDIR)/host-libuuid.install:
	@$(call targetinfo)
	@$(call touch)


# vim: syntax=make
