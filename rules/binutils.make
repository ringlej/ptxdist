# -*-makefile-*-
# $Id: binutils.make,v 1.1 2003/08/26 13:03:52 bsp Exp $
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
# Extract
# ----------------------------------------------------------------------------

binutils_extract: $(STATEDIR)/binutils.extract

$(STATEDIR)/binutils.extract: $(STATEDIR)/xchain-binutils.get
	@$(call targetinfo, binutils.extract)
	@$(call clean, $(BINUTILS_DIR))
	@$(call extract, $(BINUTILS_SOURCE))

#
# inspired by Erik Andersen's buildroot
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

binutils_prepare: $(STATEDIR)/binutils.prepare

BINUTILS_AUTOCONF_TARGET	= --enable-targets=$(PTXCONF_GNU_TARGET)
ifdef PTXCONF_ARCH_MIPS
BINUTILS_AUTOCONF_TARGET	= --enable-targets=$(PTXCONF_GNU_TARGET),mips64-linux
endif
ifdef PTXCONF_OPT_PA8X00
BINUTILS_AUTOCONF_TARGET = --enable-targets=$(PTXCONF_GNU_TARGET),hppa64-linux
endif

BINUTILS_AUTOCONF = \
	--target=$(PTXCONF_GNU_TARGET) \
	--host=$(PTXCONF_GNU_TARGET) \
	--build=$(GNU_HOST) \
	--prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET) \
	--disable-nls \
	--enable-shared \
	$(BINUTILS_AUTOCONF_TARGET)

#	--enable-multilib \

BINUTILS_ENV	= $(CROSS_ENV) PATH=$(CROSS_PATH)

$(STATEDIR)/binutils.prepare: $(STATEDIR)/binutils.extract
	@$(call targetinfo, binutils.prepare)
	cd $(BINUTILS_DIR) && $(BINUTILS_ENV) \
		./configure $(BINUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

binutils_compile: $(STATEDIR)/binutils.compile

$(STATEDIR)/binutils.compile: $(STATEDIR)/binutils.prepare 
	@$(call targetinfo, binutils.compile)
	$(BINUTILS_ENV) make -C $(BINUTILS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

binutils_install: $(STATEDIR)/binutils.install

$(STATEDIR)/binutils.install: $(STATEDIR)/binutils.compile
	@$(call targetinfo, binutils.install)
	make install -C $(BINUTILS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

binutils_targetinstall: $(STATEDIR)/binutils.targetinstall

$(STATEDIR)/binutils.targetinstall: $(STATEDIR)/binutils.install
	@$(call targetinfo, binutils.targetinstall)
	ifeq (y, $(PTXCONF_LIBBFD))
	install -d $(ROOTDIR)/lib
	cp -d $(BINUTILS_DIR)/bfd/.libs/libbfd.* $(ROOTDIR)/lib
	endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

binutils_clean: 
	rm -rf $(STATEDIR)/binutils.* $(BINUTILS_DIR)

# vim: syntax=make
