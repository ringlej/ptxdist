# -*-makefile-*-
# $Id: xchain-kernel.make,v 1.12 2003/10/28 11:12:24 mkl Exp $
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
#
# Robert says: Aber dokumentier' das entsprechend...
#
# Well, to build the glibc we need the kernel headers.
# We want to use the kernel plus the selected patches (e.g.: rmk-pxa-ptx)
# But without the ltt (linux trace toolkit) or rtai patches.
#
# The most important thing is, that the glibc and the kernel header
# (against the glibc is built) always stay together, the kernel that
# is running on the system does not matter...
#
# so we pull in the kernel's patches and drop ltt
# (rtai isn't included in kernel flavour)
#
XCHAIN_KERNEL_PATCHES	= $(addprefix xchain-kernel-, \
	$(call get_option_ext, s/^PTXCONF_KERNEL_[0-9]_[0-9]_[0-9]*_\(.*\)=y/\1/, sed -e 's/_/ /g' -e 's/[0-9]//g' -e 's/ltt//g'))

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-kernel_get: $(STATEDIR)/xchain-kernel.get

$(STATEDIR)/xchain-kernel.get: $(kernel_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-kernel_extract: $(STATEDIR)/xchain-kernel.extract

xchain-kernel_extract_deps = \
	$(STATEDIR)/xchain-kernel-base.extract \
	$(addprefix $(STATEDIR)/, $(addsuffix .install, $(XCHAIN_KERNEL_PATCHES)))

$(STATEDIR)/xchain-kernel.extract: $(xchain-kernel_extract_deps)
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/xchain-kernel-base.extract: $(STATEDIR)/xchain-kernel.get
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_KERNEL_BUILDDIR))
	@$(call extract, $(KERNEL_SOURCE), $(XCHAIN_KERNEL_BUILDDIR))
#
# kernels before 2.4.19 extract to "linux" instead of "linux-version"
#
ifeq (2.4.18,$(KERNEL_VERSION))
	mv $(XCHAIN_KERNEL_BUILDDIR)/linux $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL)
endif
	mv $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL)/* $(XCHAIN_KERNEL_BUILDDIR)
	rmdir $(XCHAIN_KERNEL_BUILDDIR)/$(KERNEL)

	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-kernel_prepare: $(STATEDIR)/xchain-kernel.prepare

$(STATEDIR)/xchain-kernel.prepare: $(STATEDIR)/xchain-kernel.extract
	@$(call targetinfo, $@)

# fake headers
	make -C $(XCHAIN_KERNEL_BUILDDIR) include/linux/version.h
	touch $(XCHAIN_KERNEL_BUILDDIR)/include/linux/autoconf.h

	rm -rf `find $(XCHAIN_KERNEL_BUILDDIR)/include -name "asm*" -type d |grep -v asm-$(PTXCONF_ARCH) | grep -v asm-generic`
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
	rm -fr $(STATEDIR)/xchain-kernel.*
	rm -fr $(XCHAIN_KERNEL_BUILDDIR)

# vim: syntax=make
