# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#                       Marc Kleine-Budde <kleine-budde@gmx.de>
#               2005-2008 by Marc Kleine-Budde <mkl@pengutronix.de>, Pengutronix
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GCCLIBS) += gcclibs

ifeq ($(shell which $(CROSS_CC) 2>/dev/null),)
GCCLIBS_VERSION	:= unknown
else
GCCLIBS_VERSION	:= $(shell $(CROSS_CC) -dumpversion)
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gcclibs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gcclibs)
	@$(call install_fixup, gcclibs,PRIORITY,optional)
	@$(call install_fixup, gcclibs,SECTION,base)
	@$(call install_fixup, gcclibs,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gcclibs,DESCRIPTION,missing)

ifdef PTXCONF_GCCLIBS_GCC_S
	@$(call install_copy_toolchain_lib, gcclibs, libgcc_s.so)
endif

ifdef PTXCONF_GCCLIBS_CXX
	@$(call install_copy_toolchain_lib, gcclibs, libstdc++.so)
endif

ifdef PTXCONF_GCCLIBS_GCJ
	@$(call install_copy_toolchain_lib, gcclibs, libgcj.so)
endif

	@$(call install_finish, gcclibs)

	@$(call touch)

# vim: syntax=make
