# -*-makefile-*-
# $Id: xchain-binutils.make,v 1.5 2003/07/16 04:23:28 mkl Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# Paths and names 
#
BINUTILS		= binutils-2.13.2.1
BINUTILS_URL		= ftp://ftp.gnu.org/pub/gnu/binutils/$(BINUTILS).tar.gz
BINUTILS_SOURCE		= $(SRCDIR)/$(BINUTILS).tar.gz
BINUTILS_DIR		= $(BUILDDIR)/$(BINUTILS)
ifdef PTXCONF_ARCH_NOMMU
BINUTILS		= binutils-2.10
BINUTILS_URL		= ftp://ftp.gnu.org/pub/gnu/binutils/$(BINUTILS).tar.gz
endif
ifdef PTXCONF_ARCH_MIPS
BINUTILS		= binutils-2.14.90.0.4
BINUTILS_URL		= ftp://ftp.de.kernel.org/pub/linux/devel/binutils/$(BINUTILS).tar.gz
endif
ifdef PTXCONF_ARCH_PARISC
BINUTILS		= binutils-2.14.90.0.4
BINUTILS_URL		= ftp://ftp.de.kernel.org/pub/linux/devel/binutils/$(BINUTILS).tar.gz
endif

BINUTILS_NOMMU_PATCH		= binutils-2.10-full.patch
BINUTILS_NOMMU_PATCH_URL	= http://www.uclinux.org/pub/uClinux/m68k-elf-tools/tools-20030314/$(BINUTILS_NOMMU_PATCH)
BINUTILS_NOMMU_PATCH_SOURCE	= $(SRCDIR)/$(BINUTILS_NOMMU_PATCH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-binutils_get: $(STATEDIR)/xchain-binutils.get

binutils_get_deps =  $(BINUTILS_SOURCE)
ifdef PTXCONF_ARCH_ARM_NOMMU
binutils_get_deps += $(BINUTILS_NOMMU_PATCH_SOURCE)
endif

$(STATEDIR)/xchain-binutils.get: $(binutils_get_deps)
	@$(call targetinfo, xchain-binutils.get)
	touch $@

$(BINUTILS_SOURCE):
	@$(call targetinfo, $(BINUTILS_SOURCE))
	@$(call get, $(BINUTILS_URL))

$(BINUTILS_NOMMU_PATCH_SOURCE):
	@$(call targetinfo, $(BINUTILS_NOMMU_PATCH_SOURCE))
	@$(call get, $(BINUTILS_NOMMU_PATCH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-binutils_extract: $(STATEDIR)/xchain-binutils.extract

$(STATEDIR)/xchain-binutils.extract: $(STATEDIR)/xchain-binutils.get
	@$(call targetinfo, xchain-binutils.extract)
	@$(call clean, $(BINUTILS_DIR))
	@$(call extract, $(BINUTILS_SOURCE))

#
# sto^H^H^Hinspired by Erik Andersen's buildroot
#

#
# Enable combreloc, since it is such a nice thing to have...
#
	perl -i -p -e "s,link_info.combreloc = false,link_info.combreloc = true,g;" $(BINUTILS_DIR)/ld/ldmain.c

#
# Hack binutils to use the correct shared lib loader
#
	cd $(BINUTILS_DIR) && \
		perl -i -p -e "s,#.*define.*ELF_DYNAMIC_INTERPRETER.*\".*\",#define ELF_DYNAMIC_INTERPRETER \"$(DYNAMIC_LINKER)\",;" \
		`grep -lr "#define ELF_DYNAMIC_INTERPRETER" $(BINUTILS_DIR)`

#
# Hack binutils to prevent it from searching the host system
# for libraries.  We only want libraries for the target system.
#
	cd $(BINUTILS_DIR) && \
		perl -i -p -e "s,^NATIVE_LIB_DIRS.*,NATIVE_LIB_DIRS='$(CROSS_LIB_DIR)/usr/lib $(CROSS_LIB_DIR)/lib',;" \
		$(BINUTILS_DIR)/ld/configure.host

ifdef PTXCONF_ARCH_ARM_NOMMU
	cd $(BINUTILS_DIR) && patch -p1 < $(BINUTILS_NOMMU_PATCH_SOURCE)
endif
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-binutils_prepare: $(STATEDIR)/xchain-binutils.prepare

XCHAIN_BINUTILS_AUTOCONF_TARGET	= --enable-targets=$(PTXCONF_GNU_TARGET)
ifdef PTXCONF_ARCH_MIPS
XCHAIN_BINUTILS_AUTOCONF_TARGET	= --enable-targets=$(PTXCONF_GNU_TARGET),mips64-linux
endif
ifdef PTXCONF_OPT_PA8X00
XCHAIN_BINUTILS_AUTOCONF_TARGET = --enable-targets=$(PTXCONF_GNU_TARGET),hppa64-linux
endif

XCHAIN_BINUTILS_AUTOCONF = \
	--target=$(PTXCONF_GNU_TARGET) \
	--host=$(GNU_HOST) \
	--build=$(GNU_HOST) \
	--prefix=$(PTXCONF_PREFIX) \
	--disable-nls \
	--disable-shared \
	--enable-multilib \
	$(XCHAIN_BINUTILS_AUTOCONF_TARGET)

XCHAIN_BINUTILS_ENV	= $(HOSTCC_ENV)

$(STATEDIR)/xchain-binutils.prepare: $(STATEDIR)/xchain-binutils.extract
	@$(call targetinfo, xchain-binutils.prepare)
	cd $(BINUTILS_DIR) && $(XCHAIN_BINUTILS_ENV) \
		./configure $(XCHAIN_BINUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-binutils_compile: $(STATEDIR)/xchain-binutils.compile

$(STATEDIR)/xchain-binutils.compile: $(STATEDIR)/xchain-binutils.prepare 
	@$(call targetinfo, xchain-binutils.compile)
	make -C $(BINUTILS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-binutils_install: $(STATEDIR)/xchain-binutils.install

$(STATEDIR)/xchain-binutils.install: $(STATEDIR)/xchain-binutils.compile
	@$(call targetinfo, xchain-binutils.install)
	make install -C $(BINUTILS_DIR)
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
	rm -rf $(STATEDIR)/xchain-binutils.* $(BINUTILS_DIR)

# vim: syntax=make
