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
ROOTFS			= root-0.1.1
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

ifdef PTXCONF_ROOTFS_PROC
	mkdir -p $(ROOTDIR)/proc
endif

ifdef PTXCONF_ROOTFS_DEV
	mkdir -p $(ROOTDIR)/dev
endif

ifdef PTXCONF_ROOTFS_MNT
	mkdir -p $(ROOTDIR)/mnt
endif

ifdef PTXCONF_ROOTFS_FLOPPY
	mkdir -p $(ROOTDIR)/floppy
endif

#	# FIXME: code rot...
#ifdef PTXCONF_OPENSSH
#	cd $(OPENSSH_DIR) && install -m 644 sshd_config.out $(ROOTDIR)/etc/ssh/sshd_config
#endif

ifdef PTXCONF_ROOTFS_TMP
	@$(call clean, $(ROOTDIR)/tmp)
  ifdef PTXCONF_ROOTFS_TMP_DATALINK
	ln -s /data/tmp $(ROOTDIR)/tmp
  else
	mkdir -p $(ROOTDIR)/tmp
  endif
endif

ifdef PTXCONF_ROOTFS_VAR
	mkdir -p $(ROOTDIR)/var
	mkdir -p $(ROOTDIR)/var/log
endif

ifdef PTXCONF_ROOTFS_SYS
	mkdir -p $(ROOTDIR)/sys
endif

ifdef PTXCONF_ROOTFS_VAR_LOG_DATALINK
	mkdir -p $(ROOTDIR)/var
	@$(call clean, $(ROOTDIR)/var/log)
	ln -s /data/log $(ROOTDIR)/var/log
endif	

ifdef PTXCONF_ROOTFS_DATA
	mkdir -p $(ROOTDIR)/data
endif

ifdef PTXCONF_ROOTFS_HOME
	mkdir -p $(ROOTDIR)/home
endif

ifdef PTXCONF_ROOTFS_ETC

	# Copy generic etc
	# FIXME: some parts of this have to be put into the packet make files!

	mkdir -p $(ROOTDIR)/etc
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/fstab,        /etc/fstab)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/group,        /etc/group)
	$(call copy_root, 0, 0, 0640, $(TOPDIR)/projects/generic/etc/gshadow,      /etc/gshadow)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/hostname,     /etc/hostname)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/hosts,        /etc/hosts)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/inittab,      /etc/inittab)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/passwd,       /etc/passwd)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/profile,      /etc/profile)
	$(call copy_root, 11, 101, 0644, $(TOPDIR)/projects/generic/etc/proftpd.conf, /etc/proftpd.conf)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/protocols,    /etc/protocols)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/resolv.conf,  /etc/resolv.conf)
	$(call copy_root, 0, 0, 0640, $(TOPDIR)/projects/generic/etc/shadow,       /etc/shadow)
	$(call copy_root, 0, 0, 0600, $(TOPDIR)/projects/generic/etc/shadow-,      /etc/shadow-)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/projects/generic/etc/udhcpc.script,/etc/udhcpc.script)
	$(call copy_root, 0, 0, 0755, /etc/init.d)
	$(call copy_root, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/banner,     /etc/init.d/banner)
	$(call copy_root, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/networking, /etc/init.d/networking)
	$(call copy_root, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/net2flash,  /etc/init.d/net2flash)
	$(call copy_root, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/proftpd,    /etc/init.d/proftpd)
	$(call copy_root, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/rcS,        /etc/init.d/rcS)
	$(call copy_root, 0, 0, 0755, $(TOPDIR)/projects/generic/etc/init.d/utelnetd,   /etc/init.d/utelnetd)
	$(call copy_root, 0, 0, 0755, /etc/rc.d)

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_HOSTNAME))"; \
	if [ -n "$$x" ]; then \
		echo $$x; \
		perl -i -p -e "s,\@HOSTNAME@,$$x,g" $(ROOTDIR)/etc/hostname; \
	fi

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_CONSOLE))"; \
	if [ -n "$$x" ]; then \
		echo $$x; \
		perl -i -p -e "s,\@CONSOLE@,$$x,g" $(ROOTDIR)/etc/inittab; \
	fi

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_CONSOLE_SPEED))"; \
	if [ -n "$$x" ]; then \
		echo $$x; \
		perl -i -p -e "s,\@SPEED@,$$x,g" $(ROOTDIR)/etc/inittab; \
	fi

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_PS1))"; \
	if [ -n "$$x" ]; then \
		echo $$x; \
		perl -i -p -e "s,\@PS1@,$$x,g" $(ROOTDIR)/etc/profile; \
	fi

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_PS2))"; \
	if [ -n "$$x" ]; then \
		echo $$x; \
		perl -i -p -e "s,\@PS2@,$$x,g" $(ROOTDIR)/etc/profile; \
	fi

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_PS4))"; \
	if [ -n "$$x" ]; then \
		echo $$x; \
		perl -i -p -e "s,\@PS4@,$$x,g" $(ROOTDIR)/etc/profile; \
	fi

	x="$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_VENDOR))"; \
	if [ -n "$$x" ]; then \
		echo $$x; \
		perl -i -p -e "s,\@VENDOR@,$$x,g" $(ROOTDIR)/etc/init.d/banner; \
	fi

	perl -i -p -e "s,\@VERSION@,$(VERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PATCHLEVEL@,$(PATCHLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@SUBLEVEL@,$(SUBLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PROJECT@,$(PROJECT),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@EXTRAVERSION@,$(EXTRAVERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@DATE@,$(shell date -Iseconds),g" $(ROOTDIR)/etc/init.d/banner

endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rootfs_clean: 
	rm -rf $(STATEDIR)/rootfs.* $(ROOTFS_DIR)

# vim: syntax=make
