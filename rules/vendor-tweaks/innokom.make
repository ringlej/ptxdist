# -*-makefile-*-
# $Id: innokom.make,v 1.10 2004/06/23 15:38:27 rsc Exp $
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG <linux-development@auerswald.de>
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

VENDORTWEAKS = innokom

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

innokom_targetinstall: $(STATEDIR)/innokom.targetinstall

$(STATEDIR)/innokom.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)

#	the application resides in /opt
	install -d $(ROOTDIR)/opt

#	writable directories must be on /data (ramdisk)
	install -d $(ROOTDIR)/data

	mv $(ROOTDIR)/var/log $(ROOTDIR)/data/log || mkdir $(ROOTDIR)/data/log
	ln -sf /data/log $(ROOTDIR)/var/log

	mv $(ROOTDIR)/tmp $(ROOTDIR)/data/tmp || mkdir $(ROOTDIR)/data/tmp
	ln -sf /data/tmp $(ROOTDIR)/tmp

ifdef PTXCONF_NFSUTILS_INSTALL_NFSD
	mv $(ROOTDIR)/var/lib/nfs $(ROOTDIR)/data/nfs || mkdir $(ROOTDIR)/data/nfs
	ln -sf /data/nfs $(ROOTDIR)/var/lib/nfs
endif

#	copy /etc template
	cp -a $(TOPDIR)/etc/innokom/. $(ROOTDIR)/etc

#	remove CVS stuff
	find $(ROOTDIR) -name "CVS" | xargs rm -fr 
	rm -f $(ROOTDIR)/JUST_FOR_CVS

#	make scripts executable
	chmod 755 $(ROOTDIR)/etc/init.d/*

#	create ppp link
	ln -sf /data/ppp/chap-secrets $(ROOTDIR)/etc/ppp/chap-secrets

#	generate version stamps
	perl -i -p -e "s,\@VERSION@,$(VERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PATCHLEVEL@,$(PATCHLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@SUBLEVEL@,$(SUBLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PROJECT@,$(PROJECT),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@EXTRAVERSION@,$(EXTRAVERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@DATE@,$(shell date -Iseconds),g" $(ROOTDIR)/etc/init.d/banner

	touch $@

# vim: syntax=make
