# -*-makefile-*-
# $Id: abbcc.make,v 1.1 2004/07/28 01:13:09 rsc Exp $
#
# Copyright (C) 2004 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

VENDORTWEAKS = abbcc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

abbcc_targetinstall: $(STATEDIR)/abbcc.targetinstall

$(STATEDIR)/abbcc.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)

#	copy /etc template
	cp -a $(TOPDIR)/etc/generic/. $(ROOTDIR)/etc

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

	install -d $(ROOTDIR)/var/run
	install -d $(ROOTDIR)/var/log
	install -d $(ROOTDIR)/var/lock
	
	# we need to fix owner / permissions at first startup 
	# FIXME: this will be done with fakeroot later...
	install -m 755 -D $(MISCDIR)/ptx-init-permissions.sh $(ROOTDIR)/sbin/ptx-init-permissions.sh
	chmod a+x $(ROOTDIR)/etc/init.d/*
	chmod a+x $(ROOTDIR)/etc/rc.d/*

	# maintenance mode helper script
	install -m 755 -D $(MISCDIR)/maintenance $(ROOTDIR)/sbin/maintenance

	# grub configuration 
	install -d $(ROOTDIR)/boot/grub/
	cp $(TOPDIR)/etc/abbcc/menu.lst $(ROOTDIR)/boot/grub/menu.lst

	touch $@
# vim: syntax=make
