# -*-makefile-*-
# $Id: xchain-binutils.make,v 1.8 2003/09/18 00:42:49 mkl Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

ifdef PTXCONF_BUILD_CROSSCHAIN
XCHAIN += xchain-binutils
endif

#
# Paths and names 
#
XBINUTILS		= binutils-2.13.2.1
XBINUTILS_URL		= ftp://ftp.gnu.org/pub/gnu/binutils/$(XBINUTILS).tar.gz
XBINUTILS_SOURCE	= $(SRCDIR)/$(XBINUTILS).tar.gz
XBINUTILS_DIR		= $(BUILDDIR)/xchain-$(XBINUTILS)
ifdef PTXCONF_ARCH_NOMMU
XBINUTILS		= binutils-2.10
XBINUTILS_URL		= ftp://ftp.gnu.org/pub/gnu/binutils/$(XBINUTILS).tar.gz
endif
# ifdef PTXCONF_ARCH_MIPS
# XBINUTILS		= binutils-2.14.90.0.4
# XBINUTILS_URL		= ftp://ftp.de.kernel.org/pub/linux/devel/binutils/$(XBINUTILS).tar.gz
# endif
# ifdef PTXCONF_ARCH_PARISC
# XBINUTILS		= binutils-2.14.90.0.4
# XBINUTILS_URL		= ftp://ftp.de.kernel.org/pub/linux/devel/binutils/$(XBINUTILS).tar.gz
# endif

XBINUTILS_NOMMU_PATCH		= binutils-2.10-full.patch
XBINUTILS_NOMMU_PATCH_URL	= http://www.uclinux.org/pub/uClinux/m68k-elf-tools/tools-20030314/$(XBINUTILS_NOMMU_PATCH)
XBINUTILS_NOMMU_PATCH_SOURCE	= $(SRCDIR)/$(XBINUTILS_NOMMU_PATCH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-binutils_get: $(STATEDIR)/xchain-binutils.get

binutils_get_deps =  $(XBINUTILS_SOURCE)
ifdef PTXCONF_ARCH_ARM_NOMMU
binutils_get_deps += $(XBINUTILS_NOMMU_PATCH_SOURCE)
endif

$(STATEDIR)/xchain-binutils.get: $(binutils_get_deps)
	@$(call targetinfo, xchain-binutils.get)
	touch $@

$(XBINUTILS_SOURCE):
	@$(call targetinfo, $(XBINUTILS_SOURCE))
	@$(call get, $(XBINUTILS_URL))

$(XBINUTILS_NOMMU_PATCH_SOURCE):
	@$(call targetinfo, $(XBINUTILS_NOMMU_PATCH_SOURCE))
	@$(call get, $(XBINUTILS_NOMMU_PATCH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-binutils_extract: $(STATEDIR)/xchain-binutils.extract

$(STATEDIR)/xchain-binutils.extract: $(STATEDIR)/xchain-binutils.get
	@$(call targetinfo, xchain-binutils.extract)
	@$(call clean, $(XBINUTILS_DIR))
	@$(call extract, $(XBINUTILS_SOURCE), $(XBINUTILS_DIR))
	mv $(XBINUTILS_DIR)/$(XBINUTILS)/* $(XBINUTILS_DIR)
#
# inspired by Erik Andersen's buildroot
#

#
# Enable combreloc, since it is such a nice thing to have...
#
	perl -i -p -e "s,link_info.combreloc = false,link_info.combreloc = true,g;" $(XBINUTILS_DIR)/ld/ldmain.c

#
# Hack binutils to use the correct shared lib loader
#
	cd $(XBINUTILS_DIR) && \
		perl -i -p -e "s,#.*define.*ELF_DYNAMIC_INTERPRETER.*\".*\",#define ELF_DYNAMIC_INTERPRETER \"$(DYNAMIC_LINKER)\",;" \
		`grep -lr "#define ELF_DYNAMIC_INTERPRETER" $(XBINUTILS_DIR)`

#
# Hack binutils to prevent it from searching the host system
# for libraries.  We only want libraries for the target system.
#
	cd $(XBINUTILS_DIR) && \
		perl -i -p -e "s,^NATIVE_LIB_DIRS.*,NATIVE_LIB_DIRS='$(CROSS_LIB_DIR)/usr/lib $(CROSS_LIB_DIR)/lib',;" \
		$(XBINUTILS_DIR)/ld/configure.host

ifdef PTXCONF_ARCH_ARM_NOMMU
	cd $(XBINUTILS_DIR) && patch -p1 < $(XBINUTILS_NOMMU_PATCH_SOURCE)
endif
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-binutils_prepare: $(STATEDIR)/xchain-binutils.prepare

XCHAIN_XBINUTILS_AUTOCONF_TARGET	= --enable-targets=$(PTXCONF_GNU_TARGET)
# ifdef PTXCONF_ARCH_MIPS
# XCHAIN_XBINUTILS_AUTOCONF_TARGET	= --enable-targets=$(PTXCONF_GNU_TARGET),mips64-linux
# endif
# ifdef PTXCONF_OPT_PA8X00
# XCHAIN_XBINUTILS_AUTOCONF_TARGET = --enable-targets=$(PTXCONF_GNU_TARGET),hppa64-linux
# endif

XCHAIN_XBINUTILS_AUTOCONF = \
	--target=$(PTXCONF_GNU_TARGET) \
	--host=$(GNU_HOST) \
	--build=$(GNU_HOST) \
	--prefix=$(PTXCONF_PREFIX) \
	--disable-nls \
	--disable-shared \
	$(XCHAIN_XBINUTILS_AUTOCONF_TARGET)

#	--enable-multilib \

XCHAIN_XBINUTILS_ENV	= $(HOSTCC_ENV)

$(STATEDIR)/xchain-binutils.prepare: $(STATEDIR)/xchain-binutils.extract
	@$(call targetinfo, xchain-binutils.prepare)
	cd $(XBINUTILS_DIR) && $(XCHAIN_XBINUTILS_ENV) \
		./configure $(XCHAIN_XBINUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-binutils_compile: $(STATEDIR)/xchain-binutils.compile

$(STATEDIR)/xchain-binutils.compile: $(STATEDIR)/xchain-binutils.prepare 
	@$(call targetinfo, xchain-binutils.compile)
	make -C $(XBINUTILS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-binutils_install: $(STATEDIR)/xchain-binutils.install

$(STATEDIR)/xchain-binutils.install: $(STATEDIR)/xchain-binutils.compile
	@$(call targetinfo, xchain-binutils.install)
	make install -C $(XBINUTILS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-binutils_targetinstall: $(STATEDIR)/xchain-binutils.targetinstall

$(STATEDIR)/xchain-binutils.targetinstall: $(STATEDIR)/xchain-binutils.install
	@$(call targetinfo, xchain-binutils.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-binutils_clean: 
	rm -rf $(STATEDIR)/xchain-binutils.* $(XBINUTILS_DIR)

# vim: syntax=make
