# -*-makefile-*-
#
# Copyright (C) 2003 Ixia Corporation (www.ixiacom.com), by Milan Bobde
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NMAP) += nmap

#
# Paths and names
#
NMAP_VERSION	:= 7.70
NMAP_MD5	:= 84eb6fbe788e0d4918c2b1e39421bf79
NMAP		:= nmap-$(NMAP_VERSION)
NMAP_SUFFIX	:= tar.bz2
NMAP_URL	:= http://nmap.org/dist/$(NMAP).$(NMAP_SUFFIX)
NMAP_SOURCE	:= $(SRCDIR)/$(NMAP).$(NMAP_SUFFIX)
NMAP_DIR	:= $(BUILDDIR)/$(NMAP)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NMAP_CONF_TOOL := autoconf
NMAP_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--without-localdirs \
	--without-ndiff \
	--without-zenmap \
	--$(call ptx/wwo, PTXCONF_NMAP_NPING)-nping \
	--with-openssl=$(call ptx/ifdef,PTXCONF_NMAP_OPENSSL,$(SYSROOT),no) \
	--with-libpcap \
	--with-libpcre \
	--without-libz \
	--without-libssh2 \
	--with-libdnet=included \
	--without-liblua \
	--with-liblinear=included \
	--without-ncat \
	--without-nmap-update \
	--without-subversion \


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nmap.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nmap)
	@$(call install_fixup, nmap,PRIORITY,optional)
	@$(call install_fixup, nmap,SECTION,base)
	@$(call install_fixup, nmap,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, nmap,DESCRIPTION,missing)

	@$(call install_copy, nmap, 0, 0, 0755, -, /usr/bin/nmap)

ifdef PTXCONF_NMAP_NPING
	@$(call install_copy, nmap, 0, 0, 0755, -, /usr/bin/nping)
endif

ifdef PTXCONF_NMAP_SERVICES
	@$(call install_copy, nmap, 0, 0, 0644, -, \
		/usr/share/nmap/nmap-mac-prefixes)
	@$(call install_copy, nmap, 0, 0, 0644, -, \
		/usr/share/nmap/nmap-os-db)
	@$(call install_copy, nmap, 0, 0, 0644, -, \
		/usr/share/nmap/nmap-protocols)
	@$(call install_copy, nmap, 0, 0, 0644, -, \
		/usr/share/nmap/nmap-rpc)
	@$(call install_copy, nmap, 0, 0, 0644, -, \
		/usr/share/nmap/nmap-service-probes)
	@$(call install_copy, nmap, 0, 0, 0644, -, \
		/usr/share/nmap/nmap-services)
endif
	@$(call install_finish, nmap)
	@$(call touch)

# vim: syntax=make
