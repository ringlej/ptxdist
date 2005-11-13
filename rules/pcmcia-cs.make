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
# We provide this package
#
PACKAGES-$(PTXCONF_PCMCIA_TOOLS) += pcmcia-cs

#
# Paths and names
#
PCMCIA-CS_VERSION	= 3.2.8
PCMCIA-CS		= pcmcia-cs-$(PCMCIA-CS_VERSION)
PCMCIA-CS_SUFFIX	= tar.gz
PCMCIA-CS_URL		= $(PTXCONF_SETUP_SFMIRROR)/pcmcia-cs/$(PCMCIA-CS).$(PCMCIA-CS_SUFFIX)
PCMCIA-CS_SOURCE	= $(SRCDIR)/$(PCMCIA-CS).$(PCMCIA-CS_SUFFIX)
PCMCIA-CS_DIR		= $(BUILDDIR)/$(PCMCIA-CS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pcmcia-cs_get: $(STATEDIR)/pcmcia-cs.get

pcmcia-cs_get_deps	=  $(PCMCIA-CS_SOURCE)

$(STATEDIR)/pcmcia-cs.get: $(pcmcia-cs_get_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

$(PCMCIA-CS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PCMCIA-CS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pcmcia-cs_extract: $(STATEDIR)/pcmcia-cs.extract

pcmcia-cs_extract_deps	=  $(STATEDIR)/pcmcia-cs.get

$(STATEDIR)/pcmcia-cs.extract: $(pcmcia-cs_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PCMCIA-CS_DIR))
	@$(call extract, $(PCMCIA-CS_SOURCE))
	@$(call patchin, $(PCMCIA-CS))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pcmcia-cs_prepare: $(STATEDIR)/pcmcia-cs.prepare

#
# dependencies
#
pcmcia-cs_prepare_deps =  \
	$(STATEDIR)/pcmcia-cs.extract \
	$(STATEDIR)/virtual-xchain.install

PCMCIA-CS_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
PCMCIA-CS_ENV 	=  $(CROSS_ENV)
#PCMCIA-CS_ENV	+=

PCMCIA-CS_CONF	=  --noprompt
PCMCIA-CS_CONF	+= --kernel=$(KERNEL_DIR)
PCMCIA-CS_CONF	+= --target=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
#PCMCIA-CS_CONF	+= --moddir=$(ROOTDIR)/lib/modules/$(KERNEL_VERSION)
PCMCIA-CS_CONF	+= --moddir=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/modules/$(KERNEL_VERSION)
PCMCIA-CS_CONF	+= --arch=$(PTXCONF_ARCH)
PCMCIA-CS_CONF	+= --ucc=$(COMPILER_PREFIX)gcc
PCMCIA-CS_CONF	+= --kcc=$(COMPILER_PREFIX)gcc
PCMCIA-CS_CONF	+= --ld=$(COMPILER_PREFIX)ld

# FIXME: We could make the following optional as well in rules/pcmcia-cs.in
PCMCIA-CS_CONF	+= --trust --nocardbus --nopnp --noapm --srctree --bsd

#PCMCIA-CS_CONF	+= --kflags=-I$(KERNEL_DIR)/include
#PCMCIA-CS_CONF	+= --uflags=-I$(KERNEL_DIR)/include

$(STATEDIR)/pcmcia-cs.prepare: $(pcmcia-cs_prepare_deps)
	@$(call targetinfo, $@)
	chmod u+w $(PCMCIA-CS_DIR)/man/*
	cd $(PCMCIA-CS_DIR) && \
		./Configure $(PCMCIA-CS_CONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pcmcia-cs_compile: $(STATEDIR)/pcmcia-cs.compile

pcmcia-cs_compile_deps =  $(STATEDIR)/pcmcia-cs.prepare

$(STATEDIR)/pcmcia-cs.compile: $(pcmcia-cs_compile_deps)
	@$(call targetinfo, $@)
	$(PCMCIA-CS_PATH) $(PCMCIA-CS_ENV)	\
	$(MAKE) -C $(PCMCIA-CS_DIR) all	
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pcmcia-cs_install: $(STATEDIR)/pcmcia-cs.install

$(STATEDIR)/pcmcia-cs.install: $(STATEDIR)/pcmcia-cs.compile
	@$(call targetinfo, $@)
	$(PCMCIA-CS_PATH) $(PCMCIA-CS_ENV) make -C $(PCMCIA-CS_DIR) install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pcmcia-cs_targetinstall: $(STATEDIR)/pcmcia-cs.targetinstall

pcmcia-cs_targetinstall_deps	=  $(STATEDIR)/pcmcia-cs.install

$(STATEDIR)/pcmcia-cs.targetinstall: $(pcmcia-cs_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,pcmcia-cs)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PCMCIA-CS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_PCMCIA_TOOLS_CARDMGR
	@$(call install_copy, 0, 0, 0755, $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sbin/cardmgr, /sbin/cardmgr)
	@$(call install_copy, 0, 0, 0755, $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sbin/cardctl, /sbin/cardctl)
endif

ifdef PTXCONF_PCMCIA_TOOLS_MISC
	# FIXME: There are more. Which ones are needed?
	@$(call install_copy, 0, 0, 0755, $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sbin/ifport, /sbin/ifport)
	@$(call install_copy, 0, 0, 0755, $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sbin/ifuser, /sbin/ifuser)
	@$(call install_copy, 0, 0, 0755, $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sbin/ide_info, /sbin/ide_info)
endif

ifdef PTXCONF_PCMCIA_TOOLS_FTL
	@$(call install_copy, 0, 0, 0755, $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sbin/ftl_format, /sbin/ftl_format)
	@$(call install_copy, 0, 0, 0755, $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sbin/ftl_check, /sbin/ftl_check)
endif

ifdef PTXCONF_PCMCIA_TOOLS_DEBUG
	@$(call install_copy, 0, 0, 0755, $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sbin/dump_cis, /sbin/dump_cis)
	@$(call install_copy, 0, 0, 0755, $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/sbin/pack_cis, /sbin/pack_cis)
endif

	# FIXME: Maybe we want to add an install option for  /etc/rc.d/rc.pcmcia
	#        and all the stuff that goes into /etc/pcmcia
	#        For now this is a task for vendortweaks.

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pcmcia-cs_clean:
	rm -rf $(STATEDIR)/pcmcia-cs.*
	rm -rf $(IMAGEDIR)/pcmcia-cs_*
	rm -rf $(PCMCIA-CS_DIR)

# vim: syntax=make
