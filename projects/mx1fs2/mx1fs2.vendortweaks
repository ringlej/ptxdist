# -*-makefile-*-
# $Id$
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
	cp -a $(TOPDIR)/projects/mx1fs2/. $(ROOTDIR)/etc

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

#	other config data
	rm -rf $(ROOTDIR)/etc/proftpd.conf
	rm -f $(ROOTDIR)/etc/rc.d/networking

	perl -i -p -e "s,\@CONSOLE@,ttsmx/1,g" $(ROOTDIR)/etc/inittab
	perl -i -p -e "s,\@SPEED@,115200,g" $(ROOTDIR)/etc/inittab
	perl -i -p -e "s,\@VENDOR@,Viasys ,g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PS1@,\'\\\u@\\\h:\\\w> \',g" $(ROOTDIR)/etc/profile
	perl -i -p -e "s,\@PS2@,\'> \',g" $(ROOTDIR)/etc/profile
	perl -i -p -e "s,\@PS4@,\'+ \',g" $(ROOTDIR)/etc/profile
	perl -i -p -e "s,\@HOSTNAME@,mx1fs2,g" $(ROOTDIR)/etc/hostname

	install -d $(ROOTDIR)/data/
	install -d $(ROOTDIR)/var/run
	install -d $(ROOTDIR)/var/log
	install -d $(ROOTDIR)/var/lock

#	create /etc/rc.d links
	mkdir -p $(ROOTDIR)/etc/rc.d
	ln -sf ../init.d/banner $(ROOTDIR)/etc/rc.d/S00_banner

	$(PTXCONF_PREFIX)/bin/mkfs.jffs2 -d root --eraseblock=131072 -o root.jffs2 --pad=5242880
	
	touch $@

# vim: syntax=make
