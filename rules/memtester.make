# -*-makefile-*-
# $Id: template 2922 2005-07-11 19:17:53Z rsc $
#
# Copyright (C) 2005 by Sascha Hauer
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MEMTESTER) += memtester

#
# Paths and names
#
MEMTESTER_VERSION	= 4.0.6
MEMTESTER		= memtester-$(MEMTESTER_VERSION)
MEMTESTER_SUFFIX	= tar.gz
MEMTESTER_URL		= http://pyropus.ca/software/memtester/old-versions/$(MEMTESTER).$(MEMTESTER_SUFFIX)
MEMTESTER_SOURCE	= $(SRCDIR)/$(MEMTESTER).$(MEMTESTER_SUFFIX)
MEMTESTER_DIR		= $(BUILDDIR)/$(MEMTESTER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

memtester_get: $(STATEDIR)/memtester.get

$(STATEDIR)/memtester.get: $(memtester_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MEMTESTER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MEMTESTER)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

memtester_extract: $(STATEDIR)/memtester.extract

$(STATEDIR)/memtester.extract: $(memtester_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MEMTESTER_DIR))
	@$(call extract, MEMTESTER)
	@$(call patchin, MEMTESTER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

memtester_prepare: $(STATEDIR)/memtester.prepare

MEMTESTER_PATH	=  PATH=$(CROSS_PATH)
MEMTESTER_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/memtester.prepare: $(memtester_prepare_deps_default)
	@$(call targetinfo, $@)
	echo "all: memtester" > $(MEMTESTER_DIR)/Makefile.ptxdist
	echo "memtester: tests.o memtester.o" >> $(MEMTESTER_DIR)/Makefile.ptxdist
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

memtester_compile: $(STATEDIR)/memtester.compile

$(STATEDIR)/memtester.compile: $(memtester_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MEMTESTER_DIR) && $(MEMTESTER_ENV) $(MEMTESTER_PATH) make -f Makefile.ptxdist
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

memtester_install: $(STATEDIR)/memtester.install

$(STATEDIR)/memtester.install: $(memtester_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

memtester_targetinstall: $(STATEDIR)/memtester.targetinstall

$(STATEDIR)/memtester.targetinstall: $(memtester_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, memtester)
	@$(call install_fixup, memtester,PACKAGE,memtester)
	@$(call install_fixup, memtester,PRIORITY,optional)
	@$(call install_fixup, memtester,VERSION,$(MEMTESTER_VERSION))
	@$(call install_fixup, memtester,SECTION,base)
	@$(call install_fixup, memtester,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, memtester,DEPENDS,)
	@$(call install_fixup, memtester,DESCRIPTION,missing)

	@$(call install_copy, memtester, 0, 0, 0755, $(MEMTESTER_DIR)/memtester, /usr/sbin/memtester)

	@$(call install_finish, memtester)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

memtester_clean:
	rm -rf $(STATEDIR)/memtester.*
	rm -rf $(PKGDIR)/memtester_*
	rm -rf $(MEMTESTER_DIR)

# vim: syntax=make
