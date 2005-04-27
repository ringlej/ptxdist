# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_SYSVINIT
PACKAGES += sysvinit
endif

#
# Paths and names
#
SYSVINIT_VERSION	= 2.85
SYSVINIT		= sysvinit-$(SYSVINIT_VERSION)
SYSVINIT_SUFFIX		= tar.gz
SYSVINIT_URL		= ftp://ftp.cistron.nl/pub/people/miquels/software/$(SYSVINIT).$(SYSVINIT_SUFFIX)
SYSVINIT_SOURCE		= $(SRCDIR)/$(SYSVINIT).$(SYSVINIT_SUFFIX)
SYSVINIT_DIR		= $(BUILDDIR)/$(SYSVINIT)/src

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sysvinit_get: $(STATEDIR)/sysvinit.get

sysvinit_get_deps = $(SYSVINIT_SOURCE)

$(STATEDIR)/sysvinit.get: $(sysvinit_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(SYSVINIT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SYSVINIT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sysvinit_extract: $(STATEDIR)/sysvinit.extract

sysvinit_extract_deps = $(STATEDIR)/sysvinit.get

$(STATEDIR)/sysvinit.extract: $(sysvinit_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SYSVINIT_DIR))
	@$(call extract, $(SYSVINIT_SOURCE))
	@$(call patchin, $(SYSVINIT))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sysvinit_prepare: $(STATEDIR)/sysvinit.prepare

#
# dependencies
#
sysvinit_prepare_deps = \
	$(STATEDIR)/sysvinit.extract \
	$(STATEDIR)/virtual-xchain.install

SYSVINIT_PATH	=  PATH=$(CROSS_PATH)
SYSVINIT_ENV 	=  $(CROSS_ENV)
#SYSVINIT_ENV	+=

$(STATEDIR)/sysvinit.prepare: $(sysvinit_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SYSVINIT_DIR)/config.cache)
	cd $(SYSVINIT_DIR) && $(SYSVINIT_PATH) \
		perl -i -p -e 's/CC.*=.*//g' $(SYSVINIT_DIR)/Makefile
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sysvinit_compile: $(STATEDIR)/sysvinit.compile

sysvinit_compile_deps = $(STATEDIR)/sysvinit.prepare

$(STATEDIR)/sysvinit.compile: $(sysvinit_compile_deps)
	@$(call targetinfo, $@)
	cd $(SYSVINIT_DIR) && $(SYSVINIT_PATH) $(SYSVINIT_ENV) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sysvinit_install: $(STATEDIR)/sysvinit.install

$(STATEDIR)/sysvinit.install: $(STATEDIR)/sysvinit.compile
	@$(call targetinfo, $@)
#	$(SYSVINIT_PATH) make -C $(SYSVINIT_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sysvinit_targetinstall: $(STATEDIR)/sysvinit.targetinstall

sysvinit_targetinstall_deps = $(STATEDIR)/sysvinit.compile

$(STATEDIR)/sysvinit.targetinstall: $(sysvinit_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,sysvinit)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(SYSVINIT_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

	# FIXME: this should be fixed
	$(SYSVINIT_PATH) ROOT=$(ROOTDIR) make -C $(SYSVINIT_DIR) install
	$(SYSVINIT_PATH) ROOT=$(IMAGEIR)/ipkg make -C $(SYSVINIT_DIR) install

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sysvinit_clean:
	rm -rf $(STATEDIR)/sysvinit.*
	rm -rf $(IMAGEDIR)/sysvinit_*
	rm -rf $(SYSVINIT_DIR)

# vim: syntax=make
