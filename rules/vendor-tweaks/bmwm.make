# -*-makefile-*-
# $Id: bmwm.make,v 1.3 2004/02/24 09:11:38 robert Exp $

VENDORTWEAKS = bmwm

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

START_M=$(ROOTDIR)/usr/bin/start_m

bmwm_targetinstall: $(STATEDIR)/bmwm.targetinstall

$(STATEDIR)/bmwm.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)
	install -d $(ROOTDIR)/etc
	cp -a $(TOPDIR)/etc/bmwm-cid_internet/* $(ROOTDIR)/etc/
	chmod a+x $(ROOTDIR)/etc/init.d/startx
