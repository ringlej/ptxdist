# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003, 2004 by Marc Kleine-Budde <kleine-budde@gmx.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_UCLIBC
ifdef PTXCONF_LIBC
PACKAGES	+= uclibc
endif
DYNAMIC_LINKER	=  /lib/ld-uClibc.so.0
endif

#
# Paths and names
#
UCLIBC_SUFFIX			= tar.bz2
UCLIBC				= uClibc-$(UCLIBC_VERSION)
UCLIBC_URL			= http://www.uclibc.org/downloads/$(UCLIBC).$(UCLIBC_SUFFIX)
UCLIBC_SOURCE			= $(SRCDIR)/$(UCLIBC).$(UCLIBC_SUFFIX)
UCLIBC_DIR			= $(BUILDDIR)/$(UCLIBC)

#
# uClibc config file fixup
#
# for uClibc that gets installed on target
#
uclibc_fix_config =					\
	@$(call uclibc_fix_config_general, $(1))

#
#
# uClibc config file fixup
#
# for uClibc that is used for the xchain
#
xchain-uclibc_fix_config =				\
	@$(call uclibc_fix_config_general, $(1))

#
#
#
uclibc_fix_config_general =							\
	echo 'KERNEL_SOURCE="$(XCHAIN_KERNEL_BUILDDIR)"'	>> $(1);	\
	echo 'SHARED_LIB_LOADER_PREFIX="/lib"'			>> $(1);	\
	echo 'RUNTIME_PREFIX="/"'				>> $(1);	\
	echo 'DEVEL_PREFIX="$(CROSS_LIB_DIR)"'			>> $(1);	\
	perl -i -p -e 's/^(.*=)"(.*?)"(.*)"(.*)"/$$1"$$2$$3$$4"/'  $(1);	\
	perl -i -p -e 's/^(.*=)"(.*?)"(.*)/$$1"$$2$$3"/'           $(1)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

uclibc_get: $(STATEDIR)/uclibc.get

uclibc_get_deps = $(UCLIBC_SOURCE)

$(STATEDIR)/uclibc.get: $(uclibc_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(UCLIBC))
	touch $@

$(UCLIBC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(UCLIBC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

uclibc_extract: $(STATEDIR)/uclibc.extract

uclibc_extract_deps = $(STATEDIR)/uclibc.get

$(STATEDIR)/uclibc.extract: $(uclibc_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(UCLIBC_DIR))
	@$(call extract, $(UCLIBC_SOURCE))
	@$(call patchin, $(UCLIBC))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

uclibc_prepare: $(STATEDIR)/uclibc.prepare

UCLIBC_PATH	= PATH=$(CROSS_PATH)
UCLIBC_MAKEVARS	= CROSS=$(COMPILER_PREFIX) HOSTCC=$(HOSTCC)

#
# dependencies
#
uclibc_prepare_deps =  $(STATEDIR)/uclibc.extract
uclibc_prepare_deps += $(STATEDIR)/xchain-kernel.install

$(STATEDIR)/uclibc.prepare: $(uclibc_prepare_deps)
	@$(call targetinfo, $@)

	grep -e PTXCONF_UC_ .config > $(UCLIBC_DIR)/.config
	perl -i -p -e 's/PTXCONF_UC_//g' $(UCLIBC_DIR)/.config
	@$(call uclibc_fix_config, $(UCLIBC_DIR)/.config)

	yes "" | $(UCLIBC_PATH) $(MAKE) -C $(UCLIBC_DIR) \
		$(UCLIBC_MAKEVARS) \
		oldconfig
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

uclibc_compile: $(STATEDIR)/uclibc.compile

uclibc_compile_deps = $(STATEDIR)/uclibc.prepare

$(STATEDIR)/uclibc.compile: $(uclibc_compile_deps)
	@$(call targetinfo, $@)
#	uClibc does not work with PARALLELMFLAGS
	$(UCLIBC_PATH) $(MAKE) -C $(UCLIBC_DIR) $(UCLIBC_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

uclibc_install: $(STATEDIR)/uclibc.install

$(STATEDIR)/uclibc.install: $(STATEDIR)/uclibc.compile
	@$(call targetinfo, $@)
	$(UCLIBC_PATH) $(MAKE) -C  $(UCLIBC_DIR) \
		$(UCLIBC_MAKEVARS) \
		install_dev

	$(UCLIBC_PATH) $(MAKE) -C  $(UCLIBC_DIR) \
		$(UCLIBC_MAKEVARS) PREFIX=$(CROSS_LIB_DIR) \
		install_runtime
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

uclibc_targetinstall: $(STATEDIR)/uclibc.targetinstall

uclibc_targetinstall_deps = $(STATEDIR)/uclibc.install

$(STATEDIR)/uclibc.targetinstall: $(uclibc_targetinstall_deps)
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/lib

	cp -d $(CROSS_LIB_DIR)/lib/ld-uClibc[-.]*so* $(ROOTDIR)/lib/

	cp -d $(CROSS_LIB_DIR)/lib/libuClibc[-.]*so* $(ROOTDIR)/lib/
	cd $(CROSS_LIB_DIR)/lib && \
		ln -sf libuClibc-*.so $(ROOTDIR)/lib/libc.so
	cd $(CROSS_LIB_DIR)/lib && \
		ln -sf libuClibc-*.so $(ROOTDIR)/lib/libc.so.0

ifdef PTXCONF_UCLIBC_CRYPT
	cp -d $(CROSS_LIB_DIR)/lib/libcrypt[-.]*so* $(ROOTDIR)/lib/
endif

ifdef PTXCONF_UCLIBC_DL
	cp -d $(CROSS_LIB_DIR)/lib/libdl[-.]*so* $(ROOTDIR)/lib/
endif

ifdef PTXCONF_UCLIBC_M
	cp -d $(CROSS_LIB_DIR)/lib/libm[-.]*so* $(ROOTDIR)/lib/
endif

ifdef PTXCONF_UCLIBC_NSL
	cp -d $(CROSS_LIB_DIR)/lib/libnsl[-.]*so* $(ROOTDIR)/lib/
endif

ifdef PTXCONF_UCLIBC_PTHREAD
	cp -d $(CROSS_LIB_DIR)/lib/libpthread[-.]*so* $(ROOTDIR)/lib/
endif

ifdef PTXCONF_UCLIBC_RESOLV
	cp -d $(CROSS_LIB_DIR)/lib/libresolv[-.]*so* $(ROOTDIR)/lib/
endif

ifdef PTXCONF_UCLIBC_UTIL
	cp -d $(CROSS_LIB_DIR)/lib/libutil[-.]*so* $(ROOTDIR)/lib/
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

uclibc_clean: 
	-rm -rf $(STATEDIR)/uclibc*
	-rm -rf $(UCLIBC_DIR)

# vim: syntax=make
