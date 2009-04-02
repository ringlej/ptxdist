# -*-makefile-*-
# $Id$
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON30) += host-python30

#
# Paths and names
#
HOST_PYTHON30_DIR	= $(HOST_BUILDDIR)/$(PYTHON30)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python30.get: $(STATEDIR)/python30.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python30.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_PYTHON30_DIR))
	@$(call extract, PYTHON30, $(HOST_BUILDDIR))
	@$(call patchin, PYTHON30, $(HOST_PYTHON30_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON30_PATH	:= PATH=$(HOST_PATH)
HOST_PYTHON30_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_PYTHON30_AUTOCONF	:= \
	$(HOST_AUTOCONF) \
	--enable-shared \
	--disable-profiling \
	--with-suffix="" \
	--without-pydebug \
	--without-system-ffi \
	--without-signal-module \
	--with-doc-strings \
	--with-pymalloc \
	--without-wctype-functions \
	--without-fpectl \
	--disable-ipv6

#ifdef PTXCONF_PYTHON30__IPV6
#HOST_PYTHON30_AUTOCONF += --enable-ipv6
#else
#HOST_PYTHON30_AUTOCONF += --disable-ipv6
#endif
#ifdef PTXCONF_ARCH_X86
#HOST_PYTHON30_AUTOCONF += --with-tsc
#else
#HOST_PYTHON30_AUTOCONF += --without-tsc
#endif

$(STATEDIR)/host-python30.prepare:
	@$(call targetinfo)
	@$(call clean, $(HOST_PYTHON30_DIR)/config.cache)
	cd $(HOST_PYTHON30_DIR) && \
		$(HOST_PYTHON30_PATH) $(HOST_PYTHON30_ENV) \
		./configure $(HOST_PYTHON30_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python30.compile:
	@$(call targetinfo)
	cd $(HOST_PYTHON30_DIR) && $(HOST_PYTHON30_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python30.install:
	@$(call targetinfo)
	@$(call install, HOST_PYTHON30,,h)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-python30_clean:
	rm -rf $(STATEDIR)/host-python30.*
	rm -rf $(HOST_PYTHON30_DIR)

# vim: syntax=make
