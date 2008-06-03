# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LOGROTATE) += logrotate

#
# Paths and names
#
LOGROTATE_VERSION	:= 3.7.1
LOGROTATE		:= logrotate-$(LOGROTATE_VERSION)
LOGROTATE_SUFFIX	:= tar.gz
LOGROTATE_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(LOGROTATE).$(LOGROTATE_SUFFIX)
LOGROTATE_SOURCE	:= $(SRCDIR)/$(LOGROTATE).$(LOGROTATE_SUFFIX)
LOGROTATE_DIR		:= $(BUILDDIR)/$(LOGROTATE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

logrotate_get: $(STATEDIR)/logrotate.get

$(STATEDIR)/logrotate.get: $(logrotate_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LOGROTATE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LOGROTATE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

logrotate_extract: $(STATEDIR)/logrotate.extract

$(STATEDIR)/logrotate.extract: $(logrotate_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LOGROTATE_DIR))
	@$(call extract, LOGROTATE)
	@$(call patchin, LOGROTATE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

logrotate_prepare: $(STATEDIR)/logrotate.prepare

LOGROTATE_PATH	:= PATH=$(CROSS_PATH)
LOGROTATE_ENV 	:= $(CROSS_ENV) RPM_OPT_FLAGS='$(strip $(CROSS_CPPFLAGS))'

LOGROTATE_MAKEVARS := OS_NAME=Linux LFS=-D_FILE_OFFSET_BITS=64

$(STATEDIR)/logrotate.prepare: $(logrotate_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

logrotate_compile: $(STATEDIR)/logrotate.compile

$(STATEDIR)/logrotate.compile: $(logrotate_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LOGROTATE_DIR) && $(LOGROTATE_ENV) $(LOGROTATE_PATH) $(MAKE) $(LOGROTATE_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

logrotate_install: $(STATEDIR)/logrotate.install

$(STATEDIR)/logrotate.install: $(logrotate_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

logrotate_targetinstall: $(STATEDIR)/logrotate.targetinstall

$(STATEDIR)/logrotate.targetinstall: $(logrotate_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, logrotate)
	@$(call install_fixup,logrotate,PACKAGE,logrotate)
	@$(call install_fixup,logrotate,PRIORITY,optional)
	@$(call install_fixup,logrotate,VERSION,$(LOGROTATE_VERSION))
	@$(call install_fixup,logrotate,SECTION,base)
	@$(call install_fixup,logrotate,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,logrotate,DEPENDS,)
	@$(call install_fixup,logrotate,DESCRIPTION,missing)

	@$(call install_copy, logrotate, 0, 0, 0755, $(LOGROTATE_DIR)/logrotate, /usr/sbin/logrotate)

	@$(call install_finish,logrotate)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

logrotate_clean:
	rm -rf $(STATEDIR)/logrotate.*
	rm -rf $(PKGDIR)/logrotate_*
	rm -rf $(LOGROTATE_DIR)

# vim: syntax=make
