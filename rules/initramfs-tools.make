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
	@echo "DPKG_ARCH=$(call remove_quotes, $(PTXCONF_ARCH_STRING))" > $(INITRAMFS_TOOLS_DIR)/conf/arch.conf
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
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /scripts/local)
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /scripts/nfs)

ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_INIT_TOP
	@$(call install_alternative_tree, initramfs-tools, 0, 0, /scripts/init-top/)
endif
ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_INIT_PREMOUNT
	@$(call install_alternative_tree, initramfs-tools, 0, 0, /scripts/init-premount/)
endif
ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_INIT_BOTTOM
	@$(call install_alternative_tree, initramfs-tools, 0, 0, /scripts/init-bottom/)
endif

ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_LOCAL_TOP
	@$(call install_alternative_tree, initramfs-tools, 0, 0, /scripts/local-top/)
endif
ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_LOCAL_BLOCK
	@$(call install_alternative_tree, initramfs-tools, 0, 0, /scripts/local-block/)
endif
ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_LOCAL_PREMOUNT
	@$(call install_alternative_tree, initramfs-tools, 0, 0, /scripts/local-premount/)
endif
ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_LOCAL_BOTTOM
	@$(call install_alternative_tree, initramfs-tools, 0, 0, /scripts/local-bottom/)
endif

ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_NFS_TOP
	@$(call install_alternative_tree, initramfs-tools, 0, 0, /scripts/nfs-top/)
endif
ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_NFS_PREMOUNT
	@$(call install_alternative_tree, initramfs-tools, 0, 0, /scripts/nfs-premount/)
endif
ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_NFS_BOTTOM
	@$(call install_alternative_tree, initramfs-tools, 0, 0, /scripts/nfs-bottom/)
endif

	@$(call install_finish, initramfs-tools)
	@$(call touch)

# vim: syntax=make
