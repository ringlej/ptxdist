# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_INITNG) += initng

#
# Paths and names
#
INITNG_VERSION	:= 0.6.0RC2
INITNG		:= initng-$(INITNG_VERSION)
INITNG_SUFFIX	:= tar.bz2
INITNG_URL	:= http://download.initng.thinktux.net/initng/v0.6/$(INITNG).$(INITNG_SUFFIX)
INITNG_SOURCE	:= $(SRCDIR)/$(INITNG).$(INITNG_SUFFIX)
INITNG_DIR	:= $(BUILDDIR)/$(INITNG)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

initng_get: $(STATEDIR)/initng.get

$(STATEDIR)/initng.get: $(initng_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(INITNG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(INITNG_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

initng_extract: $(STATEDIR)/initng.extract

$(STATEDIR)/initng.extract: $(initng_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(INITNG_DIR))
	@$(call extract, $(INITNG_SOURCE))
	@$(call patchin, $(INITNG))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

initng_prepare: $(STATEDIR)/initng.prepare

INITNG_PATH	:=  PATH=$(CROSS_PATH)
INITNG_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
INITNG_AUTOCONF := $(CROSS_AUTOCONF_USR)
INITNG_AUTOCONF += --sysconfdir=/etc  
INITNG_AUTOCONF += --localstatedir=/var 
INITNG_AUTOCONF += --disable-count-me

ifdef PTXCONF_INITNG_INSTALL_INIT
INITNG_AUTOCONF += --enable-install-init
else
INITNG_AUTOCONF += --disable-install-init 
endif

ifdef PTXCONF_INITNG_SELINUX
INITNG_AUTOCONF += --enable-selinux    
else
INITNG_AUTOCONF += --disable-selinux
endif

ifdef PTXCONF_INITNG_DEBUG
INITNG_AUTOCONF += --enable-debug     
else
INITNG_AUTOCONF += --disable-debug
endif

ifdef PTXCONF_INITNG_ALSO
INITNG_AUTOCONF += --with-also       
else
INITNG_AUTOCONF += --without-also
endif

ifdef PTXCONF_INITNG_BASH_LAUNCHER
INITNG_AUTOCONF += --with-bash_launcher 
else
INITNG_AUTOCONF += --without-bash_launcher
endif

ifdef PTXCONF_INITNG_CHDIR
INITNG_AUTOCONF += --with-chdir        
else
INITNG_AUTOCONF += --without-chdir
endif

ifdef PTXCONF_INITNG_CHROOT
INITNG_AUTOCONF += --with-chroot      
else
INITNG_AUTOCONF += --without-chroot
endif

ifdef PTXCONF_INITNG_CONFLICT
INITNG_AUTOCONF += --with-conflict   
else
INITNG_AUTOCONF += --without-conflict
endif

ifdef PTXCONF_INITNG_CPOUT
INITNG_AUTOCONF += --with-cpout     
else
INITNG_AUTOCONF += --without-cpout
endif

ifdef PTXCONF_INITNG_CRON
INITNG_AUTOCONF += --with-cron     
else
INITNG_AUTOCONF += --without-cron
endif

ifdef PTXCONF_INITNG_CRITICAL
INITNG_AUTOCONF += --with-critical     
else
INITNG_AUTOCONF += --without-critical
endif

ifdef PTXCONF_INITNG_DAEMON_CLEAN
INITNG_AUTOCONF += --with-daemon-clean 
else
INITNG_AUTOCONF += --without-daemon-clean
endif

ifdef PTXCONF_INITNG_DLLAUNCH
INITNG_AUTOCONF += --with-dllaunch    
else
INITNG_AUTOCONF += --without-dllaunch
endif

ifdef PTXCONF_INITNG_ENVPARSER
INITNG_AUTOCONF += --with-envparser  
else
INITNG_AUTOCONF += --without-envparser
endif

ifdef PTXCONF_INITNG_FIND
INITNG_AUTOCONF += --with-find      
else
INITNG_AUTOCONF += --without-find
endif

ifdef PTXCONF_INITNG_FSTAT
INITNG_AUTOCONF += --with-fstat     
else
INITNG_AUTOCONF += --without-fstat
endif

ifdef PTXCONF_INITNG_HISTORY
INITNG_AUTOCONF += --with-history     
else
INITNG_AUTOCONF += --without-history
endif

ifdef PTXCONF_INITNG_INITCTL
INITNG_AUTOCONF += --with-initctl     
else
INITNG_AUTOCONF += --without-initctl
endif

ifdef PTXCONF_INITNG_INTERACTIVE
INITNG_AUTOCONF += --with-interactive  
else
INITNG_AUTOCONF += --without-interactive
endif

ifdef PTXCONF_INITNG_IPARSER
INITNG_AUTOCONF += --with-iparser     
else
INITNG_AUTOCONF += --without-iparser
endif

ifdef PTXCONF_INITNG_LAST
INITNG_AUTOCONF += --with-last       
else
INITNG_AUTOCONF += --without-last
endif

ifdef PTXCONF_INITNG_LIMIT
INITNG_AUTOCONF += --with-limit     
else
INITNG_AUTOCONF += --without-limit
endif

ifdef PTXCONF_INITNG_LOGFILE
INITNG_AUTOCONF += --with-logfile   
else
INITNG_AUTOCONF += --without-logfile
endif

ifdef PTXCONF_INITNG_NETPROBE
INITNG_AUTOCONF += --with-netprobe   
else
INITNG_AUTOCONF += --without-netprobe
endif

ifdef PTXCONF_INITNG_MOUNTPROBE
INITNG_AUTOCONF += --with-mountprobe   
else
INITNG_AUTOCONF += --without-mountprobe
endif

ifdef PTXCONF_INITNG_IDLEPROBE
INITNG_AUTOCONF += --with-idleprobe   
else
INITNG_AUTOCONF += --without-idleprobe
endif

ifdef PTXCONF_INITNG_NGC2
INITNG_AUTOCONF += --with-ngc2       
else
INITNG_AUTOCONF += --without-ngc2
endif

ifdef PTXCONF_INITNG_NGC4
INITNG_AUTOCONF += --with-ngc4
else
INITNG_AUTOCONF += --without-ngc4
endif

ifdef PTXCONF_INITNG_NGE
INITNG_AUTOCONF += --with-nge
else
INITNG_AUTOCONF += --without-nge
endif

ifdef PTXCONF_INITNG_NGCS
INITNG_AUTOCONF += --with-ngcs      
else
INITNG_AUTOCONF += --without-ngcs
endif

ifdef PTXCONF_INITNG_PAUSE
INITNG_AUTOCONF += --with-pause    
else
INITNG_AUTOCONF += --without-pause
endif

ifdef PTXCONF_INITNG_PIDFILE_TEST
INITNG_AUTOCONF += --with-pidfile-test 
else
INITNG_AUTOCONF += --without-pidfile-test
endif

ifdef PTXCONF_INITNG_RELOAD
INITNG_AUTOCONF += --with-reload      
else
INITNG_AUTOCONF += --without-reload
endif

ifdef PTXCONF_INITNG_RENICE
INITNG_AUTOCONF += --with-renice     
else
INITNG_AUTOCONF += --without-renice
endif

ifdef PTXCONF_INITNG_RLPARSER
INITNG_AUTOCONF += --with-rlparser   
else
INITNG_AUTOCONF += --without-rlparser
endif

ifdef PTXCONF_INITNG_SIMPLE_LAUNCHER
INITNG_AUTOCONF += --with-simple_launcher 
else
INITNG_AUTOCONF += --without-simple_launcher
endif

ifdef PTXCONF_INITNG_USPLASH
INITNG_AUTOCONF += --with-usplash       
else
INITNG_AUTOCONF += --without-usplash
endif

ifdef PTXCONF_INITNG_STCMD
INITNG_AUTOCONF += --with-stcmd        
else
INITNG_AUTOCONF += --without-stcmd
endif

ifdef PTXCONF_INITNG_STDOUT
INITNG_AUTOCONF += --with-stdout      
else
INITNG_AUTOCONF += --without-stdout
endif

ifdef PTXCONF_INITNG_SUID
INITNG_AUTOCONF += --with-suid       
else
INITNG_AUTOCONF += --without-suid
endif

ifdef PTXCONF_INITNG_SYNCRON
INITNG_AUTOCONF += --with-syncron   
else
INITNG_AUTOCONF += --without-syncron
endif

ifdef PTXCONF_INITNG_SYSLOG
INITNG_AUTOCONF += --with-syslog   
else
INITNG_AUTOCONF += --without-syslog
endif

ifdef PTXCONF_INITNG_UNNEEDED
INITNG_AUTOCONF += --with-unneeded  
else
INITNG_AUTOCONF += --without-unneeded
endif


# FIXME automatic dependencies seem to be really broken 
initng_prepare_deps  = $(STATEDIR)/initng.extract
initng_prepare_deps += $(STATEDIR)/ncurses.install

$(STATEDIR)/initng.prepare: $(initng_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(INITNG_DIR)/config.cache)
	cd $(INITNG_DIR) && \
		$(INITNG_PATH) $(INITNG_ENV) \
		./configure $(INITNG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

initng_compile: $(STATEDIR)/initng.compile

$(STATEDIR)/initng.compile: $(initng_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(INITNG_DIR) && $(INITNG_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

initng_install: $(STATEDIR)/initng.install

$(STATEDIR)/initng.install: $(initng_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, INITNG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

initng_targetinstall: $(STATEDIR)/initng.targetinstall

$(STATEDIR)/initng.targetinstall: $(initng_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, initng)
	@$(call install_fixup,initng,PACKAGE,initng)
	@$(call install_fixup,initng,PRIORITY,optional)
	@$(call install_fixup,initng,VERSION,$(INITNG_VERSION))
	@$(call install_fixup,initng,SECTION,base)
	@$(call install_fixup,initng,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup,initng,DEPENDS,)
	@$(call install_fixup,initng,DESCRIPTION,missing)

	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/src/.libs/libinitng.so.0.0.0, /usr/lib/libinitng.so.0.0.0)
	@$(call install_link, initng, libinitng.so.0.0.0, /usr/lib/libinitng.so.0)
	@$(call install_link, initng, libinitng.so.0.0.0, /usr/lib/libinitng.so)

	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/runlevel/.libs/librunlevel.so, /usr/lib/initng/librunlevel.so)
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/daemon/.libs/libdaemon.so, /usr/lib/initng/libdaemon.so)
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/service/.libs/libservice.so, /usr/lib/initng/libservice.so)

ifdef PTXDIST_INITNG_PID_FILETEST
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/daemon/test/.libs/test_pidfile, /usr/sbin/test_pidfile)
endif

	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/src/.libs/initng, /sbin/initng)

ifdef PTXCONF_INITNG_NGCS
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/ngcs/.libs/libngcs.so, /usr/lib/initng/libngcs.so)
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/ngcs/.libs/libngcs_common.so.0.0.0, /usr/lib/libngcs_common.so.0.0.0)
	@$(call install_link, initng, libngcs_common.so.0.0.0, /usr/lib/libngcs_common.so.0)
	@$(call install_link, initng, libngcs_common.so.0.0.0, /usr/lib/libngcs_common.so)
