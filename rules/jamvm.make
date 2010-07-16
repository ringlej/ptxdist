# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JAMVM) += jamvm

#
# Paths and names
#
JAMVM_VERSION	:= 1.5.3
JAMVM		:= jamvm-$(JAMVM_VERSION)
JAMVM_SUFFIX	:= tar.gz
JAMVM_URL	:= $(PTXCONF_SETUP_SFMIRROR)/jamvm/$(JAMVM).$(JAMVM_SUFFIX)
JAMVM_SOURCE	:= $(SRCDIR)/$(JAMVM).$(JAMVM_SUFFIX)
JAMVM_DIR	:= $(BUILDDIR)/$(JAMVM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(JAMVM_SOURCE):
	@$(call targetinfo)
	@$(call get, JAMVM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

JAMVM_PATH	:= PATH=$(CROSS_PATH)
JAMVM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
JAMVM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-int-threading \
	--enable-int-direct \
	--enable-int-caching \
	--disable-int-prefetch \
	--enable-runtime-reloc-checks \
	--disable-int-inlining \
	--enable-zip \
	--enable-fast-install \
	--with-classpath-install-dir=/usr

ifdef PTXCONF_JAMVM_USE_LIBFFI
JAMVM_AUTOCONF += --enable-ffi
else
JAMVM_AUTOCONF += --disable-ffi
endif

ifndef PTXCONF_JAMVM_TRACE
JAMVM_AUTOCONF += --disable-trace
endif

ifdef PTXCONF_JAMVM_TRACE_ALL
JAMVM_AUTOCONF += --enable-trace
endif

ifdef PTXCONF_JAMVM_TRACE_GC
JAMVM_AUTOCONF += --enable-tracegc
endif

ifdef PTXCONF_JAMVM_TRACE_ALLOC
JAMVM_AUTOCONF += --enable-tracealloc
endif

ifdef PTXCONF_JAMVM_TRACE_FNLZ
JAMVM_AUTOCONF += --enable-tracefnlz
endif

ifdef PTXCONF_JAMVM_TRACE_DLL
JAMVM_AUTOCONF += --enable-tracedll
endif

ifdef PTXCONF_JAMVM_TRACE_LOCK
JAMVM_AUTOCONF += --enable-tracelock
endif

ifdef PTXCONF_JAMVM_TRACE_THREAD
JAMVM_AUTOCONF += --enable-tracethread
endif

ifdef PTXCONF_JAMVM_TRACE_DIRECT
JAMVM_AUTOCONF += --enable-tracedirect
endif

ifdef PTXCONF_JAMVM_TRACE_INLINING
JAMVM_AUTOCONF += --enable-traceinlining
endif

# FIXME:
# - --enable-int-caching should be disabled on x86_64
# - --enable-int-prefetch should be enabled on powerpc
# - --enable-int-inlining should be enabled on x86_64, i386 and powerpc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jamvm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, jamvm)
	@$(call install_fixup, jamvm,PRIORITY,optional)
	@$(call install_fixup, jamvm,SECTION,base)
	@$(call install_fixup, jamvm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, jamvm,DESCRIPTION,missing)

	@$(call install_copy, jamvm, 0, 0, 0755, -, /usr/bin/jamvm)
	@$(call install_copy, jamvm, 0, 0, 0644, -, /usr/share/jamvm/classes.zip)

	@$(call install_copy, jamvm, 0, 0, 0644, -, /usr/lib/libjvm.so.0.0.0)
	@$(call install_link, jamvm, libjvm.so.0.0.0, /usr/lib/libjvm.so.0)
	@$(call install_link, jamvm, libjvm.so.0.0.0, /usr/lib/libjvm.so)

	@$(call install_finish, jamvm)

	@$(call touch)

# vim: syntax=make
