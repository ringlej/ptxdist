# -*-makefile-*-
# $Id: innokom.make,v 1.6 2003/10/07 10:56:05 robert Exp $
#
# (c) 2003 by Auerswald GmbH & Co. KG <linux-development@auerswald.de>
# (c) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

# leave this intact for all vendor tweaks
VENDORTWEAKS=vendor-tweaks.targetinstall

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

vendor-tweaks_targetinstall: $(STATEDIR)/vendor-tweaks.targetinstall

$(STATEDIR)/vendor-tweaks.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)
	
	# writable directories must be on /data (ramdisk)
	install -d $(ROOTDIR)/data

	mv $(ROOTDIR)/var/log $(ROOTDIR)/data/log || mkdir $(ROOTDIR)/data/log
	ln -sf /data/log $(ROOTDIR)/var/log

	mv $(ROOTDIR)/tmp $(ROOTDIR)/data/tmp || mkdir $(ROOTDIR)/data/tmp
	ln -sf /data/tmp $(ROOTDIR)/tmp

ifeq (y, $(PTXCONF_NFSUTILS_INSTALL_NFSD))
	mv $(ROOTDIR)/var/lib/nfs $(ROOTDIR)/data/nfs || mkdir $(ROOTDIR)/data/nfs
	ln -sf /data/nfs $(ROOTDIR)/var/lib/nfs
endif

	# copy /etc template
	cp -a $(TOPDIR)/etc/innokom/. $(ROOTDIR)/etc

	# remove CVS stuff
	find $(ROOTDIR) -name "CVS" | xargs rm -fr 
	rm -f $(ROOTDIR)/JUST_FOR_CVS

	# make scripts executable
	chmod 755 $(ROOTDIR)/etc/init.d/*

	# generate version stamps
	perl -i -p -e "s,\@VERSION@,$(VERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PATCHLEVEL@,$(PATCHLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@SUBLEVEL@,$(SUBLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PROJECT@,$(PROJECT),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@EXTRAVERSION@,$(EXTRAVERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@DATE@,$(shell date -Iseconds),g" $(ROOTDIR)/etc/init.d/banner

	# generate boot script
#	( 	echo 'setenv bootargsbasic console=ttyS0,19200 mem=64m';	\
#		echo 'mtdparts=phys:256k,768k,8m,-';				\
#		echo 'setenv bootargsnfs root=/dev/nfs ip=192.168.21.48';	\
#		echo 'nfsroot=192.168.21.148:/home/kub/rootfs-ik';		\
#		echo 'setenv bootargsmtd root=/dev/mtdblock$(partition) ro';	\
#		echo 'setenv bootargs $(bootargsbasic) $(bootargsmtd)';		\
#		echo 'fsload boot/fpga.bin';					\
#		echo 'fpga load 0 0xa3000000 $(filesize)';			\
#		echo 'fsload boot/uImage';					\
#		echo 'bootm';							\
#	) > $(ROOTDIR)/boot/bootscript
	
	touch $@

# vim: syntax=make
