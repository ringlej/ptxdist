# -*-makefile-*-
# $Id$
#
# Copyright (C) 2005 by BSP
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SETSERIAL) += setserial

#
# Paths and names
#
SETSERIAL_VERSION	= 2.17
SETSERIAL		= setserial-$(SETSERIAL_VERSION)
SETSERIAL_SUFFIX	= tar.gz
SETSERIAL_URL		= $(PTXCONF_SETUP_SFMIRROR)/setserial/$(SETSERIAL).$(SETSERIAL_SUFFIX)
SETSERIAL_SOURCE	= $(SRCDIR)/$(SETSERIAL).$(SETSERIAL_SUFFIX)
SETSERIAL_DIR		= $(BUILDDIR)/$(SETSERIAL)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

setserial_get: $(STATEDIR)/setserial.get

$(STATEDIR)/setserial.get: $(setserial_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SETSERIAL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SETSERIAL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

setserial_extract: $(STATEDIR)/setserial.extract

$(STATEDIR)/setserial.extract: $(setserial_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SETSERIAL_DIR))
	@$(call extract, SETSERIAL)
	@$(call patchin, SETSERIAL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

setserial_prepare: $(STATEDIR)/setserial.prepare

SETSERIAL_PATH	=  PATH=$(CROSS_PATH)
SETSERIAL_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
SETSERIAL_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/setserial.prepare: $(setserial_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SETSERIAL_DIR)/config.cache)
	cd $(SETSERIAL_DIR) && \
		$(SETSERIAL_PATH) $(SETSERIAL_ENV) \
		./configure $(SETSERIAL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

setserial_compile: $(STATEDIR)/setserial.compile

$(STATEDIR)/setserial.compile: $(setserial_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SETSERIAL_DIR) && $(SETSERIAL_ENV) $(SETSERIAL_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

setserial_install: $(STATEDIR)/setserial.install

$(STATEDIR)/setserial.install: $(setserial_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, SETSERIAL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

setserial_targetinstall: $(STATEDIR)/setserial.targetinstall

$(STATEDIR)/setserial.targetinstall: $(setserial_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, setserial)
	@$(call install_fixup, setserial,PACKAGE,setserial)
	@$(call install_fixup, setserial,PRIORITY,optional)
	@$(call install_fixup, setserial,VERSION,$(SETSERIAL_VERSION))
	@$(call install_fixup, setserial,SECTION,base)
	@$(call install_fixup, setserial,AUTHOR,"Benedikt Spranger <b.spranger\@linutronix.de>")
	@$(call install_fixup, setserial,DEPENDS,)
	@$(call install_fixup, setserial,DESCRIPTION,missing)

	@$(call install_copy, setserial, 0, 0, 0755, $(SETSERIAL_DIR)/setserial, /bin/setserial)

	@$(call install_finish, setserial)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

setserial_clean:
	rm -rf $(STATEDIR)/setserial.*
	rm -rf $(PKGDIR)/setserial_*
	rm -rf $(SETSERIAL_DIR)

# vim: syntax=make
