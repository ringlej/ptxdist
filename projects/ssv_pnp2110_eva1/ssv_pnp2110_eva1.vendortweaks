# -*-makefile-*-
#  
# $Id:$
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

VENDORTWEAKS = ssv_pnp2110_eva1

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ssv_pnp2110_eva1_targetinstall: $(STATEDIR)/ssv_pnp2110_eva1.targetinstall

$(STATEDIR)/ssv_pnp2110_eva1.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)

	# create some mountpoints	
	$(call copy_root, 0, 0, 0755, /var/run)
	$(call copy_root, 0, 0, 0755, /var/log)
	$(call copy_root, 0, 0, 0755, /var/lock)
	
	# create /etc/rc.d links
	$(call copy_root, 0, 0, 0755, /etc/rc.d)
	$(call link_root, ../init.d/banner,     /etc/rc.d/S00_banner)
	$(call link_root, ../init.d/networking, /etc/rc.d/S01_networking)
	$(call link_root, ../init.d/utelnetd,   /etc/rc.d/S02_utelnetd)
	$(call link_root, ../init.d/proftpd,    /etc/rc.d/S02_proftpd)
	$(call link_root, ../init.d/startup,    /etc/rc.d/S99_startup)

	# donate /home to ftp.ftp so that we can download files 
	$(call copy_root, 11, 101, 0755, /home)

	# remove CVS and SVN stuff
	find $(ROOTDIR) -name "CVS" | xargs rm -fr 
	rm -f $(ROOTDIR)/JUST_FOR_CVS
	find $(ROOTDIR) -name ".svn" | xargs rm -fr

	# launch cuckoo-test
	@$(call targetinfo, cuckoo-test)
	cd $(TOPDIR) && scripts/cuckoo-test $(PTXCONF_ARCH) root $(PTXCONF_COMPILER_PREFIX)

	touch $@

# vim: syntax=make
