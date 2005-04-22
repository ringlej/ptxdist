# -*-makefile-*-
# $Id$
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
ifdef PTXCONF_HOSTTOOL_MODUTILS
PACKAGES += hosttool-modutils
endif

#
# Paths and names
#
HOSTTOOL_MODUTILS_VERSION	= 2.4.27
HOSTTOOL_MODUTILS		= modutils-$(HOSTTOOL_MODUTILS_VERSION)
HOSTTOOL_MODUTILS_SUFFIX	= tar.bz2
HOSTTOOL_MODUTILS_URL		= ftp://ftp.kernel.org/pub/linux/utils/kernel/modutils/v2.4/$(HOSTTOOL_MODUTILS).$(HOSTTOOL_MODUTILS_SUFFIX)
HOSTTOOL_MODUTILS_SOURCE	= $(SRCDIR)/$(HOSTTOOL_MODUTILS).$(HOSTTOOL_MODUTILS_SUFFIX)
HOSTTOOL_MODUTILS_DIR		= $(HOSTTOOLS_BUILDDIR)/$(HOSTTOOL_MODUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-modutils_get: $(STATEDIR)/hosttool-modutils.get

hosttool-modutils_get_deps = $(HOSTTOOL_MODUTILS_SOURCE)

$(STATEDIR)/hosttool-modutils.get: $(hosttool-modutils_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(HOSTTOOL_MODUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOSTTOOL_MODUTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-modutils_extract: $(STATEDIR)/hosttool-modutils.extract

hosttool-modutils_extract_deps = $(STATEDIR)/hosttool-modutils.get

$(STATEDIR)/hosttool-modutils.extract: $(hosttool-modutils_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_MODUTILS_DIR))
	@$(call extract, $(HOSTTOOL_MODUTILS_SOURCE), $(HOSTTOOLS_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-modutils_prepare: $(STATEDIR)/hosttool-modutils.prepare

#
# dependencies
#
hosttool-modutils_prepare_deps =  \
	$(STATEDIR)/hosttool-flex254.install \
	$(STATEDIR)/hosttool-modutils.extract

HOSTTOOL_MODUTILS_PATH	=  PATH=$(CROSS_PATH)
HOSTTOOL_MODUTILS_ENV 	=  CC=$(HOSTCC)

#
# autoconf
#
HOSTTOOL_MODUTILS_AUTOCONF = \
	--prefix=$(PTXCONF_PREFIX) \
	--build=$(GNU_HOST) \
	--host=$(GNU_HOST) \
	--target=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/hosttool-modutils.prepare: $(hosttool-modutils_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_MODUTILS_DIR)/config.cache)
	cd $(HOSTTOOL_MODUTILS_DIR) && \
		$(HOSTTOOL_MODUTILS_PATH) $(HOSTTOOL_MODUTILS_ENV) \
		./configure $(HOSTTOOL_MODUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-modutils_compile: $(STATEDIR)/hosttool-modutils.compile

hosttool-modutils_compile_deps =  $(STATEDIR)/hosttool-modutils.prepare

$(STATEDIR)/hosttool-modutils.compile: $(hosttool-modutils_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOL_MODUTILS_DIR) && \
		$(HOSTTOOL_MODUTILS_PATH) make -C $(HOSTTOOL_MODUTILS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-modutils_install: $(STATEDIR)/hosttool-modutils.install

$(STATEDIR)/hosttool-modutils.install: $(STATEDIR)/hosttool-modutils.compile
	@$(call targetinfo, $@)

	mkdir -p $(PTXCONF_PREFIX)/bin
	install -D -m755 $(HOSTTOOL_MODUTILS_DIR)/insmod/insmod \
		$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-insmod.old
	install -D -m755 $(HOSTTOOL_MODUTILS_DIR)/insmod/modinfo \
		$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-modinfo.old
	install -D -m755 $(HOSTTOOL_MODUTILS_DIR)/insmod/insmod_ksymoops_clean \
		$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-insmod_ksymoops_clean.old
	install -D -m755 $(HOSTTOOL_MODUTILS_DIR)/insmod/kernelversion \
		$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-kernelversion.old
	for FILE in ksyms kallsyms; do				\
		ln -sf $(PTXCONF_GNU_TARGET)-insmod.old \
			$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-$$FILE.old; \
	done;

	install -D -m755 $(HOSTTOOL_MODUTILS_DIR)/genksyms/genksyms \
		$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-genksyms.old
	install -D -m755 $(HOSTTOOL_MODUTILS_DIR)/depmod/depmod \
		$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-depmod.old
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-modutils_targetinstall: $(STATEDIR)/hosttool-modutils.targetinstall

hosttool-modutils_targetinstall_deps	=  $(STATEDIR)/hosttool-modutils.compile

$(STATEDIR)/hosttool-modutils.targetinstall: $(hosttool-modutils_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-modutils_clean:
	rm -rf $(STATEDIR)/hosttool-modutils.*
	rm -rf $(HOSTTOOL_MODUTILS_DIR)

# vim: syntax=make
