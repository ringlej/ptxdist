# -*-makefile-*-
# $Id: xchain-modutils.make,v 1.1 2003/10/23 18:05:53 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_XCHAIN_MODUTILS
PACKAGES += xchain-modutils
endif

#
# Paths and names
#
XCHAIN_MODUTILS_VERSION	= 2.4.25
XCHAIN_MODUTILS		= modutils-$(XCHAIN_MODUTILS_VERSION)
XCHAIN_MODUTILS_SUFFIX	= tar.bz2
XCHAIN_MODUTILS_URL	= ftp://ftp.kernel.org/pub/linux/utils/kernel/modutils/v2.4/$(XCHAIN_MODUTILS).$(XCHAIN_MODUTILS_SUFFIX)
XCHAIN_MODUTILS_SOURCE	= $(SRCDIR)/$(XCHAIN_MODUTILS).$(XCHAIN_MODUTILS_SUFFIX)
XCHAIN_MODUTILS_DIR	= $(BUILDDIR)/$(XCHAIN_MODUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-modutils_get: $(STATEDIR)/xchain-modutils.get

xchain-modutils_get_deps	=  $(XCHAIN_MODUTILS_SOURCE)

$(STATEDIR)/xchain-modutils.get: $(xchain-modutils_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(XCHAIN_MODUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XCHAIN_MODUTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-modutils_extract: $(STATEDIR)/xchain-modutils.extract

xchain-modutils_extract_deps	=  $(STATEDIR)/xchain-modutils.get

$(STATEDIR)/xchain-modutils.extract: $(xchain-modutils_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_MODUTILS_DIR))
	@$(call extract, $(XCHAIN_MODUTILS_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-modutils_prepare: $(STATEDIR)/xchain-modutils.prepare

#
# dependencies
#
xchain-modutils_prepare_deps =  \
	$(STATEDIR)/xchain-modutils.extract

XCHAIN_MODUTILS_ENV 	=  CC=$(HOSTCC)

#
# autoconf
#
XCHAIN_MODUTILS_AUTOCONF = \
	--prefix=$(PTXCONF_PREFIX) \
	--build=$(GNU_HOST) \
	--host=$(GNU_HOST) \
	--target=$(PTXCONF_GNU_TARGET) \
	--program-prefix=$(PTXCONF_GNU_TARGET)-

$(STATEDIR)/xchain-modutils.prepare: $(xchain-modutils_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_MODUTILS_DIR)/config.cache)
	cd $(XCHAIN_MODUTILS_DIR) && \
		$(XCHAIN_MODUTILS_ENV) \
		./configure $(XCHAIN_MODUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-modutils_compile: $(STATEDIR)/xchain-modutils.compile

xchain-modutils_compile_deps =  $(STATEDIR)/xchain-modutils.prepare

$(STATEDIR)/xchain-modutils.compile: $(xchain-modutils_compile_deps)
	@$(call targetinfo, $@)
	make -C $(XCHAIN_MODUTILS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-modutils_install: $(STATEDIR)/xchain-modutils.install

$(STATEDIR)/xchain-modutils.install: $(STATEDIR)/xchain-modutils.compile
	@$(call targetinfo, $@)
# 	make -C $(XCHAIN_MODUTILS_DIR) install
	mkdir -p $(PTXCONF_PREFIX)/bin
	install -m755 $(XCHAIN_MODUTILS_DIR)/insmod/insmod $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-insmod
	install -m755 $(XCHAIN_MODUTILS_DIR)/insmod/modinfo $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-modinfo
	install -m755 $(XCHAIN_MODUTILS_DIR)/insmod/insmod_ksymoops_clean $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-insmod_ksymoops_clean
	install -m755 $(XCHAIN_MODUTILS_DIR)/insmod/kernelversion $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-kernelversion
	for FILE in rmmod modprobe lsmod ksyms kallsyms; do				\
		ln -sf $(PTXCONF_GNU_TARGET)-insmod $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-$$FILE;	\
	done;

	install -m755 $(XCHAIN_MODUTILS_DIR)/genksyms/genksyms $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-genksyms
	install -m755 $(XCHAIN_MODUTILS_DIR)/depmod/depmod $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-depmod
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-modutils_targetinstall: $(STATEDIR)/xchain-modutils.targetinstall

xchain-modutils_targetinstall_deps	=  $(STATEDIR)/xchain-modutils.compile

$(STATEDIR)/xchain-modutils.targetinstall: $(xchain-modutils_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-modutils_clean:
	rm -rf $(STATEDIR)/xchain-modutils.*
	rm -rf $(XCHAIN_MODUTILS_DIR)

# vim: syntax=make
