# -*-makefile-*-
# $Id: addons.make,v 1.1 2003/09/02 14:10:22 robert Exp $
#
# (c) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
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
	@$(call targetinfo, addons.get)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

addons_extract: $(STATEDIR)/addons.extract

$(STATEDIR)/addons.extract: $(STATEDIR)/addons.get
	@$(call targetinfo, addons.extract)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

addons_prepare: $(STATEDIR)/addons.prepare

$(STATEDIR)/addons.prepare: $(STATEDIR)/addons.extract
	@$(call targetinfo, addons.prepare)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

addons_compile: $(STATEDIR)/addons.compile

$(STATEDIR)/addons.compile: $(STATEDIR)/addons.prepare
	@$(call targetinfo, addons.compile)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

addons_install: $(STATEDIR)/addons.install

$(STATEDIR)/addons.install: $(STATEDIR)/addons.compile
	@$(call targetinfo, addons.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

addons_targetinstall: $(STATEDIR)/addons.targetinstall

addons_targetinstall_deps	=  $(STATEDIR)/addons.compile

$(STATEDIR)/addons.targetinstall: $(addons_targetinstall_deps)
	@$(call targetinfo, addons.targetinstall)
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
