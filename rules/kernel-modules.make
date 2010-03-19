# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KERNEL_MODULES) += kernel-modules

#
# Paths and names
#
KERNEL_MODULES_VERSION	:= $(KERNEL_VERSION)
KERNEL_MODULES		:= kernel-modules-$(KERNEL_MODULES_VERSION)
KERNEL_MODULES_DIR		:= $(BUILDDIR)/$(KERNEL_MODULES)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(KERNEL_MODULES_SOURCE):
	@$(call targetinfo)
	@$(call get, KERNEL_MODULES)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel-modules.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KERNEL_MODULES_PATH	:= PATH=$(CROSS_PATH)
KERNEL_MODULES_ENV 	:= $(CROSS_ENV)

$(STATEDIR)/kernel-modules.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel-modules.compile: $(STATEDIR)/kernel.prepare
	@$(call targetinfo)
	cd $(KERNEL_DIR) && $(KERNEL_PATH) $(MAKE) \
		$(KERNEL_MAKEVARS) $(PTXCONF_KERNEL_MODULES_BUILD)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel-modules.install:
	@$(call targetinfo)
	@$(call clean, $(KERNEL_MODULES_PKGDIR))
	@cd $(KERNEL_DIR) && $(KERNEL_PATH) $(MAKE) \
		$(filter-out INSTALL_MOD_PATH=%,$(KERNEL_MAKEVARS)) \
		INSTALL_MOD_PATH=$(KERNEL_MODULES_PKGDIR) \
		modules_install

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel-modules.targetinstall:
	@$(call targetinfo)
	@$(call install_init,  kernel-modules)
	@$(call install_fixup, kernel-modules, PACKAGE,kernel-modules)
	@$(call install_fixup, kernel-modules, PRIORITY,optional)
	@$(call install_fixup, kernel-modules, VERSION,$(KERNEL_VERSION))
	@$(call install_fixup, kernel-modules, SECTION,base)
	@$(call install_fixup, kernel-modules, AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, kernel-modules, DEPENDS,)
	@$(call install_fixup, kernel-modules, DESCRIPTION,missing)

	@cd $(KERNEL_MODULES_PKGDIR) && \
	find lib -type d | while read dir; do \
		$(call install_copy, kernel-modules, 0, 0, 0755, /$${dir}); \
	done

ifdef PTXCONF_KERNEL_MODULES_ALL
	@cd $(KERNEL_MODULES_PKGDIR) && \
	find lib -type f | while read file; do \
		$(call install_copy, kernel-modules, 0, 0, 0644, -, /$${file}, k); \
	done
endif

ifdef PTXCONF_KERNEL_MODULES_USER_SPEC

ifdef PTXCONF_KERNEL_MODULES_INSTALL_MODULES_INFO
	cd $(KERNEL_MODULES_PKGDIR) && \
	find lib -name "modules.*" | while read file; do \
		$(call install_copy, kernel-modules, 0, 0, 0644, -, /$${file}); \
	done
endif

	@KVER="$$(cat $(KERNEL_DIR)/include/config/kernel.release)"; \
	cd $(KERNEL_MODULES_PKGDIR) && while read file; do \
		$(call install_copy, kernel-modules, 0, 0, 0644, -, /lib/modules/$${KVER}/$${file}, k); \
	done < $(call remove_quotes, $(PTXCONF_KERNEL_MODULES_USER_SPEC_FILE))
endif

	@$(call install_finish, kernel-modules)
	@$(call touch)

# vim: syntax=make
