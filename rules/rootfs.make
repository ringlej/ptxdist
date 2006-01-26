# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ROOTFS) += rootfs

# dummy to make ipkg happy
ROOTFS_VERSION=1.0.0

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rootfs_get: $(STATEDIR)/rootfs.get

$(STATEDIR)/rootfs.get: $(rootfs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rootfs_extract: $(STATEDIR)/rootfs.extract

$(STATEDIR)/rootfs.extract: $(rootfs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rootfs_prepare: $(STATEDIR)/rootfs.prepare

$(STATEDIR)/rootfs.prepare: $(rootfs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rootfs_compile: $(STATEDIR)/rootfs.compile

$(STATEDIR)/rootfs.compile: $(rootfs_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rootfs_install: $(STATEDIR)/rootfs.install

$(STATEDIR)/rootfs.install: $(rootfs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rootfs_targetinstall: $(STATEDIR)/rootfs.targetinstall

$(STATEDIR)/rootfs.targetinstall: $(rootfs_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,rootfs)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(ROOTFS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	#
	# root filesystem population
	#

ifdef PTXCONF_ROOTFS_DEV
	@$(call install_copy, 0, 0, 0755, /dev)
endif
ifdef PTXCONF_ROOTFS_DEV_PTS
	@$(call install_copy, 0, 0, 0755, /dev/pts)
endif
ifdef PTXCONF_ROOTFS_HOME
	@$(call install_copy, 0, 0, 2775, /home)
endif
ifdef PTXCONF_ROOTFS_MEDIA
ifneq ($(PTXCONF_ROOTFS_MEDIA1),"")
	@$(call install_copy, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA1))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA2),"")
	@$(call install_copy, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA2))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA3),"")
	@$(call install_copy, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA3))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA4),"")
	@$(call install_copy, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA4))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA5),"")
	@$(call install_copy, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA5))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA6),"")
	@$(call install_copy, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA6))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA7),"")
	@$(call install_copy, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA7))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA8),"")
	@$(call install_copy, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA8))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA9),"")
	@$(call install_copy, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA9))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA10),"")
	@$(call install_copy, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA10))
endif
endif
ifdef PTXCONF_ROOTFS_MNT
	@$(call install_copy, 0, 0, 0755, /mnt)
endif
ifdef PTXCONF_ROOTFS_PROC
	@$(call install_copy, 0, 0, 0555, /proc)
endif
ifdef PTXCONF_ROOTFS_SYS
	@$(call install_copy, 0, 0, 0755, /sys)
endif
ifdef PTXCONF_ROOTFS_TMP
	@$(call install_copy, 0, 0, 1777, /tmp)
endif
ifdef PTXCONF_ROOTFS_VAR
	@$(call install_copy, 0, 0, 0755, /var)
endif
ifdef PTXCONF_ROOTFS_VAR_LOG
	@$(call install_copy, 0, 0, 0755, /var/log)
endif
ifdef PTXCONF_ROOTFS_VAR_RUN
	@$(call install_copy, 0, 0, 0755, /var/run)
endif
ifdef PTXCONF_ROOTFS_VAR_LOCK
	@$(call install_copy, 0, 0, 0755, /var/lock)
endif

	#
	# Files in /etc directory
	#

ifdef PTXCONF_ROOTFS_GENERIC_FSTAB
	@$(call install_copy, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects/generic/etc/fstab, /etc/fstab, n)
endif

ifdef PTXCONF_ROOTFS_GENERIC_MTAB
	@$(call install_link, /proc/mounts, /etc/mtab)
endif

ifdef PTXCONF_ROOTFS_GENERIC_GROUP
	@$(call install_copy, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects/generic/etc/group,        /etc/group, n)
	@$(call install_copy, 0, 0, 0640, $(PTXDIST_TOPDIR)/projects/generic/etc/gshadow,      /etc/gshadow, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_HOSTNAME
	@$(call install_copy, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects/generic/etc/hostname,     /etc/hostname, n)

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_HOSTNAME))"; \
	if [ -n "$$x" ]; then \
		echo $$x; \
		perl -i -p -e "s,\@HOSTNAME@,$$x,g" $(ROOTDIR)/etc/hostname; \
		perl -i -p -e "s,\@HOSTNAME@,$$x,g" $(IMAGEDIR)/ipkg/etc/hostname; \
	fi
endif
ifdef PTXCONF_ROOTFS_GENERIC_HOSTS
	@$(call install_copy, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects/generic/etc/hosts,        /etc/hosts, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_INITTAB
	@$(call install_copy, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects/generic/etc/inittab,      /etc/inittab, n)

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_CONSOLE))"; \
	if [ -n "$$x" ]; then \
		echo $$x; \
		perl -i -p -e "s,\@CONSOLE@,$$x,g" $(ROOTDIR)/etc/inittab; \
		perl -i -p -e "s,\@CONSOLE@,$$x,g" $(IMAGEDIR)/ipkg/etc/inittab; \
	fi
	
	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_CONSOLE_SPEED))"; \
	if [ -n "$$x" ]; then \
		echo $$x; \
		perl -i -p -e "s,\@SPEED@,$$x,g" $(ROOTDIR)/etc/inittab; \
		perl -i -p -e "s,\@SPEED@,$$x,g" $(IMAGEDIR)/ipkg/etc/inittab; \
	fi
