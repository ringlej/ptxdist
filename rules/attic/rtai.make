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
PACKAGES-$(PTXCONF_RTAI) += rtai

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

$(STATEDIR)/rtai.get: $(rtai_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(RTAI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, RTAI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rtai_extract: $(STATEDIR)/rtai.extract

$(STATEDIR)/rtai.extract: $(rtai_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(RTAI_DIR))
	@$(call extract, RTAI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rtai_prepare: $(STATEDIR)/rtai.prepare

RTAI_PATH	=  PATH=$(CROSS_PATH)
RTAI_ENV = \
	ARCH=$(PTXCONF_ARCH_STRING) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	LINUXDIR=$(KERNEL_DIR) \
	MAKE='make $(KERNEL_MAKEVARS)'

RTAI_AUTOCONF =  $(CROSS_AUTOCONF_USR)
RTAI_AUTOCONF += \
	--with-kconfig-file=$(RTAI_DIR)/.config \
	--with-linux-dir=$(KERNEL_DIR)

$(STATEDIR)/rtai.prepare: $(rtai_prepare_deps_default)
	@$(call targetinfo, $@)
	grep -e PTXCONF_RTAICFG_ .config > $(RTAI_DIR)/.config
	perl -i -p -e 's/PTXCONF_RTAICFG_/CONFIG_/g' $(RTAI_DIR)/.config
	perl -i -p -e "s,\@BUILDDIR@,$(BUILDDIR),g" $(RTAI_DIR)/.config
	perl -i -p -e "s,\@KERNEL_DIR@,$(KERNEL_DIR),g" $(RTAI_DIR)/.config
	cd $(RTAI_DIR) && \
		$(RTAI_PATH) $(RTAI_ENV) ./configure $(RTAI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rtai_compile: $(STATEDIR)/rtai.compile

$(STATEDIR)/rtai.compile: $(rtai_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(RTAI_DIR) && $(RTAI_PATH) TOPDIR=$(RTAI_DIR) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rtai_install: $(STATEDIR)/rtai.install

$(STATEDIR)/rtai.install: $(rtai_install_deps_default)
	@$(call targetinfo, $@)
	# RTAI tries to install all kinds of useless crap which we don't
	# want to have on the target, so install into a build dir here
	cd $(RTAI_DIR) && $(RTAI_PATH) $(MAKE_INSTALL) DESTDIR=$(RTAI_BUILDDIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rtai_targetinstall: $(STATEDIR)/rtai.targetinstall

$(STATEDIR)/rtai.targetinstall: $(rtai_targetinstall_deps_default)
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
	$(CROSS_STRIP) -S $(ROOTDIR)/usr/realtime/testsuite/kern/latency/display
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rtai_clean: 
	rm -rf $(STATEDIR)/rtai.* $(RTAI_DIR) $(RTAI_BUILDDIR)

# vim: syntax=make
