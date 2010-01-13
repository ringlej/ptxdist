# -*-makefile-*-
#
# Copyright (C) 2003-2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_INITRAMFS_BUSYBOX) += initramfs-busybox

#
# Paths and names
#
INITRAMFS_BUSYBOX		:= initramfs-$(BUSYBOX)
INITRAMFS_BUSYBOX_DIR		:= $(KLIBC_BUILDDIR)/$(BUSYBOX)
INITRAMFS_BUSYBOX_KCONFIG	:= $(INITRAMFS_BUSYBOX_DIR)/Config.in

ifdef PTXCONF_INITRAMFS_BUSYBOX
$(STATEDIR)/klibc.targetinstall.post: $(STATEDIR)/initramfs-busybox.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-busybox.get: $(STATEDIR)/busybox.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-busybox.extract:
	@$(call targetinfo)
	@$(call clean, $(INITRAMFS_BUSYBOX_DIR))
	@$(call extract, BUSYBOX, $(KLIBC_BUILDDIR))
	@$(call patchin, INITRAMFS_BUSYBOX, $(INITRAMFS_BUSYBOX_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

INITRAMFS_BUSYBOX_PATH	:= PATH=$(CROSS_PATH)
INITRAMFS_BUSYBOX_ENV 	:= $(CROSS_ENV)

INITRAMFS_BUSYBOX_MAKEVARS := \
	ARCH=$(PTXCONF_ARCH_STRING) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	HOSTCC=$(HOSTCC)

$(STATEDIR)/initramfs-busybox.prepare:
	@$(call targetinfo)

	cd $(INITRAMFS_BUSYBOX_DIR) && \
		$(INITRAMFS_BUSYBOX_PATH) $(INITRAMFS_BUSYBOX_ENV) \
		$(MAKE) distclean $(INITRAMFS_BUSYBOX_MAKEVARS)
	grep -e PTXCONF_INITRAMFS_BUSYBOX_ $(PTXDIST_PTXCONFIG) | \
		sed -e 's/PTXCONF_INITRAMFS_BUSYBOX_/CONFIG_/g' > $(INITRAMFS_BUSYBOX_DIR)/.config

	$(call ptx/oldconfig, INITRAMFS_BUSYBOX)

	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-busybox.install:
	@$(call targetinfo)
	cd $(INITRAMFS_BUSYBOX_DIR) && $(INITRAMFS_BUSYBOX_PATH) $(MAKE) \
		$(INITRAMFS_BUSYBOX_MAKEVARS) CONFIG_PREFIX=$(SYSROOT)/usr/lib/klibc install
	cd $(INITRAMFS_BUSYBOX_DIR) && $(INITRAMFS_BUSYBOX_PATH) $(MAKE) \
		$(INITRAMFS_BUSYBOX_MAKEVARS) CONFIG_PREFIX=$(INITRAMFS_BUSYBOX_PKGDIR) install
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-busybox.targetinstall:
	@$(call targetinfo)

ifdef PTXCONF_INITRAMFS_BUSYBOX_FEATURE_SUID
	@$(call install_initramfs, initramfs-busybox, 0, 0, 4755, $(INITRAMFS_BUSYBOX_DIR)/busybox, /bin/busybox);
else
	@$(call install_initramfs, initramfs-busybox, 0, 0, 755, $(INITRAMFS_BUSYBOX_DIR)/busybox, /bin/busybox);
endif
	@cat $(INITRAMFS_BUSYBOX_DIR)/busybox.links | while read link; do		\
		case "$${link}" in					\
		(/*/*/*) to="../../bin/busybox" ;;			\
		(/bin/*) to="busybox" ;;				\
		(/*/*)	 to="../bin/busybox" ;;				\
		(/*)     to="bin/busybox" ;;				\
		esac;							\
		$(call install_initramfs_link, busybox, "$${to}", "$${link}");	\
	done

ifdef PTXCONF_INITRAMFS_BUSYBOX_TELNETD_INETD
	@$(call install_initramfs_alt, initramfs-busybox, 0, 0, 0644, /etc/inetd.conf.d/telnetd);
endif

#	#
#	# bb init: start scripts
#	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_INITRAMFS_BUSYBOX_INETD_STARTSCRIPT
	@$(call install_initramfs_alt, initramfs-busybox, 0, 0, 0755, /etc/init.d/inetd);
endif

ifdef PTXCONF_INITRAMFS_BUSYBOX_TELNETD_STARTSCRIPT
	@$(call install_initramfs_alt, initramfs-busybox, 0, 0, 0755, /etc/init.d/telnetd);
endif

ifdef PTXCONF_INITRAMFS_BUSYBOX_SYSLOGD_STARTSCRIPT
	@$(call install_initramfs_alt, initramfs-busybox, 0, 0, 0755, /etc/init.d/syslogd);
endif

ifdef PTXCONF_INITRAMFS_BUSYBOX_CROND_STARTSCRIPT
	@$(call install_initramfs_alt, initramfs-busybox, 0, 0, 0755, /etc/init.d/crond);
endif

ifdef PTXCONF_INITRAMFS_BUSYBOX_HWCLOCK_STARTSCRIPT
	@$(call install_initramfs_alt, initramfs-busybox, 0, 0, 0755, /etc/init.d/hwclock);
endif
endif # PTXCONF_INITMETHOD_BBINIT

#	#
#	# config files
#	#

ifdef PTXCONF_INITRAMFS_BUSYBOX_APP_UDHCPC
	@$(call install_initramfs_alt, initramfs-busybox, 0, 0, 0754, /etc/udhcpc.script);
	@$(call install_initramfs_link, initramfs-busybox, ../../../etc/udhcpc.script, /usr/share/udhcpc/default.script);
endif

ifdef PTXCONF_INITRAMFS_BUSYBOX_CROND
	@$(call install_initramfs, initramfs-busybox, 0, 0, 0755, /etc/cron);
	@$(call install_initramfs, initramfs-busybox, 0, 0, 0755, /var/spool/cron/crontabs/);
endif

	@$(call touch)

# vim: syntax=make
