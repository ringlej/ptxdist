# -*-makefile-*-
# $Id: shorewall.make,v 1.1 2003/09/26 12:16:07 mkl Exp $
#
# (c) 2003 by Dan Kegel, Ixia Communications (http://ixiacom.com)
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_SHOREWALL
PACKAGES += shorewall
endif

#
# Paths and names
#
SHOREWALL_VERSION	= 1.4.7-RC1
SHOREWALL		= shorewall-$(SHOREWALL_VERSION)
SHOREWALL_SUFFIX	= tgz
SHOREWALL_URL		= http://www.shorewall.net/pub/shorewall/Beta/$(SHOREWALL).$(SHOREWALL_SUFFIX)
SHOREWALL_SOURCE	= $(SRCDIR)/$(SHOREWALL).$(SHOREWALL_SUFFIX)
SHOREWALL_DIR		= $(BUILDDIR)/shorewall-1.4.7

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

shorewall_get: $(STATEDIR)/shorewall.get

shorewall_get_deps	=  $(SHOREWALL_SOURCE)

$(STATEDIR)/shorewall.get: $(shorewall_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(SHOREWALL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SHOREWALL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

shorewall_extract: $(STATEDIR)/shorewall.extract

shorewall_extract_deps	=  $(STATEDIR)/shorewall.get

$(STATEDIR)/shorewall.extract: $(shorewall_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SHOREWALL_DIR))
	@$(call extract, $(SHOREWALL_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

shorewall_targetinstall: $(STATEDIR)/shorewall.targetinstall

shorewall_targetinstall_deps	=  $(STATEDIR)/shorewall.extract

# create /etc/shorewall directory before installing to keep it from
# using build system's chkconfig script to install itself!
$(STATEDIR)/shorewall.targetinstall: $(shorewall_targetinstall_deps)
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/etc/shorewall
	PREFIX=$(ROOTDIR) sh $(SHOREWALL_DIR)/install.sh /etc/init.d
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

shorewall_clean:
	rm -rf $(STATEDIR)/shorewall.*
	rm -rf $(SHOREWALL_DIR)

# vim: syntax=make
