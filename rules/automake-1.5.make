# -*-makefile-*-
# $Id: automake-1.5.make,v 1.1 2003/09/07 18:29:42 mkl Exp $
#
# (c) 2003 by Marc Kleine-Budde
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# Paths and names
#
AUTOMAKE15_VERSION	= 1.5
AUTOMAKE15		= automake-$(AUTOMAKE15_VERSION)
AUTOMAKE15_SUFFIX	= tar.gz
AUTOMAKE15_URL		= http://ftp.gwdg.de/pub/gnu/automake/$(AUTOMAKE15).$(AUTOMAKE15_SUFFIX)
AUTOMAKE15_SOURCE	= $(SRCDIR)/$(AUTOMAKE15).$(AUTOMAKE15_SUFFIX)
AUTOMAKE15_DIR		= $(BUILDDIR)/$(AUTOMAKE15)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

automake15_get: $(STATEDIR)/automake15.get

automake15_get_deps	=  $(AUTOMAKE15_SOURCE)

$(STATEDIR)/automake15.get: $(automake15_get_deps)
	@$(call targetinfo, automake15.get)
	touch $@

$(AUTOMAKE15_SOURCE):
	@$(call targetinfo, $(AUTOMAKE15_SOURCE))
	@$(call get, $(AUTOMAKE15_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

automake15_extract: $(STATEDIR)/automake15.extract

automake15_extract_deps	=  $(STATEDIR)/automake15.get

$(STATEDIR)/automake15.extract: $(automake15_extract_deps)
	@$(call targetinfo, automake15.extract)
	@$(call clean, $(AUTOMAKE15_DIR))
	@$(call extract, $(AUTOMAKE15_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

automake15_prepare: $(STATEDIR)/automake15.prepare

#
# dependencies
#
automake15_prepare_deps =  \
	$(STATEDIR)/autoconf257.install \
	$(STATEDIR)/automake15.extract

AUTOMAKE15_PATH	=  PATH=$(PTXCONF_PREFIX)/$(AUTOCONF257)/bin:$(CROSS_PATH)

#
# autoconf
#
AUTOMAKE15_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)/$(AUTOMAKE15)

$(STATEDIR)/automake15.prepare: $(automake15_prepare_deps)
	@$(call targetinfo, automake15.prepare)
	@$(call clean, $(AUTOMAKE15_BUILDDIR))
	cd $(AUTOMAKE15_DIR) && \
		$(AUTOMAKE15_PATH) \
		./configure $(AUTOMAKE15_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

automake15_compile: $(STATEDIR)/automake15.compile

automake15_compile_deps =  $(STATEDIR)/automake15.prepare

$(STATEDIR)/automake15.compile: $(automake15_compile_deps)
	@$(call targetinfo, automake15.compile)
	$(AUTOMAKE15_PATH) make -C $(AUTOMAKE15_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

automake15_install: $(STATEDIR)/automake15.install

$(STATEDIR)/automake15.install: $(STATEDIR)/automake15.compile
	@$(call targetinfo, automake15.install)
	$(AUTOMAKE15_PATH) make -C $(AUTOMAKE15_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

automake15_targetinstall: $(STATEDIR)/automake15.targetinstall

automake15_targetinstall_deps	=

$(STATEDIR)/automake15.targetinstall: $(automake15_targetinstall_deps)
	@$(call targetinfo, automake15.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

automake15_clean:
	rm -rf $(STATEDIR)/automake15.*
	rm -rf $(AUTOMAKE15_DIR)

# vim: syntax=make
