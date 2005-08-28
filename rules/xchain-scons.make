# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Dan Kegel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_XCHAIN-SCONS
PACKAGES += xchain-scons
endif

#
# Paths and names
#
XCHAIN-SCONS_VERSION	= 0.93
XCHAIN-SCONS		= scons-$(XCHAIN-SCONS_VERSION)
XCHAIN-SCONS_SUFFIX	= tar.gz
XCHAIN-SCONS_URL	= $(PTXCONF_SETUP_SFMIRROR)/scons/$(XCHAIN-SCONS).$(XCHAIN-SCONS_SUFFIX)
XCHAIN-SCONS_SOURCE	= $(SRCDIR)/$(XCHAIN-SCONS).$(XCHAIN-SCONS_SUFFIX)
XCHAIN-SCONS_DIR	= $(BUILDDIR)/$(XCHAIN-SCONS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-scons_get: $(STATEDIR)/xchain-scons.get

xchain-scons_get_deps = $(XCHAIN-SCONS_SOURCE)

$(STATEDIR)/xchain-scons.get: $(xchain-scons_get_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

$(XCHAIN-SCONS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XCHAIN-SCONS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-scons_extract: $(STATEDIR)/xchain-scons.extract

xchain-scons_extract_deps = $(STATEDIR)/xchain-scons.get

$(STATEDIR)/xchain-scons.extract: $(xchain-scons_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN-SCONS_DIR))
	@$(call extract, $(XCHAIN-SCONS_SOURCE))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-scons_prepare: $(STATEDIR)/xchain-scons.prepare

#
# dependencies
#
xchain-scons_prepare_deps =  \
	$(STATEDIR)/xchain-scons.extract

$(STATEDIR)/xchain-scons.prepare: $(xchain-scons_prepare_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-scons_compile: $(STATEDIR)/xchain-scons.compile

xchain-scons_compile_deps = $(STATEDIR)/xchain-scons.prepare

$(STATEDIR)/xchain-scons.compile: $(xchain-scons_compile_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-scons_install: $(STATEDIR)/xchain-scons.install

$(STATEDIR)/xchain-scons.install: $(STATEDIR)/xchain-scons.compile
	@$(call targetinfo, $@)
	cd $(XCHAIN-SCONS_DIR) && \
		python setup.py install --prefix=$(PTXCONF_PREFIX)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-scons_targetinstall: $(STATEDIR)/xchain-scons.targetinstall

xchain-scons_targetinstall_deps	= $(STATEDIR)/xchain-scons.install

$(STATEDIR)/xchain-scons.targetinstall: $(xchain-scons_targetinstall_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-scons_clean:
	rm -rf $(STATEDIR)/xchain-scons.*
	rm -rf $(XCHAIN-SCONS_DIR)

# vim: syntax=make
