# -*-makefile-*-
# $Id: xchain-kernel.make,v 1.9 2003/07/17 07:41:05 robert Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# There are two "groups" of targets here: that ones starting with xchain- are
# only used for the cross chain. The "normal" targets are used for building the
# runtime kernel.
#

XCHAIN_KERNEL_BUILDDIR	= $(BUILDDIR)/xchain-kernel

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-kernel_get: $(STATEDIR)/xchain-kernel.get

$(STATEDIR)/xchain-kernel.get: $(kernel_get_deps)
	@$(call targetinfo, xchain-kernel.get)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-kernel_extract: $(STATEDIR)/xchain-kernel.extract

xchain_kernel_extract_deps =  $(kernel_get_deps)
ifdef PTXCONF_KERNEL_MTD
xchain_kernel_extract_deps += $(STATEDIR)/mtd.extract
endif

$(STATEDIR)/xchain-kernel.extract:  $(xchain_kernel_extract_deps)
	@$(call targetinfo, xchain-kernel.extract)
	@$(call clean, $(BUILDDIR)/xchain-kernel)
	@$(call extract, $(KERNEL_SOURCE), $(BUILDDIR)/xchain-kernel/tmp)
#	#
#	# kernels before 2.4.19 extract to "linux" instead of "linux-version"
#	# 
        ifeq (y,$(PTXCONF_KERNEL_2_4_18))
	cd $(BUILDDIR)/xchain-kernel/tmp && mv linux $(KERNEL)
        endif
#	#
#	# ARM patch 
#	#
        ifeq (y,$(PTXCONF_ARCH_ARM))
	cd $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL) && 			\
		$(KERNEL_RMKPATCH_EXTRACT) $(KERNEL_RMKPATCH_SOURCE) |  \
		patch -p1
        endif
#	# 
#	# XSCALE patch
#	#
        ifeq (y, $(PTXCONF_KERNEL_XSCALE))
	cd $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL) && 			\
		$(KERNEL_PXAPATCH_EXTRACT) $(KERNEL_PXAPATCH_SOURCE) |  \
		patch -p1
        endif
#	#
#	# MTD patch
#	#
        ifeq (y, $(PTXCONF_KERNEL_MTD))
	cd $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL) &&						\
		$(KERNEL_MTDPATCH_EXTRACT) $(KERNEL_MTDPATCH_SOURCE) |	\
		patch -p1
        endif
#	#
#	# XSCALE_PTX patch
#	# 
        ifeq (y, $(PTXCONF_KERNEL_XSCALE_PTX))
	cd $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL) && 			\
		$(KERNEL_PTXPATCH_EXTRACT) $(KERNEL_PTXPATCH_SOURCE) |	\
		patch -p1
        endif
#	#
# 	# patch for mmu-less architectures
#	#
        ifdef PTXCONF_ARCH_NOMMU
	cd $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL) && \
		$(KERNEL_UCLINUXPATCH_EXTRACT) $(KERNEL_UCLINUXPATCH_SOURCE) | \
		patch -p1 || true
        endif
#	# fake headers
	make -C $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL) include/linux/version.h
	touch $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL)/include/linux/autoconf.h
#	# we are only interested in include/ here 
	cp -a $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL)/include $(BUILDDIR)/xchain-kernel/
	rm -fr $(BUILDDIR)/xchain-kernel/tmp
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-kernel_prepare: $(STATEDIR)/xchain-kernel.prepare

$(STATEDIR)/xchain-kernel.prepare: $(STATEDIR)/xchain-kernel.extract
	@$(call targetinfo, xchain-kernel.prepare)

	rm -rf `find $(XCHAIN_KERNEL_BUILDDIR)/include -name "asm*" -type d |grep -v asm-$(PTXCONF_ARCH)`
	cd $(BUILDDIR)/xchain-kernel/include && ln -s asm-$(PTXCONF_ARCH) asm

ifdef PTXCONF_ARCH_ARM
	cd $(BUILDDIR)/xchain-kernel/include/asm && ln -s proc-$(PTXCONF_ARM_PROC) proc
	cd $(BUILDDIR)/xchain-kernel/include/asm && ln -s arch-$(PTXCONF_ARM_ARCH) arch
endif

ifdef PTXCONF_ARCH_ARM_NOMMU
	cd $(BUILDDIR)/xchain-kernel/include/asm && ln -s proc-$(PTXCONF_ARM_PROC) proc
	cd $(BUILDDIR)/xchain-kernel/include/asm && ln -s arch-$(PTXCONF_ARM_ARCH) arch
endif
	touch $@


# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-kernel_compile: $(STATEDIR)/xchain-kernel.compile

$(STATEDIR)/xchain-kernel.compile:
	@$(call targetinfo, xchain-kernel.compile)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xchain-kernel.install: $(STATEDIR)/xchain-kernel.prepare
	@$(call targetinfo, xchain-kernel.install)
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
	cp -a $(BUILDDIR)/xchain-kernel/include $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-kernel_targetinstall: $(STATEDIR)/xchain-kernel.targetinstall

$(STATEDIR)/xchain-kernel.targetinstall:
	@$(call targetinfo, xchain-kernel.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-kernel_clean: 
	rm -fr $(STATEDIR)/xchain-kernel.*
	rm -fr $(XCHAIN_KERNEL_BUILDDIR)

# vim: syntax=make
