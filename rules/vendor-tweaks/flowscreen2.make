# -*-makefile-*-
# $Id: flowscreen2.make,v 1.1 2004/03/28 10:53:27 robert Exp $
#
# Copyright (C) 2004 by Pengutronix, Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

VENDORTWEAKS = flowscreen2

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

flowscreen2_targetinstall: $(STATEDIR)/flowscreen2.targetinstall

$(STATEDIR)/flowscreen2.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)

#	copy /etc template
	cp -a $(TOPDIR)/etc/flowscreen2/. $(ROOTDIR)/etc

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

	touch $@

# vim: syntax=make
