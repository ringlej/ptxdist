# -*-makefile-*-
# $Id: xalf.make,v 1.1 2003/09/02 14:11:13 robert Exp $
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
ifdef PTXCONF_XALF
PACKAGES += xalf
endif

#
# Paths and names
#
XALF_VERSION		= 0.12
XALF			= xalf-$(XALF_VERSION)
XALF_SUFFIX		= tgz
XALF_URL		= http://www.lysator.liu.se/~astrand/projects/xalf/$(XALF).$(XALF_SUFFIX)
XALF_SOURCE		= $(SRCDIR)/$(XALF).$(XALF_SUFFIX)
XALF_DIR		= $(BUILDDIR)/$(XALF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xalf_get: $(STATEDIR)/xalf.get

xalf_get_deps	=  $(XALF_SOURCE)

$(STATEDIR)/xalf.get: $(xalf_get_deps)
	@$(call targetinfo, xalf.get)
	touch $@

$(XALF_SOURCE):
	@$(call targetinfo, $(XALF_SOURCE))
	@$(call get, $(XALF_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xalf_extract: $(STATEDIR)/xalf.extract

xalf_extract_deps	=  $(STATEDIR)/xalf.get

$(STATEDIR)/xalf.extract: $(xalf_extract_deps)
	@$(call targetinfo, xalf.extract)
	@$(call clean, $(XALF_DIR))
	@$(call extract, $(XALF_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xalf_prepare: $(STATEDIR)/xalf.prepare

#
# dependencies
#
xalf_prepare_deps =  \
	$(STATEDIR)/xalf.extract \
#	$(STATEDIR)/virtual-xchain.install

XALF_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
XALF_ENV 	=  $(CROSS_ENV)
#XALF_ENV	+=


#
# autoconf
#
XALF_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
XALF_AUTOCONF	+= --build=$(GNU_HOST)
XALF_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

#XALF_AUTOCONF	+= 

$(STATEDIR)/xalf.prepare: $(xalf_prepare_deps)
	@$(call targetinfo, xalf.prepare)
	@$(call clean, $(XALF_BUILDDIR))
	cd $(XALF_DIR) && \
		$(XALF_PATH) $(XALF_ENV) \
		./configure $(XALF_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xalf_compile: $(STATEDIR)/xalf.compile

xalf_compile_deps =  $(STATEDIR)/xalf.prepare

$(STATEDIR)/xalf.compile: $(xalf_compile_deps)
	@$(call targetinfo, xalf.compile)
	$(XALF_PATH) $(XALF_ENV) make -C $(XALF_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xalf_install: $(STATEDIR)/xalf.install

$(STATEDIR)/xalf.install: $(STATEDIR)/xalf.compile
	@$(call targetinfo, xalf.install)
	$(XALF_PATH) $(XALF_ENV) make -C $(XALF_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xalf_targetinstall: $(STATEDIR)/xalf.targetinstall

xalf_targetinstall_deps	=  $(STATEDIR)/xalf.compile

$(STATEDIR)/xalf.targetinstall: $(xalf_targetinstall_deps)
	@$(call targetinfo, xalf.targetinstall)
	install $(XALF_DIR)/src/xalf $(ROOTDIR)/usr/bin
	$(CROSSSTRIP) $(ROOTDIR)/usr/bin/xalf
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xalf_clean:
	rm -rf $(STATEDIR)/xalf.*
	rm -rf $(XALF_DIR)

# vim: syntax=make
