# -*-makefile-*-
# $Id: ksymoops.make,v 1.4 2003/07/16 04:23:28 mkl Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y, $(PTXCONF_KSYMOOPS))
PACKAGES += ksymoops
endif

#
# Paths and names 
#
KSYMOOPS			= ksymoops-2.4.6
KSYMOOPS_URL			= http://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/$(KSYMOOPS).tar.bz2
KSYMOOPS_SOURCE			= $(SRCDIR)/$(KSYMOOPS).tar.bz2
KSYMOOPS_DIR			= $(BUILDDIR)/$(KSYMOOPS)
KSYMOOPS_EXTRACT 		= bzip2 -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ksymoops_get: $(STATEDIR)/ksymoops.get

$(STATEDIR)/ksymoops.get: $(KSYMOOPS_SOURCE)
	@$(call targetinfo, ksymoops.get)
	touch $@

$(KSYMOOPS_SOURCE):
	@$(call targetinfo, $(KSYMOOPS_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(KSYMOOPS_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ksymoops_extract: $(STATEDIR)/ksymoops.extract

$(STATEDIR)/ksymoops.extract: $(STATEDIR)/ksymoops.get
	@$(call targetinfo, ksymoops.extract)
	$(KSYMOOPS_EXTRACT) $(KSYMOOPS_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ksymoops_prepare: $(STATEDIR)/ksymoops.prepare

$(STATEDIR)/ksymoops.prepare: $(STATEDIR)/ksymoops.extract
	@$(call targetinfo, ksymoops.prepare)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ksymoops_compile: $(STATEDIR)/ksymoops.compile

$(STATEDIR)/ksymoops.compile: $(STATEDIR)/ksymoops.prepare 
	@$(call targetinfo, ksymoops.compile)
	CFLAGS="-I$(PTXCONF_PREFIX)/include" make -C $(KSYMOOPS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ksymoops_install: $(STATEDIR)/ksymoops.install

$(STATEDIR)/ksymoops.install: $(STATEDIR)/ksymoops.compile
	@$(call targetinfo, ksymoops.install)
	make -C $(KSYMOOPS_DIR) install INSTALL_PREFIX=$(PTXCONF_PREFIX)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ksymoops_targetinstall: $(STATEDIR)/ksymoops.targetinstall

$(STATEDIR)/ksymoops.targetinstall: $(STATEDIR)/ksymoops.install
	@$(call targetinfo, ksymoops.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ksymoops_clean: 
	rm -rf $(STATEDIR)/ksymoops.* $(KSYMOOPS_DIR)

# vim: syntax=make
