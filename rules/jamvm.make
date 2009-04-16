# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
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
JAMVM_VERSION	:= 1.5.2
JAMVM		:= jamvm-$(JAMVM_VERSION)
JAMVM_SUFFIX	:= tgz
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
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/jamvm.extract:
	@$(call targetinfo)
	@$(call clean, $(JAMVM_DIR))
	@$(call extract, JAMVM)
	@$(call patchin, JAMVM)
	@$(call touch)

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
	--disable-tracegc \
	--disable-tracealloc \
	--disable-tracefnlz \
	--disable-tracedll \
	--disable-tracelock \
	--disable-tracethread \
	--disable-tracecompact \
	--disable-tracedirect \
	--disable-traceinlining \
	--disable-trace \
	--enable-int-threading \
	--enable-int-direct \
	--enable-int-caching \
	--disable-int-prefetch \
	--enable-runtime-reloc-checks \
	--disable-int-inlining \
	--enable-zip \
	--enable-fast-install \
	--with-classpath-install-dir=/usr/classpath

ifdef PTXCONF_JAMVM_USE_LIBFFI
JAMVM_AUTOCONF += --enable-ffi
else
JAMVM_AUTOCONF += --disable-ffi
endif

# FIXME:
# - --enable-int-caching should be disabled on x86_64
# - --enable-int-prefetch should be enabled on powerpc
# - --enable-int-inlining should be enabled on x86_64, i386 and powerpc

$(STATEDIR)/jamvm.prepare:
	@$(call targetinfo)
	@$(call clean, $(JAMVM_DIR)/config.cache)
	cd $(JAMVM_DIR) && \
		$(JAMVM_PATH) $(JAMVM_ENV) \
		./configure $(JAMVM_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/jamvm.compile:
	@$(call targetinfo)
	cd $(JAMVM_DIR) && $(JAMVM_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jamvm.install:
	@$(call targetinfo)
	@$(call install, JAMVM)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jamvm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, jamvm)
	@$(call install_fixup, jamvm,PACKAGE,jamvm)
	@$(call install_fixup, jamvm,PRIORITY,optional)
	@$(call install_fixup, jamvm,VERSION,$(JAMVM_VERSION))
	@$(call install_fixup, jamvm,SECTION,base)
	@$(call install_fixup, jamvm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, jamvm,DEPENDS,)
	@$(call install_fixup, jamvm,DESCRIPTION,missing)

	@$(call install_copy, jamvm, 0, 0, 0755, -, /usr/bin/jamvm)
	@$(call install_copy, jamvm, 0, 0, 0644, -, /usr/share/jamvm/classes.zip)
	@$(call install_copy, jamvm, 0, 0, 0644, -, /usr/lib/libjvm.so.0.0.0)
	@$(call install_link, jamvm, libjvm.so.0.0.0, /usr/lib/libjvm.so.0)
	@$(call install_link, jamvm, libjvm.so.0.0.0, /usr/lib/libjvm.so)
	# FIXME: /usr/lib/rt.jar

	@$(call install_finish, jamvm)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

jamvm_clean:
	rm -rf $(STATEDIR)/jamvm.*
	rm -rf $(PKGDIR)/jamvm_*
	rm -rf $(JAMVM_DIR)

# vim: syntax=make
