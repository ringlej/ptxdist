# -*-makefile-*-
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
ifdef PTXCONF_MODULE_INIT_TOOLS
PACKAGES += module-init-tools
endif

#
# Paths and names
#
MODULE_INIT_TOOLS_VERSION	= 3.2-pre1
MODULE_INIT_TOOLS		= module-init-tools-$(MODULE_INIT_TOOLS_VERSION)
MODULE_INIT_TOOLS_SUFFIX	= tar.bz2
MODULE_INIT_TOOLS_URL		= http://www.kernel.org/pub/linux/utils/kernel/module-init-tools/$(MODULE_INIT_TOOLS).$(MODULE_INIT_TOOLS_SUFFIX)
MODULE_INIT_TOOLS_SOURCE	= $(SRCDIR)/$(MODULE_INIT_TOOLS).$(MODULE_INIT_TOOLS_SUFFIX)
MODULE_INIT_TOOLS_DIR		= $(BUILDDIR)/$(MODULE_INIT_TOOLS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

module-init-tools_get: $(STATEDIR)/module-init-tools.get

module-init-tools_get_deps = $(MODULE_INIT_TOOLS_SOURCE)

$(STATEDIR)/module-init-tools.get: $(module-init-tools_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(MODULE_INIT_TOOLS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MODULE_INIT_TOOLS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

module-init-tools_extract: $(STATEDIR)/module-init-tools.extract

module-init-tools_extract_deps = $(STATEDIR)/module-init-tools.get

$(STATEDIR)/module-init-tools.extract: $(module-init-tools_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MODULE_INIT_TOOLS_DIR))
	@$(call extract, $(MODULE_INIT_TOOLS_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

module-init-tools_prepare: $(STATEDIR)/module-init-tools.prepare

#
# dependencies
#
module-init-tools_prepare_deps = $(STATEDIR)/module-init-tools.extract

MODULE_INIT_TOOLS_PATH	= PATH=$(CROSS_PATH) 
MODULE_INIT_TOOLS_ENV 	= $(CROSS_ENV)
MODULE_INIT_TOOLS_AUTOCONF = \
	--prefix=$(PTXCONF_PREFIX) \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \

$(STATEDIR)/module-init-tools.prepare: $(module-init-tools_prepare_deps)
	@$(call targetinfo, $@)
	cd $(MODULE_INIT_TOOLS_DIR) && \
		$(MODULE_INIT_TOOLS_PATH) $(MODULE_INIT_TOOLS_ENV) \
		./configure $(MODULE_INIT_TOOLS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

module-init-tools_compile: $(STATEDIR)/module-init-tools.compile

module-init-tools_compile_deps = $(STATEDIR)/module-init-tools.prepare

$(STATEDIR)/module-init-tools.compile: $(module-init-tools_compile_deps)
	@$(call targetinfo, $@)
	$(MODULE_INIT_TOOLS_PATH) make -C $(MODULE_INIT_TOOLS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

module-init-tools_install: $(STATEDIR)/module-init-tools.install

$(STATEDIR)/module-init-tools.install: $(STATEDIR)/module-init-tools.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

module-init-tools_targetinstall: $(STATEDIR)/module-init-tools.targetinstall

module-init-tools_targetinstall_deps = $(STATEDIR)/module-init-tools.compile

$(STATEDIR)/module-init-tools.targetinstall: $(module-init-tools_targetinstall_deps)
	@$(call targetinfo, $@)

	$(call install_init,default)
	$(call install_fixup,PACKAGE,module-init-tools)
	$(call install_fixup,PRIORITY,optional)
	$(call install_fixup,VERSION,$(MODULE_INIT_TOOLS_VERSION))
	$(call install_fixup,SECTION,base)
	$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	$(call install_fixup,DEPENDS,libc)
	$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_MODULE_INIT_TOOLS_INSMOD
	$(CROSSSTRIP) -R .notes -R .comment $(MODULE_INIT_TOOLS_DIR)/insmod
	$(call install_copy, 0, 0, 0755, $(MODULE_INIT_TOOLS_DIR)/insmod, /sbin/insmod) 
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_RMMOD
	$(CROSSSTRIP) -R .notes -R .comment $(MODULE_INIT_TOOLS_DIR)/rmmod
	$(call install_copy, 0, 0, 0755, $(MODULE_INIT_TOOLS_DIR)/rmmod, /sbin/rmmod)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_LSMOD
	$(CROSSSTRIP) -R .notes -R .comment $(MODULE_INIT_TOOLS_DIR)/lsmod
	$(call install_copy, 0, 0, 0755, $(MODULE_INIT_TOOLS_DIR)/lsmod, /bin/lsmod)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_MODINFO
	$(CROSSSTRIP) -R .notes -R .comment $(MODULE_INIT_TOOLS_DIR)/modinfo
	$(call install_copy, 0, 0, 0755, $(MODULE_INIT_TOOLS_DIR)/modinfo, /sbin/modinfo)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_MODPROBE
	$(CROSSSTRIP) -R .notes -R .comment $(MODULE_INIT_TOOLS_DIR)/modprobe
	$(call install_copy, 0, 0, 0755, $(MODULE_INIT_TOOLS_DIR)/modprobe, /sbin/modprobe)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_DEPMOD
	$(CROSSSTRIP) -R .notes -R .comment $(MODULE_INIT_TOOLS_DIR)/depmod
	$(call install_copy, 0, 0, 0755, $(MODULE_INIT_TOOLS_DIR)/depmod, /sbin/depmod)
endif

	$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

module-init-tools_clean:
	rm -rf $(STATEDIR)/module-init-tools.*
	rm -rf $(MODULE_INIT_TOOLS_DIR)

# vim: syntax=make
