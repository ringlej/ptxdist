# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
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
PACKAGES-$(PTXCONF_LTRACE) += ltrace

#
# Paths and names
#
LTRACE_VERSION	:= 0.4
LTRACE		:= ltrace-$(LTRACE_VERSION)
LTRACE_SUFFIX	:= tar.gz
LTRACE_TARBALL	:= ltrace_$(LTRACE_VERSION).orig.$(LTRACE_SUFFIX)
LTRACE_URL	:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/l/ltrace/$(LTRACE_TARBALL)
LTRACE_SOURCE	:= $(SRCDIR)/$(LTRACE_TARBALL)
LTRACE_DIR	:= $(BUILDDIR)/$(LTRACE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltrace_get: $(STATEDIR)/ltrace.get

$(STATEDIR)/ltrace.get: $(ltrace_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LTRACE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LTRACE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltrace_extract: $(STATEDIR)/ltrace.extract

$(STATEDIR)/ltrace.extract: $(ltrace_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LTRACE_DIR))
	@$(call extract, LTRACE)
	@$(call patchin, LTRACE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltrace_prepare: $(STATEDIR)/ltrace.prepare

LTRACE_PATH	:= PATH=$(CROSS_PATH)
LTRACE_ENV 	:= $(CROSS_ENV)
LTRACE_MAKEVARS	:= ARCH=$(SHORT_TARGET)

#
# autoconf
#
LTRACE_AUTOCONF := $(CROSS_AUTOCONF_USR) --target=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/ltrace.prepare: $(ltrace_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LTRACE_DIR)/config.cache)
	cd $(LTRACE_DIR) && \
		$(LTRACE_PATH) $(LTRACE_ENV) \
		./configure $(LTRACE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltrace_compile: $(STATEDIR)/ltrace.compile

$(STATEDIR)/ltrace.compile: $(ltrace_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LTRACE_DIR) && $(LTRACE_PATH) make $(LTRACE_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltrace_install: $(STATEDIR)/ltrace.install

$(STATEDIR)/ltrace.install: $(ltrace_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LTRACE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltrace_targetinstall: $(STATEDIR)/ltrace.targetinstall

$(STATEDIR)/ltrace.targetinstall: $(ltrace_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, ltrace)
	@$(call install_fixup,ltrace,PACKAGE,ltrace)
	@$(call install_fixup,ltrace,PRIORITY,optional)
	@$(call install_fixup,ltrace,VERSION,$(LTRACE_VERSION))
	@$(call install_fixup,ltrace,SECTION,base)
	@$(call install_fixup,ltrace,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,ltrace,DEPENDS,)
	@$(call install_fixup,ltrace,DESCRIPTION,missing)

	@$(call install_copy, ltrace, 0, 0, 0755, $(LTRACE_DIR)/ltrace, /usr/bin/ltrace)

	@$(call install_finish,ltrace)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltrace_clean:
	rm -rf $(STATEDIR)/ltrace.*
	rm -rf $(IMAGEDIR)/ltrace_*
	rm -rf $(LTRACE_DIR)

# vim: syntax=make
