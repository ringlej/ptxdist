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

# FIXME: RSC: does nothing on targetinstall

#
# We provide this package
#
ifdef PTXCONF_PCMCIA-CS
PACKAGES += pcmcia-cs
endif

#
# Paths and names
#
PCMCIA-CS_VERSION	= 3.2.5
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
	touch $@

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
	touch $@

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

$(STATEDIR)/pcmcia-cs.prepare: $(pcmcia-cs_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PCMCIA-CS_BUILDDIR))
	cd $(PCMCIA-CS_DIR) && \
		echo $(KERNEL_DIR) | ./Configure
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pcmcia-cs_compile: $(STATEDIR)/pcmcia-cs.compile

pcmcia-cs_compile_deps =  $(STATEDIR)/pcmcia-cs.prepare

$(STATEDIR)/pcmcia-cs.compile: $(pcmcia-cs_compile_deps)
	@$(call targetinfo, $@)
	$(PCMCIA-CS_PATH) $(PCMCIA-CS_ENV) make -C $(PCMCIA-CS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pcmcia-cs_install: $(STATEDIR)/pcmcia-cs.install

$(STATEDIR)/pcmcia-cs.install: $(STATEDIR)/pcmcia-cs.compile
	@$(call targetinfo, $@)
	$(PCMCIA-CS_PATH) $(PCMCIA-CS_ENV) make -C $(PCMCIA-CS_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pcmcia-cs_targetinstall: $(STATEDIR)/pcmcia-cs.targetinstall

pcmcia-cs_targetinstall_deps	=  $(STATEDIR)/pcmcia-cs.compile

$(STATEDIR)/pcmcia-cs.targetinstall: $(pcmcia-cs_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pcmcia-cs_clean:
	rm -rf $(STATEDIR)/pcmcia-cs.*
	rm -rf $(IMAGEDIR)/pcmcia-cs_*
	rm -rf $(PCMCIA-CS_DIR)

# vim: syntax=make
