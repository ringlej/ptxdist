# -*-makefile-*-
# $Id: innokom.make,v 1.2 2003/10/07 05:55:43 robert Exp $
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

	touch $@

# vim: syntax=make
