# -*-makefile-*-
# $Id: native-gcc.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifneq ($(HOST_GCC_OK),yes)
NATIVE			+= native-gcc
NATIVE_CC		=  gcc-$(NATIVE_GCC_VERSION)
NATIVE_CXX		=  g++-$(NATIVE_GCC_VERSION)
else
NATIVE_CC		=  $(HOSTCC)
NATIVE_CXX		=  $(HOSTCC)
endif

#
# Paths and names 
#
NATIVE_GCC_VERSION	= 3.2.3
NATIVE_GCC		= gcc-$(NATIVE_GCC_VERSION)
NATIVE_GCC_SUFFIX	= tar.gz
NATIVE_GCC_URL		= ftp://ftp.gnu.org/pub/gnu/gcc/$(NATIVE_GCC).$(NATIVE_GCC_SUFFIX)
NATIVE_GCC_SOURCE	= $(SRCDIR)/$(NATIVE_GCC).$(NATIVE_GCC_SUFFIX)
NATIVE_GCC_DIR		= $(NATIVE_BUILDDIR)/$(NATIVE_GCC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

native-gcc_get: $(STATEDIR)/native-gcc.get

native-gcc_get_deps = \
	$(NATIVE_GCC_SOURCE) \
	$(STATEDIR)/native-gcc-patches.get

$(STATEDIR)/native-gcc.get: $(native-gcc_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/native-gcc-patches.get:
	@$(call targetinfo, $@)
	@$(call get_patches, $(NATIVE_GCC))
	touch $@

ifneq ($(GCC_VERSION),$(NATIVE_GCC_VERSION))
$(NATIVE_GCC_SOURCE): 
	@$(call targetinfo, $@)
	@$(call get, $(NATIVE_GCC_URL))
endif

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

native-gcc_extract: $(STATEDIR)/native-gcc.extract

native-gcc_extract_deps = $(STATEDIR)/native-gcc.get

$(STATEDIR)/native-gcc.extract: $(native-gcc_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(NATIVE_GCC_DIR))
	@$(call extract, $(NATIVE_GCC_SOURCE), $(NATIVE_BUILDDIR))
	@$(call patchin, $(NATIVE_GCC), $(NATIVE_GCC_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

native-gcc_prepare: $(STATEDIR)/native-gcc.prepare

native-gcc_prepare_deps = \
	$(STATEDIR)/native-gcc.extract

NATIVE_GCC_PATH	= PATH=$(NATIVE_PATH)
NATIVE_GCC_ENV	= CC=$(HOSTCC)

NATIVE_GCC_AUTOCONF = \
	--prefix=$(PTXCONF_PREFIX)/$(NATIVE_GCC) \
	--program-suffix=-$(NATIVE_GCC_VERSION) \
	--disable-nls \
	--disable-multilib \
	--enable-threads \
	--enable-shared \
	--enable-languages=c \
	--enable-symvers=gnu \
	--enable-target-optspace \
	--enable-version-specific-runtime-libs \
	--enable-c99 \
	--enable-long-long \
	--enable-__cxa_atexit

$(STATEDIR)/native-gcc.prepare: $(native-gcc_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(NATIVE_GCC_DIR)/config.cache)

	cd $(NATIVE_GCC_DIR) && \
		$(NATIVE_GCC_PATH) $(NATIVE_GCC_ENV) \
		./configure $(NATIVE_GCC_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

native-gcc_compile: $(STATEDIR)/native-gcc.compile

$(STATEDIR)/native-gcc.compile: $(STATEDIR)/native-gcc.prepare
	@$(call targetinfo, $@)
	$(NATIVE_GCC_PATH) make -C $(NATIVE_GCC_DIR) all-gcc
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

native-gcc_install: $(STATEDIR)/native-gcc.install

$(STATEDIR)/native-gcc.install: $(STATEDIR)/native-gcc.compile
	@$(call targetinfo, $@)
	$(NATIVE_GCC_PATH) make -C $(NATIVE_GCC_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

native-gcc_targetinstall: $(STATEDIR)/native-gcc.targetinstall

$(STATEDIR)/native-gcc.targetinstall:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

native-gcc_clean:
	rm -fr $(NATIVE_GCC_DIR)
	rm -fr $(STATEDIR)/native-gcc.*
	rm -fr $(NATIVE_GCC_DIR)

# vim: syntax=make
