# $Id: ksymoops.make,v 1.1 2003/04/24 08:06:33 jst Exp $
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
	touch $@

$(KSYMOOPS_SOURCE):
	@echo
	@echo --------------------
	@echo target: ksymoops.get
	@echo --------------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(KSYMOOPS_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ksymoops_extract: $(STATEDIR)/ksymoops.extract

$(STATEDIR)/ksymoops.extract: $(STATEDIR)/ksymoops.get
	@echo
	@echo ------------------------
	@echo target: ksymoops.extract
	@echo ------------------------
	@echo
	$(KSYMOOPS_EXTRACT) $(KSYMOOPS_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ksymoops_prepare: $(STATEDIR)/ksymoops.prepare

$(STATEDIR)/ksymoops.prepare: $(STATEDIR)/ksymoops.extract
	@echo
	@echo ------------------------
	@echo target: ksymoops.prepare
	@echo ------------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ksymoops_compile: $(STATEDIR)/ksymoops.compile

$(STATEDIR)/ksymoops.compile: $(STATEDIR)/ksymoops.prepare 
	@echo
	@echo ------------------------
	@echo target: ksymoops.compile
	@echo ------------------------
	@echo
	make -C $(KSYMOOPS_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ksymoops_install: $(STATEDIR)/ksymoops.install

$(STATEDIR)/ksymoops.install: $(STATEDIR)/ksymoops.compile
	@echo
	@echo ------------------------
	@echo target: ksymoops.install
	@echo ------------------------
	@echo
	make -C $(KSYMOOPS_DIR) install INSTALL_PREFIX=$(PTXCONF_PREFIX)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ksymoops_targetinstall: $(STATEDIR)/ksymoops.targetinstall

$(STATEDIR)/ksymoops.targetinstall: $(STATEDIR)/ksymoops.install
	@echo
	@echo ------------------------------ 
	@echo target: ksymoops.targetinstall
	@echo ------------------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ksymoops_clean: 
	rm -rf $(STATEDIR)/ksymoops.* $(KSYMOOPS_DIR)

# vim: syntax=make
