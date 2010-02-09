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
HOST_PACKAGES-$(PTXCONF_HOST_LIBBLKID) += host-libblkid

# ----------------------------------------------------------------------------
# Virtual fake package
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libblkid.get:
	@$(call touch)

$(STATEDIR)/host-libblkid.extract:
	@$(call touch)

$(STATEDIR)/host-libblkid.prepare:
	@$(call touch)

$(STATEDIR)/host-libblkid.compile:
	@$(call touch)

$(STATEDIR)/host-libblkid.install:
	@$(call targetinfo)
	@$(call touch)


# vim: syntax=make
