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

$(STATEDIR)/pcmcia-cs.get: $(pcmcia-cs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PCMCIA-CS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PCMCIA-CS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pcmcia-cs_extract: $(STATEDIR)/pcmcia-cs.extract

$(STATEDIR)/pcmcia-cs.extract: $(pcmcia-cs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PCMCIA-CS_DIR))
	@$(call extract, PCMCIA-CS)
	@$(call patchin, PCMCIA-CS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pcmcia-cs_prepare: $(STATEDIR)/pcmcia-cs.prepare

PCMCIA-CS_PATH	=  PATH=$(CROSS_PATH)
PCMCIA-CS_ENV 	=  $(CROSS_ENV)

PCMCIA-CS_CONF	=  --noprompt \
	--kernel=$(KERNEL_DIR) \
	--target=$(SYSROOT) \
	--moddir=$(SYSROOT)/lib/modules/$(KERNEL_VERSION) \
	--arch=$(PTXCONF_ARCH_STRING) \
	--ucc=$(COMPILER_PREFIX)gcc \
	--kcc=$(COMPILER_PREFIX)gcc \
	--ld=$(COMPILER_PREFIX)ld

#PCMCIA-CS_CONF	+= --moddir=$(ROOTDIR)/lib/modules/$(KERNEL_VERSION)

# FIXME: We could make the following optional as well in rules/pcmcia-cs.in
PCMCIA-CS_CONF	+= --trust --nocardbus --nopnp --noapm --srctree --bsd

#PCMCIA-CS_CONF	+= --kflags=-I$(KERNEL_DIR)/include
#PCMCIA-CS_CONF	+= --uflags=-I$(KERNEL_DIR)/include

$(STATEDIR)/pcmcia-cs.prepare: $(pcmcia-cs_prepare_deps_default)
	@$(call targetinfo, $@)
	chmod u+w $(PCMCIA-CS_DIR)/man/*
	cd $(PCMCIA-CS_DIR) && \
		./Configure $(PCMCIA-CS_CONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pcmcia-cs_compile: $(STATEDIR)/pcmcia-cs.compile

pcmcia-cs_compile_deps =  $(STATEDIR)/pcmcia-cs.prepare

$(STATEDIR)/pcmcia-cs.compile: $(pcmcia-cs_compile_deps_default)
	@$(call targetinfo, $@)
	$(PCMCIA-CS_PATH) $(PCMCIA-CS_ENV)	\
	$(MAKE) -C $(PCMCIA-CS_DIR) all	
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pcmcia-cs_install: $(STATEDIR)/pcmcia-cs.install

$(STATEDIR)/pcmcia-cs.install: $(pcmcia-cs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, PCMCIA-CS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pcmcia-cs_targetinstall: $(STATEDIR)/pcmcia-cs.targetinstall

$(STATEDIR)/pcmcia-cs.targetinstall: $(pcmcia-cs_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, pcmcia-cs)
	@$(call install_fixup, pcmcia-cs,PACKAGE,pcmcia-cs)
	@$(call install_fixup, pcmcia-cs,PRIORITY,optional)
	@$(call install_fixup, pcmcia-cs,VERSION,$(PCMCIA-CS_VERSION))
	@$(call install_fixup, pcmcia-cs,SECTION,base)
	@$(call install_fixup, pcmcia-cs,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, pcmcia-cs,DEPENDS,)
	@$(call install_fixup, pcmcia-cs,DESCRIPTION,missing)

ifdef PTXCONF_PCMCIA_TOOLS_CARDMGR
	@$(call install_copy, pcmcia-cs, 0, 0, 0755, $(SYSROOT)/sbin/cardmgr, /sbin/cardmgr)
	@$(call install_copy, pcmcia-cs, 0, 0, 0755, $(SYSROOT)/sbin/cardctl, /sbin/cardctl)
endif

ifdef PTXCONF_PCMCIA_TOOLS_MISC
	# FIXME: There are more. Which ones are needed?
	@$(call install_copy, pcmcia-cs, 0, 0, 0755, $(SYSROOT)/sbin/ifport, /sbin/ifport)
	@$(call install_copy, pcmcia-cs, 0, 0, 0755, $(SYSROOT)/sbin/ifuser, /sbin/ifuser)
	@$(call install_copy, pcmcia-cs, 0, 0, 0755, $(SYSROOT)/sbin/ide_info, /sbin/ide_info)
endif

ifdef PTXCONF_PCMCIA_TOOLS_FTL
	@$(call install_copy, pcmcia-cs, 0, 0, 0755, $(SYSROOT)/sbin/ftl_format, /sbin/ftl_format)
	@$(call install_copy, pcmcia-cs, 0, 0, 0755, $(SYSROOT)/sbin/ftl_check, /sbin/ftl_check)
endif

ifdef PTXCONF_PCMCIA_TOOLS_DEBUG
	@$(call install_copy, pcmcia-cs, 0, 0, 0755, $(SYSROOT)/sbin/dump_cis, /sbin/dump_cis)
	@$(call install_copy, pcmcia-cs, 0, 0, 0755, $(SYSROOT)/sbin/pack_cis, /sbin/pack_cis)
endif

	# FIXME: Maybe we want to add an install option for  /etc/rc.d/rc.pcmcia
	#        and all the stuff that goes into /etc/pcmcia
	#        For now this is a task for vendortweaks.

	@$(call install_finish, pcmcia-cs)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pcmcia-cs_clean:
	rm -rf $(STATEDIR)/pcmcia-cs.*
	rm -rf $(PKGDIR)/pcmcia-cs_*
	rm -rf $(PCMCIA-CS_DIR)

# vim: syntax=make
