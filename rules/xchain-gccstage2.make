# $Id: xchain-gccstage2.make,v 1.1 2003/04/24 08:06:33 jst Exp $
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
	@echo
	@echo ----------------------------
	@echo target: xchain-gccstage2.get 
	@echo ----------------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-gccstage2_extract: $(STATEDIR)/xchain-gccstage2.extract

$(STATEDIR)/xchain-gccstage2.extract: 					\
	$(STATEDIR)/xchain-gccstage2.get				\
	$(STATEDIR)/glibc.install
	@echo
	@echo --------------------------------
	@echo target: xchain-gccstage2.extract 
	@echo --------------------------------
	@echo
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

xchain-gccstage2_prepare_deps =  $(STATEDIR)/xchain-gccstage2.extract
xchain-gccstage2_prepare_deps += $(STATEDIR)/xchain-kernel.prepare

$(STATEDIR)/xchain-gccstage2.prepare: $(xchain-gccstage2_prepare_deps)
	@echo
	@echo --------------------------------
	@echo target: xchain-gccstage2.prepare 
	@echo --------------------------------
	@echo
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
		$(GCC_DIR)/configure 						\
			--target=$(PTXCONF_GNU_TARGET)				\
			--prefix=$(PTXCONF_PREFIX)				\
			--enable-target-optspace				\
			--disable-nls						\
			--with-gnu-ld						\
			--disable-shared					\
			--enable-languages="c,c++"				\
			--with-headers=$(PTXCONF_PREFIX)/include
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-gccstage2_compile: $(STATEDIR)/xchain-gccstage2.compile

$(STATEDIR)/xchain-gccstage2.compile: 					\
	$(STATEDIR)/xchain-gccstage2.prepare
	@echo
	@echo --------------------------------
	@echo target: xchain-gccstage2.compile 
	@echo --------------------------------
	@echo
	# FIXME: why do we have to define _GNU_SOURCE here? Otherwhise 
	# the c++ compiler cannot be compiled. 
	cd $(GCC_STAGE2_DIR) && 					\
		PATH=$(PATH):$(PTXCONF_PREFIX)/bin make CXXFLAGS_FOR_TARGET="-g -Os -D_GNU_SOURCE"
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-gccstage2_install: $(STATEDIR)/xchain-gccstage2.install

$(STATEDIR)/xchain-gccstage2.install: $(STATEDIR)/xchain-gccstage2.compile
	@echo
	@echo --------------------------------
	@echo target: xchain-gccstage2.install 
	@echo --------------------------------
	@echo
	cd $(GCC_STAGE2_DIR) && 					\
		PATH=$(PATH):$(PTXCONF_PREFIX)/bin make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-gccstage2_targetinstall: $(STATEDIR)/xchain-gccstage2.targetinstall

$(STATEDIR)/xchain-gccstage2.targetinstall: $(STATEDIR)/xchain-gccstage2.install
	@echo
	@echo --------------------------------------
	@echo target: xchain-gccstage2.targetinstall 
	@echo --------------------------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-gccstage2_clean:
	rm -fr $(GCC_STAGE2_DIR) $(STATEDIR)/xchain-gccstage2.* 


# vim: syntax=make
