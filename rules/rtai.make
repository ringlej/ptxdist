# -*-makefile-*-
# $Id: rtai.make,v 1.9 2003/11/02 13:48:16 mkl Exp $
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_RTAI
PACKAGES += rtai
endif

#
# Paths and names 
#
RTAI_VERSION		= $(RTAI_VERSION_RELEASE)
RTAI			= rtai-$(RTAI_VERSION)
RTAI_SUFFIX		= tgz
RTAI_URL		= http://www.aero.polimi.it/RTAI/$(RTAI).$(RTAI_SUFFIX)
RTAI_SOURCE		= $(SRCDIR)/$(RTAI).$(RTAI_SUFFIX)
RTAI_DIR		= $(BUILDDIR)/$(RTAI)
RTAI_MODULEDIR		= /lib/modules/$(KERNEL_VERSION)-$(RTAI_TECH_SHORT)/rtai
RTAI_PATCH		= $(RTAI_DIR)/patches/patch-$(KERNEL_VERSION)-$(RTAI_TECH)

# ----------------------------------------------------------------------------
# Menuconfig
# ----------------------------------------------------------------------------
#
# FIXME: not tested
#
# rtai_menuconfig: $(STATEDIR)/rtai.prepare
# 	@if [ -f $(TOPDIR)/config/rtai/$(PTXCONF_RTAI_CONFIG) ]; then \
# 		install -m 644 $(TOPDIR)/config/rtai/$(PTXCONF_RTAI_CONFIG) \
# 			$(RTAI_DIR)/.config; \
# 	fi

# 	$(RTAI_PATH) make -C $(RTAI_DIR) $(RTAI_MAKEVARS) \
# 		menuconfig

# 	@if [ -f $(RTAI_DIR)/.config ]; then \
# 		install -m 644 $(RTAI_DIR)/.config \
# 			$(TOPDIR)/config/rtai/$(PTXCONF_RTAI_CONFIG); \
# 	fi

# 	@if [ -f $(STATEDIR)/rtai.compile ]; then \
# 		rm $(STATEDIR)/rtai.compile; \
# 	fi

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rtai_get: $(STATEDIR)/rtai.get

$(STATEDIR)/rtai.get: $(RTAI_SOURCE)
	@$(call targetinfo, $@)
	touch $@

$(RTAI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(RTAI_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rtai_extract: $(STATEDIR)/rtai.extract

$(STATEDIR)/rtai.extract: $(STATEDIR)/rtai.get
	@$(call targetinfo, $@)
	@$(call clean, $(RTAI_DIR))
	@$(call extract, $(RTAI_SOURCE))
#
# FIXME: Hopefully someone will fix this one:
#
	cp -f $(RTAI_DIR)/lxrt/Makefile $(RTAI_DIR)/lxrt/Makefile.orig
	sed -e "s/pressa//g" $(RTAI_DIR)/lxrt/Makefile.orig >$(RTAI_DIR)/lxrt/Makefile
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rtai_prepare: $(STATEDIR)/rtai.prepare

RTAI_PATH	=  PATH=$(CROSS_PATH)
RTAI_ENV	= \
	ARCH=$(PTXCONF_ARCH) \
	CROSS_COMPILE=$(PTXCONF_GNU_TARGET)- \
	LINUXDIR=$(KERNEL_DIR) \
	MAKE='make $(KERNEL_MAKEVARS)'

rtai_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/kernel.prepare \
	$(STATEDIR)/rtai.extract

$(STATEDIR)/rtai.prepare: $(rtai_prepare_deps)
	@$(call targetinfo, $@)

	if [ -f $(TOPDIR)/config/rtai/$(PTXCONF_RTAI_CONFIG) ]; then		\
		install -m 644 $(TOPDIR)/config/rtai/$(PTXCONF_RTAI_CONFIG)	\
		$(RTAI_DIR)/.config;						\
	fi

	cd $(RTAI_DIR) && \
		yes no | $(RTAI_PATH) $(RTAI_ENV) ./configure --reconf

	$(RTAI_PATH) TOPDIR=$(RTAI_DIR) make -C $(RTAI_DIR) dep
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rtai_compile: $(STATEDIR)/rtai.compile

$(STATEDIR)/rtai.compile: $(STATEDIR)/rtai.prepare 
	@$(call targetinfo, $@)
	$(RTAI_PATH) TOPDIR=$(RTAI_DIR) make -C $(RTAI_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rtai_install: $(STATEDIR)/rtai.install

$(STATEDIR)/rtai.install: $(STATEDIR)/rtai.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rtai_targetinstall: $(STATEDIR)/rtai.targetinstall

$(STATEDIR)/rtai.targetinstall: $(STATEDIR)/rtai.install
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/$(RTAI_MODULEDIR)

	install $(RTAI_DIR)/rtaidir/rtai.o $(ROOTDIR)/$(RTAI_MODULEDIR)
	$(CROSSSTRIP) -S $(ROOTDIR)/$(RTAI_MODULEDIR)/rtai.o

	install $(RTAI_DIR)/upscheduler/rtai_sched_up.o $(ROOTDIR)/$(RTAI_MODULEDIR)
	$(CROSSSTRIP) -S $(ROOTDIR)/$(RTAI_MODULEDIR)/rtai_sched_up.o
	ln -sf rtai_sched_up.o $(ROOTDIR)/$(RTAI_MODULEDIR)/rtai_sched.o

ifeq ($(RTAI_VERSION_RELEASE),24.1.9)
	install $(RTAI_DIR)/lxrt/rtai_lxrt.o $(ROOTDIR)/$(RTAI_MODULEDIR)
	$(CROSSSTRIP) -S $(ROOTDIR)/$(RTAI_MODULEDIR)/rtai_lxrt.o
else
	install $(RTAI_DIR)/lxrt/rtai_lxrt_old.o $(ROOTDIR)/$(RTAI_MODULEDIR)
	$(CROSSSTRIP) -S $(ROOTDIR)/$(RTAI_MODULEDIR)/rtai_lxrt_old.o
	ln -sf rtai_lxrt_old.o $(ROOTDIR)/$(RTAI_MODULEDIR)/rtai_lxrt.o
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rtai_clean: 
	rm -rf $(STATEDIR)/rtai.* $(RTAI_DIR)

# vim: syntax=make
