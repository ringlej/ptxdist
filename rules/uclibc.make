# -*-makefile-*-
# $Id: uclibc.make,v 1.5 2003/11/17 03:36:57 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
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
ifdef PTXCONF_BUILD_CROSSCHAIN
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
# FIXME: enable widechar support for c++
xchain-uclibc_fix_config =				\
	@$(call uclibc_fix_config_general, $(1))

#
#
#
uclibc_fix_config_general =								\
	perl -i -p -e 's,^(KERNEL_SOURCE=).*,$$1\"$(XCHAIN_KERNEL_BUILDDIR)\",' $(1);	\
	perl -i -p -e 's,^(SHARED_LIB_LOADER_PATH=).*,$$1"/lib",' $(1);			\
	perl -i -p -e 's,^(DEVEL_PREFIX=).*,$$1$(CROSS_LIB_DIR),' $(1);			\
	perl -i -p -e 's,^(SYSTEM_DEVEL_PREFIX=).*,$$1$(PTXCONF_PREFIX),' $(1);		\
	perl -i -p -e 's,^(DEVEL_TOOL_PREFIX=).*,$$1"\$$(DEVEL_PREFIX)",' $(1);		\
	perl -i -p -e 's/^(.*=)"(.*?)"(.*)"(.*)"/$$1"$$2$$3$$4"/' $(1);			\
	perl -i -p -e 's/^(.*=)"(.*?)"(.*)/$$1"$$2$$3"/' $(1)

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
UCLIBC_MAKEVARS	= CROSS=$(PTXCONF_GNU_TARGET)- HOSTCC=$(HOSTCC)

#
# dependencies
#
uclibc_prepare_deps = \
	$(STATEDIR)/xchain-gccstage1.install \
	$(STATEDIR)/uclibc.extract

$(STATEDIR)/uclibc.prepare: $(uclibc_prepare_deps)
	@$(call targetinfo, $@)

	grep -e PTXCONF_UCLIBC_ .config > $(UCLIBC_DIR)/.config
	perl -i -p -e 's/PTXCONF_UCLIBC_//g' $(UCLIBC_DIR)/.config
	@$(call uclibc_fix_config, $(UCLIBC_DIR)/.config)

	$(UCLIBC_PATH) make -C $(UCLIBC_DIR) \
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
	$(UCLIBC_PATH) make -C $(UCLIBC_DIR) $(UCLIBC_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

uclibc_install: $(STATEDIR)/uclibc.install

$(STATEDIR)/uclibc.install: $(STATEDIR)/uclibc.compile
	@$(call targetinfo, $@)
	$(UCLIBC_PATH) make -C  $(UCLIBC_DIR) \
		$(UCLIBC_MAKEVARS) TARGET_ARCH=$(SHORT_TARGET) \
		install_dev install_runtime install_utils
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

uclibc_targetinstall: $(STATEDIR)/uclibc.targetinstall

ifdef PTXCONF_BUILD_CROSSCHAIN
uclibc_targetinstall_deps = $(STATEDIR)/uclibc.install
endif

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
