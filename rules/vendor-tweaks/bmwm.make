# -*-makefile-*-
# $Id: bmwm.make,v 1.8 2004/04/06 10:12:48 robert Exp $

VENDORTWEAKS = bmwm

VENDORTWEAKS_BMWM_IDRIVE_DIR = /ptx/home/Projects/BMW/I-Drive/idrive-drv-1.10-ptx1

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

	# FIXME: this is leaking in, find out why...
	cp /usr/lib/libexpat.so.1 $(ROOTDIR)/usr/lib/

	# copy /etc skeleton
	cp -a $(TOPDIR)/etc/bmwm-cid_internet/* $(ROOTDIR)/etc/
	
	# menu.lst for grub
	install -d $(ROOTDIR)/boot/grub
	echo "timeout 5" > $(ROOTDIR)/boot/grub/menu.lst
	echo "title BMWM" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "root (hd0,0)" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "kernel /boot/bzImage root=/dev/hda1 vga=785" >> \
		$(ROOTDIR)/boot/grub/menu.lst
	echo "title BMWM (nfs)" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "root (hd0,0)" >> $(ROOTDIR)/boot/grub/menu.lst
	echo "kernel /boot/bzImage root=/dev/nfs ip=dhcp vga=785" >> \
		$(ROOTDIR)/boot/grub/menu.lst

	# remove stuff from build proces
	find $(ROOTDIR) -name "JUST_FOR_CVS" | xargs rm -f
	find $(ROOTDIR) -name "CVS" | xargs rm -fr

	# lock dir
	mkdir -p $(ROOTDIR)/var/lock

	# generate version stamps
	perl -i -p -e "s,\@VERSION@,$(VERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PATCHLEVEL@,$(PATCHLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@SUBLEVEL@,$(SUBLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PROJECT@,$(PROJECT),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@EXTRAVERSION@,$(EXTRAVERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@DATE@,$(shell date -Iseconds),g" $(ROOTDIR)/etc/init.d/banner

	# pango configuration
	mkdir -p $(ROOTDIR)/etc/pango

	# FIXME: install fonts from temporary archive
	cd $(ROOTDIR) && tar -jxf /ptx/home/Projects/BMW/Projekt-Autosalon2004/patches/fonts.tar.bz2

	# create and copy proprietary I-Drive tool
	PATH=$(CROSS_PATH) CROSS=$(PTXCONF_GNU_TARGET)- make -C \
		$(VENDORTWEAKS_BMWM_IDRIVE_DIR)/idrive -f userMake
	install -d $(ROOTDIR)/usr/local/bin
	cp $(VENDORTWEAKS_BMWM_IDRIVE_DIR)/idrive/userIDrive $(ROOTDIR)/usr/local/bin/


