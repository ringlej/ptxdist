# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# import kconfig tree from package into ptxdist
#
# package must setup variable <PACKAGE>_KCONFIG
# that points to the toplevel KCONFIG file
#
# the kconfig tree will be found in
# $PTXDIST_TOPLEVEL/config/<package>
# all symbols are prefixed with <PACKAGE>
#
# the import is started with:
# ptxdist make import <package>
#
%_import: $(STATEDIR)/%.extract
	@$(call targetinfo)
	@"${PTXDIST_LIB_DIR}/ptxd_make_import.awk" "$(*)" "$($(PTX_MAP_TO_PACKAGE_$(*))_KCONFIG)"

# vim: syntax=make
