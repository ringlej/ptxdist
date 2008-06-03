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
PACKAGES-$(PTXCONF_MEMSTAT) += memstat

#
# Paths and names
#
MEMSTAT_VERSION	= 0.4
MEMSTAT		= memstat_$(MEMSTAT_VERSION)
MEMSTAT_SUFFIX	= tar.gz
MEMSTAT_URL	= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/m/memstat/memstat_$(MEMSTAT_VERSION).$(MEMSTAT_SUFFIX)
MEMSTAT_SOURCE	= $(SRCDIR)/memstat_$(MEMSTAT_VERSION).$(MEMSTAT_SUFFIX)
MEMSTAT_DIR	= $(BUILDDIR)/memstat-$(MEMSTAT_VERSION)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

memstat_get: $(STATEDIR)/memstat.get

$(STATEDIR)/memstat.get: $(memstat_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MEMSTAT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MEMSTAT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

memstat_extract: $(STATEDIR)/memstat.extract

$(STATEDIR)/memstat.extract: $(memstat_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MEMSTAT_DIR))
	@$(call extract, MEMSTAT)
	@$(call patchin, MEMSTAT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

memstat_prepare: $(STATEDIR)/memstat.prepare

MEMSTAT_PATH	=  PATH=$(CROSS_PATH)
MEMSTAT_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
MEMSTAT_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/memstat.prepare: $(memstat_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

memstat_compile: $(STATEDIR)/memstat.compile

$(STATEDIR)/memstat.compile: $(memstat_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MEMSTAT_DIR) && $(MEMSTAT_ENV) $(MEMSTAT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

memstat_install: $(STATEDIR)/memstat.install

$(STATEDIR)/memstat.install: $(memstat_install_deps_default)
	@$(call targetinfo, $@)
	# make install does bogus stuff
	mkdir -p $(SYSROOT)/usr/bin/
	rm -f $(SYSROOT)/usr/bin/memstat
	cp $(MEMSTAT_DIR)/memstat $(SYSROOT)/usr/bin/memstat
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

memstat_targetinstall: $(STATEDIR)/memstat.targetinstall

$(STATEDIR)/memstat.targetinstall: $(memstat_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, memstat)
	@$(call install_fixup, memstat,PACKAGE,memstat)
	@$(call install_fixup, memstat,PRIORITY,optional)
	@$(call install_fixup, memstat,VERSION,$(MEMSTAT_VERSION))
	@$(call install_fixup, memstat,SECTION,base)
	@$(call install_fixup, memstat,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, memstat,DEPENDS,)
	@$(call install_fixup, memstat,DESCRIPTION,missing)

	@$(call install_copy, memstat, 0, 0, 0755, $(MEMSTAT_DIR)/memstat, /usr/bin/memstat)
	
	@$(call install_finish, memstat)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

memstat_clean:
	rm -rf $(STATEDIR)/memstat.*
	rm -rf $(PKGDIR)/memstat_*
	rm -rf $(MEMSTAT_DIR)

# vim: syntax=make
