# -*-makefile-*-
# $Id$
#
# Copyright (C) 2005 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef NATIVE

PACKAGES-$(PTXCONF_KERNEL_HOST) += kernel

#
# Use a PTXdist built kernel which is parametrized here or use one from 
# an external directory
#

# version stuff in now in rules/Version.make
# NB: make s*cks

KERNEL_HOST_VERSION	= $(call remove_quotes,$(PTXCONF_KERNEL_HOST_VERSION))

KERNEL_HOST		= linux-$(KERNEL_HOST_VERSION)
KERNEL_HOST_SUFFIX	= tar.bz2
KERNEL_HOST_URL		= http://www.kernel.org/pub/linux/kernel/v$(KERNEL_HOST_VERSION_MAJOR).$(KERNEL_HOST_VERSION_MINOR)/$(KERNEL_HOST).$(KERNEL_HOST_SUFFIX)
KERNEL_HOST_SOURCE	= $(SRCDIR)/$(KERNEL_HOST).$(KERNEL_HOST_SUFFIX)
KERNEL_HOST_DIR		= $(BUILDDIR)/$(KERNEL_HOST)
KERNEL_HOST_CONFIG	= $(PTXCONF_KERNEL_HOST_CONFIG)

KERNEL_HOST_INST_DIR	= $(KERNEL_HOST_DIR)-install

KERNEL_HOST_TARGET	= linux
KERNEL_HOST_TARGET_PATH	= $(KERNEL_HOST_DIR)/linux

# ----------------------------------------------------------------------------
# Menuconfig
# ----------------------------------------------------------------------------

kernel_menuconfig: $(STATEDIR)/kernel.extract

	cp $(KERNEL_HOST_CONFIG) $(KERNEL_HOST_DIR)/.config
	cd $(KERNEL_HOST_DIR) && $(KERNEL_HOST_PATH) make menuconfig $(KERNEL_HOST_MAKEVARS)
	cd $(KERNEL_HOST_DIR) && $(KERNEL_HOST_PATH) make oldconfig $(KERNEL_HOST_MAKEVARS)
	cp $(KERNEL_HOST_DIR)/.config $(KERNEL_HOST_CONFIG)

	@if [ -f $(STATEDIR)/kernel.compile ]; then \
		rm $(STATEDIR)/kernel.compile; \
	fi

# ----------------------------------------------------------------------------
# Oldconfig
# ----------------------------------------------------------------------------

kernel_oldconfig: $(STATEDIR)/kernel.extract

	cd $(KERNEL_HOST_DIR) && $(KERNEL_HOST_PATH) make oldconfig $(KERNEL_HOST_MAKEVARS)

	@if [ -f $(STATEDIR)/kernel.compile ]; then \
		rm $(STATEDIR)/kernel.compile; \
	fi

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel_get: $(STATEDIR)/kernel.get

ifdef PTXCONF_KERNEL_HOST
kernel_get_deps = \
	$(KERNEL_HOST_SOURCE) \
	$(STATEDIR)/kernel-patchstack.get
endif

$(STATEDIR)/kernel.get: $(kernel_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(KERNEL_HOST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL_HOST_URL))


# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

kernel_extract: $(STATEDIR)/kernel.extract

kernel_extract_deps = $(STATEDIR)/kernel-base.extract

