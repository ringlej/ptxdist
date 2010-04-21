bin_PROGRAMS = \
	@name@

lib_LTLIBRARIES = \
	lib@name@.la

AM_CPPFLAGS = \
	-I$(top_srcdir)/include \
	-I$(top_builddir)/include
#	$(some_CFLAGS)

EXTRA_DIST = \
	autogen.sh

MAINTAINERCLEANFILES = \
	configure \
	aclocal.m4 \
	Makefile.in

#
# library
#
lib@namenodash@_la_SOURCES = \
	lib@name@.c

#
# binary
#
@namenodash@_SOURCES = \
	@name@.c

#@namenodash@_LDADD = \
#	$(some_LIBS)

