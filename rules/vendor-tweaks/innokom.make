# -*-makefile-*-
# $Id: innokom.make,v 1.1 2003/09/19 08:37:36 robert Exp $
#
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
	install -d $(ROOTDIR)/data/log
	install -d $(ROOTDIR)/data/tmp
	ln -sf /data/tmp $(ROOTDIR)/tmp
	ln -sf /data/log $(ROOTDIR)/var/log

	# copy /etc template
	cp -a $(TOPDIR)/etc/innokom-20030625 $(ROOTDIR)/etc

	touch $@

# vim: syntax=make
