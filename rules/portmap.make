# $Id: portmap.make,v 1.3 2003/06/30 15:43:26 bsp Exp $
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
ifeq (y, $(PTXCONF_PORTMAP))
PACKAGES += portmap
endif

#
# Paths and names 
#
PORTMAP			= portmap_4
PORTMAP_URL		= ftp://ftp.porcupine.org/pub/security/$(PORTMAP).tar.gz
PORTMAP_SOURCE		= $(SRCDIR)/$(PORTMAP).tar.gz
PORTMAP_DIR		= $(BUILDDIR)/$(PORTMAP)
PORTMAP_EXTRACT 	= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

portmap_get: $(STATEDIR)/portmap.get

$(STATEDIR)/portmap.get: $(PORTMAP_SOURCE)
	touch $@

$(PORTMAP_SOURCE):
	@$(call targetinfo, portmap.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(PORTMAP_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

portmap_extract: $(STATEDIR)/portmap.extract

$(STATEDIR)/portmap.extract: $(STATEDIR)/portmap.get
	@$(call targetinfo, portmap.extract)
	$(PORTMAP_EXTRACT) $(PORTMAP_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	# apply some fixes
	perl -i -p -e 's/^HOSTS_ACCESS/#HOSTS_ACCESS/g' $(PORTMAP_DIR)/Makefile
	perl -i -p -e 's/^CHECK_PORT/#CHECK_PORT/g' $(PORTMAP_DIR)/Makefile
	perl -i -p -e "s|^WRAP_DIR=(.*)$$|WRAP_DIR = $(TCPWRAPPER_DIR)|g" $(PORTMAP_DIR)/Makefile
	perl -i -p -e 's/^AUX/#AUX/g' $(PORTMAP_DIR)/Makefile
	# FIXME: uggly, make patch
	perl -i -p -e "s/const/__const/g" $(PORTMAP_DIR)/portmap.c
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

portmap_prepare: $(STATEDIR)/portmap.prepare

$(STATEDIR)/portmap.prepare: $(STATEDIR)/portmap.extract
	@$(call targetinfo, portmap.prepare)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

portmap_compile: $(STATEDIR)/portmap.compile

PORTMAP_ENVIRONMENT = CC=$(PTXCONF_GNU_TARGET)-gcc PATH=$(PTXCONF_PREFIX)/bin:$$PATH

portmap_compile_deps = $(STATEDIR)/portmap.prepare
portmap_compile_deps += $(STATEDIR)/tcpwrapper.compile

$(STATEDIR)/portmap.compile: $(portmap_compile_deps)
	@$(call targetinfo, portmap.compile)
	$(PORTMAP_ENVIRONMENT) make -C $(PORTMAP_DIR) $(PORTMAP_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

portmap_install: $(STATEDIR)/portmap.install

$(STATEDIR)/portmap.install: $(STATEDIR)/portmap.compile
	@$(call targetinfo, portmap.install)
	#make -C $(PORTMAP_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

portmap_targetinstall: $(STATEDIR)/portmap.targetinstall

$(STATEDIR)/portmap.targetinstall: $(STATEDIR)/portmap.install
	@$(call targetinfo, portmap.targetinstall)
        ifeq (y, $(PTXCONF_PORTMAP_INSTALL_PORTMAPPER))
	mkdir -p $(ROOTDIR)/sbin
	install $(PORTMAP_DIR)/portmap $(ROOTDIR)/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/portmap
        endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

portmap_clean: 
	rm -rf $(STATEDIR)/portmap.* $(PORTMAP_DIR)

# vim: syntax=make
