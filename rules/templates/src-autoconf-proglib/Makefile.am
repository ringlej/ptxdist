if BUILD_SILENTLY
AM_MAKEFLAGS = --no-print-directory
endif

# pkg's stuff
pkgconfig_DATA = \
	lib@name@.pc

#
# binary
#
bin_PROGRAMS = \
	@name@

noinst_HEADERS = \
	internal.h

# this one gets installed to enable others to link against your library
include_HEADERS = \
	lib@name@.h

lib_LTLIBRARIES = \
	lib@namenodash@.la

# TODO remove the not used M4 macro files
EXTRA_DIST = \
	autogen.sh \
	m4/attributes.m4 \
	m4/ptx.m4 \
	m4/ax_armv4_detection.m4 \
	m4/ax_armv5_detection.m4 \
	m4/ax_armv6_detection.m4 \
	m4/ax_armv7_detection.m4 \
	m4/ax_floating_point.m4 \
	m4/ax_code_coverage.m4 \
	m4/pkg.m4 \
	lib@name@.pc.in \
	COPYING

# if "make" has built it, clean only some basic files, but not all
# MOSTLYCLEANFILES =

# clean files "make" has built
CLEANFILES = \
	$(DIST_ARCHIVES)

# clean files "configure" has built
DISTCLEAN = \
	config.log \
	config.status \
	config.h \
	Makefile

# clean all files the maintainer of the package has created
MAINTAINERCLEANFILES = \
	configure \
	configure.scan \
	config.guess \
	config.sub \
	install-sh \
	ltmain.sh \
	config.h.in~ \
	config.h.in \
	missing \
	Makefile.in \
	compile \
	autoscan.log
#
# library
#
lib@namenodash@_la_CPPFLAGS = \
	@CODE_COVERAGE_CPPFLAGS@

lib@namenodash@_la_CFLAGS = \
	@CODE_COVERAGE_CFLAGS@

# lib@namenodash@_la_LIBADD = \
#	$(some_libs)

lib@namenodash@_la_LDFLAGS = \
	@LDFLAGS_NOUNDEFINED@ \
	@CODE_COVERAGE_LDFLAGS@ \
	-version-info $(LT_CURRENT):$(LT_REVISION):$(LT_AGE)

lib@namenodash@_la_SOURCES = \
	lib@name@.c

#
# binary
#
@namenodash@_CPPFLAGS = \
	@CODE_COVERAGE_CPPFLAGS@

@namenodash@_CFLAGS = \
	@CODE_COVERAGE_CFLAGS@

@namenodash@_LDADD = \
	lib@namenodash@.la

@namenodash@_LDFLAGS = \
	@LDFLAGS_NOUNDEFINED@ \
	@CODE_COVERAGE_LDFLAGS@

@namenodash@_SOURCES = \
	@name@.c

ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
