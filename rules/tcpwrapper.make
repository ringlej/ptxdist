# $Id: tcpwrapper.make,v 1.1 2003/04/24 08:06:33 jst Exp $
#
# (c) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y, $(PTXCONF_TCPWRAPPER))
PACKAGES += tcpwrapper
endif

#
# Paths and names 
#
TCPWRAPPER			= tcp_wrappers_7.6
TCPWRAPPER_URL			= ftp://ftp.porcupine.org/pub/security/$(TCPWRAPPER).tar.gz
TCPWRAPPER_SOURCE		= $(SRCDIR)/$(TCPWRAPPER).tar.gz
TCPWRAPPER_DIR			= $(BUILDDIR)/$(TCPWRAPPER)
TCPWRAPPER_EXTRACT 		= gzip -dc

TCPWRAPPER_PTXPATCH		= tcp_wrappers_7.6-ptx1
TCPWRAPPER_PTXPATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(TCPWRAPPER_PTXPATCH).diff
TCPWRAPPER_PTXPATCH_SOURCE	= $(SRCDIR)/$(TCPWRAPPER_PTXPATCH).diff

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

tcpwrapper_get: $(STATEDIR)/tcpwrapper.get

$(STATEDIR)/tcpwrapper.get: $(TCPWRAPPER_SOURCE) $(TCPWRAPPER_PTXPATCH_SOURCE)
	touch $@

$(TCPWRAPPER_SOURCE):
	@echo
	@echo ---------------------- 
	@echo target: tcpwrapper.get
	@echo ----------------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(TCPWRAPPER_URL)
	
$(TCPWRAPPER_PTXPATCH_SOURCE): 
	@echo
	@echo ------------------------------- 
	@echo target: tcpwrapper-ptxpatch.get
	@echo -------------------------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(TCPWRAPPER_PTXPATCH_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tcpwrapper_extract: $(STATEDIR)/tcpwrapper.extract

$(STATEDIR)/tcpwrapper.extract: $(STATEDIR)/tcpwrapper.get
	@echo
	@echo -------------------------- 
	@echo target: tcpwrapper.extract
	@echo --------------------------
	@echo
	$(TCPWRAPPER_EXTRACT) $(TCPWRAPPER_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	cd $(TCPWRAPPER_DIR) && patch -p1 < $(TCPWRAPPER_PTXPATCH_SOURCE)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tcpwrapper_prepare: $(STATEDIR)/tcpwrapper.prepare

$(STATEDIR)/tcpwrapper.prepare: $(STATEDIR)/tcpwrapper.extract
	@echo
	@echo -------------------------- 
	@echo target: tcpwrapper.prepare
	@echo --------------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

tcpwrapper_compile: $(STATEDIR)/tcpwrapper.compile

TCPWRAPPER_ENVIRONMENT = CC=$(PTXCONF_GNU_TARGET)-gcc

$(STATEDIR)/tcpwrapper.compile: $(STATEDIR)/tcpwrapper.prepare 
	@echo
	@echo -------------------------- 
	@echo target: tcpwrapper.compile
	@echo --------------------------
	@echo
	$(TCPWRAPPER_ENVIRONMENT) make -C $(TCPWRAPPER_DIR) linux $(TCPWRAPPER_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tcpwrapper_install: $(STATEDIR)/tcpwrapper.install

$(STATEDIR)/tcpwrapper.install: $(STATEDIR)/tcpwrapper.compile
	@echo
	@echo -------------------------- 
	@echo target: tcpwrapper.install
	@echo --------------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tcpwrapper_targetinstall: $(STATEDIR)/tcpwrapper.targetinstall

$(STATEDIR)/tcpwrapper.targetinstall: $(STATEDIR)/tcpwrapper.install
	@echo
	@echo -------------------------------- 
	@echo target: tcpwrapper.targetinstall
	@echo --------------------------------
	@echo
        ifeq (y, $(PTXCONF_TCPWRAPPER_INSTALL_TCPD))
	mkdir -p $(ROOTDIR)/usr/sbin
	install $(TCPWRAPPER_DIR)/tcpd $(ROOTDIR)/usr/sbin
	$(CROSSSTRIP) -S $(ROOTDIR)/usr/sbin/tcpd
        endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tcpwrapper_clean: 
	rm -rf $(STATEDIR)/tcpwrapper.* $(TCPWRAPPER_DIR)

# vim: syntax=make
