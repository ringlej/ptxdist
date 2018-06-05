if BUILD_SILENTLY
AM_MAKEFLAGS = --no-print-directory
endif

#
# binary
#
bin_PROGRAMS = \
	@name@

noinst_HEADERS = \
	internal.h

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
	m4/ax_am_jobserver.m4 \
	m4/ax_code_coverage.m4 \
	m4/pkg.m4 \
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

@namenodash@_CPPFLAGS = \
	@CODE_COVERAGE_CPPFLAGS@

@namenodash@_CFLAGS = \
	@CODE_COVERAGE_CFLAGS@

# @namenodash@_LIBADD = \
#	$(some_libs)

@namenodash@_LDFLAGS = \
	@LDFLAGS_NOUNDEFINED@ \
	@CODE_COVERAGE_LDFLAGS@

@namenodash@_SOURCES = \
	@name@.c

ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
