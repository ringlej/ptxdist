# -*-makefile-*-
# $Id: busybox.make,v 1.2 2003/05/13 11:37:14 robert Exp $
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
ifeq (y,$(PTXCONF_BUSYBOX))
PACKAGES += busybox
endif

#
# Paths and names 
#
BUSYBOX			= busybox-0.61.pre-ptx9
BUSYBOX_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(BUSYBOX).tar.gz  
BUSYBOX_SOURCE		= $(SRCDIR)/$(BUSYBOX).tar.gz
BUSYBOX_DIR		= $(BUILDDIR)/$(BUSYBOX)
BUSYBOX_EXTRACT 	= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

busybox_get: $(STATEDIR)/busybox.get

busybox_get_deps =  $(BUSYBOX_SOURCE)

$(STATEDIR)/busybox.get: $(busybox_get_deps)
	touch $@

$(BUSYBOX_SOURCE):
	@echo
	@echo ------------------- 
	@echo target: busybox.get
	@echo -------------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(BUSYBOX_URL)
	@exit

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

busybox_extract: $(STATEDIR)/busybox.extract

$(STATEDIR)/busybox.extract: $(STATEDIR)/busybox.get
	@echo
	@echo ----------------------- 
	@echo target: busybox.extract
	@echo -----------------------
	@echo
	$(BUSYBOX_EXTRACT) $(BUSYBOX_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
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

BUSYBOX_ENVIRONMENT = 
BUSYBOX_MAKEVARS    =
BUSYBOX_ENVIRONMENT += PATH=$(PTXCONF_PREFIX)/bin:$$PATH
BUSYBOX_MAKEVARS    += CROSS=$(PTXCONF_GNU_TARGET)-

#
# dependencies
#
busybox_prepare_deps =  $(STATEDIR)/busybox.extract 
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN))
busybox_prepare_deps += $(STATEDIR)/xchain-gccstage2.install
endif

$(STATEDIR)/busybox.prepare: $(busybox_prepare_deps)
	@echo
	@echo ----------------------- 
	@echo target: busybox.prepare
	@echo -----------------------
	@echo
	# FIXME: is this necessary?
	touch $(BUSYBOX_DIR)/busybox.links
	$(BUSYBOX_ENVIRONMENT) make -C $(BUSYBOX_DIR) distclean $(BUSYBOX_MAKEVARS)
	grep -e PTXCONF_BB_ .config > $(BUSYBOX_DIR)/.config
	perl -i -p -e 's/PTXCONF_BB_//g' $(BUSYBOX_DIR)/.config
	$(BUSYBOX_ENVIRONMENT) make -C $(BUSYBOX_DIR) oldconfig $(BUSYBOX_MAKEVARS)
	$(BUSYBOX_ENVIRONMENT) make -C $(BUSYBOX_DIR) dep $(BUSYBOX_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

busybox_compile_deps = $(STATEDIR)/busybox.prepare
ifeq (y, $(PTXCONF_GLIBC))
busybox_compile_deps += $(STATEDIR)/glibc.install
endif
ifeq (y, $(PTXCONF_UCLIBC))
busybox_compile_deps += $(STATEDIR)/uclibc.install
endif

busybox_compile: $(STATEDIR)/busybox.compile

$(STATEDIR)/busybox.compile: $(busybox_compile_deps) 
	@echo
	@echo ----------------------- 
	@echo target: busybox.compile
	@echo -----------------------
	@echo
	$(BUSYBOX_ENVIRONMENT) make -C $(BUSYBOX_DIR) $(BUSYBOX_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

busybox_install: $(STATEDIR)/busybox.install

$(STATEDIR)/busybox.install: $(STATEDIR)/busybox.compile
	@echo
	@echo ----------------------- 
	@echo target: busybox.install
	@echo -----------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

busybox_targetinstall: $(STATEDIR)/busybox.targetinstall

$(STATEDIR)/busybox.targetinstall: $(STATEDIR)/busybox.install
	@echo
	@echo ----------------------------- 
	@echo target: busybox.targetinstall
	@echo -----------------------------
	@echo
	rm -f $(BUSYBOX_DIR)/busybox.links
	$(BUSYBOX_ENVIRONMENT) make -C $(BUSYBOX_DIR) install 		\
		PREFIX=$(ROOTDIR) $(BUSYBOX_MAKEVARS)
	$(CROSSSTRIP) -S $(ROOTDIR)/bin/busybox
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

busybox_clean: 
	-rm -rf $(STATEDIR)/busybox* 
	-rm -rf $(BUSYBOX_DIR) 

# vim: syntax=make
