# -*-makefile-*-
#
# Copyright (C) 2009 by Jon Ringle <jon@ringle.org>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_INITRAMFS_TOOLS) += initramfs-tools

#
# Paths and names
#
INITRAMFS_TOOLS_VERSION	:= 0.130
INITRAMFS_TOOLS_MD5	:= f219c0277766104005419ee35151c5d4
INITRAMFS_TOOLS_SUFFIX	:= tar.gz
INITRAMFS_TOOLS		:= initramfs-tools-v$(INITRAMFS_TOOLS_VERSION)
INITRAMFS_TOOLS_TARBALL	:= $(INITRAMFS_TOOLS).$(INITRAMFS_TOOLS_SUFFIX)
INITRAMFS_TOOLS_URL	:= https://salsa.debian.org/kernel-team/initramfs-tools/-/archive/v$(INITRAMFS_TOOLS_VERSION)/$(INITRAMFS_TOOLS_TARBALL)
INITRAMFS_TOOLS_SOURCE	:= $(SRCDIR)/$(INITRAMFS_TOOLS_TARBALL)
INITRAMFS_TOOLS_DIR	:= $(BUILDDIR)/$(INITRAMFS_TOOLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-tools.prepare:
	@$(call targetinfo)
	@echo "DPKG_ARCH=$(PTXCONF_ARCH_STRING)" > $(INITRAMFS_TOOLS_DIR)/conf/arch.conf
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-tools.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-tools.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, initramfs-tools)
	@$(call install_fixup, initramfs-tools,PRIORITY,optional)
	@$(call install_fixup, initramfs-tools,SECTION,base)
	@$(call install_fixup, initramfs-tools,AUTHOR,"Jon Ringle <jon@ringle.org>")
	@$(call install_fixup, initramfs-tools,DESCRIPTION,missing)

	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /init)
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /conf/initramfs.conf)
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /conf/arch.conf)
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /scripts/functions)

ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_INIT
	@cd $(INITRAMFS_TOOLS_DIR) && \
		find scripts/init-* -type d | while read dir; do \
			$(call install_alternative_tree, initramfs-tools, 0, 0, /$${dir}$(ptx/nl)); \
		done
endif

ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_LOCAL
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /scripts/local)
	@cd $(INITRAMFS_TOOLS_DIR) && \
		find scripts/local-* -type d | while read dir; do \
			$(call install_alternative_tree, initramfs-tools, 0, 0, /$${dir}$(ptx/nl)); \
		done
endif

ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_NFS
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /scripts/nfs)
	@cd $(INITRAMFS_TOOLS_DIR) && \
		find scripts/nfs-* -type d | while read dir; do \
			$(call install_alternative_tree, initramfs-tools, 0, 0, /$${dir}$(ptx/nl)); \
		done
endif

	@$(call install_finish, initramfs-tools)
	@$(call touch)

# vim: syntax=make
