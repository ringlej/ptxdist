# -*-makefile-*-
# $Id: xchain-glibc.make,v 1.20 2003/11/24 01:08:09 mkl Exp $
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
# ifdef PTXCONF_GLIBC
# XCHAIN += xchain-glibc
# endif

XCHAIN_GLIBC_BUILDDIR	= $(BUILDDIR)/xchain-$(GLIBC)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-glibc_get: $(STATEDIR)/xchain-glibc.get

xchain-glibc_get_deps = \
	$(glibc_get_deps)

$(STATEDIR)/xchain-glibc.get: $(xchain-glibc_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-glibc_extract:	$(STATEDIR)/xchain-glibc.extract

$(STATEDIR)/xchain-glibc.extract: $(glibc_extract_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-glibc_prepare:	$(STATEDIR)/xchain-glibc.prepare

xchain-glibc_prepare_deps = \
	$(STATEDIR)/xchain-binutils.install \
	$(STATEDIR)/xchain-glibc.extract

XCHAIN_GLIBC_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--with-header=$(CROSS_LIB_DIR)/include \
	--without-cvs \
	--disable-sanity-checks \
	--enable-hacker-mode

XCHAIN_GLIBC_ENV	=  CC=$(HOSTCC)

$(STATEDIR)/xchain-glibc.prepare: $(xchain-glibc_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_GLIBC_BUILDDIR))
	mkdir -p $(XCHAIN_GLIBC_BUILDDIR)
	cd $(XCHAIN_GLIBC_BUILDDIR) && \
	        $(XCHAIN_GLIBC_PATH) $(XCHAIN_GLIBC_ENV) \
		$(GLIBC_DIR)/configure $(XCHAIN_GLIBC_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-glibc_compile:	$(STATEDIR)/xchain-glibc.compile

$(STATEDIR)/xchain-glibc.compile: $(STATEDIR)/xchain-glibc.prepare
	@$(call targetinfo, $@)
#
# Dan Kegel writes:
#
# glibc-2.3.x passes cross options to $(CC) when generating
# errlist-compat.c, which fails without a real cross-compiler.
# Fortunately, we don't need errlist-compat.c, since we just need .h
# files, so work around this by creating a fake errlist-compat.c and
# satisfying its dependencies. Another workaround might be to tell
# configure to not use any cross options to $(CC). The real fix would
# be to get install-headers to not generate errlist-compat.c.
#
# Robert Schwebel writes:
#
# Is this necessary? The lines below are commented out but it seems 
# to compile anyway...
#
# Marc Kleine-Budde has also something to say:
#
# This is definitely needed by x86 -> ppc
#
	$(XCHAIN_GLIBC_PATH) make -C $(XCHAIN_GLIBC_BUILDDIR) sysdeps/gnu/errlist.c
	mkdir -p $(XCHAIN_GLIBC_BUILDDIR)/stdio-common
	touch $(XCHAIN_GLIBC_BUILDDIR)/stdio-common/errlist-compat.c
	touch $@
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-glibc_install:	$(STATEDIR)/xchain-glibc.install

$(STATEDIR)/xchain-glibc.install: $(STATEDIR)/xchain-glibc.compile
	@$(call targetinfo, $@)

	$(XCHAIN_GLIBC_PATH) make -C $(XCHAIN_GLIBC_BUILDDIR) \
		cross-compiling=yes install_root=$(CROSS_LIB_DIR) prefix="" \
		install-headers
#
# Dan Kegel says:
# 
# Two headers -- stubs.h and features.h -- aren't installed by
# install-headers, so do them by hand.  We can tolerate an empty
# stubs.h for the moment.  See
# e.g. http://gcc.gnu.org/ml/gcc/2002-01/msg00900.html
#
	mkdir -p $(CROSS_LIB_DIR)/include/gnu
	touch $(CROSS_LIB_DIR)/include/gnu/stubs.h
	install -m 644 $(GLIBC_DIR)/include/features.h \
		$(CROSS_LIB_DIR)/include/features.h

	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-glibc_targetinstall:	$(STATEDIR)/xchain-glibc.targetinstall

$(STATEDIR)/xchain-glibc.targetinstall: $(STATEDIR)/xchain-glibc.install
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-glibc_clean:
	-rm -rf $(STATEDIR)/xchain-glibc*
	-rm -rf $(XCHAIN_GLIBC_BUILDDIR)
# vim: syntax=make
