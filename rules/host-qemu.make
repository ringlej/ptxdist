# -*-makefile-*-
#
# Copyright (C) 2012 by Bernhard Walle <bernhard@bwalle.de>
#           (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#           (C) 2013 by Jan Luebbe <j.luebbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_QEMU) += host-qemu

#
# Paths and names
#
HOST_QEMU_VERSION	:= 1.4.1
HOST_QEMU_MD5		:= eb2d696956324722b5ecfa46e41f9a75
HOST_QEMU		:= qemu-$(HOST_QEMU_VERSION)
HOST_QEMU_SUFFIX	:= tar.bz2
HOST_QEMU_URL		:= http://wiki.qemu.org/download/$(HOST_QEMU).$(HOST_QEMU_SUFFIX)
HOST_QEMU_SOURCE	:= $(SRCDIR)/$(HOST_QEMU).$(HOST_QEMU_SUFFIX)
HOST_QEMU_DIR		:= $(HOST_BUILDDIR)/$(HOST_QEMU)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#

HOST_QEMU_TARGETS	:= \
	$(call ptx/ifdef, PTXCONF_ARCH_X86,,$(PTXCONF_ARCH_STRING)) \
	$(call ptx/ifdef, PTXCONF_ARCH_X86,i386,)
HOST_QEMU_SYS_TARGETS	:= $(patsubst %,%-softmmu,$(HOST_QEMU_TARGETS))
HOST_QEMU_USR_TARGETS	:= $(patsubst %,%-linux-user,$(HOST_QEMU_TARGETS))

HOST_QEMU_CONF_TOOL	:= autoconf
# 'net user' support: there is no --enable-slirp, so we have to leave out --disable-slirp
# firmware blobs: there is no --enable-blobs, so we have to leave out --disable-blobs
HOST_QEMU_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--target-list=" \
		$(call ptx/ifdef, PTXCONF_HOST_QEMU_SYS,$(HOST_QEMU_SYS_TARGETS),) \
		$(call ptx/ifdef, PTXCONF_HOST_QEMU_USR,$(HOST_QEMU_USR_TARGETS),) \
	" \
	--disable-debug-tcg \
	--disable-sparse \
	--disable-werror \
	--disable-sdl \
	--disable-vnc \
	--disable-cocoa \
	--audio-drv-list= \
	--audio-card-list= \
	--disable-xen \
	--disable-brlapi \
	--disable-curses \
	--disable-curl \
	--disable-fdt \
	--disable-bluez \
	--disable-kvm \
	--disable-tcg-interpreter \
	--enable-nptl \
	--$(call ptx/endis, PTXCONF_HOST_QEMU_SYS)-system \
	--disable-user \
	--$(call ptx/endis, PTXCONF_HOST_QEMU_USR)-linux-user \
	--disable-bsd-user \
	--enable-guest-base \
	--disable-uuid \
	--disable-vde \
	--disable-linux-aio \
	--disable-cap-ng \
	--disable-attr \
	--disable-docs \
	--disable-vhost-net \
	--disable-spice \
	--disable-opengl \
	--disable-rbd \
	--disable-libiscsi \
	--disable-smartcard-nss \
	--disable-usb-redir \
	--disable-guest-agent \
	--disable-seccomp \
	--disable-glusterfs \
	--disable-virtio-blk-data-plane \
	--disable-tools

# vim: syntax=make