endif

ifdef PTXCONF_INITNG_NGC2
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/ngc2/ngdc, /sbin/ngdc)
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/ngc2/ngc, /sbin/ngc)

	@$(call install_link, initng, ngc, /sbin/nghalt)
	@$(call install_link, initng, ngc, /sbin/ngreboot)
	@$(call install_link, initng, ngc, /sbin/ngrestart)
	@$(call install_link, initng, ngc, /sbin/ngstart)
	@$(call install_link, initng, ngc, /sbin/ngstatus)
	@$(call install_link, initng, ngc, /sbin/ngstop)
	@$(call install_link, initng, ngc, /sbin/ngzap)
endif

ifdef PTXCONF_INITNG_NGC4
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/ngc4/.libs/libngc4.so, /usr/lib/initng/libngc4.so)
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/ngc4/.libs/libngcclient.so.0.0.0, /usr/lib/libngcclient.so.0.0.0)
	@$(call install_link, initng, libngcclient.so.0.0.0, /usr/lib/libngcclient.so.0)
	@$(call install_link, initng, libngcclient.so.0.0.0, /usr/lib/libngcclient.so)

	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/ngc4/.libs/ngc4, /sbin/ngc4)
endif

ifdef PTXCONF_INITNG_NGE
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/nge/.libs/libngeclient.so, /usr/lib/libngeclient.so.0.0.0)
	@$(call install_link, initng, libngeclient.so.0.0.0, /usr/lib/libngeclient.so.0)
	@$(call install_link, initng, libngeclient.so.0.0.0, /usr/lib/libngeclient.so)
	
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/nge/.libs/libnge.so, /usr/lib/initng/libnge.so)

	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/nge/.libs/ngde, /sbin/ngde)
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/nge/.libs/nge, /sbin/nge)
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/nge/.libs/nge_raw, /sbin/nge_raw)
endif

