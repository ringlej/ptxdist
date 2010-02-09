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
PACKAGES-$(PTXCONF_LIBBLKID) += libblkid

# ----------------------------------------------------------------------------
# Virtual fake package
# ----------------------------------------------------------------------------

$(STATEDIR)/libblkid.get:
	@$(call touch)

$(STATEDIR)/libblkid.extract:
	@$(call touch)

$(STATEDIR)/libblkid.prepare:
	@$(call touch)

$(STATEDIR)/libblkid.compile:
	@$(call touch)

$(STATEDIR)/libblkid.install:
	@$(call targetinfo)
	@$(call touch)

$(STATEDIR)/libblkid.targetinstall:
	@$(call touch)


# vim: syntax=make
