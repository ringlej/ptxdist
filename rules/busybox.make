# -*-makefile-*-
# $Id: busybox.make,v 1.4 2003/07/16 04:23:28 mkl Exp $
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
ifdef PTXCONF_BUSYBOX
PACKAGES += busybox
endif

#
# Paths and names 
#
BUSYBOX			= busybox-0.61.pre-ptx9
BUSYBOX_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(BUSYBOX).tar.gz  
BUSYBOX_SOURCE		= $(SRCDIR)/$(BUSYBOX).tar.gz
BUSYBOX_DIR		= $(BUILDDIR)/$(BUSYBOX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

busybox_get: $(STATEDIR)/busybox.get

busybox_get_deps =  $(BUSYBOX_SOURCE)

$(STATEDIR)/busybox.get: $(busybox_get_deps)
	@$(call targetinfo, busybox.get)
	touch $@

$(BUSYBOX_SOURCE):
	@$(call targetinfo, $(BUSYBOX_SOURCE))
	@$(call get, $(BUSYBOX_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

busybox_extract: $(STATEDIR)/busybox.extract

$(STATEDIR)/busybox.extract: $(STATEDIR)/busybox.get
	@$(call targetinfo, busybox.extract)
	@$(call clean, $(BUSYBOX_DIR))
	@$(call extract, $(BUSYBOX_SOURCE))
#	#
#	# fix: turn off debugging in init.c
#	#
	perl -i -p -e 's/^#define DEBUG_INIT/#undef DEBUG_INIT/g' $(BUSYBOX_DIR)/init/init.c
#	#
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

busybox_prepare: $(STATEDIR)/busybox.prepare 

BUSYBOX_PATH		= PATH=$(CROSS_PATH)
BUSYBOX_MAKEVARS	= CROSS=$(PTXCONF_GNU_TARGET)- HOSTCC=$(HOSTCC)

#
# dependencies
#
busybox_prepare_deps =  $(STATEDIR)/virtual-xchain.install $(STATEDIR)/busybox.extract

$(STATEDIR)/busybox.prepare: $(busybox_prepare_deps)
	@$(call targetinfo, busybox.prepare)
	# FIXME: is this necessary?
	touch $(BUSYBOX_DIR)/busybox.links
	$(BUSYBOX_PATH) make -C $(BUSYBOX_DIR) distclean $(BUSYBOX_MAKEVARS)
	grep -e PTXCONF_BB_ .config > $(BUSYBOX_DIR)/.config
	perl -i -p -e 's/PTXCONF_BB_//g' $(BUSYBOX_DIR)/.config
	$(BUSYBOX_PATH) make -C $(BUSYBOX_DIR) oldconfig $(BUSYBOX_MAKEVARS)
	$(BUSYBOX_PATH) make -C $(BUSYBOX_DIR) dep $(BUSYBOX_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

busybox_compile: $(STATEDIR)/busybox.compile

busybox_compile_deps =  $(STATEDIR)/busybox.prepare

$(STATEDIR)/busybox.compile: $(busybox_compile_deps) 
	@$(call targetinfo, busybox.compile)
	$(BUSYBOX_PATH) make -C $(BUSYBOX_DIR) $(BUSYBOX_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

busybox_install: $(STATEDIR)/busybox.install

$(STATEDIR)/busybox.install: $(STATEDIR)/busybox.compile
	@$(call targetinfo, busybox.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

busybox_targetinstall: $(STATEDIR)/busybox.targetinstall

$(STATEDIR)/busybox.targetinstall: $(STATEDIR)/busybox.compile
	@$(call targetinfo, busybox.targetinstall)
	rm -f $(BUSYBOX_DIR)/busybox.links
	$(BUSYBOX_PATH) make -C $(BUSYBOX_DIR) install 		\
		PREFIX=$(ROOTDIR) $(BUSYBOX_MAKEVARS)
	$(CROSSSTRIP) -R .notes -R .comment $(ROOTDIR)/bin/busybox
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

busybox_clean: 
	-rm -rf $(STATEDIR)/busybox* 
	-rm -rf $(BUSYBOX_DIR) 

# vim: syntax=make