# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEMD) += host-systemd

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# FIXME: disable intltool-merge
# https://github.com/systemd/systemd/issues/7300

HOST_SYSTEMD_CONF_TOOL	:= meson
HOST_SYSTEMD_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Drootprefix=/lib/.. \
	-Dacl=false \
	-Dadm-group=true \
	-Dapparmor=false \
	-Daudit=false \
	-Dbacklight=false \
	-Dbinfmt=false \
	-Dblkid=false \
	-Dbzip2=false \
	-Dcompat-gateway-hostname=false \
	-Dcoredump=false \
	-Ddbus=false \
	-Ddbuspolicydir=/usr/share/dbus-1/system.d \
	-Ddbussessionservicedir=/usr/share/dbus-1/services \
	-Ddbussystemservicedir=/usr/share/dbus-1/system-services \
	-Ddefault-dns-over-tls=no \
	-Ddefault-dnssec=no \
	-Ddefault-hierarchy=hybrid \
	-Ddefault-kill-user-processes=true \
	-Ddev-kvm-mode=0660 \
	-Ddns-over-tls=false \
	-Ddns-servers= \
	-Defi=false \
	-Delfutils=false \
	-Denvironment-d=false \
	-Dfirstboot=false \
	-Dgcrypt=false \
	-Dglib=false \
	-Dgnutls=false \
	-Dgshadow=false \
	-Dhibernate=false \
	-Dhostnamed=false \
	-Dhtml=false \
	-Dhwdb=true \
	-Didn=false \
	-Dima=false \
	-Dimportd=false \
	-Dinstall-tests=false \
	-Dkmod=false \
	-Dldconfig=false \
	-Dlibcryptsetup=false \
	-Dlibcurl=false \
	-Dlibidn=false \
	-Dlibidn2=false \
	-Dlibiptc=false \
	-Dlink-systemctl-shared=true \
	-Dlink-udev-shared=true \
	-Dllvm-fuzz=false \
	-Dlocaled=false \
	-Dlogind=false \
	-Dlz4=false \
	-Dmachined=false \
	-Dman=false \
	-Dmemory-accounting-default=true \
	-Dmicrohttpd=false \
	-Dmyhostname=false \
	-Dnetworkd=false \
	-Dnobody-group=nobody \
	-Dnobody-user=nobody \
	-Dnss-systemd=false \
	-Dntp-servers= \
	-Dok-color=green \
	-Doss-fuzz=false \
	-Dpam=false \
	-Dpcre2=false \
	-Dpolkit=false \
	-Dportabled=false \
	-Dqrencode=false \
	-Dquotacheck=false \
	-Drandomseed=false \
	-Dremote=false \
	-Dresolve=false \
	-Drfkill=false \
	-Dseccomp=false \
	-Dselinux=false \
	-Dslow-tests=false \
	-Dsmack=false \
	-Dsplit-bin=true \
	-Dstatic-libsystemd=false \
	-Dstatic-libudev=false \
	-Dsplit-usr=false \
	-Dsystem-gid-max=999 \
	-Dsystem-uid-max=999 \
	-Dsysusers=false \
	-Dtests=false \
	-Dtime-epoch=`date --date "$(PTXDIST_VERSION_YEAR)-$(PTXDIST_VERSION_MONTH)-01 UTC" +%s` \
	-Dtimedated=false \
	-Dtimesyncd=false \
	-Dtmpfiles=false \
	-Dtpm=false \
	-Dutmp=false \
	-Dvalgrind=false \
	-Dvconsole=false \
	-Dwheel-group=false \
	-Dxkbcommon=false \
	-Dxz=false \
	-Dzlib=false

ifndef PTXCONF_HOST_SYSTEMD_INSTALL_DEV
HOST_SYSTEMD_MAKE_OPT := systemd-hwdb
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-systemd.install:
	@$(call targetinfo)
ifdef PTXCONF_HOST_SYSTEMD_INSTALL_DEV
	@$(call world/install, HOST_SYSTEMD)
else
	@rm -rf $(HOST_SYSTEMD_PKGDIR)
	@install -vD -m755 $(HOST_SYSTEMD_DIR)-build/systemd-hwdb \
		$(HOST_SYSTEMD_PKGDIR)/bin/systemd-hwdb
	@install -vD -m755 $(HOST_SYSTEMD_DIR)-build/src/shared/libsystemd-shared-$(HOST_SYSTEMD_VERSION).so \
		$(HOST_SYSTEMD_PKGDIR)/lib/libsystemd-shared-$(HOST_SYSTEMD_VERSION).so
endif
	@$(call touch)

# vim: syntax=make
