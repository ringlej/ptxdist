# -*-makefile-*-
# $Id: frako.make,v 1.1 2003/12/04 13:19:46 bsp Exp $
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG <linux-development@auerswald.de>
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

VENDORTWEAKS = frako

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

frako_targetinstall: $(STATEDIR)/frako.targetinstall

$(STATEDIR)/frako.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)

#	copy /etc template
	cp -a $(TOPDIR)/etc/frako/. $(ROOTDIR)/etc

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

	# create menu.lst for grub
	install -d $(ROOTDIR)/boot
	echo "timeout 30" > $(ROOTDIR)/boot/grub/menu.lst
	echo "default 0" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "title \"Compact Flash\"" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "root (hd0,0)" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "kernel /boot/bzImage ip=192.168.1.254:::255.255.0.0::eth0:off root=/dev/hdc1" >> $(ROOTDIR)/boot/grub/menu.lst
#	echo "title \"NFS\"" >> $(ROOTDIR)/boot/grub/menu.lst
#	echo "root (hd0,0)" >> $(ROOTDIR)/boot/grub/menu.lst
#	echo "kernel /boot/bzImage ip=dhcp root=/dev/nfs" >> $(ROOTDIR)/boot/grub/menu.lst
	# create some mountpoints
	install -d $(ROOTDIR)/var/run
	install -d $(ROOTDIR)/var/log
	
	# create home directories
	install -d $(ROOTDIR)/home/frako
	install -d $(ROOTDIR)/home/system
	
	touch $@

# vim: syntax=make
