# -*-makefile-*-
#  
# $Id:$
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES += ssv_pnp2110_eva1

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ssv_pnp2110_eva1_targetinstall: $(STATEDIR)/ssv_pnp2110_eva1.targetinstall

$(STATEDIR)/ssv_pnp2110_eva1.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,ssv-pnp2110-eva1)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,1.0.0)
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

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

	$(call install_finish)

	$(call touch, $@)

# vim: syntax=make
