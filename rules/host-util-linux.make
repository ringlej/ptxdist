# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# Paths and names
#

HOST_PACKAGES-$(PTXCONF_HOST_UTIL_LINUX) += host-util-linux

HOST_UTIL_LINUX		= $(UTIL_LINUX)
HOST_UTIL_LINUX_DIR	= $(HOST_BUILDDIR)/$(HOST_UTIL_LINUX)


# ----------------------------------------------------------------------------
# Hosttool Get
# ----------------------------------------------------------------------------

host-util-linux_get: $(STATEDIR)/host-util-linux.get

$(STATEDIR)/host-util-linux.get: $(STATEDIR)/util-linux.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Hosttool Extract
# ----------------------------------------------------------------------------

host-util-linux_extract: $(STATEDIR)/host-util-linux.extract

$(STATEDIR)/host-util-linux.extract: $(host-util-linux_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(UTIL_LINUX_DIR))
	@$(call extract, UTIL_LINUX, $(HOST_BUILDDIR))
	@$(call patchin, UTIL_LINUX,$(HOST_UTIL_LINUX_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Hosttool Prepare
# ----------------------------------------------------------------------------

host-util-linux_prepare: $(STATEDIR)/host-util-linux.prepare

$(STATEDIR)/host-util-linux.prepare: $(host-util-linux_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_UTIL_LINUX_DIR) && \
		$(HOSTCC_ENV) ./configure
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Hosttool Compile
# ----------------------------------------------------------------------------

host-util-linux_compile: $(STATEDIR)/host-util-linux.compile

$(STATEDIR)/host-util-linux.compile: $(host-util-linux_compile_deps_default)
	@$(call targetinfo, $@)

ifdef PTXCONF_HOST_UTIL_LINUX_FDISK
	$(UTIL_LINUX_PATH) make -C $(HOST_UTIL_LINUX_DIR)/fdisk fdisk
endif

ifdef PTXCONF_HOST_UTIL_LINUX_CFDISK
	$(UTIL_LINUX_PATH) make -C $(HOST_UTIL_LINUX_DIR)/fdisk cfdisk
endif

ifdef PTXCONF_HOST_UTIL_LINUX_SFDISK
	$(UTIL_LINUX_PATH) make -C $(HOST_UTIL_LINUX_DIR)/fdisk sfdisk
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Hosttool Install
# ----------------------------------------------------------------------------

host-util-linux_install: $(STATEDIR)/host-util-linux.install

$(STATEDIR)/host-util-linux.install: $(host-util-linux_install_deps_default)
	@$(call targetinfo, $@)

ifdef PTXCONF_HOST_UTIL_LINUX_FDISK
	install -D $(HOST_UTIL_LINUX_DIR)/fdisk/fdisk \
		$(PTXCONF_SYSROOT_TARGET)/sbin/fdisk
endif

ifdef PTXCONF_HOST_UTIL_LINUX_CFDISK
	install -D $(HOST_UTIL_LINUX_DIR)/fdisk/cfdisk \
		$(PTXCONF_SYSROOT_TARGET)/sbin/cfdisk
endif

ifdef PTXCONF_HOST_UTIL_LINUX_SFDISK
	install -D $(HOST_UTIL_LINUX_DIR)/fdisk/sfdisk \
		$(PTXCONF_SYSROOT_TARGET)/sbin/sfdisk
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Hosttool Targetinstall
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Hosttool Clean
# ----------------------------------------------------------------------------

host-util-linux_clean:
	rm -rf $(STATEDIR)/host-util-linux.*
	rm -rf $(HOST_UTIL_LINUX_DIR)

# vim: syntax=make
