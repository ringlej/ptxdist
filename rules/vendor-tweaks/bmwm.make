# -*-makefile-*-
# $Id: bmwm.make,v 1.7 2004/03/31 16:19:37 robert Exp $

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

