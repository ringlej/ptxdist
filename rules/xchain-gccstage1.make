# $Id: xchain-gccstage1.make,v 1.4 2003/06/29 13:27:36 robert Exp $
#
# (c) 2002,2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN))
PACKAGES += xchain-gccstage1
endif

#
# Paths and names 
#
GCC_PREFIX		= $(PTXCONF_GNU_TARGET)-

GCC			= gcc-2.95.3
GCC_URL			= ftp://ftp.gnu.org/pub/gnu/gcc/$(GCC).tar.gz
GCC_SOURCE		= $(SRCDIR)/$(GCC).tar.gz
GCC_DIR			= $(BUILDDIR)/$(GCC)
GCC_STAGE1_DIR		= $(BUILDDIR)/$(GCC)-$(GCC_PREFIX)stage1
GCC_STAGE2_DIR		= $(BUILDDIR)/$(GCC)-$(GCC_PREFIX)stage2
GCC_EXTRACT		= gzip -dc

GCC_ARMPATCH		= gcc-2.95.3.diff
GCC_ARMPATCH_URL	= ftp://ftp.arm.linux.org.uk/pub/armlinux/toolchain/src-2.95.3/$(GCC_ARMPATCH).bz2
GCC_ARMPATCH_SOURCE	= $(SRCDIR)/$(GCC_ARMPATCH).bz2
GCC_ARMPATCH_DIR	= $(GCC_DIR)
GCC_ARMPATCH_EXTRACT	= bzip2 -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-gccstage1_get: $(STATEDIR)/xchain-gccstage1.get

xchain-gccstage1_get_deps =  $(GCC_SOURCE)
ifeq (y,$(PTXCONF_ARCH_ARM))
xchain-gccstage1_get_deps += $(GCC_ARMPATCH_SOURCE)
endif

$(STATEDIR)/xchain-gccstage1.get: $(xchain-gccstage1_get_deps)
	touch $@

$(GCC_SOURCE): 
	wget -P $(SRCDIR) $(PASSIVEFTP) $(GCC_URL)

$(GCC_ARMPATCH_SOURCE): 
	wget -P $(SRCDIR) $(PASSIVEFTP) $(GCC_ARMPATCH_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-gccstage1_extract: $(STATEDIR)/xchain-gccstage1.extract

$(STATEDIR)/xchain-gccstage1.extract: $(STATEDIR)/xchain-gccstage1.get
	@$(call targetinfo, xchain-gccstage1.extract)
	$(GCC_EXTRACT) $(GCC_SOURCE) | tar -C $(BUILDDIR) -xf -
	#
        ifeq (y, $(PTXCONF_ARCH_ARM))	
	#
	# ARM: add architecure patch; fake headers
	# 
	cd $(GCC_DIR) && 								\
		$(GCC_ARMPATCH_EXTRACT) $(GCC_ARMPATCH_SOURCE) | patch -p1
	perl -i -p -e 									\
		's/^(TARGET_LIBGCC2_CFLAGS.*)/$$1 -Dinhibit_libc -D__gthr_posix_h/' 	\
		$(GCC_DIR)/gcc/config/arm/t-linux
        endif
	#
        ifeq (y, $(PTXCONF_ARCH_X86))
	#
	# x86: fake headers
	# 
	perl -i -p -e 									\
		's/^(TARGET_LIBGCC2_CFLAGS.*)/$$1 -Dinhibit_libc -D__gthr_posix_h/'	\
		$(GCC_DIR)/gcc/config/t-linux
        endif		
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-gccstage1_prepare: $(STATEDIR)/xchain-gccstage1.prepare

xchain-gccstage1_prepare_deps =  $(STATEDIR)/xchain-binutils.install
xchain-gccstage1_prepare_deps += $(STATEDIR)/xchain-gccstage1.extract
xchain-gccstage1_prepare_deps += $(STATEDIR)/xchain-kernel.install

$(STATEDIR)/xchain-gccstage1.prepare: $(xchain-gccstage1_prepare_deps)
	@$(call targetinfo, xchain-gccstage1.prepare)
	mkdir -p $(GCC_STAGE1_DIR)
	#
	# configure 
	#
	cd $(GCC_STAGE1_DIR) && 					\
		PATH=$(PTXCONF_PREFIX)/bin:$$PATH			\
	  	AR=$(PTXCONF_GNU_TARGET)-ar				\
		RANLIB=$(PTXCONF_GNU_TARGET)-ranlib			\
	     	CC=$(HOSTCC)						\
		$(GCC_DIR)/configure 					\
			--target=$(PTXCONF_GNU_TARGET)			\
			--prefix=$(PTXCONF_PREFIX)			\
			--enable-target-optspace			\
			--disable-nls					\
			--with-gnu-ld					\
			--disable-shared				\
			--enable-languages=c
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-gccstage1_compile: $(STATEDIR)/xchain-gccstage1.compile

$(STATEDIR)/xchain-gccstage1.compile: 					\
	$(STATEDIR)/xchain-gccstage1.prepare
	@$(call targetinfo, xchain-gccstage1.compile)
	cd $(GCC_STAGE1_DIR) &&						\
		PATH=$(PATH):$(PTXCONF_PREFIX)/bin make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-gccstage1_install: $(STATEDIR)/xchain-gccstage1.install

$(STATEDIR)/xchain-gccstage1.install: $(STATEDIR)/xchain-gccstage1.compile
	@$(call targetinfo, xchain-gccstage1.install)
	cd $(GCC_STAGE1_DIR) &&						\
		PATH=$(PATH):$(PTXCONF_PREFIX)/bin make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-gccstage1_targetinstall: $(STATEDIR)/xchain-gccstage1.targetinstall

$(STATEDIR)/xchain-gccstage1.targetinstall: $(STATEDIR)/xchain-gccstage1.install
	@$(call targetinfo, xchain-gccstage1.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-gccstage1_clean:
	rm -fr $(GCC_STAGE1_DIR) $(STATEDIR)/xchain-gccstage1.* $(GCC_DIR)


# vim: syntax=make
