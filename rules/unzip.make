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
PACKAGES-$(PTXCONF_UNZIP) += unzip

#
# Paths and names
# (unzip is packaged a bit unusual way, that's why two version variables exist)
#
UNZIP_VERSION	:= 5.52
UNZIP_AVERSION	:= 552
UNZIP_ARCHIVE	:= unzip$(UNZIP_AVERSION).tgz
UNZIP		:= unzip-$(UNZIP_VERSION)
UNZIP_URL	:= http://www.mirrorservice.org/sites/ftp.info-zip.org/pub/infozip/src/$(UNZIP_ARCHIVE)
UNZIP_SOURCE	:= $(SRCDIR)/$(UNZIP_ARCHIVE)
UNZIP_DIR	:= $(BUILDDIR)/$(UNZIP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

unzip_get: $(STATEDIR)/unzip.get

$(STATEDIR)/unzip.get: $(unzip_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(UNZIP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, UNZIP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

unzip_extract: $(STATEDIR)/unzip.extract

$(STATEDIR)/unzip.extract: $(unzip_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(UNZIP_DIR))
	@$(call extract, UNZIP)
	@$(call patchin, UNZIP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

unzip_prepare: $(STATEDIR)/unzip.prepare

UNZIP_PATH	:= PATH=$(CROSS_PATH)
UNZIP_ENV 	:= $(CROSS_ENV_CC)

$(STATEDIR)/unzip.prepare: $(unzip_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

unzip_compile: $(STATEDIR)/unzip.compile

$(STATEDIR)/unzip.compile: $(unzip_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(UNZIP_DIR) && $(UNZIP_PATH) \
		$(MAKE) $(UNZIP_ENV) $(PARALLELMFLAGS) -f unix/Makefile generic
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

unzip_install: $(STATEDIR)/unzip.install

$(STATEDIR)/unzip.install: $(unzip_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

unzip_targetinstall: $(STATEDIR)/unzip.targetinstall

$(STATEDIR)/unzip.targetinstall: $(unzip_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, unzip)
	@$(call install_fixup, unzip,PACKAGE,unzip)
	@$(call install_fixup, unzip,PRIORITY,optional)
	@$(call install_fixup, unzip,VERSION,$(UNZIP_VERSION))
	@$(call install_fixup, unzip,SECTION,base)
	@$(call install_fixup, unzip,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, unzip,DEPENDS,)
	@$(call install_fixup, unzip,DESCRIPTION,missing)

ifdef PTXCONF_UNZIP_UNZIP
	@$(call install_copy, unzip, 0, 0, 0755, $(UNZIP_DIR)/unzip, /usr/bin/unzip)
endif
ifdef PTXCONF_UNZIP_FUNZIP
	@$(call install_copy, unzip, 0, 0, 0755, $(UNZIP_DIR)/funzip, /usr/bin/funzip)
endif
ifdef PTXCONF_UNZIP_UNZIPSFX
	@$(call install_copy, unzip, 0, 0, 0755, $(UNZIP_DIR)/unzipsfx, /usr/bin/unzipsfx)
endif

	@$(call install_finish, unzip)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

unzip_clean:
	rm -rf $(STATEDIR)/unzip.*
	rm -rf $(PKGDIR)/unzip_*
	rm -rf $(UNZIP_DIR)

# vim: syntax=make
