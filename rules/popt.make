# -*-makefile-*-
# $Id: popt.make,v 1.2 2003/08/28 14:27:29 mkl Exp $
#
# (c) 2003 by Benedikt Spranger <b.spranger@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_POPT
PACKAGES += popt
endif

#
# Paths and names
#
POPT_VERSION	= 1.7
POPT		= popt-$(POPT_VERSION)
POPT_SUFFIX	= tar.gz
POPT_URL	= ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.1.x/$(POPT).$(POPT_SUFFIX)
POPT_SOURCE	= $(SRCDIR)/$(POPT).$(POPT_SUFFIX)
POPT_DIR	= $(BUILDDIR)/$(POPT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

popt_get: $(STATEDIR)/popt.get

popt_get_deps	=  $(POPT_SOURCE)

$(STATEDIR)/popt.get: $(popt_get_deps)
	@$(call targetinfo, popt.get)
	touch $@

$(POPT_SOURCE):
	@$(call targetinfo, $(POPT_SOURCE))
	@$(call get, $(POPT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

popt_extract: $(STATEDIR)/popt.extract

popt_extract_deps	=  $(STATEDIR)/popt.get

$(STATEDIR)/popt.extract: $(popt_extract_deps)
	@$(call targetinfo, popt.extract)
	@$(call clean, $(POPT_DIR))
	@$(call extract, $(POPT_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

popt_prepare: $(STATEDIR)/popt.prepare

#
# dependencies
#
popt_prepare_deps =  \
	$(STATEDIR)/popt.extract \
	$(STATEDIR)/virtual-xchain.install

POPT_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
POPT_ENV 	=  $(CROSS_ENV)
#POPT_ENV	+=


#
# autoconf
#
POPT_AUTOCONF	=  --prefix=$(CROSS_LIB_DIR)
POPT_AUTOCONF	+= --build=$(GNU_HOST)
POPT_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/popt.prepare: $(popt_prepare_deps)
	@$(call targetinfo, popt.prepare)
	@$(call clean, $(POPT_BUILDDIR))
	cd $(POPT_DIR) && \
		$(POPT_PATH) $(POPT_ENV) \
		./configure $(POPT_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

popt_compile: $(STATEDIR)/popt.compile

popt_compile_deps =  $(STATEDIR)/popt.prepare

$(STATEDIR)/popt.compile: $(popt_compile_deps)
	@$(call targetinfo, popt.compile)
	$(POPT_PATH) $(POPT_ENV) make -C $(POPT_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

popt_install: $(STATEDIR)/popt.install

$(STATEDIR)/popt.install: $(STATEDIR)/popt.compile
	@$(call targetinfo, popt.install)
	$(POPT_PATH) $(POPT_ENV) make -C $(POPT_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

popt_targetinstall: $(STATEDIR)/popt.targetinstall

popt_targetinstall_deps	=  $(STATEDIR)/popt.compile

$(STATEDIR)/popt.targetinstall: $(popt_targetinstall_deps)
	@$(call targetinfo, popt.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

popt_clean:
	rm -rf $(STATEDIR)/popt.*
	rm -rf $(POPT_DIR)

# vim: syntax=make
