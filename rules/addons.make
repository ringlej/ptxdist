# -*-makefile-*-
# $Id: addons.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_ADDONS
PACKAGES += addons
endif

ADDONS_DIR		= $(TOPDIR)/addons

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

addons_get: $(STATEDIR)/addons.get

$(STATEDIR)/addons.get:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

addons_extract: $(STATEDIR)/addons.extract

$(STATEDIR)/addons.extract: $(STATEDIR)/addons.get
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

addons_prepare: $(STATEDIR)/addons.prepare

$(STATEDIR)/addons.prepare: $(STATEDIR)/addons.extract
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

addons_compile: $(STATEDIR)/addons.compile

$(STATEDIR)/addons.compile: $(STATEDIR)/addons.prepare
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

addons_install: $(STATEDIR)/addons.install

$(STATEDIR)/addons.install: $(STATEDIR)/addons.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

addons_targetinstall: $(STATEDIR)/addons.targetinstall

addons_targetinstall_deps	=  $(STATEDIR)/addons.compile

$(STATEDIR)/addons.targetinstall: $(addons_targetinstall_deps)
	@$(call targetinfo, $@)
	@cd $(ROOTDIR) && 					\
		for i in $(ADDONS_DIR)/*.tar.gz; do 		\
			echo "Adding stuff from $$i...";	\
			tar -zxf $$i; 				\
		done; 
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

addons_clean:
	rm -rf $(STATEDIR)/addons.*
	rm -rf $(ADDONS_DIR)

# vim: syntax=make