ifdef PTXCONF_INITNG_RELOAD
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/reload/.libs/libreload.so, /usr/lib/initng/libreload.so)
endif

ifdef PTXCONF_INITNG_CONFLICT
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/conflict/.libs/libconflict.so, /usr/lib/initng/libconflict.so)
endif

ifdef PTXCONF_INITNG_FSTAT
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/fstat/.libs/libfstat.so, /usr/lib/initng/libfstat.so)
endif

ifdef PTXCONF_INITNG_PAUSE
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/pause/.libs/libpause.so, /usr/lib/initng/libpause.so)
endif

ifdef PTXCONF_INITNG_SUID
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/suid/.libs/libsuid.so, /usr/lib/initng/libsuid.so)
endif

ifdef PTXCONF_INITNG_INTERACTIVE
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/interactive/.libs/libinteractive.so, /usr/lib/initng/libinteractive.so)
endif

ifdef PTXCONF_INITNG_INITCTL
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/initctl/.libs/libinitctl.so, /usr/lib/initng/libinitctl.so)
endif

ifdef PTXCONF_INITNG_CHROOT
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/chroot/.libs/libchroot.so, /usr/lib/initng/libchroot.so)
endif

ifdef PTXCONF_INITNG_FIND
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/find/.libs/libfind.so, /usr/lib/initng/libfind.so)
endif

