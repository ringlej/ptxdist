# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: this needs maintainance. Really. Not only ipkgisation. 

#
# We provide this package
#
ifdef PTXCONF_RTAI
PACKAGES += rtai
endif

#
# Paths and names 
#
ifdef PTXCONF_RTAI_3_1_TEST4
RTAI_VERSION		= 3.1-test4
else
RTAI_VERSION		= please_port_me
endif
RTAI			= rtai-$(RTAI_VERSION)
RTAI_SUFFIX		= tar.bz2
RTAI_URL		= http://www.aero.polimi.it/RTAI/$(RTAI).$(RTAI_SUFFIX)
RTAI_SOURCE		= $(SRCDIR)/$(RTAI).$(RTAI_SUFFIX)
RTAI_DIR		= $(BUILDDIR)/$(RTAI)
RTAI_BUILDDIR		= $(BUILDDIR)/$(RTAI)-build
RTAI_MODULEDIR		= $(ROOTDIR)/lib/modules/$(KERNEL_VERSION)-adeos/kernel/drivers
RTAI_PATCH		= $(RTAI_DIR)/patches/patch-$(KERNEL_VERSION)-$(RTAI_TECH)

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
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rtai_prepare: $(STATEDIR)/rtai.prepare

RTAI_PATH	=  PATH=$(CROSS_PATH)
RTAI_ENV = \
	ARCH=$(PTXCONF_ARCH) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	LINUXDIR=$(KERNEL_DIR) \
	MAKE='make $(KERNEL_MAKEVARS)'

rtai_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/kernel.prepare \
	$(STATEDIR)/rtai.extract

RTAI_AUTOCONF =  $(CROSS_AUTOCONF)
RTAI_AUTOCONF += \
	--with-kconfig-file=$(RTAI_DIR)/.config \
	--with-linux-dir=$(KERNEL_DIR)

$(STATEDIR)/rtai.prepare: $(rtai_prepare_deps)
	@$(call targetinfo, $@)
	grep -e PTXCONF_RTAICFG_ .config > $(RTAI_DIR)/.config
	perl -i -p -e 's/PTXCONF_RTAICFG_/CONFIG_/g' $(RTAI_DIR)/.config
	perl -i -p -e "s,\@BUILDDIR@,$(BUILDDIR),g" $(RTAI_DIR)/.config
	perl -i -p -e "s,\@KERNEL_DIR@,$(KERNEL_DIR),g" $(RTAI_DIR)/.config
	cd $(RTAI_DIR) && \
		$(RTAI_PATH) $(RTAI_ENV) ./configure $(RTAI_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rtai_compile: $(STATEDIR)/rtai.compile

$(STATEDIR)/rtai.compile: $(STATEDIR)/rtai.prepare 
	@$(call targetinfo, $@)
	cd $(RTAI_DIR) && $(RTAI_PATH) TOPDIR=$(RTAI_DIR) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rtai_install: $(STATEDIR)/rtai.install

$(STATEDIR)/rtai.install: $(STATEDIR)/rtai.compile
	@$(call targetinfo, $@)
	# RTAI tries to install all kinds of useless crap which we don't
	# want to have on the target, so install into a build dir here
	cd $(RTAI_DIR) && $(RTAI_PATH) make install DESTDIR=$(RTAI_BUILDDIR)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rtai_targetinstall: $(STATEDIR)/rtai.targetinstall

$(STATEDIR)/rtai.targetinstall: $(STATEDIR)/rtai.install
	@$(call targetinfo, $@)

	install -d $(RTAI_MODULEDIR)/rtai
	install \
		$(RTAI_BUILDDIR)/usr/realtime/modules/rtai_hal.* \
		$(RTAI_MODULEDIR)/rtai/
	install \
		$(RTAI_BUILDDIR)/usr/realtime/modules/rtai_up.* \
		$(RTAI_MODULEDIR)/rtai/

ifdef PTXCONF_RTAI_TESTSUITE
	install -d $(ROOTDIR)/usr/realtime
	cp -a \
		$(RTAI_BUILDDIR)/usr/realtime/testsuite \
		$(ROOTDIR)/usr/realtime
	$(CROSSSTRIP) -S $(ROOTDIR)/usr/realtime/testsuite/kern/latency/display
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rtai_clean: 
	rm -rf $(STATEDIR)/rtai.* $(RTAI_DIR) $(RTAI_BUILDDIR)

# vim: syntax=make
