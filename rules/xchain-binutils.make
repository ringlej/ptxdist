# -*-makefile-*-
# $Id: xchain-binutils.make,v 1.14 2003/12/07 21:42:25 robert Exp $
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_BUILD_CROSSCHAIN
XCHAIN += xchain-binutils
endif

#
# Paths and names 
#
XCHAIN_BINUTILS_VERSION	= $(BINUTILS_VERSION)
XCHAIN_BINUTILS		= $(BINUTILS)
XCHAIN_BINUTILS_SOURCE	= $(BINUTILS_SOURCE)
XCHAIN_BINUTILS_DIR	= $(XCHAIN_BUILDDIR)/$(XCHAIN_BINUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-binutils_get: $(STATEDIR)/xchain-binutils.get

xchain-binutils_get_deps = \
	$(XCHAIN_BINUTILS_SOURCE) \
	$(STATEDIR)/xchain-binutils-patches.get

$(STATEDIR)/xchain-binutils.get: $(xchain-binutils_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/xchain-binutils-patches.get:
	@$(call targetinfo, $@)
	@$(call get_patches, $(XCHAIN_BINUTILS))
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-binutils_extract: $(STATEDIR)/xchain-binutils.extract

$(STATEDIR)/xchain-binutils.extract: $(STATEDIR)/xchain-binutils.get
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_BINUTILS_DIR))
	@$(call extract, $(XCHAIN_BINUTILS_SOURCE), $(XCHAIN_BUILDDIR))
	@$(call patchin, $(BINUTILS), $(XCHAIN_BINUTILS_DIR))
#
# inspired by Erik Andersen's buildroot
#

#
# Enable combreloc, since it is such a nice thing to have...
#
	perl -i -p -e "s,link_info.combreloc = false,link_info.combreloc = true,g;" $(XCHAIN_BINUTILS_DIR)/ld/ldmain.c

#
# Hack binutils to use the correct shared lib loader
#
	cd $(XCHAIN_BINUTILS_DIR) && \
		perl -i -p -e "s,#.*define.*ELF_DYNAMIC_INTERPRETER.*\".*\",#define ELF_DYNAMIC_INTERPRETER \"$(DYNAMIC_LINKER)\",;" \
		`grep -lr "#define ELF_DYNAMIC_INTERPRETER" $(XCHAIN_BINUTILS_DIR)`

#
# Hack binutils to prevent it from searching the host system
# for libraries.  We only want libraries for the target system.
#
	cd $(XCHAIN_BINUTILS_DIR) && \
		perl -i -p -e "s,^NATIVE_LIB_DIRS.*,NATIVE_LIB_DIRS='$(CROSS_LIB_DIR)/usr/lib $(CROSS_LIB_DIR)/lib',;" \
		$(XCHAIN_BINUTILS_DIR)/ld/configure.host
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-binutils_prepare: $(STATEDIR)/xchain-binutils.prepare

XCHAIN_BINUTILS_AUTOCONF = \
	--target=$(PTXCONF_GNU_TARGET) \
	--host=$(GNU_HOST) \
	--build=$(GNU_HOST) \
	--prefix=$(PTXCONF_PREFIX) \
	--enable-targets=$(PTXCONF_GNU_TARGET) \
	--disable-nls \
	--enable-shared \
	--enable-commonbfdlib \
	--enable-install-libiberty \
	--with-sysroot=$(CROSS_LIB_DIR) \
	--with-lib-path="$(CROSS_LIB_DIR)/usr/lib:$(CROSS_LIB_DIR)/lib"

XCHAIN_BINUTILS_ENV	= $(HOSTCC_ENV)

$(STATEDIR)/xchain-binutils.prepare: $(STATEDIR)/xchain-binutils.extract
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_BINUTILS_DIR)/config.cache)
	cd $(XCHAIN_BINUTILS_DIR) && $(XCHAIN_BINUTILS_ENV) \
		./configure $(XCHAIN_BINUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-binutils_compile: $(STATEDIR)/xchain-binutils.compile

$(STATEDIR)/xchain-binutils.compile: $(STATEDIR)/xchain-binutils.prepare 
	@$(call targetinfo, $@)
	make -C $(XCHAIN_BINUTILS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-binutils_install: $(STATEDIR)/xchain-binutils.install

$(STATEDIR)/xchain-binutils.install: $(STATEDIR)/xchain-binutils.compile
	@$(call targetinfo, $@)
	make install -C $(XCHAIN_BINUTILS_DIR)
#
# make short-name links to long-name programms
# e.g.: arm-linux-gcc -> arm-unknown-linux-gnu-gcc
# take care not to make liks in case the short names are identical to 
# the long names
#
	cd $(PTXCONF_PREFIX)/bin &&										\
		for FILE in addr2line ar as ld nm objcompy objdump ranlib readelf size strings strip; do	\
		if [ ! -e $(SHORT_TARGET)-linux-$$FILE ]; then 							\
			ln -sf $(PTXCONF_GNU_TARGET)-$$FILE $(SHORT_TARGET)-linux-$$FILE;			\
		fi;												\
	done

#
# here we convert the static libiberty.a into a
# shared one (.so)
#
	cd $(XCHAIN_BINUTILS_DIR)/libiberty && \
		ld --whole-archive libiberty.a -r -o libiberty-$(XCHAIN_BINUTILS_VERSION).so

	install -m 755 -D $(XCHAIN_BINUTILS_DIR)/libiberty/libiberty-$(XCHAIN_BINUTILS_VERSION).so \
		$(PTXCONF_PREFIX)/$(GNU_HOST)/$(PTXCONF_GNU_TARGET)/lib/libiberty-$(XCHAIN_BINUTILS_VERSION).so
	ln -sf libiberty-$(XCHAIN_BINUTILS_VERSION).so $(PTXCONF_PREFIX)/$(GNU_HOST)/$(PTXCONF_GNU_TARGET)/lib/libiberty.so

#
# ksymoops want's to have libiberty.a, we copy it into the dir where ksymoops
# expects it
#
	install -m 644 -D $(XCHAIN_BINUTILS_DIR)/libiberty/libiberty.a \
		$(PTXCONF_PREFIX)/$(GNU_HOST)/$(PTXCONF_GNU_TARGET)/lib/libiberty.a

	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-binutils_targetinstall: $(STATEDIR)/xchain-binutils.targetinstall

$(STATEDIR)/xchain-binutils.targetinstall: $(STATEDIR)/xchain-binutils.install
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-binutils_clean: 
	rm -rf $(STATEDIR)/xchain-binutils.* $(XCHAIN_BINUTILS_DIR)

# vim: syntax=make
