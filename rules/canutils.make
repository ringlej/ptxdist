# -*-makefile-*-
# $Id: template 2516 2005-04-25 10:29:55Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CANUTILS) += canutils

#
# Paths and names
#
CANUTILS_VERSION	= 1.0.5
CANUTILS		= canutils-$(CANUTILS_VERSION)
CANUTILS_SUFFIX		= tar.bz2
CANUTILS_URL		= http://www.pengutronix.de/software/socket-can/download/canutils/v1.0/$(CANUTILS).$(CANUTILS_SUFFIX)
CANUTILS_SOURCE		= $(SRCDIR)/$(CANUTILS).$(CANUTILS_SUFFIX)
CANUTILS_DIR		= $(BUILDDIR)/$(CANUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

canutils_get: $(STATEDIR)/canutils.get

canutils_get_deps = \
	$(CANUTILS_SOURCE) \
	$(RULESDIR)/canutils.make

$(STATEDIR)/canutils.get: $(canutils_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(CANUTILS))
	touch $@

$(CANUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(CANUTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

canutils_extract: $(STATEDIR)/canutils.extract

canutils_extract_deps = $(STATEDIR)/canutils.get

$(STATEDIR)/canutils.extract: $(canutils_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CANUTILS_DIR))
	@$(call extract, $(CANUTILS_SOURCE))
	@$(call patchin, $(CANUTILS))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

canutils_prepare: $(STATEDIR)/canutils.prepare

#
# dependencies
#
canutils_prepare_deps = \
	$(STATEDIR)/canutils.extract \
	$(STATEDIR)/virtual-xchain.install

CANUTILS_PATH	=  PATH=$(CROSS_PATH)
CANUTILS_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
CANUTILS_AUTOCONF =  $(CROSS_AUTOCONF)
CANUTILS_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/canutils.prepare: $(canutils_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CANUTILS_DIR)/config.cache)
	cd $(CANUTILS_DIR) && \
		$(CANUTILS_PATH) $(CANUTILS_ENV) \
		./configure $(CANUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

canutils_compile: $(STATEDIR)/canutils.compile

canutils_compile_deps = $(STATEDIR)/canutils.prepare

$(STATEDIR)/canutils.compile: $(canutils_compile_deps)
	@$(call targetinfo, $@)
	cd $(CANUTILS_DIR) && $(CANUTILS_ENV) $(CANUTILS_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

canutils_install: $(STATEDIR)/canutils.install

$(STATEDIR)/canutils.install: $(STATEDIR)/canutils.compile
	@$(call targetinfo, $@)
	cd $(CANUTILS_DIR) && $(CANUTILS_ENV) $(CANUTILS_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

canutils_targetinstall: $(STATEDIR)/canutils.targetinstall

canutils_targetinstall_deps = $(STATEDIR)/canutils.compile

$(STATEDIR)/canutils.targetinstall: $(canutils_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,canutils)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(CANUTILS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_CANUTILS_CANCONFIG
	@$(call install_copy, 0, 0, 0755, $(CANUTILS_DIR)/canconfig, /sbin/canconfig)
endif
ifdef PTXCONF_CANUTILS_CANECHO
	@$(call install_copy, 0, 0, 0755, $(CANUTILS_DIR)/canecho,   /sbin/canecho)
endif
ifdef PTXCONF_CANUTILS_CANDUMP
	@$(call install_copy, 0, 0, 0755, $(CANUTILS_DIR)/candump,   /sbin/candump)
endif
ifdef PTXCONF_CANUTILS_CANSEND
	@$(call install_copy, 0, 0, 0755, $(CANUTILS_DIR)/cansend,   /sbin/cansend)
endif
	@$(call install_finish)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

canutils_clean:
	rm -rf $(STATEDIR)/canutils.*
	rm -rf $(IMAGEDIR)/canutils_*
	rm -rf $(CANUTILS_DIR)

# vim: syntax=make
