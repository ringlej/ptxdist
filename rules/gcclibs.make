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

GCCLIBS_VERSION	:= $(or $(shell $(CROSS_CC) -dumpversion),unknown)
# for license information
-include $(PTXDIST_PLATFORMDIR)/selected_toolchain/../share/compliance/gcclibs.make

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

ifdef PTXCONF_GCCLIBS_ATOMIC
	@$(call install_copy_toolchain_lib, gcclibs, libatomic.so)
endif

ifdef PTXCONF_GCCLIBS_GCJ
	@$(call install_copy_toolchain_lib, gcclibs, libgcj.so)
endif

ifdef PTXCONF_GCCLIBS_LIBASAN
	@$(call install_copy_toolchain_lib, gcclibs, libasan.so)
endif

ifdef PTXCONF_GCCLIBS_LIBLSAN
	@$(call install_copy_toolchain_lib, gcclibs, liblsan.so)
endif

ifdef PTXCONF_GCCLIBS_LIBTSAN
	@$(call install_copy_toolchain_lib, gcclibs, liblsan.so)
endif

ifdef PTXCONF_GCCLIBS_LIBUBSAN
	@$(call install_copy_toolchain_lib, gcclibs, libubsan.so)
endif

	@$(call install_finish, gcclibs)

	@$(call touch)

# vim: syntax=make