endif
ifdef PTXCONF_ROOTFS_GENERIC_IPKG_CONF
	@$(call install_copy, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects/generic/etc/ipkg.conf, /etc/ipkg.conf, n)
	x="$(call remove_quotes,$(PTXCONF_ROOTFS_GENERIC_IPKG_CONF_URL))"; \
	echo $$x; \
	perl -i -p -e "s,\@SRC@,src $$x,g" $(ROOTDIR)/etc/ipkg.conf; \
	perl -i -p -e "s,\@SRC@,src $$x,g" $(IMAGEDIR)/ipkg/etc/ipkg.conf; \
	x="$(call remove_quotes,$(PTXCONF_ARCH))"; \
	echo $$x; \
	perl -i -p -e "s,\@ARCH@,$$x,g" $(ROOTDIR)/etc/ipkg.conf; \
	perl -i -p -e "s,\@ARCH@,$$x,g" $(IMAGEDIR)/ipkg/etc/ipkg.conf;
endif
ifdef PTXCONF_ROOTFS_GENERIC_NSSWITCH
	@$(call install_copy, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects/generic/etc/nsswitch.conf,/etc/nsswitch.conf, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_PASSWD
	@$(call install_copy, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects/generic/etc/passwd,       /etc/passwd, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_PROFILE
	@$(call install_copy, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects/generic/etc/profile,      /etc/profile, n)
	
	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_PS1))"; \
	echo $$x; \
	perl -i -p -e "s,\@PS1@,\"$$x\",g" $(ROOTDIR)/etc/profile; \
	perl -i -p -e "s,\@PS1@,\"$$x\",g" $(IMAGEDIR)/ipkg/etc/profile; \

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_PS2))"; \
	echo $$x; \
	perl -i -p -e "s,\@PS2@,\"$$x\",g" $(ROOTDIR)/etc/profile; \
	perl -i -p -e "s,\@PS2@,\"$$x\",g" $(IMAGEDIR)/ipkg/etc/profile; \

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_PS4))"; \
	echo $$x; \
	perl -i -p -e "s,\@PS4@,\"$$x\",g" $(ROOTDIR)/etc/profile; \
	perl -i -p -e "s,\@PS4@,\"$$x\",g" $(IMAGEDIR)/ipkg/etc/profile;
endif
ifdef PTXCONF_ROOTFS_GENERIC_PROTOCOLS
	@$(call install_copy, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects/generic/etc/protocols,    /etc/protocols, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_RESOLV
	@$(call install_copy, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects/generic/etc/resolv.conf,  /etc/resolv.conf, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_INETD
	inetdconf=`mktemp`; \
	servicesfile=`mktemp`; \
	cp $(PTXDIST_TOPDIR)/projects/generic/etc/inetd.conf $$inetdconf; \
	cp $(PTXDIST_TOPDIR)/projects/generic/etc/services $$servicesfile; \
	if [ "$(PTXCONF_INETUTILS_RSHD)" = "y" ]; then \
		sed -ie "s,@RSHD@,shell stream tcp nowait root /usr/sbin/rshd,g" $$inetdconf; \
		sed -ie "s,@RSHD@,shell 514/tcp cmd,g" $$servicesfile; \
	else \
		sed -ie "s,@RSHD@,,g" $$inetdconf; \
		sed -ie "s,@RSHD@,,g" $$servicesfile; \
	fi; \
	if [ "$(PTXCONF_NTP)$(PTXCONF_CHRONY)" != "" ]; then \
		sed -ie "s,@NTP@,ntp 123/tcp\nntp 123/udp,g" $$servicesfile; \
	else \
		sed -ie "s,@NTP@,,g" $$servicesfile; \
	fi; \
	echo "inetd.conf:"; \
	cat $$inetdconf; \
	echo "services:"; \
	cat $$servicesfile; \
	$(call install_copy, 0, 0, 0644, $$inetdconf, /etc/inetd.conf, n); \
	$(call install_copy, 0, 0, 0644, $$servicesfile, /etc/services, n); \
	rm -f $$inetdconf; \
	rm -f $$servicesfile
endif
ifdef PTXCONF_ROOTFS_GENERIC_SHADOW
	@$(call install_copy, 0, 0, 0640, $(PTXDIST_TOPDIR)/projects/generic/etc/shadow,       /etc/shadow, n)
	@$(call install_copy, 0, 0, 0600, $(PTXDIST_TOPDIR)/projects/generic/etc/shadow-,      /etc/shadow-, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_UDHCPC
	@$(call install_copy, 0, 0, 0744, $(PTXDIST_TOPDIR)/projects/generic/etc/udhcpc.script,/etc/udhcpc.script, n)
endif

	#
	# Startup scripts in /etc/init.d
	#
ifdef PTXCONF_ROOTFS_ETC_INITD_INETD
	@$(call install_copy, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects/generic/etc/init.d/inetd, /etc/init.d/inetd, n)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_INETD_LINK),"")
	@$(call install_link, /etc/init.d/inetd, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_INETD_LINK))
