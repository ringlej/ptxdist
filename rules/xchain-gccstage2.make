# -*-makefile-*-
# $Id: xchain-gccstage2.make,v 1.6 2003/07/16 04:23:28 mkl Exp $
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
# See gccstage1 for variable definitions


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-gccstage2_get: $(STATEDIR)/xchain-gccstage2.get

$(STATEDIR)/xchain-gccstage2.get: $(xchain-gccstate1_get_deps)
	@$(call targetinfo, xchain-gccstage2.get)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-gccstage2_extract: $(STATEDIR)/xchain-gccstage2.extract

$(STATEDIR)/xchain-gccstage2.extract: $(xchain-gccstage1_extract_deps)
	@$(call targetinfo, xchain-gccstage2.extract)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-gccstage2_prepare: $(STATEDIR)/xchain-gccstage2.prepare

xchain-gccstage2_prepare_deps =  $(STATEDIR)/xchain-gccstage2.extract
ifdef PTXCONF_GLIBC
xchain-gccstage2_prepare_deps += $(STATEDIR)/xchain-glibc.install
endif
ifdef PTXCONF_UCLIBC
xchain-gccstage2_prepare_deps += $(STATEDIR)/xchain-uclibc.install
endif

GCC_STAGE2_PATH	= PATH=$(CROSS_PATH)
GCC_STAGE2_ENV	= $(HOSTCC_ENV)

GCC_STAGE2_AUTOCONF_THREADS = --disable-threads
ifdef PTXCONF_GLIBC_PTHREADS
GCC_STAGE2_AUTOCONF_THREADS = --enable-threads=posix
endif
ifdef PTXCONF_UCLIBC_UCLIBC_HAS_THREADS
GCC_STAGE2_AUTOCONF_THREADS = --enable-threads=posix
endif

GCC_STAGE2_AUTOCONF = \
	--target=$(PTXCONF_GNU_TARGET) \
	--host=$(GNU_HOST) \
	--build=$(GNU_HOST) \
	--prefix=$(PTXCONF_PREFIX) \
	--disable-nls \
	--disable-shared \
	--enable-multilib \
	--enable-target-optspace \
	--disable-threads \
	--with-gnu-ld \
	--enable-languages="c,c++" \
	--with-headers=$(CROSS_LIB_DIR)/include \
	$(GCC_STAGE2_AUTOCONF_THREADS)

$(STATEDIR)/xchain-gccstage2.prepare: $(xchain-gccstage2_prepare_deps)
	@$(call targetinfo, xchain-gccstage2.prepare)
	@$(call clean, $(GCC_STAGE2_DIR))
	[ -d $(GCC_STAGE2_DIR) ] || mkdir -p $(GCC_STAGE2_DIR)

	cd $(GCC_STAGE2_DIR) &&						\
	     	$(GCC_STAGE2_PATH) $(GCC_STAGE2_ENV)			\
		$(GCC_DIR)/configure $(GCC_STAGE2_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-gccstage2_compile: $(STATEDIR)/xchain-gccstage2.compile

$(STATEDIR)/xchain-gccstage2.compile: 					\
	$(STATEDIR)/xchain-gccstage2.prepare
	@$(call targetinfo, xchain-gccstage2.compile)
#	# FIXME: why do we have to define _GNU_SOURCE here? Otherwhise 
#	# the c++ compiler cannot be compiled. 
	cd $(GCC_STAGE2_DIR) && 					\
		$(GCC_STAGE2_PATH) $(GCC_STAGE2_ENV)			\
		make CXXFLAGS_FOR_TARGET="-D_GNU_SOURCE"
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-gccstage2_install: $(STATEDIR)/xchain-gccstage2.install

$(STATEDIR)/xchain-gccstage2.install: $(STATEDIR)/xchain-gccstage2.compile
	@$(call targetinfo, xchain-gccstage2.install)
	cd $(GCC_STAGE2_DIR) && 					\
		$(GCC_STAGE2_PATH) $(GCC_STAGE2_ENV)			\
		make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-gccstage2_targetinstall: $(STATEDIR)/xchain-gccstage2.targetinstall

$(STATEDIR)/xchain-gccstage2.targetinstall:
	@$(call targetinfo, xchain-gccstage2.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-gccstage2_clean:
	rm -fr $(GCC_STAGE2_DIR) $(STATEDIR)/xchain-gccstage2.* 


# vim: syntax=make
