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
PACKAGES-$(PTXCONF_BUSYBOX) += busybox

#
# Paths and names
#
BUSYBOX_VERSION	:= 1.15.2
BUSYBOX		:= busybox-$(BUSYBOX_VERSION)
BUSYBOX_SUFFIX	:= tar.bz2
BUSYBOX_URL	:= http://www.busybox.net/downloads/$(BUSYBOX).$(BUSYBOX_SUFFIX)
BUSYBOX_SOURCE	:= $(SRCDIR)/$(BUSYBOX).$(BUSYBOX_SUFFIX)
BUSYBOX_DIR	:= $(BUILDDIR)/$(BUSYBOX)
BUSYBOX_PKGDIR	:= $(PKGDIR)/$(BUSYBOX)
BUSYBOX_KCONFIG	:= $(BUSYBOX_DIR)/Config.in
BUSYBOX_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BUSYBOX_SOURCE):
	@$(call targetinfo)
	@$(call get, BUSYBOX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BUSYBOX_PATH	:= PATH=$(CROSS_PATH)
BUSYBOX_ENV 	:= $(CROSS_ENV)

BUSYBOX_MAKEVARS := \
	ARCH=$(PTXCONF_ARCH_STRING) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	HOSTCC=$(HOSTCC)

$(STATEDIR)/busybox.prepare:
	@$(call targetinfo)

	@cd $(BUSYBOX_DIR) && \
		$(BUSYBOX_PATH) $(BUSYBOX_ENV) \
		$(MAKE) distclean $(BUSYBOX_MAKEVARS)
	@grep -e PTXCONF_BUSYBOX_ $(PTXDIST_PTXCONFIG) | \
		sed -e 's/PTXCONF_BUSYBOX_/CONFIG_/g' > $(BUSYBOX_DIR)/.config

	@$(call ptx/oldconfig, BUSYBOX)

	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/busybox.install:
	@$(call targetinfo)
	cd $(BUSYBOX_DIR) && $(BUSYBOX_PATH) $(MAKE) \
		$(BUSYBOX_MAKEVARS) CONFIG_PREFIX=$(SYSROOT) install
	cd $(BUSYBOX_DIR) && $(BUSYBOX_PATH) $(MAKE) \
		$(BUSYBOX_MAKEVARS) CONFIG_PREFIX=$(BUSYBOX_PKGDIR) install
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/busybox.targetinstall:
	@$(call targetinfo)

	@$(call install_init, busybox)
	@$(call install_fixup, busybox,PACKAGE,busybox)
	@$(call install_fixup, busybox,PRIORITY,optional)
	@$(call install_fixup, busybox,VERSION,$(BUSYBOX_VERSION))
	@$(call install_fixup, busybox,SECTION,base)
	@$(call install_fixup, busybox,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, busybox,DEPENDS,)
	@$(call install_fixup, busybox,DESCRIPTION,missing)

ifdef PTXCONF_BUSYBOX_FEATURE_SUID
	@$(call install_copy, busybox, 0, 0, 4755, -, /bin/busybox)
else
	@$(call install_copy, busybox, 0, 0, 755, -, /bin/busybox)
endif
	@cat $(BUSYBOX_DIR)/busybox.links | while read link; do		\
		case "$${link}" in					\
		(/*/*/*) to="../../bin/busybox" ;;			\
		(/bin/*) to="busybox" ;;				\
		(/*/*)	 to="../bin/busybox" ;;				\
		(/*)     to="bin/busybox" ;;				\
		esac;							\
		$(call install_link, busybox, "$${to}", "$${link}");	\
	done

ifdef PTXCONF_BUSYBOX_TELNETD_INETD
	@$(call install_alternative, busybox, 0, 0, 0644, /etc/inetd.conf.d/telnetd)
endif

#	#
#	# bb init: start scripts
#	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_BUSYBOX_INETD_STARTSCRIPT
	@$(call install_alternative, busybox, 0, 0, 0755, /etc/init.d/inetd)
endif

ifdef PTXCONF_BUSYBOX_TELNETD_STARTSCRIPT
	@$(call install_alternative, busybox, 0, 0, 0755, /etc/init.d/telnetd)
endif

ifdef PTXCONF_BUSYBOX_SYSLOGD_STARTSCRIPT
	@$(call install_alternative, busybox, 0, 0, 0755, /etc/init.d/syslogd)
endif

ifdef PTXCONF_BUSYBOX_CROND_STARTSCRIPT
	@$(call install_alternative, busybox, 0, 0, 0755, /etc/init.d/crond)
endif

ifdef PTXCONF_BUSYBOX_HWCLOCK_STARTSCRIPT
	@$(call install_alternative, busybox, 0, 0, 0755, /etc/init.d/hwclock)
endif
endif # PTXCONF_INITMETHOD_BBINIT

#	#
#	# config files
#	#

ifdef PTXCONF_BUSYBOX_APP_UDHCPC
	@$(call install_alternative, busybox, 0, 0, 0754, /etc/udhcpc.script)
	@$(call install_link, busybox, ../../../etc/udhcpc.script, /usr/share/udhcpc/default.script)
endif

ifdef PTXCONF_BUSYBOX_CROND
	@$(call install_copy, busybox, 0, 0, 0755, /etc/cron)
	@$(call install_copy, busybox, 0, 0, 0755, /var/spool/cron/crontabs/)
endif

	@$(call install_finish, busybox)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

busybox_clean:
	rm -rf $(STATEDIR)/busybox.*
	rm -rf $(PKGDIR)/busybox_*
	rm -rf $(BUSYBOX_DIR)

# vim: syntax=make
