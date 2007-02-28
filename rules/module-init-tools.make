# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
#
# Copyright (C) 2005 Ladislav Michl <ladis@linux-mips.org>
#               2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MODULE_INIT_TOOLS) += module-init-tools

#
# Paths and names
#
MODULE_INIT_TOOLS_VERSION	:= 3.3-pre1
MODULE_INIT_TOOLS		:= module-init-tools-$(MODULE_INIT_TOOLS_VERSION)
MODULE_INIT_TOOLS_SUFFIX	:= tar.bz2
MODULE_INIT_TOOLS_URL		:= http://www.kernel.org/pub/linux/utils/kernel/module-init-tools/$(MODULE_INIT_TOOLS).$(MODULE_INIT_TOOLS_SUFFIX)
MODULE_INIT_TOOLS_SOURCE	:= $(SRCDIR)/$(MODULE_INIT_TOOLS).$(MODULE_INIT_TOOLS_SUFFIX)
MODULE_INIT_TOOLS_DIR		:= $(BUILDDIR)/$(MODULE_INIT_TOOLS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

module-init-tools_get: $(STATEDIR)/module-init-tools.get

$(STATEDIR)/module-init-tools.get: $(module-init-tools_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MODULE_INIT_TOOLS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MODULE_INIT_TOOLS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

module-init-tools_extract: $(STATEDIR)/module-init-tools.extract

$(STATEDIR)/module-init-tools.extract: $(module-init-tools_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MODULE_INIT_TOOLS_DIR))
	@$(call extract, MODULE_INIT_TOOLS)
	@$(call patchin, MODULE_INIT_TOOLS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

module-init-tools_prepare: $(STATEDIR)/module-init-tools.prepare

MODULE_INIT_TOOLS_PATH	:= PATH=$(CROSS_PATH)
MODULE_INIT_TOOLS_ENV 	:= $(CROSS_ENV)
MODULE_INIT_TOOLS_MAKEVARS := MAN5="" MAN8=""

#
# autoconf
#
MODULE_INIT_TOOLS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/module-init-tools.prepare: $(module-init-tools_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MODULE_INIT_TOOLS_DIR)/config.cache)
	cd $(MODULE_INIT_TOOLS_DIR) && \
		$(MODULE_INIT_TOOLS_PATH) $(MODULE_INIT_TOOLS_ENV) \
		./configure $(MODULE_INIT_TOOLS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

module-init-tools_compile: $(STATEDIR)/module-init-tools.compile

$(STATEDIR)/module-init-tools.compile: $(module-init-tools_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MODULE_INIT_TOOLS_DIR) && $(MODULE_INIT_TOOLS_PATH) $(MAKE) $(MODULE_INIT_TOOLS_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

module-init-tools_install: $(STATEDIR)/module-init-tools.install

$(STATEDIR)/module-init-tools.install: $(module-init-tools_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, MODULE_INIT_TOOLS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

module-init-tools_targetinstall: $(STATEDIR)/module-init-tools.targetinstall

$(STATEDIR)/module-init-tools.targetinstall: $(module-init-tools_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, module-init-tools)
	@$(call install_fixup, module-init-tools,PACKAGE,module-init-tools)
	@$(call install_fixup, module-init-tools,PRIORITY,optional)
	@$(call install_fixup, module-init-tools,VERSION,$(MODULE_INIT_TOOLS_VERSION))
	@$(call install_fixup, module-init-tools,SECTION,base)
	@$(call install_fixup, module-init-tools,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, module-init-tools,DEPENDS,)
	@$(call install_fixup, module-init-tools,DESCRIPTION,missing)

ifdef PTXCONF_MODULE_INIT_TOOLS_INSMOD
	@$(call install_copy, module-init-tools, 0, 0, 0755, $(MODULE_INIT_TOOLS_DIR)/insmod, /sbin/insmod) 
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_RMMOD
	@$(call install_copy, module-init-tools, 0, 0, 0755, $(MODULE_INIT_TOOLS_DIR)/rmmod, /sbin/rmmod)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_LSMOD
	@$(call install_copy, module-init-tools, 0, 0, 0755, $(MODULE_INIT_TOOLS_DIR)/lsmod, /bin/lsmod)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_MODINFO
	@$(call install_copy, module-init-tools, 0, 0, 0755, $(MODULE_INIT_TOOLS_DIR)/modinfo, /sbin/modinfo)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_MODPROBE
	@$(call install_copy, module-init-tools, 0, 0, 0755, $(MODULE_INIT_TOOLS_DIR)/modprobe, /sbin/modprobe)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_DEPMOD
	@$(call install_copy, module-init-tools, 0, 0, 0755, $(MODULE_INIT_TOOLS_DIR)/depmod, /sbin/depmod)
endif

	@$(call install_finish, module-init-tools)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

module-init-tools_clean:
	rm -rf $(STATEDIR)/module-init-tools.*
	rm -rf $(IMAGEDIR)/module-init-tools_*
	rm -rf $(MODULE_INIT_TOOLS_DIR)

# vim: syntax=make
