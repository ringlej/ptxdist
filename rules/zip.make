#
# Copyright (C) 2007 by Ladislav Michl
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ZIP) += zip

#
# Paths and names
# (zip is packaged a bit unusual way, that's why two version variables exist)
#
ZIP_VERSION	:= 2.32
ZIP_AVERSION	:= 232
ZIP_ARCHIVE	:= zip$(ZIP_AVERSION).tgz
ZIP		:= zip-$(ZIP_VERSION)
ZIP_URL		:= http://www.mirrorservice.org/sites/ftp.info-zip.org/pub/infozip/src/$(ZIP_ARCHIVE)
ZIP_SOURCE	:= $(SRCDIR)/$(ZIP_ARCHIVE)
ZIP_DIR		:= $(BUILDDIR)/$(ZIP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

zip_get: $(STATEDIR)/zip.get

$(STATEDIR)/zip.get: $(zip_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ZIP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, ZIP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

zip_extract: $(STATEDIR)/zip.extract

$(STATEDIR)/zip.extract: $(zip_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ZIP_DIR))
	@$(call extract, ZIP)
	@$(call patchin, ZIP, $(ZIP))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

zip_prepare: $(STATEDIR)/zip.prepare

ZIP_PATH	:= PATH=$(CROSS_PATH)
ZIP_ENV 	:= $(CROSS_ENV) CROSS_COMPILE=$(COMPILER_PREFIX)

$(STATEDIR)/zip.prepare: $(zip_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

zip_compile: $(STATEDIR)/zip.compile

$(STATEDIR)/zip.compile: $(zip_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(ZIP_DIR) && $(ZIP_PATH) \
		$(MAKE) $(ZIP_ENV) $(PARALLELMFLAGS) -f unix/Makefile generic
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

zip_install: $(STATEDIR)/zip.install

$(STATEDIR)/zip.install: $(zip_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

zip_targetinstall: $(STATEDIR)/zip.targetinstall

$(STATEDIR)/zip.targetinstall: $(zip_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, zip)
	@$(call install_fixup, zip,PACKAGE,zip)
	@$(call install_fixup, zip,PRIORITY,optional)
	@$(call install_fixup, zip,VERSION,$(ZIP_VERSION))
	@$(call install_fixup, zip,SECTION,base)
	@$(call install_fixup, zip,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, zip,DEPENDS,)
	@$(call install_fixup, zip,DESCRIPTION,missing)

ifdef PTXCONF_ZIP_ZIP
	@$(call install_copy, zip, 0, 0, 0755, $(ZIP_DIR)/zip, /usr/bin/zip)
endif
ifdef PTXCONF_ZIP_ZIPCLOAK
	@$(call install_copy, zip, 0, 0, 0755, $(ZIP_DIR)/zipcloak, /usr/bin/zipcloak)
endif
ifdef PTXCONF_ZIP_ZIPNOTE
	@$(call install_copy, zip, 0, 0, 0755, $(ZIP_DIR)/zipnote, /usr/bin/zipnote)
endif
ifdef PTXCONF_ZIP_ZIPSPLIT
	@$(call install_copy, zip, 0, 0, 0755, $(ZIP_DIR)/zipsplit, /usr/bin/zipsplit)
endif

	@$(call install_finish, zip)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

zip_clean:
	rm -rf $(STATEDIR)/zip.*
	rm -rf $(IMAGEDIR)/zip_*
	rm -rf $(ZIP_DIR)

# vim: syntax=make
