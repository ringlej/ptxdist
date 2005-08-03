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
ifdef PTXCONF_ROOTFS
PACKAGES += rootfs
endif

#
# Paths and names 
#
ROOTFS_VERSION		= 0.1.1
ROOTFS			= root-$(ROOTFS_VERSION)
ROOTFS_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(ROOTFS).tgz
ROOTFS_SOURCE		= $(SRCDIR)/$(ROOTFS).tgz
ROOTFS_DIR		= $(BUILDDIR)/$(ROOTFS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rootfs_get: $(STATEDIR)/rootfs.get

$(STATEDIR)/rootfs.get: $(ROOTFS_SOURCE)
	@$(call targetinfo, $@)
	touch $@

$(ROOTFS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(ROOTFS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rootfs_extract: $(STATEDIR)/rootfs.extract

$(STATEDIR)/rootfs.extract: $(STATEDIR)/rootfs.get
	@$(call targetinfo, $@)
	@$(call extract, $(ROOTFS_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rootfs_prepare: $(STATEDIR)/rootfs.prepare

$(STATEDIR)/rootfs.prepare: $(STATEDIR)/rootfs.extract
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rootfs_compile: $(STATEDIR)/rootfs.compile

$(STATEDIR)/rootfs.compile: $(STATEDIR)/rootfs.prepare 
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rootfs_install: $(STATEDIR)/rootfs.install

$(STATEDIR)/rootfs.install: $(STATEDIR)/rootfs.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rootfs_targetinstall: $(STATEDIR)/rootfs.targetinstall

$(STATEDIR)/rootfs.targetinstall: $(STATEDIR)/rootfs.install
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,rootfs)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(ROOTFS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_ROOTFS_PROC
	@$(call install_copy, 0, 0, 0555, /proc)
endif

ifdef PTXCONF_ROOTFS_DEV
	@$(call install_copy, 0, 0, 0755, /dev)
endif

ifdef PTXCONF_ROOTFS_MNT
	@$(call install_copy, 0, 0, 0755, /mnt)
endif

ifneq ($(PTXCONF_ROOTFS_MEDIA1),"")
	@$(call install_copy, 0, 0, 0755, /media/$(PTXCONF_ROOTFS_MEDIA1))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA2),"")
	@$(call install_copy, 0, 0, 0755, /media/$(PTXCONF_ROOTFS_MEDIA2))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA3),"")
	@$(call install_copy, 0, 0, 0755, /media/$(PTXCONF_ROOTFS_MEDIA3))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA4),"")
	@$(call install_copy, 0, 0, 0755, /media/$(PTXCONF_ROOTFS_MEDIA4))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA5),"")
	@$(call install_copy, 0, 0, 0755, /media/$(PTXCONF_ROOTFS_MEDIA5))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA6),"")
	@$(call install_copy, 0, 0, 0755, /media/$(PTXCONF_ROOTFS_MEDIA6))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA7),"")
	@$(call install_copy, 0, 0, 0755, /media/$(PTXCONF_ROOTFS_MEDIA7))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA8),"")
	@$(call install_copy, 0, 0, 0755, /media/$(PTXCONF_ROOTFS_MEDIA8))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA9),"")
	@$(call install_copy, 0, 0, 0755, /media/$(PTXCONF_ROOTFS_MEDIA9))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA10),"")
	@$(call install_copy, 0, 0, 0755, /media/$(PTXCONF_ROOTFS_MEDIA10))
endif

ifdef PTXCONF_ROOTFS_FLOPPY
	@$(call install_copy, 0, 0, 0755, /floppy)
endif

ifdef PTXCONF_ROOTFS_TMP
	@$(call install_copy, 0, 0, 1777, /tmp)
endif

ifdef PTXCONF_ROOTFS_VAR
	@$(call install_copy, 0, 0, 0755, /var)
	@$(call install_copy, 0, 0, 0755, /var/log)
	@$(call install_copy, 0, 0, 0755, /var/www)
