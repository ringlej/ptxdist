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
HOST_PACKAGES-$(PTXCONF_HOST_MODUTILS) += host-modutils

#
# Paths and names
#
HOST_MODUTILS		= $(MODUTILS)
HOST_MODUTILS_DIR	= $(HOST_BUILDDIR)/$(HOST_MODUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-modutils_get: $(STATEDIR)/host-modutils.get

$(STATEDIR)/host-modutils.get: $(STATEDIR)/modutils.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-modutils_extract: $(STATEDIR)/host-modutils.extract

$(STATEDIR)/host-modutils.extract: $(host-modutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MODUTILS_DIR))
	@$(call extract, MODUTILS, $(HOST_BUILDDIR))
	@$(call patchin, MODUTILS, $(HOST_MODUTILS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-modutils_prepare: $(STATEDIR)/host-modutils.prepare

HOST_MODUTILS_PATH	=  PATH=$(CROSS_PATH)
HOST_MODUTILS_ENV 	=  CC=$(HOSTCC)

#
# autoconf
#
HOST_MODUTILS_AUTOCONF = $(HOST_AUTOCONF)

$(STATEDIR)/host-modutils.prepare: $(host-modutils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MODUTILS_DIR)/config.cache)
	cd $(HOST_MODUTILS_DIR) && \
		$(HOST_MODUTILS_PATH) $(HOST_MODUTILS_ENV) \
		./configure $(HOST_MODUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-modutils_compile: $(STATEDIR)/host-modutils.compile

$(STATEDIR)/host-modutils.compile: $(host-modutils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_MODUTILS_DIR) && \
		$(HOST_MODUTILS_PATH) make -C $(HOST_MODUTILS_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-modutils_install: $(STATEDIR)/host-modutils.install

$(STATEDIR)/host-modutils.install: $(STATEDIR)/host-modutils.compile
	@$(call targetinfo, $@)
#	FIXME
#	@$(call install, HOST_MODUTILS,,h)
	mkdir -p $(PTXCONF_PREFIX)/bin
	install -D -m755 $(HOST_MODUTILS_DIR)/insmod/insmod \
		$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-insmod.old
	install -D -m755 $(HOST_MODUTILS_DIR)/insmod/modinfo \
		$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-modinfo.old
	install -D -m755 $(HOST_MODUTILS_DIR)/insmod/insmod_ksymoops_clean \
		$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-insmod_ksymoops_clean.old
	install -D -m755 $(HOST_MODUTILS_DIR)/insmod/kernelversion \
		$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-kernelversion.old
	for FILE in ksyms kallsyms; do				\
		ln -sf $(PTXCONF_GNU_TARGET)-insmod.old \
			$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-$$FILE.old; \
	done;

	install -D -m755 $(HOST_MODUTILS_DIR)/genksyms/genksyms \
		$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-genksyms.old
	install -D -m755 $(HOST_MODUTILS_DIR)/depmod/depmod \
		$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-depmod.old
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-modutils_targetinstall: $(STATEDIR)/host-modutils.targetinstall

$(STATEDIR)/host-modutils.targetinstall: $(host-modutils_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-modutils_clean:
	rm -rf $(STATEDIR)/host-modutils.*
	rm -rf $(HOST_MODUTILS_DIR)

# vim: syntax=make
