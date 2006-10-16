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
HOST_PACKAGES-$(PTXCONF_HOST_MODULE_INIT_TOOLS) += host-module-init-tools

#
# Paths and names
#
HOST_MODULE_INIT_TOOLS		= $(MODULE_INIT_TOOLS)
HOST_MODULE_INIT_TOOLS_DIR	= $(HOST_BUILDDIR)/$(HOST_MODULE_INIT_TOOLS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-module-init-tools_get: $(STATEDIR)/host-module-init-tools.get

#
# FIXME: This Package is probably totally broken - this dependency definition
#        is only a quick-fix to make it compile again. Please review this
#        makefile and make it a real cross- (?) or host- (?) package
#
host-module-init-tools_get_deps = $(STATEDIR)/module-init-tools.get

$(STATEDIR)/host-module-init-tools.get: $(host-module-init-tools_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-module-init-tools_extract: $(STATEDIR)/host-module-init-tools.extract

$(STATEDIR)/host-module-init-tools.extract: $(host-module-init-tools_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MODULE_INIT_TOOLS_DIR))
	@$(call extract, MODULE_INIT_TOOLS, $(HOST_BUILDDIR))
	@$(call patchin, MODULE_INIT_TOOLS, $(HOST_MODULE_INIT_TOOLS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-module-init-tools_prepare: $(STATEDIR)/host-module-init-tools.prepare

HOST_MODULE_INIT_TOOLS_PATH	= PATH=$(CROSS_PATH)
HOST_MODULE_INIT_TOOLS_ENV 	= $(HOSTCC_ENV)
HOST_MODULE_INIT_TOOLS_MAKEVARS	= MAN5=''
HOST_MODULE_INIT_TOOLS_AUTOCONF = $(HOST_AUTOCONF)

$(STATEDIR)/host-module-init-tools.prepare: $(host-module-init-tools_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_MODULE_INIT_TOOLS_DIR) && \
		$(HOST_MODULE_INIT_TOOLS_PATH) $(HOST_MODULE_INIT_TOOLS_ENV) \
		./configure $(HOST_MODULE_INIT_TOOLS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-module-init-tools_compile: $(STATEDIR)/host-module-init-tools.compile

$(STATEDIR)/host-module-init-tools.compile: $(host-module-init-tools_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_MODULE_INIT_TOOLS_DIR) && \
		$(HOST_MODULE_INIT_TOOLS_PATH) make \
			$(HOST_MODULE_INIT_TOOLS_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-module-init-tools_install: $(STATEDIR)/host-module-init-tools.install

$(STATEDIR)/host-module-init-tools.install: $(host-module-init-tools_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_MODULE_INIT_TOOLS,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-module-init-tools_targetinstall: $(STATEDIR)/host-module-init-tools.targetinstall

$(STATEDIR)/host-module-init-tools.targetinstall: $(host-module-init-tools_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-module-init-tools_clean:
	rm -rf $(STATEDIR)/host-module-init-tools.*
	rm -rf $(HOST_MODULE_INIT_TOOLS_DIR)

# vim: syntax=make
