# -*-makefile-*-

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
	@"${PTX_LIBDIR}/ptxd_make_import.awk" "$(*)" "$($(PTX_MAP_TO_PACKAGE_$(*))_KCONFIG)"

# vim: syntax=make