ifdef PTXCONF_INITNG_UNNEEDED
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/unneeded/.libs/libunneeded.so, /usr/lib/initng/libunneeded.so)
endif


ifdef PTXCONF_INITNG_IPARSER
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/iparser/.libs/libiparser.so, /usr/lib/initng/libiparser.so)
endif

ifdef PTXCONF_INITNG_ALSO
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/also/.libs/libalso.so, /usr/lib/initng/libalso.so)
endif

ifdef PTXCONF_INITNG_SIMPLE_LAUNCHER
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/simple_launcher/.libs/libsimplelauncher.so, /usr/lib/initng/libsimplelauncher.so)
endif

ifdef PTXCONF_INITNG_USPLASH
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/usplash/.libs/libusplash.so, /usr/lib/initng/libusplash.so)
endif

ifdef PTXCONF_INITNG_NGC2
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/ngc2/.libs/libngc2.so, /usr/lib/initng/libngc2.so)
endif

ifdef PTXCONF_INITNG_LOGFILE
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/logfile/.libs/liblogfile.so, /usr/lib/initng/liblogfile.so)
endif

ifdef PTXCONF_INITNG_STCMD
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/stcmd/.libs/libstcmd.so, /usr/lib/initng/libstcmd.so)
endif

ifdef PTXCONF_INITNG_RENICE
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/renice/.libs/librenice.so, /usr/lib/initng/librenice.so)
endif

ifdef PTXCONF_INITNG_CHDIR
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/chdir/.libs/libchdir.so, /usr/lib/initng/libchdir.so)
endif

ifdef PTXCONF_INITNG_DAEMON_CLEAN
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/daemon_clean/.libs/libdaemon_clean.so, /usr/lib/initng/libdaemon_clean.so)
endif

ifdef PTXCONF_INITNG_HISTORY
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/history/.libs/libhistory.so, /usr/lib/initng/libhistory.so)
endif

ifdef PTXCONF_INITNG_RLPARSER
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/rlparser/.libs/librlparser.so, /usr/lib/initng/librlparser.so)
endif

ifdef PTXCONF_INITNG_STDOUT
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/stdout/.libs/libstdout.so, /usr/lib/initng/libstdout.so)
endif

ifdef PTXCONF_INITNG_BASH_LAUNCHER
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/bash_launcher/.libs/libbashlaunch.so, /usr/lib/initng/libbashlaunch.so)
endif

ifdef PTXCONF_INITNG_NETPROBE
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/netprobe/.libs/libnetprobe.so, /usr/lib/initng/libnetprobe.so)
endif

ifdef PTXCONF_INITNG_SYSLOG
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/syslog/.libs/libsyslog.so, /usr/lib/initng/libsyslog.so)
endif

ifdef PTXCONF_INITNG_IDLEPROBE
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/idleprobe/.libs/libidleprobe.so, /usr/lib/initng/libidleprobe.so)
endif

ifdef PTXCONF_INITNG_LAST
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/last/.libs/liblast.so, /usr/lib/initng/liblast.so)
endif

ifdef PTXCONF_INITNG_CPOUT
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/cpout/.libs/libcpout.so, /usr/lib/initng/libcpout.so)
endif

ifdef PTXCONF_INITNG_SYNCRON
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/syncron/.libs/libsyncron.so, /usr/lib/initng/libsyncron.so)
endif

ifdef PTXCONF_INITNG_ENVPARSER
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/envparser/.libs/libenvparser.so, /usr/lib/initng/libenvparser.so)
endif

ifdef PTXCONF_INITNG_LIMIT
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/limit/.libs/liblimit.so, /usr/lib/initng/liblimit.so)
endif

ifdef PTXCONF_INITNG_CRITICAL
	@$(call install_copy, initng, 0, 0, 0755, $(INITNG_DIR)/plugins/critical/.libs/libcritical.so, /usr/lib/initng/libcritical.so)
endif
	@$(call install_finish,initng)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

initng_clean:
	rm -rf $(STATEDIR)/initng.*
	rm -rf $(IMAGEDIR)/initng_*
	rm -rf $(INITNG_DIR)

# vim: syntax=make
