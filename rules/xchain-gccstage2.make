# $Id: xchain-gccstage2.make,v 1.3 2003/06/25 12:12:31 robert Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN))
PACKAGES += xchain-gccstage2
endif

#
# Paths and names 
#
# See gccstage1 for variable definitions


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

# FIXME: ??? xchain-gccstage2_get: $(STATEDIR)/glibc.install
xchain-gccstage2_get: $(STATEDIR)/xchain-gccstage2.get

$(STATEDIR)/xchain-gccstage2.get: $(STATEDIR)/xchain-gccstage1.get
	@$(call targetinfo, xchain-gccstage2.get)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-gccstage2_extract: $(STATEDIR)/xchain-gccstage2.extract

$(STATEDIR)/xchain-gccstage2.extract: 					\
	$(STATEDIR)/xchain-gccstage2.get				\
	$(STATEDIR)/glibc.install
	@$(call targetinfo, xchain-gccstage2.extract)
	# remove glibc header hack
        ifeq (y, $(PTXCONF_ARCH_ARM))	
	perl -p -i -e 									\
		's/^(TARGET_LIBGCC2_CFLAGS = -fomit-frame-pointer -fPIC).*/$$1/' 	\
		$(GCC_DIR)/gcc/config/arm/t-linux
        endif
        ifeq (y, $(PTXCONF_ARCH_X86))	
	perl -p -i -e 									\
		's/^(TARGET_LIBGCC2_CFLAGS = -fPIC).*/$$1/' 	\
		$(GCC_DIR)/gcc/config/t-linux
        endif
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-gccstage2_prepare: $(STATEDIR)/xchain-gccstage2.prepare

GCC_STAGE2_AUTOCONF	=  --target=$(PTXCONF_GNU_TARGET)
GCC_STAGE2_AUTOCONF	+= --prefix=$(PTXCONF_PREFIX)
GCC_STAGE2_AUTOCONF	+= --enable-target-optspace
GCC_STAGE2_AUTOCONF	+= --disable-nls
GCC_STAGE2_AUTOCONF	+= --with-gnu-ld
GCC_STAGE2_AUTOCONF	+= --disable-shared
GCC_STAGE2_AUTOCONF	+= --enable-languages="c,c++"
GCC_STAGE2_AUTOCONF	+= --with-headers=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
ifeq (y, $(PTXCONF_GLIBC_PTHREADS))
GCC_STAGE2_AUTOCONF	+= --enable-threads=posix
else
GCC_STAGE2_AUTOCONF	+= --disable-threads
endif

xchain-gccstage2_prepare_deps =  $(STATEDIR)/xchain-gccstage2.extract
xchain-gccstage2_prepare_deps += $(STATEDIR)/xchain-kernel.prepare

$(STATEDIR)/xchain-gccstage2.prepare: $(xchain-gccstage2_prepare_deps)
	@$(call targetinfo, xchain-gccstage2.prepare)
	[ -d $(GCC_STAGE2_DIR) ] || mkdir $(GCC_STAGE2_DIR)
	#
	# copy some header files
	#
	mkdir -p $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sys-include
	#
	# permanent asm-arm directory (temporarily created in stage 1)
	# FIXME: this is currently processor dependend
	#
	rm -fr  $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sys-include/asm-$(PTXCONF_ARCH)
	# FIXME: replace by install? 
	cp -a   $(BUILDDIR)/xchain-kernel/include/asm-$(PTXCONF_ARCH)		 	\
		$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sys-include/asm-$(PTXCONF_ARCH)
	rm -f	$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sys-include/asm
	ln -s	asm-$(PTXCONF_ARCH) $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sys-include/asm
	#
	# permanent linux directory (temporarily created in stage 1)
	#
	rm -fr   $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sys-include/linux
	cp -a    $(BUILDDIR)/xchain-kernel/include/linux $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sys-include/linux
#	#
#	# configure
#	# 
	cd $(GCC_STAGE2_DIR) && 						\
		PATH=$(PTXCONF_PREFIX)/bin:$$PATH				\
	  	AR=$(PTXCONF_GNU_TARGET)-ar					\
		RANLIB=$(PTXCONF_GNU_TARGET)-ranlib				\
	     	CC=$(HOSTCC)							\
		$(GCC_DIR)/configure $(GCC_STAGE2_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-gccstage2_compile: $(STATEDIR)/xchain-gccstage2.compile

$(STATEDIR)/xchain-gccstage2.compile: 					\
	$(STATEDIR)/xchain-gccstage2.prepare
	@$(call targetinfo, xchain-gccstage2.compile)
	# FIXME: why do we have to define _GNU_SOURCE here? Otherwhise 
	# the c++ compiler cannot be compiled. 
	cd $(GCC_STAGE2_DIR) && 					\
		PATH=$(PATH):$(PTXCONF_PREFIX)/bin make CXXFLAGS_FOR_TARGET="-D_GNU_SOURCE"
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-gccstage2_install: $(STATEDIR)/xchain-gccstage2.install

$(STATEDIR)/xchain-gccstage2.install: $(STATEDIR)/xchain-gccstage2.compile
	@$(call targetinfo, xchain-gccstage2.install)
	cd $(GCC_STAGE2_DIR) && 					\
		PATH=$(PATH):$(PTXCONF_PREFIX)/bin make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-gccstage2_targetinstall: $(STATEDIR)/xchain-gccstage2.targetinstall

$(STATEDIR)/xchain-gccstage2.targetinstall: $(STATEDIR)/xchain-gccstage2.install
	@$(call targetinfo, xchain-gccstage2.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-gccstage2_clean:
	rm -fr $(GCC_STAGE2_DIR) $(STATEDIR)/xchain-gccstage2.* 


# vim: syntax=make
