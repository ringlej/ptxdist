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
INITRAMFS_TOOLS_VERSION	:= 0.93.4
INITRAMFS_TOOLS_SUFFIX	:= tar.gz
INITRAMFS_TOOLS		:= initramfs-tools
INITRAMFS_TOOLS_TARBALL	:= $(INITRAMFS_TOOLS)_$(INITRAMFS_TOOLS_VERSION).$(INITRAMFS_TOOLS_SUFFIX)
INITRAMFS_TOOLS_URL	:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/i/initramfs-tools/$(INITRAMFS_TOOLS_TARBALL)
INITRAMFS_TOOLS_SOURCE	:= $(SRCDIR)/$(INITRAMFS_TOOLS_TARBALL)
INITRAMFS_TOOLS_DIR	:= $(BUILDDIR)/$(INITRAMFS_TOOLS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(INITRAMFS_TOOLS_SOURCE):
	@$(call targetinfo)
	@$(call get, INITRAMFS_TOOLS)
	@$(call touch)

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
	@$(call install_fixup, initramfs-tools,PACKAGE,initramfs-tools)
	@$(call install_fixup, initramfs-tools,PRIORITY,optional)
	@$(call install_fixup, initramfs-tools,VERSION,$(INITRAMFS_TOOLS_VERSION))
	@$(call install_fixup, initramfs-tools,SECTION,base)
	@$(call install_fixup, initramfs-tools,AUTHOR,"Jon Ringle <jon@ringle.org>")
	@$(call install_fixup, initramfs-tools,DEPENDS,)
	@$(call install_fixup, initramfs-tools,DESCRIPTION,missing)

	@$(call install_copy,        initramfs-tools, 0, 0, 0755, /conf);
	@$(call install_copy,        initramfs-tools, 0, 0, 0755, /conf/conf.d);
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /init);
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /conf/initramfs.conf);
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /conf/arch.conf);

	@$(call install_copy,        initramfs-tools, 0, 0, 0755, /scripts);
	@$(call install_copy,        initramfs-tools, 0, 0, 0755, /scripts/init-top);
	@$(call install_copy,        initramfs-tools, 0, 0, 0755, /scripts/init-premount);
	@$(call install_copy,        initramfs-tools, 0, 0, 0755, /scripts/init-bottom);
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /scripts/functions);

ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_INIT
	@cd $(INITRAMFS_TOOLS_DIR) && \
		find scripts/init-* -type f | while read file; do \
			$(call install_alternative, initramfs-tools, 0, 0, 0755, /$${file}); \
		done
endif

ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_LOCAL
	@$(call install_copy,        initramfs-tools, 0, 0, 0755, /scripts/local-top);
	@$(call install_copy,        initramfs-tools, 0, 0, 0755, /scripts/local-premount);
	@$(call install_copy,        initramfs-tools, 0, 0, 0755, /scripts/local-bottom);
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /scripts/local);
	@cd $(INITRAMFS_TOOLS_DIR) && \
		find scripts/local-* -type f | while read file; do \
			$(call install_alternative, initramfs-tools, 0, 0, 0755, /$${file}); \
		done
endif

ifdef PTXCONF_INITRAMFS_TOOLS_SCRIPTS_NFS
	@$(call install_copy,        initramfs-tools, 0, 0, 0755, /scripts/nfs-top);
	@$(call install_copy,        initramfs-tools, 0, 0, 0755, /scripts/nfs-premount);
	@$(call install_copy,        initramfs-tools, 0, 0, 0755, /scripts/nfs-bottom);
	@$(call install_alternative, initramfs-tools, 0, 0, 0755, /scripts/nfs);
endif

ifdef PTXCONF_INITRAMFS_SPEC
	@$(call install_spec, initramfs-tools, $(PTXCONF_INITRAMFS_SPEC_FILE));
endif

	@$(call install_finish, initramfs-tools)
	@$(call touch)

# vim: syntax=make
