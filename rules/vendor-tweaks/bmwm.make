# -*-makefile-*-
# $Id: bmwm.make,v 1.2 2004/01/30 13:27:33 bsp Exp $

VENDORTWEAKS = bmwm

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

START_M=$(ROOTDIR)/usr/bin/start_m

bmwm_targetinstall: $(STATEDIR)/bmwm.targetinstall

$(STATEDIR)/bmwm.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)
	cp -a $(TOPDIR)/etc/bmwm/. $(ROOTDIR)/etc
	echo '#!/bin/sh' > $(START_M)
	echo 'insmod /lib/modules/2.4.21/kernel/drivers/input/pcan.o type=isa io=0x300 irq=7' >> $(START_M)
	echo 'insmod /lib/modules/2.4.21/kernel/drivers/input/mousedev.o' >> $(START_M)
	echo '/bin/commdrive &' >> $(START_M)
	echo '/usr/X11R6/bin/X -mouse /dev/input/mice &' >> $(START_M)
	echo 'cd /usr/lib/mozilla-1.5' >> $(START_M)
	echo 'export LD_LIBRARY_PATH=.' >> $(START_M)
	echo './penguzilla_bin' >> $(START_M)
	chmod a+x $(START_M)