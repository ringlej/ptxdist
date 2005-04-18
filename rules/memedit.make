# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_MEMEDIT
PACKAGES += memedit
endif

#
# Paths and names
#
MEMEDIT_VERSION		= 0.4
MEMEDIT			= memedit-$(MEMEDIT_VERSION)
MEMEDIT_SUFFIX		= tar.gz
MEMEDIT_URL		= http://www.pengutronix.de/software/memedit/downloads/$(MEMEDIT).$(MEMEDIT_SUFFIX)
MEMEDIT_SOURCE		= $(SRCDIR)/$(MEMEDIT).$(MEMEDIT_SUFFIX)
MEMEDIT_DIR		= $(BUILDDIR)/$(MEMEDIT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

memedit_get: $(STATEDIR)/memedit.get

memedit_get_deps = $(MEMEDIT_SOURCE)

$(STATEDIR)/memedit.get: $(memedit_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(MEMEDIT))
	touch $@

$(MEMEDIT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MEMEDIT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

memedit_extract: $(STATEDIR)/memedit.extract

memedit_extract_deps = $(STATEDIR)/memedit.get

$(STATEDIR)/memedit.extract: $(memedit_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MEMEDIT_DIR))
	@$(call extract, $(MEMEDIT_SOURCE))
	@$(call patchin, $(MEMEDIT))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

memedit_prepare: $(STATEDIR)/memedit.prepare

#
# dependencies
#
memedit_prepare_deps = \
	$(STATEDIR)/memedit.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/readline.install	

MEMEDIT_PATH	=  PATH=$(CROSS_PATH)
MEMEDIT_ENV 	=  $(CROSS_ENV)
#MEMEDIT_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#MEMEDIT_ENV	+=

#
# autoconf
#
MEMEDIT_AUTOCONF =  --build=$(GNU_HOST)
MEMEDIT_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
MEMEDIT_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/memedit.prepare: $(memedit_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MEMEDIT_DIR)/config.cache)
	cd $(MEMEDIT_DIR) && \
		$(MEMEDIT_PATH) $(MEMEDIT_ENV) \
		./configure $(MEMEDIT_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

memedit_compile: $(STATEDIR)/memedit.compile

memedit_compile_deps = $(STATEDIR)/memedit.prepare

$(STATEDIR)/memedit.compile: $(memedit_compile_deps)
	@$(call targetinfo, $@)
	cd $(MEMEDIT_DIR) && $(MEMEDIT_ENV) $(MEMEDIT_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

memedit_install: $(STATEDIR)/memedit.install

$(STATEDIR)/memedit.install: $(STATEDIR)/memedit.compile
	@$(call targetinfo, $@)
	cd $(MEMEDIT_DIR) && $(MEMEDIT_ENV) $(MEMEDIT_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

memedit_targetinstall: $(STATEDIR)/memedit.targetinstall

memedit_targetinstall_deps = $(STATEDIR)/memedit.compile \
			      $(STATEDIR)/readline.targetinstall

$(STATEDIR)/memedit.targetinstall: $(memedit_targetinstall_deps)
	@$(call targetinfo, $@)

	$(call install_init,default)
	$(call install_fixup,PACKAGE,memedit)
	$(call install_fixup,PRIORITY,optional)
	$(call install_fixup,VERSION,$(MEMEDIT_VERSION))
	$(call install_fixup,SECTION,base)
	$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	$(call install_fixup,DEPENDS,libc)
	$(call install_fixup,DESCRIPTION,missing)

	$(call install_copy, 0, 0, 0755, $(MEMEDIT_DIR)/memedit, /bin/memedit)

	$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

memedit_clean:
	rm -rf $(STATEDIR)/memedit.*
	rm -rf $(MEMEDIT_DIR)

# vim: syntax=make
