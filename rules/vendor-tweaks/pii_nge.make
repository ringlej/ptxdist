# -*-makefile-*-
# $Id: pii_nge.make,v 1.5 2004/08/17 12:57:07 sha Exp $
#
# Copyright (C) 2004 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

VENDORTWEAKS = pii_nge

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pii_nge_targetinstall: $(STATEDIR)/pii_nge.targetinstall

$(STATEDIR)/pii_nge.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)

#	copy /etc template
	cp -a $(TOPDIR)/etc/generic/. $(ROOTDIR)/etc
	cp $(TOPDIR)/etc/pii_nge/init.d/* $(ROOTDIR)/etc/init.d/

#	remove CVS stuff
	find $(ROOTDIR) -name "CVS" | xargs rm -fr 
	rm -f $(ROOTDIR)/JUST_FOR_CVS

#	make scripts executable
	chmod 755 $(ROOTDIR)/etc/init.d/*

#	generate version stamps
	perl -i -p -e "s,\@VERSION@,$(VERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PATCHLEVEL@,$(PATCHLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@SUBLEVEL@,$(SUBLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PROJECT@,$(PROJECT),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@EXTRAVERSION@,$(EXTRAVERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@DATE@,$(shell date -Iseconds),g" $(ROOTDIR)/etc/init.d/banner

#	other config data
	rm -f $(ROOTDIR)/etc/hostname
	perl -i -p -e "s,\@CONSOLE@,tts/0,g" $(ROOTDIR)/etc/inittab
	perl -i -p -e "s,\@SPEED@,115200,g" $(ROOTDIR)/etc/inittab
	perl -i -p -e "s,\@VENDOR@,PII ,g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PS1@,\'\\\u@\\\h:\\\w> \',g" $(ROOTDIR)/etc/profile
	perl -i -p -e "s,\@PS2@,\'> \',g" $(ROOTDIR)/etc/profile
	perl -i -p -e "s,\@PS4@,\'+ \',g" $(ROOTDIR)/etc/profile

	# create some mountpoints	
	#install -d $(ROOTDIR)/data/

	install -d $(ROOTDIR)/var/run
	install -d $(ROOTDIR)/var/log
	install -d $(ROOTDIR)/var/lock
	
#	create /etc/rc.d links
	ln -sf ../init.d/banner $(ROOTDIR)/etc/rc.d/S00_banner
	ln -sf ../init.d/networking $(ROOTDIR)/etc/rc.d/S01_networking
	ln -sf ../init.d/utelnetd $(ROOTDIR)/etc/rc.d/S02_utelnetd

	# we need to fix owner / permissions at first startup 
	# FIXME: this will be done with fakeroot later...
	install -m 755 -D $(MISCDIR)/ptx-init-permissions.sh $(ROOTDIR)/sbin/ptx-init-permissions.sh
	chmod a+x $(ROOTDIR)/etc/init.d/*
	chmod a+x $(ROOTDIR)/etc/rc.d/*

	# maintenance mode helper script
	install -m 755 -D $(MISCDIR)/maintenance $(ROOTDIR)/sbin/maintenance

	touch $@

# vim: syntax=make
