# -*-makefile-*-
#
# Copyright (C) 2015 Dr. Neuhaus Telekommunikation GmbH, Hamburg Germany, Oliver Graute <oliver.graute@neuhaus.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QUAGGA) += quagga

#
# Paths and names
#
QUAGGA_VERSION	:= 1.2.4
QUAGGA_MD5	:= eced21b054d71c9e1b7c6ac43286a166
QUAGGA		:= quagga-$(QUAGGA_VERSION)
QUAGGA_SUFFIX	:= tar.gz
QUAGGA_URL	:= http://download.savannah.gnu.org/releases/quagga/$(QUAGGA).$(QUAGGA_SUFFIX)
QUAGGA_SOURCE	:= $(SRCDIR)/$(QUAGGA).$(QUAGGA_SUFFIX)
QUAGGA_DIR	:= $(BUILDDIR)/$(QUAGGA)
QUAGGA_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
QUAGGA_CONF_TOOL	:= autoconf
QUAGGA_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/endis, PTXCONF_QUAGGA_VTYSH)-vtysh \
	--$(call ptx/endis, PTXCONF_QUAGGA_ZEBRA)-zebra \
	--$(call ptx/endis, PTXCONF_QUAGGA_BGPD)-bgpd \
	--$(call ptx/endis, PTXCONF_QUAGGA_RIPD)-ripd \
	--$(call ptx/endis, PTXCONF_QUAGGA_RIPNGD)-ripngd \
	--$(call ptx/endis, PTXCONF_QUAGGA_OSPFD)-ospfd \
	--$(call ptx/endis, PTXCONF_QUAGGA_OSPF6D)-ospf6d \
	--$(call ptx/endis, PTXCONF_QUAGGA_NHRPD)-nhrpd \
	--$(call ptx/endis, PTXCONF_QUAGGA_WATCHQUAGGA)-watchquagga \
	--$(call ptx/endis, PTXCONF_QUAGGA_ISISD)-isisd \
	--$(call ptx/endis, PTXCONF_QUAGGA_PIMD)-pimd \
	--disable-doc \
	--disable-bgp-announce \
	--enable-snmp=agentx \
	--enable-tcp-zebra \
	--$(call ptx/endis, PTXCONF_QUAGGA_OSPF)-ospfapi \
	--$(call ptx/endis, PTXCONF_QUAGGA_OSPF)-ospfclient \
	--enable-multipath=1 \
	--enable-user=user \
	--enable-group=group \
	--enable-vty-group=no \
	--enable-configfile-mask=-600 \
	--enable-logfile-mask=-600 \
	--disable-rtadv \
	--enable-irdp \
	--enable-isis-topology \
	--disable-capabilities \
	--disable-rusage \
	--enable-gcc-ultra-verbose \
	--enable-linux24-tcp-md5 \
	--enable-gcc-rdynamic \
	--disable-backtrace \
	--disable-time-check \
	--enable-pcreposix \
	--enable-fpm

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/quagga.targetinstall:
	@$(call targetinfo)

	@$(call install_init, quagga)
	@$(call install_fixup, quagga,PRIORITY,optional)
	@$(call install_fixup, quagga,SECTION,base)
	@$(call install_fixup, quagga,AUTHOR,"<oliver.graute@neuhaus.de>")
	@$(call install_fixup, quagga,DESCRIPTION,missing)

	@$(call install_lib, quagga, 0, 0, 0644, libzebra)

ifdef PTXCONF_QUAGGA_RIPD
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/ripd)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/quagga/ripd.conf)
endif
ifdef PTXCONF_QUAGGA_RIPNGD
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/ripngd)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/quagga/ripngd.conf)
endif
ifdef PTXCONF_QUAGGA_NHRPD
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/nhrpd)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/quagga/nhrpd.conf)
endif
ifdef PTXCONF_QUAGGA_BGPD
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/bgpd)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/quagga/bgpd.conf)
endif
ifdef PTXCONF_QUAGGA_ZEBRA
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/zebra)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/quagga/zebra.conf)
endif
ifdef PTXCONF_QUAGGA_OSPFD
	@$(call install_lib, quagga, 0, 0, 0644, libospf)
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/ospfd)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/quagga/ospfd.conf)
endif
ifdef PTXCONF_QUAGGA_OSPF6D
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/ospf6d)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/quagga/ospf6d.conf)
endif
ifdef PTXCONF_QUAGGA_WATCHQUAGGA
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/watchquagga)
endif
ifdef PTXCONF_QUAGGA_VTYSH
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/bin/vtysh)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/quagga/vtysh.conf)
endif
ifdef PTXCONF_QUAGGA_ISISD
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/isisd)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/quagga/isisd.conf)
endif
ifdef PTXCONF_QUAGGA_PIMD
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/pimd)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/quagga/pimd.conf)
endif
ifdef PTXCONF_QUAGGA_OSPF
	@$(call install_lib, quagga, 0, 0, 0644, libospfapiclient)
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/ospfclient)
endif

	@$(call install_finish, quagga)

	@$(call touch)

# vim: syntax=make
