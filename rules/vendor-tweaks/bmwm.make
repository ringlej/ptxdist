# -*-makefile-*-
# $Id: bmwm.make,v 1.5 2004/02/27 17:10:32 robert Exp $

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

	# FIXME: somehow the path to the gdkpixbuf & pango 
	# config files is hardcoded into some tools
	rm -fr $(ROOTDIR)/$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
	install -d $(ROOTDIR)/$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
	ln -s /etc $(ROOTDIR)/$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/etc

	# copy /etc skeleton
	cp -a $(TOPDIR)/etc/bmwm-cid_internet/* $(ROOTDIR)/etc/
	chmod a+x $(ROOTDIR)/etc/init.d/startx
	
	# menu.lst for grub
	install -d $(ROOTDIR)/boot/grub
	echo "timeout 5" > $(ROOTDIR)/boot/grub/menu.lst
	echo "title BMWM" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "root (hd0,0)" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "kernel /boot/bzImage root=/dev/hda1 vga=768" >> \
		$(ROOTDIR)/boot/grub/menu.lst
	echo "title BMWM (nfs)" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "root (hd0,0)" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "kernel /boot/bzImage root=/dev/nfs ip=dhcp vga=768" >> \
		$(ROOTDIR)/boot/grub/menu.lst
