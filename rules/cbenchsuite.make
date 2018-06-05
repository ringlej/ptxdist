# -*-makefile-*-
#
# Copyright (C) 2015 by Markus Pargmann <mpa@pengutronix.de
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CBENCHSUITE) += cbenchsuite

#
# Paths and names
#
CBENCHSUITE_VERSION	:= 1.1
CBENCHSUITE_MD5		:= c82d5e453cd38c9c933493845d0f5c2d
CBENCHSUITE		:= cbenchsuite-$(CBENCHSUITE_VERSION)
CBENCHSUITE_SUFFIX	:= tar.gz
CBENCHSUITE_URL		:= https://github.com/scosu/cbenchsuite/archive/v$(CBENCHSUITE_VERSION).$(CBENCHSUITE_SUFFIX)
CBENCHSUITE_SOURCE	:= $(SRCDIR)/$(CBENCHSUITE).$(CBENCHSUITE_SUFFIX)
CBENCHSUITE_DIR		:= $(BUILDDIR)/$(CBENCHSUITE)
CBENCHSUITE_LICENSE	:= GPL-2.0-or-later

#
# autoconf
#
CBENCHSUITE_CONF_TOOL	:= cmake
CBENCHSUITE_CONF_OPT	= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_TESTS:BOOL=OFF \
	-DMODULE_COMPRESSION:BOOL=ON \
	-DMODULE_COOLDOWN:BOOL=ON \
	-DMODULE_CPUSCHED:BOOL=ON \
	-DMODULE_KERNEL:BOOL=ON \
	-DMODULE_LINUX_PERF:BOOL=ON \
	-DMODULE_MATH:BOOL=ON \
	-DMODULE_SYSCTL:BOOL=ON \
	-DDB_DIR:STRING=/run/cbenchsuite/db/ \
	-DWORK_DIR:STRING=/run/cbenchsuite/work/ \
	-DDOWNLOAD_DIR:STRING=/run/cbenchsuite/downloads/


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cbenchsuite.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cbenchsuite)
	@$(call install_fixup, cbenchsuite,PRIORITY,optional)
	@$(call install_fixup, cbenchsuite,SECTION,base)
	@$(call install_fixup, cbenchsuite,AUTHOR,"Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, cbenchsuite,DESCRIPTION,missing)

	@$(call install_copy, cbenchsuite, 0, 0, 0755, -, /usr/bin/cbenchsuite)
	@$(call install_tree, cbenchsuite, 0, 0, -, /usr/lib/cbenchsuite)

	@$(call install_finish, cbenchsuite)

	@$(call touch)

# vim: syntax=make
