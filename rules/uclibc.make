# -*-makefile-*-
# $Id: uclibc.make,v 1.2 2003/07/23 12:39:06 mkl Exp $
#
# (c) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_UCLIBC
PACKAGES += uclibc
endif

#
# Paths and names
#
ifdef PTXCONF_UCLIBC_0_9_19
UCLIBC_VERSION			= 0.9.19
endif
ifdef PTXCONF_UCLIBC_0_9_20
UCLIBC_VERSION			= 0.9.20
endif

UCLIBC_SUFFIX			= tar.bz2
UCLIBC				= uClibc-$(UCLIBC_VERSION)
UCLIBC_URL			= http://www.uclibc.org/downloads/$(UCLIBC).$(UCLIBC_SUFFIX)
UCLIBC_SOURCE			= $(SRCDIR)/$(UCLIBC).$(UCLIBC_SUFFIX)
UCLIBC_DIR			= $(BUILDDIR)/$(UCLIBC)

UCLIBC_CRIS_PATCH_SOURCE	= $(SRCDIR)/$(UCLIBC)-mkb1.patch

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
xchain_uclibc_fix_config =				\
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

uclibc_get_deps =  $(UCLIBC_SOURCE)

$(STATEDIR)/uclibc.get: $(uclibc_get_deps)
	@$(call targetinfo, uclibc.get)
	touch $@

$(UCLIBC_SOURCE):
	@$(call targetinfo, $(UCLIBC_SOURCE))
	@$(call get, $(UCLIBC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

uclibc_extract: $(STATEDIR)/uclibc.extract

uclibc_extract_deps = $(STATEDIR)/uclibc.get

$(STATEDIR)/uclibc.extract: $(uclibc_extract_deps)
	@$(call targetinfo, uclibc.extract)
	@$(call clean, $(UCLIBC_DIR))
	@$(call extract, $(UCLIBC_SOURCE))
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
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/uclibc.extract


$(STATEDIR)/uclibc.prepare: $(uclibc_prepare_deps)
	@$(call targetinfo, uclibc.prepare)

	grep -e PTXCONF_UCLIBC_ .config > $(UCLIBC_DIR)/.config
	perl -i -p -e 's/PTXCONF_UCLIBC_//g' $(UCLIBC_DIR)/.config
	@$(call uclibc_fix_config, $(UCLIBC_DIR)/.config)

	$(UCLIBC_PATH) make -C $(UCLIBC_DIR) oldconfig $(UCLIBC_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

uclibc_compile: $(STATEDIR)/uclibc.compile

uclibc_compile_deps =  $(STATEDIR)/uclibc.prepare

$(STATEDIR)/uclibc.compile: $(uclibc_compile_deps)
	@$(call targetinfo, uclibc.compile)
	$(UCLIBC_PATH) make -C $(UCLIBC_DIR) $(UCLIBC_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

uclibc_install: $(STATEDIR)/uclibc.install

$(STATEDIR)/uclibc.install:
	@$(call targetinfo, uclibc.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

uclibc_targetinstall: $(STATEDIR)/uclibc.targetinstall

$(STATEDIR)/uclibc.targetinstall: $(STATEDIR)/uclibc.compile
	@$(call targetinfo, uclibc.targetinstall)
	mkdir -p $(ROOTDIR)/lib

	install $(UCLIBC_DIR)/lib/ld-uClibc-$(UCLIBC_VERSION).so \
		$(ROOTDIR)/lib/ld-uClibc-$(UCLIBC_VERSION).so
	ln -sf ld-uClibc-$(UCLIBC_VERSION).so $(ROOTDIR)/lib/ld-uClibc.so.0

	install $(UCLIBC_DIR)/lib/libuClibc-$(UCLIBC_VERSION).so \
		$(ROOTDIR)/lib/libuClibc-$(UCLIBC_VERSION).so
	ln -sf libuClibc-$(UCLIBC_VERSION).so $(ROOTDIR)/lib/libc.so.0

ifdef PTXCONF_UCLIBC_CRYPT
	install $(UCLIBC_DIR)/lib/libcrypt-$(UCLIBC_VERSION).so \
		$(ROOTDIR)/lib/libcrypt-$(UCLIBC_VERSION).so
	ln -sf libcrypt-$(UCLIBC_VERSION).so $(ROOTDIR)/lib/libcrypt.so.0
endif

ifdef PTXCONF_UCLIBC_DL
	install $(UCLIBC_DIR)/lib/libdl-$(UCLIBC_VERSION).so \
		$(ROOTDIR)/lib/libdl-$(UCLIBC_VERSION).so
	ln -sf libdl-$(UCLIBC_VERSION).so $(ROOTDIR)/lib/libdl.so.0
endif

ifdef PTXCONF_UCLIBC_M
	install $(UCLIBC_DIR)/lib/libm-$(UCLIBC_VERSION).so \
		$(ROOTDIR)/lib/libm-$(UCLIBC_VERSION).so
	ln -sf libm-$(UCLIBC_VERSION).so $(ROOTDIR)/lib/libm.so.0
endif

ifdef PTXCONF_UCLIBC_NSL
	install $(UCLIBC_DIR)/lib/libnsl-$(UCLIBC_VERSION).so \
		$(ROOTDIR)/lib/libnsl-$(UCLIBC_VERSION).so
	ln -sf libnsl-$(UCLIBC_VERSION).so $(ROOTDIR)/lib/libnsl.so.0
endif

ifdef PTXCONF_UCLIBC_PTHREAD
	install $(UCLIBC_DIR)/lib/libpthread-$(UCLIBC_VERSION).so \
		$(ROOTDIR)/lib/libpthread-$(UCLIBC_VERSION).so
	ln -sf libpthread-$(UCLIBC_VERSION).so $(ROOTDIR)/lib/libpthread.so.0
endif

ifdef PTXCONF_UCLIBC_RESOLV
	install $(UCLIBC_DIR)/lib/libresolv-$(UCLIBC_VERSION).so \
		$(ROOTDIR)/lib/libresolv-$(UCLIBC_VERSION).so
	ln -sf libresolv-$(UCLIBC_VERSION).so $(ROOTDIR)/lib/libresolv.so.0
endif

ifdef PTXCONF_UCLIBC_UTIL
	install $(UCLIBC_DIR)/lib/libutil-$(UCLIBC_VERSION).so \
		$(ROOTDIR)/lib/libutil-$(UCLIBC_VERSION).so
	ln -sf libutil-$(UCLIBC_VERSION).so $(ROOTDIR)/lib/libutil.so.0
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

uclibc_clean: 
	-rm -rf $(STATEDIR)/uclibc*
	-rm -rf $(UCLIBC_DIR)

# vim: syntax=make
