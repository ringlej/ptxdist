# -*-makefile-*-
# $Id: xchain-kernel.make,v 1.29 2004/07/01 16:08:37 rsc Exp $
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# There are two "groups" of targets here: that ones starting with xchain- are
# only used for the cross chain. The "normal" targets are used for building the
# runtime kernel.
#

ifdef PTXCONF_BUILD_CROSSCHAIN
XCHAIN += xchain-kernel
endif

XCHAIN_KERNEL_BUILDDIR	= $(BUILDDIR)/xchain-$(KERNEL)

# ----------------------------------------------------------------------------
# Get patchstack-patches
# ----------------------------------------------------------------------------

xchain-kernel-patchstack_get: $(STATEDIR)/xchain-kernel-patchstack.get

$(STATEDIR)/xchain-kernel-patchstack.get: $(xchain_kernel_patchstack_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-kernel_get: $(STATEDIR)/xchain-kernel.get

xchain-kernel_get_deps = \
	$(KERNEL_SOURCE) \
	$(STATEDIR)/xchain-kernel-patchstack.get

$(STATEDIR)/xchain-kernel.get: $(xchain-kernel_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-kernel_extract: $(STATEDIR)/xchain-kernel.extract

xchain-kernel_extract_deps = \
	$(STATEDIR)/xchain-kernel.get

$(STATEDIR)/xchain-kernel.extract: $(xchain-kernel_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_KERNEL_BUILDDIR))
	@$(call extract, $(KERNEL_SOURCE), $(XCHAIN_KERNEL_BUILDDIR))

	#
	# kernels before 2.4.19 extract to "linux" instead of "linux-version"
	#
ifeq (2.4.18,$(KERNEL_VERSION))
	mv $(XCHAIN_KERNEL_BUILDDIR)/linux $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL)
endif
	# Add "patchstack" patches
ifdef PTXCONF_KERNEL_PATCH1_XCHAIN
	$(call feature_patchin, $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL), $(PTXCONF_KERNEL_PATCH1_NAME)) 
endif
ifdef PTXCONF_KERNEL_PATCH2_XCHAIN
	@$(call feature_patchin, $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL), $(PTXCONF_KERNEL_PATCH2_NAME)) 
endif
ifdef PTXCONF_KERNEL_PATCH3_XCHAIN
	@$(call feature_patchin, $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL), $(PTXCONF_KERNEL_PATCH3_NAME)) 
endif
ifdef PTXCONF_KERNEL_PATCH4_XCHAIN
	@$(call feature_patchin, $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL), $(PTXCONF_KERNEL_PATCH4_NAME)) 
endif
ifdef PTXCONF_KERNEL_PATCH5_XCHAIN
	@$(call feature_patchin, $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL), $(PTXCONF_KERNEL_PATCH5_NAME)) 
endif
ifdef PTXCONF_KERNEL_PATCH6_XCHAIN
	@$(call feature_patchin, $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL), $(PTXCONF_KERNEL_PATCH6_NAME)) 
endif
ifdef PTXCONF_KERNEL_PATCH7_XCHAIN
	@$(call feature_patchin, $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL), $(PTXCONF_KERNEL_PATCH7_NAME)) 
endif
ifdef PTXCONF_KERNEL_PATCH8_XCHAIN
	@$(call feature_patchin, $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL), $(PTXCONF_KERNEL_PATCH8_NAME)) 
endif
ifdef PTXCONF_KERNEL_PATCH9_XCHAIN
	@$(call feature_patchin, $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL), $(PTXCONF_KERNEL_PATCH9_NAME)) 
endif
ifdef PTXCONF_KERNEL_PATCH10_XCHAIN
	@$(call feature_patchin, $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL), $(PTXCONF_KERNEL_PATCH10_NAME)) 
endif
	mv $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL)/* $(XCHAIN_KERNEL_BUILDDIR)

	rm -fr $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL)

	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-kernel_prepare: $(STATEDIR)/xchain-kernel.prepare

xchain-kernel_prepare_deps = \
	$(STATEDIR)/xchain-kernel.extract

$(STATEDIR)/xchain-kernel.prepare: $(xchain-kernel_prepare_deps)
	@$(call targetinfo, $@)

	# fake headers
	cd $(XCHAIN_KERNEL_BUILDDIR) && make include/linux/version.h
	touch $(XCHAIN_KERNEL_BUILDDIR)/include/linux/autoconf.h

	ln -s asm-$(PTXCONF_ARCH) $(XCHAIN_KERNEL_BUILDDIR)/include/asm

ifdef PTXCONF_ARM_PROC
	ln -s proc-$(PTXCONF_ARM_PROC) $(XCHAIN_KERNEL_BUILDDIR)/include/asm/proc
	ln -s arch-$(PTXCONF_ARM_ARCH) $(XCHAIN_KERNEL_BUILDDIR)/include/asm/arch
endif
	touch $@


# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-kernel_compile: $(STATEDIR)/xchain-kernel.compile

$(STATEDIR)/xchain-kernel.compile:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-kernel_install: $(STATEDIR)/xchain-kernel.install

$(STATEDIR)/xchain-kernel.install: $(STATEDIR)/xchain-kernel.prepare
	@$(call targetinfo, $@)
	@$(call clean, $(CROSS_LIB_DIR)/include/asm)
	install -d $(CROSS_LIB_DIR)
	cp -dr $(XCHAIN_KERNEL_BUILDDIR)/include $(CROSS_LIB_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-kernel_targetinstall: $(STATEDIR)/xchain-kernel.targetinstall

$(STATEDIR)/xchain-kernel.targetinstall:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kernel_clean: 
	# remove feature patches, but only if kernel was cleaned before.  
	if [ ! -f $(STATEDIR)/kernel.get ]; then                                                                 \
		for i in `ls $(STATEDIR)/kernel-feature-*.* | sed -e 's/.*kernel-feature-\(.*\)\..*$$/\1/g'`; do        \
			if [ $$? -eq 0 ]; then                                                                          \
				rm -f $(STATEDIR)/kernel-feature-$$i*;                                                  \
				rm -fr $(TOPDIR)/feature-patches/$$i;                                                   \
			fi;                                                                                             \
			rm -f $(STATEDIR)/kernel-patchstack.get;							\
		done;													\
	fi;

	rm -fr $(STATEDIR)/xchain-kernel.*
	rm -fr $(XCHAIN_KERNEL_BUILDDIR)

# vim: syntax=make
