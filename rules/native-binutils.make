# -*-makefile-*-
# $Id: native-binutils.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifneq ($(HOST_BINUTILS_OK),yes)
NATIVE			+= native-binutils
endif

#
# Paths and names 
#
NATIVE_BINUTILS_VERSION	= 2.13.2.1
NATIVE_BINUTILS		= binutils-$(NATIVE_BINUTILS_VERSION)
NATIVE_BINUTILS_SUFFIX	= tar.gz
NATIVE_BINUTILS_URL	= ftp://ftp.gnu.org/pub/gnu/binutils/$(NATIVE_BINUTILS).$(NATIVE_BINUTILS_SUFFIX)
NATIVE_BINUTILS_SOURCE	= $(SRCDIR)/$(NATIVE_BINUTILS).$(NATIVE_BINUTILS_SUFFIX)
NATIVE_BINUTILS_DIR	= $(NATIVE_BUILDDIR)/$(NATIVE_BINUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

native-binutils_get: $(STATEDIR)/native-binutils.get

native-binutils_get_deps = \
	$(NATIVE_BINUTILS_SOURCE) \
	$(STATEDIR)/native-binutils-patches.get

$(STATEDIR)/native-binutils.get: $(native-binutils_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/native-binutils-patches.get:
	@$(call targetinfo, $@)
	@$(call get_patches, $(NATIVE_BINUTILS))
	touch $@

ifneq ($(BINUTILS_VERSION),$(NATIVE_BINUTILS_VERSION))
$(NATIVE_BINUTILS_SOURCE): 
	@$(call targetinfo, $@)
	@$(call get, $(NATIVE_BINUTILS_URL))
endif


# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

native-binutils_extract: $(STATEDIR)/native-binutils.extract

$(STATEDIR)/native-binutils.extract: $(STATEDIR)/native-binutils.get
	@$(call targetinfo, $@)
	@$(call clean, $(NATIVE_BINUTILS_DIR))
	@$(call extract, $(NATIVE_BINUTILS_SOURCE), $(NATIVE_BUILDDIR))
	@$(call patchin, $(NATIVE_BINUTILS), $(NATIVE_BINUTILS_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

native-binutils_prepare: $(STATEDIR)/native-binutils.prepare

NATIVE_NATIVE_BINUTILS_AUTOCONF = \
	--prefix=$(PTXCONF_PREFIX)/$(NATIVE_BINUTILS) \
	--disable-nls \
	--enable-shared \
	--enable-commonbfdlib \
	--enable-install-libiberty

NATIVE_NATIVE_BINUTILS_ENV	= CC=$(HOSTCC)

$(STATEDIR)/native-binutils.prepare: $(STATEDIR)/native-binutils.extract
	@$(call targetinfo, $@)
	@$(call clean, $(NATIVE_BINUTILS_DIR)/config.cache)
	cd $(NATIVE_BINUTILS_DIR) && $(NATIVE_NATIVE_BINUTILS_ENV) \
		./configure $(NATIVE_NATIVE_BINUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

native-binutils_compile: $(STATEDIR)/native-binutils.compile

$(STATEDIR)/native-binutils.compile: $(STATEDIR)/native-binutils.prepare 
	@$(call targetinfo, $@)
	make -C $(NATIVE_BINUTILS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

native-binutils_install: $(STATEDIR)/native-binutils.install

$(STATEDIR)/native-binutils.install: $(STATEDIR)/native-binutils.compile
	@$(call targetinfo, $@)
	make -C $(NATIVE_BINUTILS_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

native-binutils_targetinstall: $(STATEDIR)/native-binutils.targetinstall

$(STATEDIR)/native-binutils.targetinstall: $(STATEDIR)/native-binutils.install
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

native-binutils_clean: 
	rm -rf $(STATEDIR)/native-binutils.* $(NATIVE_BINUTILS_DIR)

# vim: syntax=make
