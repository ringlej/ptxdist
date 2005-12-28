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

HOSTPACKAGES-$(HOSTTOOL_UTIL-LINUX) += hosttool-util-linux

HOSTTOOL_UTIL-LINUX_DIR	= $(HOST_BUILDDIR)/$(UTIL-LINUX)

# ----------------------------------------------------------------------------
# Hosttool Extract
# ----------------------------------------------------------------------------

hosttool-util-linux_extract: $(STATEDIR)/hosttool-util-linux.extract

hosttool-util-linux_extract_deps =  $(STATEDIR)/util-linux.get

$(STATEDIR)/hosttool-util-linux.extract: $(hosttool-util-linux_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(UTIL-LINUX_DIR))
	@$(call extract, $(UTIL-LINUX_SOURCE), $(HOST_BUILDDIR))
	@$(call patchin, $(UTIL-LINUX),$(HOSTTOOL_UTIL-LINUX_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Hosttool Prepare
# ----------------------------------------------------------------------------

hosttool-util-linux_prepare: $(STATEDIR)/hosttool-util-linux.prepare

#
# dependencies
#
hosttool-util-linux_prepare_deps = $(STATEDIR)/hosttool-util-linux.extract

$(STATEDIR)/hosttool-util-linux.prepare: $(hosttool-util-linux_prepare_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOL_UTIL-LINUX_DIR) && \
		$(HOSTCC_ENV) ./configure
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Hosttool Compile
# ----------------------------------------------------------------------------

hosttool-util-linux_compile: $(STATEDIR)/hosttool-util-linux.compile

hosttool-util-linux_compile_deps =  $(STATEDIR)/hosttool-util-linux.prepare

$(STATEDIR)/hosttool-util-linux.compile: $(hosttool-util-linux_compile_deps)
	@$(call targetinfo, $@)

ifdef PTXCONF_UTLNX_SFDISK
	$(UTIL-LINUX_PATH) make -C $(HOSTTOOL_UTIL-LINUX_DIR)/fdisk sfdisk
endif

ifdef PTXCONF_UTLNX_FDISK
	$(UTIL-LINUX_PATH) make -C $(HOSTTOOL_UTIL-LINUX_DIR)/fdisk fdisk
endif

ifdef PTXCONF_UTLNX_CFFDISK
	$(UTIL-LINUX_PATH) make -C $(HOSTTOOL_UTIL-LINUX_DIR)/fdisk cfdisk
endif

# ----------------------------------------------------------------------------
# Hosttool Install
# ----------------------------------------------------------------------------

hosttool-util-linux_install: $(STATEDIR)/hosttool-util-linux.install

$(STATEDIR)/hosttool-util-linux.install: $(STATEDIR)/hosttool-util-linux.compile
	@$(call targetinfo, $@)

	# FIXME: packetize

ifdef PTXCONF_UTLNX_SFDISK
	install -D $(HOSTTOOL_UTIL-LINUX_DIR)/fdisk/sfdisk \
		$(PTXCONF_PREFIX)/sbin/sfdisk
endif

ifdef PTXCONF_UTLNX_FDISK
	install -D $(HOSTTOOL_UTIL-LINUX_DIR)/fdisk/sfdisk \
		$(PTXCONF_PREFIX)/sbin/sfdisk
endif

ifdef PTXCONF_UTLNX_CFFDISK
	install -D $(HOSTTOOL_UTIL-LINUX_DIR)/fdisk/sfdisk \
		$(PTXCONF_PREFIX)/sbin/sfdisk
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Hosttool Clean
# ----------------------------------------------------------------------------

hosttool-util-linux_clean:
	rm -rf $(STATEDIR)/hosttool-util-linux.*
	rm -rf $(HOSTTOOL_UTIL-LINUX_DIR)

# vim: syntax=make