$(STATEDIR)/kernel.extract: $(kernel_extract_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(STATEDIR)/kernel-base.extract: $(STATEDIR)/kernel.get
	@$(call targetinfo, $@)

ifdef PTXCONF_KERNEL_HOST
	@$(call clean, $(KERNEL_HOST_DIR))
	@$(call extract, $(KERNEL_HOST_SOURCE))

#
# apply the patch series
#
	@if [ -e $(PTXCONF_KERNEL_HOST_PATCH_SERIES) ]; then \
		$(PTXDIST_TOPDIR)/scripts/apply_patch_series.sh -s $(PTXCONF_KERNEL_HOST_PATCH_SERIES) -d $(KERNEL_HOST_DIR); \
	fi

endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

kernel_prepare: $(STATEDIR)/kernel.prepare

kernel_prepare_deps =  $(STATEDIR)/virtual-xchain.install
kernel_prepare_deps += $(STATEDIR)/kernel.extract
kernel_prepare_deps += $(STATEDIR)/host-module-init-tools.install

KERNEL_HOST_PATH	=  PATH=$(CROSS_PATH)
KERNEL_HOST_MAKEVARS	=  HOSTCC=$(HOSTCC)
KERNEL_HOST_MAKEVARS	=  CC=$(HOSTCC)
KERNEL_HOST_MAKEVARS	+= $(PARALLELMFLAGS)
KERNEL_HOST_MAKEVARS 	+= DEPMOD=$(call remove_quotes,$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-depmod)
KERNEL_HOST_MAKEVARS	+= ARCH=um
KERNEL_HOST_MAKEVARS 	+= CROSS_COMPILE=$(COMPILER_PREFIX)

$(STATEDIR)/kernel.prepare: $(kernel_prepare_deps)
	@$(call targetinfo, $@)

ifdef PTXCONF_KERNEL_HOST

	@if [ -f $(KERNEL_HOST_CONFIG) ]; then	                        \
		echo "Using kernel config file: $(KERNEL_HOST_CONFIG)"; 	\
		install -m 644 $(KERNEL_HOST_CONFIG) $(KERNEL_HOST_DIR)/.config;	\
	else								\
		echo "ERROR: No kernel config file found.";		\
		exit 1;							\
	fi
	# create symlinks in case we are here only to provide headers
	cd $(KERNEL_HOST_DIR) && $(KERNEL_HOST_PATH) make include/linux/version.h $(KERNEL_HOST_MAKEVARS)
	touch $(KERNEL_HOST_DIR)/include/linux/autoconf.h
	#ln -sf asm-$(PTXCONF_ARCH) $(KERNEL_HOST_DIR)/include/asm
	@echo 
	@echo "------------- make oldconfig -------------"
	@echo
	cd $(KERNEL_HOST_DIR) && $(KERNEL_HOST_PATH) make oldconfig $(KERNEL_HOST_MAKEVARS)
	@echo 
	@echo "---------- make modules_prepare ----------"
	@echo 
	-cd $(KERNEL_HOST_DIR) && $(KERNEL_HOST_PATH) make modules_prepare $(KERNEL_HOST_MAKEVARS)

endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Modversions-Prepare
# ----------------------------------------------------------------------------

#
# Some packages (like rtnet.) need modversions.h
#
# we build it only when needed cause it can be build only if kernel modules
# are selected
#
$(STATEDIR)/kernel-modversions.prepare: $(STATEDIR)/kernel.prepare
	@$(call targetinfo, $@)

ifdef PTXCONF_KERNEL_HOST

	cd $(KERNEL_HOST_DIR) && $(KERNEL_HOST_PATH) make				\
		$(KERNEL_HOST_DIR)/include/linux/modversions.h		\
		$(KERNEL_HOST_MAKEVARS)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

kernel_compile: $(STATEDIR)/kernel.compile

kernel_compile_deps =  $(STATEDIR)/kernel.prepare

$(STATEDIR)/kernel.compile: $(kernel_compile_deps)
	@$(call targetinfo, $@)

ifdef PTXCONF_KERNEL_HOST

	cd $(KERNEL_HOST_DIR) && $(KERNEL_HOST_PATH) make \
		$(KERNEL_HOST_TARGET) modules $(KERNEL_HOST_MAKEVARS)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel_install: $(STATEDIR)/kernel.install

$(STATEDIR)/kernel.install:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

kernel_targetinstall: $(STATEDIR)/kernel.targetinstall

kernel_targetinstall_deps =  $(STATEDIR)/kernel.compile

$(STATEDIR)/kernel.targetinstall: $(kernel_targetinstall_deps)
	@$(call targetinfo, $@)

ifdef PTXCONF_KERNEL_HOST

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,kernel)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(KERNEL_HOST_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(KERNEL_HOST_TARGET_PATH), /boot/linux, n)
	@$(call install_finish)

	rm -fr $(KERNEL_HOST_INST_DIR)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,kernel-modules)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(KERNEL_HOST_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	cd $(KERNEL_HOST_DIR) && $(KERNEL_HOST_PATH) make 			\
		modules_install $(KERNEL_HOST_MAKEVARS) INSTALL_MOD_PATH=$(KERNEL_HOST_INST_DIR)

	cd $(KERNEL_HOST_INST_DIR) &&					\
		for file in `find . -type f | sed -e "s/\.\//\//g"`; do	\
			$(call install_copy, 0, 0, 0664, $(KERNEL_HOST_INST_DIR)/$$file, $$file, n) \
		done

	rm -fr $(KERNEL_HOST_INST_DIR)

endif

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel_clean:
	for i in `find $(STATEDIR) -name "kernel-feature-*.*" | sed -e 's/.*kernel-feature-\(.*\)\..*$$/\1/g'`; do \
		if [ $$? -eq 0 ]; then										\
			rm -f $(STATEDIR)/kernel-feature-$$i*;							\
			rm -fr $(PTXDIST_TOPDIR)/feature-patches/$$i;							\
		fi;												\
	done;													\
	rm -f $(STATEDIR)/kernel-patchstack.get;								\
	rm -rf $(KERNEL_HOST_DIR)
	rm -f $(STATEDIR)/kernel.*

endif # NATIVE

# vim: syntax=make
