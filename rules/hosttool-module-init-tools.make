# -*-makefile-*-
# $Id: kernel.make 2486 2005-04-19 12:18:08Z mkl $
#
# Copyright (C) 2005 Ladislav Michl <ladis@linux-mips.org>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_HOSTTOOLS_MODULE_INIT_TOOLS
PACKAGES += hosttool-module-init-tools
endif

#
# Paths and names
#
HOSTTOOLS_MODULE_INIT_TOOLS_DIR		= $(HOSTTOOLS_BUILDDIR)/$(MODULE_INIT_TOOLS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-module-init-tools_get: $(STATEDIR)/hosttool-module-init-tools.get

hosttool-module-init-tools_get_deps = $(STATEDIR)/module-init-tools.get

$(STATEDIR)/hosttool-module-init-tools.get: $(hosttool-module-init-tools_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-module-init-tools_extract: $(STATEDIR)/hosttool-module-init-tools.extract

hosttool-module-init-tools_extract_deps = $(STATEDIR)/hosttool-module-init-tools.get

$(STATEDIR)/hosttool-module-init-tools.extract: $(hosttool-module-init-tools_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOLS_MODULE_INIT_TOOLS_DIR))
	@$(call extract, $(MODULE_INIT_TOOLS_SOURCE), $(HOSTTOOLS_BUILDDIR))
	@$(call patchin, $(MODULE_INIT_TOOLS), $(HOSTTOOLS_MODULE_INIT_TOOLS_DIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-module-init-tools_prepare: $(STATEDIR)/hosttool-module-init-tools.prepare
#
# dependencies
#
hosttool-module-init-tools_prepare_deps = $(STATEDIR)/hosttool-module-init-tools.extract

HOSTTOOLS_MODULE_INIT_TOOLS_PATH	= PATH=$(CROSS_PATH) 
HOSTTOOLS_MODULE_INIT_TOOLS_ENV 	= $(HOSTCC_ENV)
HOSTTOOLS_MODULE_INIT_TOOLS_MAKEVARS	= MAN5=''
HOSTTOOLS_MODULE_INIT_TOOLS_AUTOCONF 	= \
	--prefix=$(PTXCONF_PREFIX) \
	--build=$(GNU_HOST) \
	--host=$(GNU_HOST) \
	--target=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/hosttool-module-init-tools.prepare: $(hosttool-module-init-tools_prepare_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOLS_MODULE_INIT_TOOLS_DIR) && \
		$(HOSTTOOLS_MODULE_INIT_TOOLS_PATH) $(HOSTTOOLS_MODULE_INIT_TOOLS_ENV) \
		./configure $(HOSTTOOLS_MODULE_INIT_TOOLS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-module-init-tools_compile: $(STATEDIR)/hosttool-module-init-tools.compile

hosttool-module-init-tools_compile_deps = $(STATEDIR)/hosttool-module-init-tools.prepare

$(STATEDIR)/hosttool-module-init-tools.compile: $(hosttool-module-init-tools_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOLS_MODULE_INIT_TOOLS_DIR) && \
		$(HOSTTOOLS_MODULE_INIT_TOOLS_PATH) make \
			$(HOSTTOOLS_MODULE_INIT_TOOLS_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-module-init-tools_install: $(STATEDIR)/hosttool-module-init-tools.install

hosttool-module-init-tools_install_deps = $(STATEDIR)/hosttool-module-init-tools.compile
ifdef PTXCONF_KERNEL_2_4
hosttool-module-init-tools_install_deps += $(STATEDIR)/hosttool-modutils.install
endif

$(STATEDIR)/hosttool-module-init-tools.install: $(hosttool-module-init-tools_install_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOLS_MODULE_INIT_TOOLS_DIR) && \
		$(HOSTTOOLS_MODULE_INIT_TOOLS_PATH) make install \
			$(HOSTTOOLS_MODULE_INIT_TOOLS_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-module-init-tools_targetinstall: $(STATEDIR)/hosttool-module-init-tools.targetinstall

hosttool-module-init-tools_targetinstall_deps = $(STATEDIR)/hosttool-module-init-tools.install

$(STATEDIR)/hosttool-module-init-tools.targetinstall: $(hosttool-module-init-tools_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-module-init-tools_clean:
	rm -rf $(STATEDIR)/hosttool-module-init-tools.*
	rm -rf $(HOSTTOOLS_MODULE_INIT_TOOLS_DIR)

# vim: syntax=make
