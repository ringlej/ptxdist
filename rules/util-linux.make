# -*-makefile-*-
# $Id: util-linux.make,v 1.1 2003/08/26 13:20:12 robert Exp $
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
ifdef PTXCONF_UTIL-LINUX
PACKAGES += util-linux
endif

#
# Paths and names
#
UTIL-LINUX_VERSION	= 2.12pre
UTIL-LINUX		= util-linux-$(UTIL-LINUX_VERSION)
UTIL-LINUX_SUFFIX	= tar.bz2
UTIL-LINUX_URL		= http://www.kernel.org/pub/linux/utils/util-linux/$(UTIL-LINUX).$(UTIL-LINUX_SUFFIX)
UTIL-LINUX_SOURCE	= $(SRCDIR)/$(UTIL-LINUX).$(UTIL-LINUX_SUFFIX)
UTIL-LINUX_DIR		= $(BUILDDIR)/$(UTIL-LINUX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

util-linux_get: $(STATEDIR)/util-linux.get

util-linux_get_deps	=  $(UTIL-LINUX_SOURCE)

$(STATEDIR)/util-linux.get: $(util-linux_get_deps)
	@$(call targetinfo, util-linux.get)
	touch $@

$(UTIL-LINUX_SOURCE):
	@$(call targetinfo, $(UTIL-LINUX_SOURCE))
	@$(call get, $(UTIL-LINUX_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

util-linux_extract: $(STATEDIR)/util-linux.extract

util-linux_extract_deps	=  $(STATEDIR)/util-linux.get

$(STATEDIR)/util-linux.extract: $(util-linux_extract_deps)
	@$(call targetinfo, util-linux.extract)
	@$(call clean, $(UTIL-LINUX_DIR))
	@$(call extract, $(UTIL-LINUX_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

util-linux_prepare: $(STATEDIR)/util-linux.prepare

#
# dependencies
#
util-linux_prepare_deps =  \
	$(STATEDIR)/util-linux.extract \
#	$(STATEDIR)/virtual-xchain.install

UTIL-LINUX_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
UTIL-LINUX_ENV 	=  $(CROSS_ENV)
#UTIL-LINUX_ENV	+=

$(STATEDIR)/util-linux.prepare: $(util-linux_prepare_deps)
	@$(call targetinfo, util-linux.prepare)
	@$(call clean, $(UTIL-LINUX_BUILDDIR))
	
	# FIXME: strange configure script, not cross enabled...
	cd $(UTIL-LINUX_DIR) && \
		$(UTIL-LINUX_PATH) $(UTIL-LINUX_ENV) \
		./configure
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

util-linux_compile: $(STATEDIR)/util-linux.compile

util-linux_compile_deps =  $(STATEDIR)/util-linux.prepare

$(STATEDIR)/util-linux.compile: $(util-linux_compile_deps)
	@$(call targetinfo, util-linux.compile)
	
ifeq (y, $(PTXCONF_UTLNX_MKSWAP))
	cd $(UTIL-LINUX_DIR)/disk-utils && $(UTIL-LINUX_PATH) $(UTIL-LINUX_ENV) make mkswap
endif
ifeq (y, $(PTXCONF_UTLNX_SWAPON))
	cd $(UTIL-LINUX_DIR)/mount && $(UTIL-LINUX_PATH) $(UTIL-LINUX_ENV) make swapon
endif	

	# FIXME: implement other utilities

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

util-linux_install: $(STATEDIR)/util-linux.install

$(STATEDIR)/util-linux.install: $(STATEDIR)/util-linux.compile
	@$(call targetinfo, util-linux.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

util-linux_targetinstall: $(STATEDIR)/util-linux.targetinstall

util-linux_targetinstall_deps	=  $(STATEDIR)/util-linux.compile

$(STATEDIR)/util-linux.targetinstall: $(util-linux_targetinstall_deps)
	@$(call targetinfo, util-linux.targetinstall)
	
ifeq (y, $(PTXCONF_UTLNX_MKSWAP))
	install $(UTIL-LINUX_DIR)/disk-utils/mkswap $(ROOTDIR)/sbin/
	$(CROSSSTRIP) $(ROOTDIR)/sbin/mkswap
endif
ifeq (y, $(PTXCONF_UTLNX_SWAPON))
	install $(UTIL-LINUX_DIR)/mount/swapon $(ROOTDIR)/sbin/
	$(CROSSSTRIP) $(ROOTDIR)/sbin/swapon
endif

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

util-linux_clean:
	rm -rf $(STATEDIR)/util-linux.*
	rm -rf $(UTIL-LINUX_DIR)

# vim: syntax=make
