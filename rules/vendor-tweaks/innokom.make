# -*-makefile-*-
# $Id: innokom.make,v 1.7 2003/10/09 07:43:00 robert Exp $
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

	# the application resides in /opt
	install -d $(ROOTDIR)/opt

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

	touch $@

# vim: syntax=make
