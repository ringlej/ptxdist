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
QUAGGA_VERSION	:= 0.99.23
QUAGGA_MD5	:= d17145e62b6ea14f0f13bb63f59e5166
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
	$(GLOBAL_IPV6_OPTION) \
	--$(call ptx/endis, PTXCONF_QUAGGA_VTYSH)-vtysh \
	--$(call ptx/endis, PTXCONF_QUAGGA_ZEBRA)-zebra \
	--$(call ptx/endis, PTXCONF_QUAGGA_BGPD)-bgpd \
	--$(call ptx/endis, PTXCONF_QUAGGA_RIPD)-ripd \
	--$(call ptx/endis, PTXCONF_QUAGGA_RIPNGD)-ripngd \
	--$(call ptx/endis, PTXCONF_QUAGGA_OSPFD)-ospfd \
	--$(call ptx/endis, PTXCONF_QUAGGA_OSPF6D)-ospf6d \
	--$(call ptx/endis, PTXCONF_QUAGGA_BABELD)-babeld \
	--$(call ptx/endis, PTXCONF_QUAGGA_WATCHQUAGGA)-watchquagga \
	--disable-doc \
	--enable-isisd \
	--enable-solaris \
	--disable-bgp-announce \
	--enable-netlink \
	--enable-snmp=agentx \
	--enable-tcp-zebra \
	--disable-opaque-lsa \
	--disable-ospfapi \
	--disable-ospfclient \
	--disable-ospf-te \
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
	--enable-fpm \
	--disable-pie

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
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/ripd.conf)
endif
ifdef PTXCONF_QUAGGA_RIPNGD
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/ripngd)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/ripngd.conf)
endif
ifdef PTXCONF_QUAGGA_BABELD
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/babeld)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/babeld.conf)
endif
ifdef PTXCONF_QUAGGA_BGPD
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/bgpd)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/bgpd.conf)
endif
ifdef PTXCONF_QUAGGA_ZEBRA
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/zebra)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/zebra.conf)
endif
ifdef PTXCONF_QUAGGA_OSPFD
	@$(call install_lib, quagga, 0, 0, 0644, libospf)
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/ospfd)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/ospfd.conf)
endif
ifdef PTXCONF_QUAGGA_OSPF6D
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/ospf6d)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/ospf6d.conf)
endif
ifdef PTXCONF_QUAGGA_WATCHQUAGGA
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/sbin/watchquagga)
endif
ifdef PTXCONF_QUAGGA_VTYSH
	@$(call install_copy, quagga, 0, 0, 0755, -, /usr/bin/vtysh)
	@$(call install_alternative, quagga, 0, 0, 0644, /etc/vtysh.conf)
endif


	@$(call install_finish, quagga)

	@$(call touch)

# vim: syntax=make