endif
endif

ifdef PTXCONF_ROOTFS_ETC_INITD

	# Copy generic etc/init.d
	@$(call install_copy, 0, 0, 0755, /etc/init.d)
	@$(call install_copy, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects/generic/etc/init.d/rcS,        /etc/init.d/rcS, n)

ifdef ROOTFS_ETC_INITD_LOGROTATE
	@$(call install_copy, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects/generic/etc/init.d/logrotate, /etc/init.d/logrotate, n)
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_NETWORKING
	@$(call install_copy, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects/generic/etc/init.d/networking, /etc/init.d/networking, n)
	@$(call install_copy, 0, 0, 0755, /etc/network/if-down.d)
	@$(call install_copy, 0, 0, 0755, /etc/network/if-up.d)
	@$(call install_copy, 0, 0, 0755, /etc/network/if-post-down.d)
	@$(call install_copy, 0, 0, 0755, /etc/network/if-pre-up.d)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_NETWORKING_LINK),"")
	@$(call install_link, /etc/init.d/networking, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_NETWORKING_LINK))
endif
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_NETWORKING_INTERFACES),"")
	$(call install_copy, 0, 0, 0644, $(PTXCONF_ROOTFS_ETC_INITD_NETWORKING_INTERFACES), /etc/network/interfaces, n)
endif
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_TELNETD
	@$(call install_copy, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects/generic/etc/init.d/telnetd,    /etc/init.d/telnetd, n)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_TELNETD_LINK),"")
	@$(call install_link, /etc/init.d/telnetd, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_TELNETD_LINK))
endif
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_HTTPD
	@$(call install_copy, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects/generic/etc/init.d/httpd,    /etc/init.d/httpd, n)
	x="$(call remove_quotes,$(PTXCONF_APACHE2_CONFIGDIR))/httpd.conf"; \
	echo $$x; \
	perl -i -p -e "s,\@APACHECONFIG@,$$x,g" $(ROOTDIR)/etc/init.d/httpd; \
	perl -i -p -e "s,\@APACHECONFIG@,$$x,g" $(IMAGEDIR)/ipkg/etc/init.d/httpd;

ifneq ($(PTXCONF_ROOTFS_ETC_INITD_HTTPD_LINK),"")
	@$(call install_link, /etc/init.d/httpd, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_HTTPD_LINK))
endif
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_STARTUP
	@$(call install_copy, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects/generic/etc/init.d/startup,    /etc/init.d/startup, n)
endif

	@$(call install_copy, 0, 0, 0755, /etc/rc.d)

ifdef PTXCONF_ROOTFS_ETC_INITD_BANNER
	@$(call install_copy, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects/generic/etc/init.d/banner,     /etc/init.d/banner, n)
	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_VENDOR))"; \
	perl -i -p -e "s,\@VENDOR@,$$x,g" $(ROOTDIR)/etc/init.d/banner; \
	perl -i -p -e "s,\@VENDOR@,$$x,g" $(IMAGEDIR)/ipkg/etc/init.d/banner; \

	perl -i -p -e "s,\@VERSION@,$(VERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@VERSION@,$(VERSION),g" $(IMAGEDIR)/ipkg/etc/init.d/banner
	perl -i -p -e "s,\@PATCHLEVEL@,$(PATCHLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PATCHLEVEL@,$(PATCHLEVEL),g" $(IMAGEDIR)/ipkg/etc/init.d/banner
	perl -i -p -e "s,\@SUBLEVEL@,$(SUBLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@SUBLEVEL@,$(SUBLEVEL),g" $(IMAGEDIR)/ipkg/etc/init.d/banner
	perl -i -p -e "s,\@PROJECT@,$(PROJECT),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PROJECT@,$(PROJECT),g" $(IMAGEDIR)/ipkg/etc/init.d/banner
	perl -i -p -e "s,\@EXTRAVERSION@,$(EXTRAVERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@EXTRAVERSION@,$(EXTRAVERSION),g" $(IMAGEDIR)/ipkg/etc/init.d/banner
	perl -i -p -e "s,\@DATE@,$(shell date -Iseconds),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@DATE@,$(shell date -Iseconds),g" $(IMAGEDIR)/ipkg/etc/init.d/banner
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_BANNER_LINK),"")
	@$(call install_link, ../init.d/banner, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_BANNER_LINK))
endif
endif

endif

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rootfs_clean: 
	rm -rf $(STATEDIR)/rootfs.* $(ROOTFS_DIR)
	rm -rf $(IMAGEDIR)/rootfs_*

# vim: syntax=make
