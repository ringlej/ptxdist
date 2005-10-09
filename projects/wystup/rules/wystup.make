# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG <linux-development@auerswald.de>
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES += wystup

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

wystup_targetinstall: $(STATEDIR)/wystup.targetinstall

$(STATEDIR)/wystup.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)

	# FIXME: use normal ipkg mechanism

#	copy /etc template
#	cp -a $(PROJECTDIR)/etc/. $(ROOTDIR)/etc

#	make scripts executable
	chmod 755 $(ROOTDIR)/etc/init.d/*

	# create menu.lst for grub
	install -d $(ROOTDIR)/boot
	echo "timeout 30" > $(ROOTDIR)/boot/grub/menu.lst
	echo "default 0" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "title \"Compact Flash\"" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "root (hd0,0)" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "kernel /boot/bzImage rw ide=nodma root=/dev/hdc1 ip=dhcp" >> $(ROOTDIR)/boot/grub/menu.lst
#	echo "title \"NFS\"" >> $(ROOTDIR)/boot/grub/menu.lst
#	echo "root (hd0,0)" >> $(ROOTDIR)/boot/grub/menu.lst
#	echo "kernel /boot/bzImage ip=dhcp root=/dev/nfs" >> $(ROOTDIR)/boot/grub/menu.lst
	# create some mountpoints
	install -d $(ROOTDIR)/var/run
	install -d $(ROOTDIR)/var/log
	
	touch $@

# vim: syntax=make
