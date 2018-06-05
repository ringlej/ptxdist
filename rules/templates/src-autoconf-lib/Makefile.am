if BUILD_SILENTLY
AM_MAKEFLAGS = --no-print-directory
endif

# TODO add more subdirs to visit on demand
# SUBDIR =

# pkg's stuff
pkgconfig_DATA = \
	lib@name@.pc

# this one gets not installed, only internally used
noinst_HEADERS = \
	internal.h

# this one gets installed to enable others to link against your library
include_HEADERS = \
	lib@name@.h

#
# What is to build here
#
lib_LTLIBRARIES = \
	lib@name@.la

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
	libtool \
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
	missing \
	depcomp \
	config.h.in \
	Makefile.in \
	aclocal.m4 \
	m4/libtool.m4 \
	m4/ltoptions.m4 \
	m4/ltsugar.m4 \
	m4/ltversion.m4 \
	m4/lt~obsolete.m4 \
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
	@name@.c

ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