endif

ifdef PTXCONF_ROOTFS_SYS
	@$(call install_copy, 0, 0, 0755, /sys)
endif

ifdef PTXCONF_ROOTFS_HOME
	@$(call install_copy, 0, 0, 2775, /home)
endif

ifdef PTXCONF_ROOTFS_ETC

	# Copy generic etc
	@$(call install_copy, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/fstab,        /etc/fstab, n)
	@$(call install_copy, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/group,        /etc/group, n)
	@$(call install_copy, 0, 0, 0640, $(TOPDIR)/projects/generic/etc/gshadow,      /etc/gshadow, n)
	@$(call install_copy, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/hostname,     /etc/hostname, n)
	@$(call install_copy, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/hosts,        /etc/hosts, n)
	@$(call install_copy, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/inittab,      /etc/inittab, n)
	@$(call install_copy, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/nsswitch.conf,/etc/nsswitch.conf, n)
	@$(call install_copy, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/passwd,       /etc/passwd, n)
	@$(call install_copy, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/profile,      /etc/profile, n)
	@$(call install_copy, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/protocols,    /etc/protocols, n)
	@$(call install_copy, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/resolv.conf,  /etc/resolv.conf, n)
	@$(call install_copy, 0, 0, 0640, $(TOPDIR)/projects/generic/etc/shadow,       /etc/shadow, n)
	@$(call install_copy, 0, 0, 0600, $(TOPDIR)/projects/generic/etc/shadow-,      /etc/shadow-, n)
	@$(call install_copy, 0, 0, 0755, /etc/init.d)
	@$(call install_copy, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/banner,     /etc/init.d/banner, n)
	@$(call install_copy, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/networking, /etc/init.d/networking, n)
	@$(call install_copy, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/net2flash,  /etc/init.d/net2flash, n)
	@$(call install_copy, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/proftpd,    /etc/init.d/proftpd, n)
	@$(call install_copy, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/rcS,        /etc/init.d/rcS, n)
	@$(call install_copy, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/telnetd,    /etc/init.d/telnetd, n)
	@$(call install_copy, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/startup,    /etc/init.d/startup, n)
	@$(call install_copy, 0, 0, 0755, /etc/rc.d)

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_HOSTNAME))"; \
	if [ -n "$$x" ]; then \
		echo $$x; \
		perl -i -p -e "s,\@HOSTNAME@,$$x,g" $(ROOTDIR)/etc/hostname; \
		perl -i -p -e "s,\@HOSTNAME@,$$x,g" $(IMAGEDIR)/ipkg/etc/hostname; \
	fi

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
	perl -i -p -e "s,\@PS4@,\"$$x\",g" $(IMAGEDIR)/ipkg/etc/profile; \

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_VENDOR))"; \
	if [ -n "$$x" ]; then \
		echo $$x; \
		perl -i -p -e "s,\@VENDOR@,$$x,g" $(ROOTDIR)/etc/init.d/banner; \
		perl -i -p -e "s,\@VENDOR@,$$x,g" $(IMAGEDIR)/ipkg/etc/init.d/banner; \
	else \
		perl -i -p -e "s,\@VENDOR@,,g" $(ROOTDIR)/etc/init.d/banner; \
		perl -i -p -e "s,\@VENDOR@,,g" $(IMAGEDIR)/ipkg/etc/init.d/banner; \
	fi

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

ifdef PTXCONF_ROOTFS_ETC_UDHCPC
	@$(call install_copy, 0, 0, 0744, $(TOPDIR)/projects/generic/etc/udhcpc.script,/etc/udhcpc.script, n)
endif

endif
	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rootfs_clean: 
	rm -rf $(STATEDIR)/rootfs.* $(ROOTFS_DIR)
	rm -rf $(IMAGEDIR)/rootfs_*

# vim: syntax=make
