# -*-makefile-*-
# $Id: bmwm.make,v 1.4 2004/02/27 11:57:30 robert Exp $

VENDORTWEAKS = bmwm

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

START_M=$(ROOTDIR)/usr/bin/start_m

bmwm_targetinstall: $(STATEDIR)/bmwm.targetinstall

$(STATEDIR)/bmwm.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)
	install -d $(ROOTDIR)/etc
	install -d $(ROOTDIR)/sys
	install -d $(ROOTDIR)/var/log
	install -d $(ROOTDIR)/var/run
	rm -fr $(ROOTDIR)/$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
	install -d $(ROOTDIR)/$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
	ln -s /etc $(ROOTDIR)/$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/etc
	cp -a $(TOPDIR)/etc/bmwm-cid_internet/* $(ROOTDIR)/etc/
	chmod a+x $(ROOTDIR)/etc/init.d/startx
	
