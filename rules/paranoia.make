# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: RSC: does nothing on targetinstall?

#
# We provide this package
#
PACKAGES-$(PTXCONF_PARANOIA) += paranoia

#
# Paths and names
#
PARANOIA		= paranoia
PARANOIA_URL		= http://www.netlib.org/paranoia/paranoia.c
PARANOIA_SOURCE		= $(PARANOIA).c
PARANOIA_DIR		= $(BUILDDIR)/$(PARANOIA)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

paranoia_get: $(STATEDIR)/paranoia.get

$(STATEDIR)/paranoia.get: $(paranoia_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PARANOIA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PARANOIA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

paranoia_extract: $(STATEDIR)/paranoia.extract

$(STATEDIR)/paranoia.extract: $(paranoia_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PARANOIA_DIR))
	mkdir $(PARANOIA_DIR)
	cp $(PARANOIA_SRC) $(PARANOIA_DIR)
	@$(call patchin, PARANOIA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

paranoia_prepare: $(STATEDIR)/paranoia.prepare

PARANOIA_PATH	=  PATH=$(CROSS_PATH)
PARANOIA_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/paranoia.prepare: $(paranoia_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

paranoia_compile: $(STATEDIR)/paranoia.compile

$(STATEDIR)/paranoia.compile: $(paranoia_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PARANOIA_DIR) && \
		$(PARANOIA_ENV) $(PARANOIA_PATH) $(CROSS_GCC) paranoia.c -o paranoia
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

paranoia_install: $(STATEDIR)/paranoia.install

$(STATEDIR)/paranoia.install: $(paranoia_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

paranoia_targetinstall: $(STATEDIR)/paranoia.targetinstall

$(STATEDIR)/paranoia.targetinstall: $(paranoia_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

paranoia_clean:
	rm -rf $(STATEDIR)/paranoia.*
	rm -rf $(PARANOIA_DIR)

# vim: syntax=make
