# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#                       Marc Kleine-Budde <kleine-budde@gmx.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_GCCLIBS
PACKAGES += gcclibs
endif

#
# Paths and names
#
# We use the same version as our compiler here
#
GCCLIBS_VERSION		= $(PTXCONF_CROSSCHAIN_CHECK)
GCCLIBS			= gcc-$(call remove_quotes,$(GCCLIBS_VERSION))
GCCLIBS_SUFFIX		= tar.bz2
GCCLIBS_URL		= ftp://ftp.gnu.org/gnu/gcc/$(GCCLIBS)/$(GCCLIBS).$(GCCLIBS_SUFFIX)
GCCLIBS_SOURCE		= $(SRCDIR)/$(GCCLIBS).$(GCCLIBS_SUFFIX)
GCCLIBS_DIR		= $(BUILDDIR)/gcclibs
GCCLIBS_BUILDDIR	= $(BUILDDIR)/gcclibs/$(GCCLIBS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gcclibs_get: $(STATEDIR)/gcclibs.get

gcclibs_get_deps = $(GCCLIBS_SOURCE)

$(STATEDIR)/gcclibs.get: $(gcclibs_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(GCCLIBS))
	touch $@

$(GCCLIBS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GCCLIBS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gcclibs_extract: $(STATEDIR)/gcclibs.extract

gcclibs_extract_deps = $(STATEDIR)/gcclibs.get

$(STATEDIR)/gcclibs.extract: $(gcclibs_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GCCLIBS_DIR))
	@$(call extract, $(GCCLIBS_SOURCE), $(GCCLIBS_DIR))
	@$(call patchin, $(GCCLIBS))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gcclibs_prepare: $(STATEDIR)/gcclibs.prepare

#
# dependencies
#
gcclibs_prepare_deps =  $(STATEDIR)/gcclibs.extract
gcclibs_prepare_deps += $(STATEDIR)/virtual-xchain.install

GCCLIBS_PATH =  PATH=$(CROSS_PATH)
#GCCLIBS_ENV  =  $(CROSS_ENV)

#
# autoconf
#
GCCLIBS_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(GNU_HOST) \
	--target=$(PTXCONF_GNU_TARGET) \
	--prefix=$(PTXCONF_PREFIX) \
	--with-headers=$(CROSS_LIB_DIR)/include \
	--with-local-prefix=$(CROSS_LIB_DIR) \
	--disable-nls \
	--enable-threads=posix \
	--enable-symvers=gnu \
	--enable-__cxa_atexit \
	--enable-languages=c,c++ \
	--enable-shared \
	--enable-c99 \
	--enable-long-long

#
# FIXME: enable only when softfloat activated???? (mkl)
#
ifdef PTXCONF_ARCH_ARM
GCCLIBS_AUTOCONF += --with-float=soft --with-cpu=strongarm
endif


$(STATEDIR)/gcclibs.prepare: $(gcclibs_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GCCLIBS_DIR)/config.cache)
#
# HACK!
#
# - we need this dir for --with-headers option, otherwise configure aborts
# - the --without-headers option causes configure to copy the whole gcc source tree
#   (sutpid buggy behaviour, or user mistake) (mkl)
#
	mkdir -p $(CROSS_LIB_DIR)/include
	cp -av `which $(CROSS_ENV_CC_PROG) | sed s,bin/$(CROSS_ENV_CC_PROG),$(PTXCONF_GNU_TARGET)/include/*,` 


	cd $(GCCLIBS_BUILDDIR) && \
		$(GCCLIBS_PATH) $(GCCLIBS_ENV) \
		./configure $(GCCLIBS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gcclibs_compile: $(STATEDIR)/gcclibs.compile

gcclibs_compile_deps = $(STATEDIR)/gcclibs.prepare

$(STATEDIR)/gcclibs.compile: $(gcclibs_compile_deps)
	@$(call targetinfo, $@)
	cd $(GCCLIBS_BUILDDIR) && $(GCCLIBS_ENV) $(GCCLIBS_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gcclibs_install: $(STATEDIR)/gcclibs.install

$(STATEDIR)/gcclibs.install: $(STATEDIR)/gcclibs.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gcclibs_targetinstall: $(STATEDIR)/gcclibs.targetinstall

gcclibs_targetinstall_deps = $(STATEDIR)/gcclibs.compile

$(STATEDIR)/gcclibs.targetinstall: $(gcclibs_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gcclibs_clean:
	rm -rf $(STATEDIR)/gcclibs.*
	rm -rf $(GCCLIBS_DIR)

# vim: syntax=make
